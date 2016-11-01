unit svrSMEstoqueUnt;

interface

uses
  Datasnap.DSProviderDataModuleAdapter,
  System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  Data.DBXMSSQL, Data.DB, Data.SqlExpr, Data.FMTBcd, Datasnap.Provider,
  DBXDBReaders, DBXCommon, DBXJSon, Datasnap.DBClient;

type
  TDSServerModuleEstoque = class(TDSServerModule) //(TDSServerModule)
    sqlConnEstoque: TSQLConnection;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetProdutos (campo: integer; parametro : string) : TDBXReader;
    function GetProdutosSuperPromocao (campo: integer; parametro : string) : TDBXReader;
    function GetGiroSimples(Grupo, DataIni, DataFim: string): TDBXReader;
    function GetClientes (campo: integer; parametro : string) : TDBXReader;
    function GetVendedores (campo: integer; parametro : string) : TDBXReader;
    function CorrigePedidoDuplicado (NumPedido : string; out Mensagem : string ) : Boolean;
    function GetRomaneioCarga (NumRomaneio : string; out Mensagem : string) : TDBXReader;
    function GetPontuacaoClienteOuro(CNPJ, Senha, DataIni, DataFim : string ;
       Mensagem : string) : TDBXReader;
    function GetPontuacaoOuroGMC(CNPJ, Senha: string; out Mensagem : string) : TDBXReader;
    function GetDadosProdutividade(DataIni, DataFim: string; out Mensagem : string) : TDBXReader;
    function GetFormulaVitoria(DataIni, DataFim: string; out Mensagem : string) : TDBXReader;
    function GetVendaLiquida(DataIni, DataFim: string; out Mensagem : string) : TDBXReader;
    function AtualizaCargaPE(senha : string; tipocarga: integer;  out Mensagem : string) : Boolean;
    function GetPedidosDuplicados( data : string; out Mensagem : string) : TDBXReader;
    function GetProdDupliCond (out Mensagem : string) : TDBXReader;
    function GetXMLStatusEnvio (NF : integer; out Mensagem : string) : TDBXReader;
    function AtualizaXMLStatusEnvio(NF: integer; email : string; out Mensagem : string) : Boolean;
    function GetPedidosEnderecar(Rota: string; out Mensagem : string) : TDBXReader;
    function GetWMSOrdemEntradaDivergencias (out Mensagem : string): TDBXReader;
    function GetWMSOrdemSaidaToERP(out Mensagem : string): TDBXReader;
    function GetWMSOrdemSaidaConferir (out Mensagem : string) : TDBXReader ;
    function GetWMSOrdemSaidasRecusadas (out Mensagem : string) : TDBXReader;
    function GetWMSItensOrdemSaidasRecusadas (out Mensagem : string) : TDBXReader;
    function ZerarSTNF(Senha, NF : string; out Mensagem : string) : Boolean;
    function GetWMSPedidosRetornadosXHora(out Mensagem : string) : TDBXReader;
    function GetWMSMovtosEstoqueItem (out Mensagem : string) : TDBXReader;
    function GetWMSExportOSSemSucesso(out Mensagem : string) : TDBXReader;
    function CorrigeWMSEmpenhoNegaMerc (NumPedido : string; out Mensagem : string) : Boolean;
    function GetAFVImportar(out MSG : string) : TDBXReader;
    function GetDetalhesPedidoAFV(NumAFV : string; out Mensagem : string ) : TDBXReader;
    function DeletaItemPedidoAFV(NumAFV, CodProduto : string; out Mensagem : string) : Boolean;
    function DeletaPedidoAFV(NumAFV, senha : string; out Mensagem : string) : Boolean;
    function ValidaSenhaDelPed(NumAFV, senha: string; out Mensagem : string) : Boolean;
    function GetProdutoSCondicoes() : TDBXReader;
    //Modulo Apk Cliente
    function ValidaCliente(CNPJ : string; out Mensagem : string) : String;
    function GetPedidosCliente(CodCliente, dataIni: string; out Mensagem : string ) : TDBXReader;
    function GetNFCliente(CodigoCliente, NF : string; out Mensagem : string): Boolean;

  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses URotinasGenericas, StrUtils, DateUtils ;

{$R *.dfm}

{ TDSServerModuleEstoque }

function TDSServerModuleEstoque.GetPedidosCliente(CodCliente, dataIni: string;
  out Mensagem: string): TDBXReader;
var
  CommPedidos : TDBXCommand;
  RD          : TDBXReader;
begin
  if DataIni = EmptyStr then
    dataIni := FormatDateTime('yyyymmdd', Now()- 31);

  sqlConnEstoque.Open;
  CommPedidos := sqlConnEstoque.DBXConnection.CreateCommand;
  CommPedidos.CommandType := TDBXCommandTypes.DbxSQL;
  CommPedidos.Text := Format('select c5_num, c5_emissao, c5_nota, c5_cliente, c5_obs, d_e_l_e_t_ ' +
                        'from SC5000 with(nolock)' +
                        'where c5_emissao between %s and GetDate() and c5_cliente = %s ', 
                        [QuotedStr(dataIni), QuotedStr(CodCliente)] );
  if not CommPedidos.IsPrepared then
    CommPedidos.Prepare;

  RD := CommPedidos.ExecuteQuery;
  if Assigned(Rd) then
  begin
    if Rd.Next then
      Mensagem := Format('Foram encontrados pedidos para o cliente %s, pesquisa em %s', 
            [codCliente, FormatDateTime('dd/mm/yyyy às hh:nn:ss', Now())] )
    else
      Mensagem := Format('Não existem pedidos para o cliente %s, pesquisa em %s', 
            [codCliente, FormatDateTime('dd/mm/yyyy às hh:nn:ss', Now())] );

    RD.Free;
  end;
  
  Result := CommPedidos.ExecuteQuery;

end;

function TDSServerModuleEstoque.GetPedidosDuplicados( data : string;
  out Mensagem: string): TDBXReader;
var
  CommPedDupl : TDBXCommand;
//  Rd : TDBXReader;
begin
  if data = EmptyStr then
    data := FormatDateTime('yyyymmdd', Now());

  sqlConnEstoque.Open;
  CommPedDupl := sqlConnEstoque.DBXConnection.CreateCommand;
  CommPedDupl.CommandType := TDBXCommandTypes.DbxSQL;
  CommPedDupl.Text := Format('select C5_CLIENTE, C5_NUMAFV, count(C5_NUMAFV) from SC5000 with(nolock) '    +
    'where C5_EMISSAO >= %s and C5_NUMAFV <> %s and C5_TIPOVEN = %s and D_E_L_E_T_ <> %s '  +
    'group by C5_CLIENTE, C5_NUMAFV having count(C5_NUMAFV) > 1', [ QuotedStr(data), QuotedStr(''), QuotedStr('V'), QuotedStr('*') ]);


  if not CommPedDupl.IsPrepared then
    CommPedDupl.Prepare;

//  RD := CommPedDupl.ExecuteQuery;
//  if Assigned(Rd) then
//  begin
//    if Rd.Next then
//      Mensagem := Format('Foram encontrados pedidos em duplicidade, pesquisa em %s', [FormatDateTime('dd/mm/yyyy às hh:nn:ss', Now())] )
//    else
//      Mensagem := Format('Não existem pedidos em duplicidade, pesquisa em %s', [FormatDateTime('dd/mm/yyyy às hh:nn:ss', Now())] );
//
//    RD.Free;
//  end;

  Result :=  CommPedDupl.ExecuteQuery;

end;

function TDSServerModuleEstoque.GetPedidosEnderecar(Rota: string;
  out Mensagem: string): TDBXReader;
var
  commEnderecar : TDBXCommand;
begin
  sqlConnEstoque.Open;
  commEnderecar := sqlConnEstoque.DBXConnection.CreateCommand;
  commEnderecar.CommandType := TDBXCommandTypes.DbxSQL;
  commEnderecar.Text := 'select C5_EMISSAO DT_PED, C5_HRGRV HR_GRAV, C5_NUMAFV ID_IMPORT, C5_TIPOVEN, '   +
          	'C5_TRANSP ROTA, C5_VEND1 VEND, C5_CLIENTE CLIENTE, C5_NUM, C5_OBS, C6_PRODUTO, C6_DESCRI, '  +
            'BF_LOCAL ARMAZ, BF_LOCALIZ ENDERECO from SC5000 with(nolock) '                               +
            'inner join SC6000 with(nolock) on C6_NUM = C5_NUM and C6_ENTREG >= GETDATE() - 5 and '       +
            'C6_OP = ' + QuotedStr('07') + 'and SC6000.D_E_L_E_T_ <> ' + QuotedStr('*') + ' '             +
            'inner join SC9000 with(nolock) on C9_PEDIDO = C5_NUM and C9_PRODUTO = C6_PRODUTO and C9_BLEST = ' +
            QuotedStr('02') + 'and SC9000.D_E_L_E_T_ <> ' + QuotedStr('*') + ' '                          +
            'inner join SBF000 with(nolock) on BF_PRODUTO = C6_PRODUTO and BF_LOCAL < ' + QuotedStr('04') +
            ' and SBF000.D_E_L_E_T_ <> ' + QuotedStr('*') + ' where 	C5_EMISSAO >= GETDATE() - 5 and'    +
            ' SC5000.D_E_L_E_T_ <> ' + QuotedStr('*') + ' and  C5_NOTA = ' + QuotedStr(' ') + 'and C5_HRIMP = ' +
            QuotedStr(' ') + 'and C5_LIBEROK <> ' + QuotedStr(' ') + ' ';
  if Rota <> EmptyStr then
    begin
      commEnderecar.Text := commEnderecar.Text + ' and C5_TRANSP = ' + QuotedStr(Rota) + ' ';
    end;
  commEnderecar.Text := commEnderecar.Text +  ' order by C5_EMISSAO desc, C5_HRGRV desc;';

  Result := commEnderecar.ExecuteQuery;
  if Assigned(Result) then
    Mensagem := Format('Ok %s %s', ['!', '!'] )
  else
    Mensagem := Format('Não foi %s.', ['!'] );


end;

function TDSServerModuleEstoque.GetPontuacaoClienteOuro(CNPJ, Senha, DataIni, DataFim : string;
  Mensagem: string): TDBXReader;
var
  commPontCli : TDBXCommand;
  dtDataIni, dtDataFim :string;
//  DTDevIni : string;
begin

  dtDataIni := '20141101';
  dtDataFim := FormatDateTime('yyyymmdd', Now()-1);

  sqlConnEstoque.Open;
  commPontCli := sqlConnEstoque.DBXConnection.CreateCommand;
  commPontCli.CommandType := TDBXCommandTypes.DbxSQL;
  commPontCli.Text := 'select A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, ANO_MES, ' + #13 +
	  'Sum(R$_MES_NEOQUIMICA_GEN) NEOQUIMICA_GEN, Round(sum(R$_MES_NEOQUIMICA_GEN)/500, 0, 1) PT_NQG,' + #13 +
    'SUM(R$_MES_NEOQUIMICA_SMART) NEOQUIMICA_SMART, Round(SUM(R$_MES_NEOQUIMICA_SMART)/500, 0, 1) PT_NQS, ' + #13 +
	  'SUM(R$_MES_NIVEA) NIVEA, Round(SUM(R$_MES_NIVEA)/300, 0, 1) PT_NIV ' + #13 +
    'from (' + #13 +
    //Neo Quimica Generico - 6902
    ' select A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL,--BM_GRUPO, BM_DESC GRUPO, ' + #13 +
	  'substring(D2_EMISSAO, 1, 6) ANO_MES , isnull(SUM(D2_TOTAL),0) R$_MES_NEOQUIMICA_GEN, '+ #13 +
    '0 R$_MES_NEOQUIMICA_SMART , 0 R$_MES_NIVEA from SA1000 with(nolock) ' + #13 +
    'left join SD2000 with(nolock) on D2_CLIENTE = A1_COD and D2_GRUPO in (' +
    QuotedStr('6902') + ') and D2_EMISSAO between ' + QuotedStr(dtDataIni) + ' AND ' + QuotedStr(dtDataFim) + #13 +
		' and D2_EMISSAO >= A1_XDTREDE and D2_TIPO <> ' + QuotedStr('D') + ' and SD2000.D_E_L_E_T_ <> ' + QuotedStr('*') + #13 +
    ' left join SBM000 with(nolock) on D2_GRUPO = BM_GRUPO where A1_CODREDE = '+ QuotedStr('000002') + #13 +
    ' and A1_CGC = ' + QuotedStr(CNPJ) + ' and A1_XSENHA = ' + QuotedStr(Senha) + #13 +
    'group by A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, substring(D2_EMISSAO, 1, 6) ' + #13 +
    'union all ' + #13 +
    //Neo Quimica Smart
    'select A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL,--BM_GRUPO, BM_DESC GRUPO, ' + #13 +
	  'substring(D2_EMISSAO, 1, 6) ANO_MES , 0 R$_MES_NEOQUIMICA_GEN, '+ #13 +
    'isnull(SUM(D2_TOTAL),0) R$_MES_NEOQUIMICA_SMART , 0 R$_MES_NIVEA from SA1000 with(nolock) ' + #13 +
    'left join SD2000 with(nolock) on D2_CLIENTE = A1_COD and D2_GRUPO in (' +
//    QuotedStr('6901, 6903, 0510, 0511') + ') and D2_EMISSAO between ' + QuotedStr(dtDataIni) + ' AND ' + QuotedStr(dtDataFim) + #13 +
    '6901, 6903, 0510, 0511' + ') and D2_EMISSAO between ' + QuotedStr(dtDataIni) + ' AND ' + QuotedStr(dtDataFim) + #13 +
		' and D2_EMISSAO >= A1_XDTREDE and D2_TIPO <> ' + QuotedStr('D') + ' and SD2000.D_E_L_E_T_ <> ' + QuotedStr('*') + #13 +
    ' left join SBM000 with(nolock) on D2_GRUPO = BM_GRUPO where A1_CODREDE = '+ QuotedStr('000002') + #13 +
    ' and A1_CGC = ' + QuotedStr(CNPJ) + ' and A1_XSENHA = ' + QuotedStr(Senha) +  #13 +
    'group by A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, substring(D2_EMISSAO, 1, 6) ' + #13 +
    'union all ' + #13 +
    //NIVEA
    'select A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL,--BM_GRUPO, BM_DESC GRUPO, ' + #13 +
	  'substring(D2_EMISSAO, 1, 6) ANO_MES , 0 R$_MES_NEOQUIMICA_GEN, '+ #13 +
    '0 R$_MES_NEOQUIMICA_SMART , isnull(SUM(D2_TOTAL),0) R$_MES_NIVEA from SA1000 with(nolock) ' + #13 +
    'left join SD2000 with(nolock) on D2_CLIENTE = A1_COD and D2_GRUPO in (' +
    QuotedStr('5210') + ') and D2_EMISSAO between ' + QuotedStr(dtDataIni) + ' AND ' + QuotedStr(dtDataFim) + #13 +
		' and D2_EMISSAO >= A1_XDTREDE and D2_TIPO <> ' + QuotedStr('D') + ' and SD2000.D_E_L_E_T_ <> ' + QuotedStr('*') + #13 +
    ' left join SBM000 with(nolock) on D2_GRUPO = BM_GRUPO where A1_CODREDE = '+ QuotedStr('000002') + #13 +
    ' and A1_CGC = ' + QuotedStr(CNPJ) + ' and A1_XSENHA = ' + QuotedStr(Senha) +  #13 +
    'group by A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, substring(D2_EMISSAO, 1, 6) ' + #13 +
    'union all ' + #13 +
    //-- Abaixo as devoluções digitadas no mesmo periodo
    //NeoQuimica Generico
    'select A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL,--BM_GRUPO, BM_DESC GRUPO,' + #13 +
	  'substring(D1_DTDIGIT, 1, 6) ANO_MES , isnull(Round(SUM(D1_TOTAL - D1_VALDESC),2)*-1,0) R$_MES_NEOQUIMICA_GEN, ' + #13 +
	  '0 R$_MES_NEOQUIMICA_SMART, 0 R$_MES_NIVEA from SA1000 with(nolock) ' +#13 +
    'left join SD1000 with(nolock) on D1_FORNECE = A1_COD and D1_GRUPO in (' + QuotedStr('6902') + #13 +
		') and D1_DTDIGIT between ' + QuotedStr(dtDataIni) + ' AND ' + QuotedStr(dtDataFim)+ #13 +
		' and D1_DTDIGIT >= A1_XDTREDE and D1_TIPO = '+QuotedStr('D') + ' and SD1000.D_E_L_E_T_ <> '+ QuotedStr('*') + #13 +
    'left join SBM000 with(nolock) on D1_GRUPO = BM_GRUPO where A1_CODREDE = '+ QuotedStr('000002') + #13 +
    ' and A1_CGC = ' + QuotedStr(CNPJ) + ' and A1_XSENHA = ' + QuotedStr(Senha)  + #13 +
    'group by A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, substring(D1_DTDIGIT, 1, 6) '  + #13 +
    ' union all '  + #13 +
    //Neo Quimica Smart
    'select A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL,--BM_GRUPO, BM_DESC GRUPO,' + #13 +
	  'substring(D1_DTDIGIT, 1, 6) ANO_MES , 0 R$_MES_NEOQUIMICA_GEN, ' + #13 +
	  'isnull(Round(SUM(D1_TOTAL - D1_VALDESC),2)*-1,0)  R$_MES_NEOQUIMICA_SMART, 0 R$_MES_NIVEA from SA1000 with(nolock) ' +#13 +
    'left join SD1000 with(nolock) on D1_FORNECE = A1_COD and D1_GRUPO in (' + '6901, 6903, 0510, 0511' + #13 +
		') and D1_DTDIGIT between ' + QuotedStr(dtDataIni) + ' AND ' + QuotedStr(dtDataFim)+ #13 +
		' and D1_DTDIGIT >= A1_XDTREDE and D1_TIPO = '+QuotedStr('D') + ' and SD1000.D_E_L_E_T_ <> '+ QuotedStr('*') + #13 +
    'left join SBM000 with(nolock) on D1_GRUPO = BM_GRUPO where A1_CODREDE = '+ QuotedStr('000002') + #13 +
    ' and A1_CGC = ' + QuotedStr(CNPJ) + ' and A1_XSENHA = ' + QuotedStr(Senha) + #13 +
    'group by A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, substring(D1_DTDIGIT, 1, 6) '  + #13 +
    ' union all '  + #13 +
    //NIVEA
    'select A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL,--BM_GRUPO, BM_DESC GRUPO,' + #13 +
	  'substring(D1_DTDIGIT, 1, 6) ANO_MES , 0 R$_MES_NEOQUIMICA_GEN, ' + #13 +
	  '0 R$_MES_NEOQUIMICA_SMART, isnull(Round(SUM(D1_TOTAL - D1_VALDESC),2)*-1,0) R$_MES_NIVEA from SA1000 with(nolock) ' +#13 +
    'left join SD1000 with(nolock) on D1_FORNECE = A1_COD and D1_GRUPO in (' + QuotedStr('5210') + #13 +
		') and D1_DTDIGIT between ' + QuotedStr(dtDataIni) + ' AND ' + QuotedStr(dtDataFim)+ #13 +
		' and D1_DTDIGIT >= A1_XDTREDE and D1_TIPO = '+QuotedStr('D') + ' and SD1000.D_E_L_E_T_ <> '+ QuotedStr('*') + #13 +
    'left join SBM000 with(nolock) on D1_GRUPO = BM_GRUPO where A1_CODREDE = '+ QuotedStr('000002') + #13 +
    ' and A1_CGC = ' + QuotedStr(CNPJ) + ' and A1_XSENHA = ' + QuotedStr(Senha) +  #13 +
    'group by A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, substring(D1_DTDIGIT, 1, 6) '  + #13 +
//    ') as RESULTADO where ANO_MES is not null ' + #13 +
    ') as RESULTADO ' + #13 +
    'group by A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, ANO_MES order by	A1_NOME, ANO_MES ';

  if not commPontCli.IsPrepared then
    commPontCli.Prepare;

  Result := commPontCli.ExecuteQuery;
  if Assigned(Result) then
    Mensagem := Format('Pontuação do cliente % no período : %s à %s', [CNPJ, dtDataIni, dtDataFim] )
  else
    Mensagem := Format('Não foi possível executar o extrato do cliente %s.', [CNPJ] );

    begin
      if Result.ColumnCount > 1 then
        Mensagem := Format('Pontuação do cliente % no período : %s à %s', [CNPJ, dtDataIni, dtDataFim] )
      else
        Mensagem := Format('Não foi possível executar o extrato do cliente %s.', [CNPJ] );
    end;

end;

function TDSServerModuleEstoque.GetPontuacaoOuroGMC(CNPJ, Senha: string; out Mensagem: string): TDBXReader;
var
  commPontCli : TDBXCommand;
  dtDataIni, dtDataFim :string;
begin

  dtDataIni := '20150101';
  dtDataFim := FormatDateTime('yyyymmdd', Now()-1);

  sqlConnEstoque.Open;
  commPontCli := sqlConnEstoque.DBXConnection.CreateCommand;
  commPontCli.CommandType := TDBXCommandTypes.DbxSQL;
  commPontCli.Text := 'select A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, ANO_MES, ' + #13 +
	  'Sum(R$_MES_GERMED) GERMED, Round(sum(R$_MES_GERMED)/250, 0, 1) PT_GERMED,' + #13 +
    'SUM(R$_MES_GLOBO) GLOBO, Round(SUM(R$_MES_GLOBO)/250, 0, 1) PT_GLOBO, ' + #13 +
	  'SUM(R$_MES_NIVEA) NIVEA, Round(SUM(R$_MES_NIVEA)/250, 0, 1) PT_NIVEA ' + #13 +
    'from (' + #13 +
    //GERMED
    ' select A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL,--BM_GRUPO, BM_DESC GRUPO, ' + #13 +
	  'substring(D2_EMISSAO, 1, 6) ANO_MES , isnull(SUM(D2_TOTAL),0) R$_MES_GERMED, '+ #13 +
    '0 R$_MES_GLOBO, 0 R$_MES_NIVEA from SA1000 with(nolock) ' + #13 +
    'left join SD2000 with(nolock) on D2_CLIENTE = A1_COD and D2_GRUPO in (' +
    QuotedStr('1810') + ') and D2_EMISSAO between ' + QuotedStr(dtDataIni) + ' AND ' + QuotedStr(dtDataFim) + #13 +
		' and D2_EMISSAO >= A1_XDTREDE and D2_TIPO <> ' + QuotedStr('D') + ' and SD2000.D_E_L_E_T_ <> ' + QuotedStr('*') + #13 +
    ' left join SBM000 with(nolock) on D2_GRUPO = BM_GRUPO where A1_CODREDE = '+ QuotedStr('000017') + #13 +
    ' and A1_CGC = ' + QuotedStr(CNPJ) + ' and A1_XSENHA = ' + QuotedStr(Senha) + #13 +
    'group by A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, substring(D2_EMISSAO, 1, 6) ' + #13 +
    'union all ' + #13 +
    //GLOBO
    'select A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL,--BM_GRUPO, BM_DESC GRUPO, ' + #13 +
	  'substring(D2_EMISSAO, 1, 6) ANO_MES , 0 R$_MES_GERMED, '+ #13 +
    'isnull(SUM(D2_TOTAL),0) R$_MES_GLOBO, 0 R$_MES_NIVEA from SA1000 with(nolock) ' + #13 +
    'left join SD2000 with(nolock) on D2_CLIENTE = A1_COD and D2_GRUPO in (' +
    '1910, 1911' + ') and D2_EMISSAO between ' + QuotedStr(dtDataIni) + ' AND ' + QuotedStr(dtDataFim) + #13 +
		' and D2_EMISSAO >= A1_XDTREDE and D2_TIPO <> ' + QuotedStr('D') + ' and SD2000.D_E_L_E_T_ <> ' + QuotedStr('*') + #13 +
    ' left join SBM000 with(nolock) on D2_GRUPO = BM_GRUPO where A1_CODREDE = '+ QuotedStr('000017') + #13 +
    ' and A1_CGC = ' + QuotedStr(CNPJ) + ' and A1_XSENHA = ' + QuotedStr(Senha) +  #13 +
    'group by A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, substring(D2_EMISSAO, 1, 6) ' + #13 +
    'union all ' + #13 +
    //NIVEA
    'select A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL,--BM_GRUPO, BM_DESC GRUPO, ' + #13 +
	  'substring(D2_EMISSAO, 1, 6) ANO_MES , 0 R$_MES_GERMED, '+ #13 +
    '0 R$_MES_GLOBO, isnull(SUM(D2_TOTAL),0) R$_MES_NIVEA from SA1000 with(nolock) ' + #13 +
    'left join SD2000 with(nolock) on D2_CLIENTE = A1_COD and D2_GRUPO in (' +
    QuotedStr('5210') + ') and D2_EMISSAO between ' + QuotedStr(dtDataIni) + ' AND ' + QuotedStr(dtDataFim) + #13 +
		' and D2_EMISSAO >= A1_XDTREDE and D2_TIPO <> ' + QuotedStr('D') + ' and SD2000.D_E_L_E_T_ <> ' + QuotedStr('*') + #13 +
    ' left join SBM000 with(nolock) on D2_GRUPO = BM_GRUPO where A1_CODREDE = '+ QuotedStr('000017') + #13 +
    ' and A1_CGC = ' + QuotedStr(CNPJ) + ' and A1_XSENHA = ' + QuotedStr(Senha) +  #13 +
    'group by A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, substring(D2_EMISSAO, 1, 6) ' + #13 +
    'union all ' + #13 +
    //-- Abaixo as devoluções digitadas no mesmo periodo
    //GERMED
    'select A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL,--BM_GRUPO, BM_DESC GRUPO,' + #13 +
	  'substring(D1_DTDIGIT, 1, 6) ANO_MES , isnull(Round(SUM(D1_TOTAL - D1_VALDESC),2)*-1,0) R$_MES_GERMED, ' + #13 +
	  '0 R$_MES_GLOBO, 0 R$_MES_NIVEA from SA1000 with(nolock) ' +#13 +
    'left join SD1000 with(nolock) on D1_FORNECE = A1_COD and D1_GRUPO in (' + QuotedStr('6902') + #13 +
		') and D1_DTDIGIT between ' + QuotedStr(dtDataIni) + ' AND ' + QuotedStr(dtDataFim)+ #13 +
		' and D1_DTDIGIT >= A1_XDTREDE and D1_TIPO = '+QuotedStr('D') + ' and SD1000.D_E_L_E_T_ <> '+ QuotedStr('*') + #13 +
    'left join SBM000 with(nolock) on D1_GRUPO = BM_GRUPO where A1_CODREDE = '+ QuotedStr('000017') + #13 +
    ' and A1_CGC = ' + QuotedStr(CNPJ) + ' and A1_XSENHA = ' + QuotedStr(Senha)  + #13 +
    'group by A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, substring(D1_DTDIGIT, 1, 6) '  + #13 +
    ' union all '  + #13 +
    //GLOBO
    'select A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL,--BM_GRUPO, BM_DESC GRUPO,' + #13 +
	  'substring(D1_DTDIGIT, 1, 6) ANO_MES , 0 R$_MES_GERMED, ' + #13 +
	  'isnull(Round(SUM(D1_TOTAL - D1_VALDESC),2)*-1,0)  R$_MES_GLOBO, 0 R$_MES_NIVEA from SA1000 with(nolock) ' +#13 +
    'left join SD1000 with(nolock) on D1_FORNECE = A1_COD and D1_GRUPO in (' + '1910, 1911' + #13 +
		') and D1_DTDIGIT between ' + QuotedStr(dtDataIni) + ' AND ' + QuotedStr(dtDataFim)+ #13 +
		' and D1_DTDIGIT >= A1_XDTREDE and D1_TIPO = '+QuotedStr('D') + ' and SD1000.D_E_L_E_T_ <> '+ QuotedStr('*') + #13 +
    'left join SBM000 with(nolock) on D1_GRUPO = BM_GRUPO where A1_CODREDE = '+ QuotedStr('000017') + #13 +
    ' and A1_CGC = ' + QuotedStr(CNPJ) + ' and A1_XSENHA = ' + QuotedStr(Senha) + #13 +
    'group by A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, substring(D1_DTDIGIT, 1, 6) '  + #13 +
    ' union all '  + #13 +
    //NIVEA
    'select A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL,--BM_GRUPO, BM_DESC GRUPO,' + #13 +
	  'substring(D1_DTDIGIT, 1, 6) ANO_MES , 0 R$_MES_GERMED, ' + #13 +
	  '0 R$_MES_GLOBO, isnull(Round(SUM(D1_TOTAL - D1_VALDESC),2)*-1,0) R$_MES_NIVEA from SA1000 with(nolock) ' +#13 +
    'left join SD1000 with(nolock) on D1_FORNECE = A1_COD and D1_GRUPO in (' + QuotedStr('5210') + #13 +
		') and D1_DTDIGIT between ' + QuotedStr(dtDataIni) + ' AND ' + QuotedStr(dtDataFim)+ #13 +
		' and D1_DTDIGIT >= A1_XDTREDE and D1_TIPO = '+QuotedStr('D') + ' and SD1000.D_E_L_E_T_ <> '+ QuotedStr('*') + #13 +
    'left join SBM000 with(nolock) on D1_GRUPO = BM_GRUPO where A1_CODREDE = '+ QuotedStr('000017') + #13 +
    ' and A1_CGC = ' + QuotedStr(CNPJ) + ' and A1_XSENHA = ' + QuotedStr(Senha) +  #13 +
    'group by A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, substring(D1_DTDIGIT, 1, 6) '  + #13 +
//    ') as RESULTADO where ANO_MES is not null ' + #13 +
    ') as RESULTADO ' + #13 +
    'group by A1_COD, A1_NOME, A1_NREDUZ, A1_CGC, A1_MUN, A1_MSBLQL, ANO_MES order by	A1_NOME, ANO_MES ';

  if not commPontCli.IsPrepared then
    commPontCli.Prepare;

  Result := commPontCli.ExecuteQuery;
  if Result.ColumnCount > 1 then
    Mensagem := Format('Pontuação do cliente % no período : %s à %s', [CNPJ, dtDataIni, dtDataFim] )
  else
    Mensagem := Format('Não foi possível executar o extrato do cliente %s.', [CNPJ] );
end;

function TDSServerModuleEstoque.GetProdDupliCond(
  out Mensagem: string): TDBXReader;
var
  CommProdDupli : TDBXCommand;
  RD : TDBXReader;
begin
  sqlConnEstoque.Open;
  CommProdDupli := sqlConnEstoque.DBXConnection.CreateCommand;
  CommProdDupli.CommandType := TDBXCommandTypes.DbxSQL;
  CommProdDupli.Text := Format( 'select ACP_CODPRO, ACP_ITEM, ACP_PERDES from ACP000 where ACP_CODPRO in ( '  +
      'select distinct(ACP_CODPRO) from ACP000 where ACP_CODPRO <> %s and D_E_L_E_T_ <> %s '          +
      'group by ACP_CODPRO, ACP_CODREG having COUNT(ACP_CODPRO) > 1) order by ACP_CODPRO, ACP_ITEM ' ,
      [QuotedStr(''), QuotedStr('*')]);
  if not CommProdDupli.IsPrepared then
    CommProdDupli.Prepare;

  RD := CommProdDupli.ExecuteQuery;
  if  RD.Next then
    Mensagem := 'Foram encontrados itens em duplicidade!'
  else
    Mensagem := 'Não há itens duplicados!';

  RD.Free;
  Result := CommProdDupli.ExecuteQuery;


end;

function TDSServerModuleEstoque.GetProdutos(campo: integer; parametro : string): TDBXReader;
var
  CommProdutos : TDBXCommand;
begin
  try
    sqlConnEstoque.Open;
    CommProdutos := sqlConnEstoque.DBXConnection.CreateCommand;
    CommProdutos.CommandType := TDBXCommandTypes.DbxSQL;

    case campo of
      0: // Busca por código pode ser parcial
        begin
          CommProdutos.Text := 'select B1_COD, B1_CODBAR, B1_DESC, B1_DESCGRU, '      +
            'B1_PRV1, B1_PRCMAX, ISNULL(SUM(B2_QATU - B2_RESERVA), 0) QTD '           +
            'from SB1000 with(nolock) left join SB2000 with(nolock) on B2_COD = '     +
            'B1_COD and SB2000.D_E_L_E_T_ <> ' + QuotedStr('*') + ' and B2_LOCAL < '  +
            QuotedStr('03') + ' where B1_GRUPO <= ' + QuotedStr('9800')               +
            ' and SB1000.D_E_L_E_T_ <> ' + QuotedStr('*')                             +
            ' and B1_COD like ' + QuotedStr(UpperCase(parametro) + '%')               +
            ' group by B1_COD, B1_CODBAR, B1_DESC, B1_DESCGRU, B1_PRV1, B1_PRCMAX '   +
            ' order by B1_DESC, B1_DESCGRU'
        end;

      1: // Busca por Descrição pode ser parcial
        begin
          CommProdutos.Text := 'select B1_COD, B1_CODBAR, B1_DESC, B1_DESCGRU, '      +
            'B1_PRV1, B1_PRCMAX, ISNULL(SUM(B2_QATU - B2_RESERVA), 0) QTD '           +
            'from SB1000 with(nolock) left join SB2000 with(nolock) on B2_COD = '     +
            'B1_COD and SB2000.D_E_L_E_T_ <> ' + QuotedStr('*') + ' and B2_LOCAL < '  +
            QuotedStr('03') + ' where B1_GRUPO <= ' + QuotedStr('9800')               +
            ' and SB1000.D_E_L_E_T_ <> ' + QuotedStr('*')                             +
            ' and B1_DESC like ' + QuotedStr(UpperCase(parametro) + '%')              +
            ' group by B1_COD, B1_CODBAR, B1_DESC, B1_DESCGRU, B1_PRV1, B1_PRCMAX '   +
            ' order by B1_DESC, B1_DESCGRU'
        end;

      2: //Busca por EAN
        begin
          CommProdutos.Text := 'select B1_COD, B1_CODBAR, B1_DESC, B1_DESCGRU, '      +
            'B1_PRV1, B1_PRCMAX, ISNULL(SUM(B2_QATU - B2_RESERVA), 0) QTD '           +
            'from SB1000 with(nolock) left join SB2000 with(nolock) on B2_COD = '     +
            'B1_COD and SB2000.D_E_L_E_T_ <> ' + QuotedStr('*') + ' and B2_LOCAL < '  +
            QuotedStr('03') + ' where B1_GRUPO <= ' + QuotedStr('9800')               +
            ' and SB1000.D_E_L_E_T_ <> ' + QuotedStr('*') + ' and B1_CODBAR <> ' + QuotedStr('') +
            ' and B1_CODBAR <> ' + QuotedStr('.') + ' and B1_CODBAR like '            +
              QuotedStr(UpperCase(parametro) + '%')                                   +
            ' group by B1_COD, B1_CODBAR, B1_DESC, B1_DESCGRU, B1_PRV1, B1_PRCMAX '   +
            ' order by B1_DESC, B1_DESCGRU'
        end;
    end;
  finally
    if not CommProdutos.IsPrepared then
      CommProdutos.Prepare;
     Result := CommProdutos.ExecuteQuery;
  end;


end;

function TDSServerModuleEstoque.GetProdutoSCondicoes: TDBXReader;
var
  command : TDBXCommand;
begin
  try
    sqlConnEstoque.Open;
    command := sqlConnEstoque.DBXConnection.CreateCommand;
    command.CommandType := TDBXCommandTypes.DbxSQL;
    command.Text := 'SELECT * FROM ACP000 a ORDER BY a.ACP_GRUPO, a.ACP_CODPRO, a.ACP_CODREG';
  finally
    if not command.IsPrepared then
      command.Prepare;

    Result := command.ExecuteQuery;
  end;

end;

function TDSServerModuleEstoque.GetProdutosSuperPromocao(campo: integer;
  parametro: string): TDBXReader;
var
  commSuperPromocao : TDBXCommand;
begin
  try
    sqlConnEstoque.Open;
    commSuperPromocao := sqlConnEstoque.DBXConnection.CreateCommand;
    commSuperPromocao.CommandType := TDBXCommandTypes.DbxSQL;

    case campo of
      0: // Busca por Codigo
        begin
          commSuperPromocao.Text := 'select B1_COD, B1_CODBAR, B1_DESC, B1_DESCGRU, ' +
            'B1_PRV1, B1_PRCMAX, ISNULL(SUM(B2_QATU - B2_RESERVA), 0) QTD '           +
            'from SB1000 with(nolock) left join SB2000 with(nolock) on B2_COD = '     +
            'B1_COD and SB2000.D_E_L_E_T_ <> ' + QuotedStr('*') + ' and B2_LOCAL = '  +
            QuotedStr('03') + ' where B1_GRUPO <= ' + QuotedStr('9800')               +
            ' and SB1000.D_E_L_E_T_ <> ' + QuotedStr('*')                             +
            ' and B1_COD like ' + QuotedStr(UpperCase(parametro) + '%')               +
            ' group by B1_COD, B1_CODBAR, B1_DESC, B1_DESCGRU, B1_PRV1, B1_PRCMAX '   +
            ' having sum(B2_QATU - B2_RESERVA) > 0 order by B1_DESC, B1_DESCGRU'
        end;

      1: // Busca por descricao
        begin
          commSuperPromocao.Text := 'select B1_COD, B1_CODBAR, B1_DESC, B1_DESCGRU, ' +
            'B1_PRV1, B1_PRCMAX, ISNULL(SUM(B2_QATU - B2_RESERVA), 0) QTD '           +
            'from SB1000 with(nolock) left join SB2000 with(nolock) on B2_COD = '     +
            'B1_COD and SB2000.D_E_L_E_T_ <> ' + QuotedStr('*') + ' and B2_LOCAL = '  +
            QuotedStr('03') + ' where B1_GRUPO <= ' + QuotedStr('9800')               +
            ' and SB1000.D_E_L_E_T_ <> ' + QuotedStr('*')                             +
            ' and B1_DESC LIKE  ' + QuotedStr(UpperCase(parametro) + '%')             +
            ' group by B1_COD, B1_CODBAR, B1_DESC, B1_DESCGRU, B1_PRV1, B1_PRCMAX '   +
            ' having sum(B2_QATU - B2_RESERVA) > 0 order by B1_DESC, B1_DESCGRU'
        end;

      2: // Busca por EAN
        begin
          commSuperPromocao.Text := 'select B1_COD, B1_CODBAR, B1_DESC, B1_DESCGRU, ' +
            'B1_PRV1, B1_PRCMAX, ISNULL(SUM(B2_QATU - B2_RESERVA), 0) QTD '           +
            'from SB1000 with(nolock) left join SB2000 with(nolock) on B2_COD = '     +
            'B1_COD and SB2000.D_E_L_E_T_ <> ' + QuotedStr('*') + ' and B2_LOCAL = '  +
            QuotedStr('03') + ' where B1_GRUPO <= ' + QuotedStr('9800')               +
            ' and SB1000.D_E_L_E_T_ <> ' + QuotedStr('*') + 'and B1_CODBAR <> ' + QuotedStr('') +
            ' and B1_CODBAR <> ' + QuotedStr('.') + 'and B1_CODBAR like '             +
                  QuotedStr(UpperCase(parametro) + '%')                               +
            ' group by B1_COD, B1_CODBAR, B1_DESC, B1_DESCGRU, B1_PRV1, B1_PRCMAX '   +
            ' having sum(B2_QATU - B2_RESERVA) > 0 order by B1_DESC, B1_DESCGRU'
        end;
    end;

  finally
    if not commSuperPromocao.IsPrepared then
      commSuperPromocao.Prepare;
    Result := commSuperPromocao.ExecuteQuery;
  end;

end;

function TDSServerModuleEstoque.GetRomaneioCarga(NumRomaneio: string;
  out Mensagem: string): TDBXReader;
var
  commRomaneio : TDBXCommand;
  ReaderRomaneio : TDBXReader;
begin
  try
    try
      sqlConnEstoque.Open;
      commRomaneio := sqlConnEstoque.DBXConnection.CreateCommand;
      commRomaneio.CommandType := TDBXCommandTypes.DbxSQL;
      commRomaneio.Text := 'select Z5_ROMANE ROMANEIO, Z5_NOTA NF, Z5_SERIE SERIE, F2_VOLUME VOL, F2_CHVNFE CHAVE_NFE ' +
              'from SZ5000 with(nolock) inner join SF2000 with(nolock) on F2_DOC = Z5_NOTA and F2_SERIE = Z5_SERIE ' +
              'and SF2000.D_E_L_E_T_ <> ' + QuotedStr('*') + ' where Z5_ROMANE = ' + QuotedStr(StrZero(NumRomaneio, 6)) +
              ' and SZ5000.D_E_L_E_T_ <> '  + QuotedStr('*') + ' order by z5_nota ;' ;
    except on E: Exception do
      Mensagem := E.Message;
    end;
  finally
    if not commRomaneio.IsPrepared then
    commRomaneio.Prepare;
    Result := commRomaneio.ExecuteQuery;
    if Assigned(Result) then
      begin
        if Result.ToString.Length > 0 then
          Mensagem := Format('Romaneio %s carregado com sucesso!', [NumRomaneio] )
        else
          Mensagem := Format('Não foi possível localizar o romaneio %s ', [NumRomaneio] )

      end;
  end;

end;

function TDSServerModuleEstoque.AtualizaCargaPE(senha : string; tipocarga: integer; out Mensagem: string): Boolean;
var
  Path : string;
  Busca : TSearchRec;
  Arquivos : TStringList;
  i : integer;

  CommAtualizacao : TDBXCommand;
  Conteudo : TStringList;
begin
  if UpperCase(senha) <> '347874633' then
    begin
      Result := False;
      Mensagem := 'Senha incorreta, Operação não realizada!'
    end
  else
    begin
      if tipocarga = 1 then
        Path := ExtractFilePath(ParamStr(0)) + '\scripts_pe\cargacompleta\'
      else
        Path := ExtractFilePath(ParamStr(0)) + '\scripts_pe\';

      Result := False;
      sqlConnEstoque.Open;
      CommAtualizacao := sqlConnEstoque.DBXConnection.CreateCommand;
      CommAtualizacao.CommandType := TDBXCommandTypes.DbxSQL;
      Conteudo := TStringList.Create;

      Arquivos := TStringList.Create;
      Arquivos.Clear;
      try
        i := FindFirst(Path + '*.SQL', 0, Busca);
        while i = 0 do
          begin
            Arquivos.Add(Busca.Name);
            i := FindNext(Busca);
          end;
      except
          Arquivos.Free;
          raise;
      end;
      Mensagem := EmptyStr;
      for i := 0 to Arquivos.Count -1 do
      begin
        Conteudo.Clear;
        Conteudo.LoadFromFile(Path +  UpperCase(Arquivos.Strings[i]));
        CommAtualizacao.Text := Conteudo.Text;
        if not CommAtualizacao.IsPrepared then
          CommAtualizacao.Prepare;

        CommAtualizacao.ExecuteUpdate;
        Mensagem := Mensagem + Format('Comando %s executado!' + #13, [UpperCase(Arquivos.Strings[i])]);
      end;
      FreeAndNil(CommAtualizacao);
      Result := True;
    end;
end;

function TDSServerModuleEstoque.AtualizaXMLStatusEnvio(NF: integer;
  email: string; out Mensagem : string): Boolean;
var
  CommAtualizaXMLStatusEnvio : TDBXCommand;
begin
  // Passar funcção de atualização do status
  Result := False;
  Mensagem := EmptyStr;
  try
    sqlConnEstoque.Open;
    CommAtualizaXMLStatusEnvio := sqlConnEstoque.DBXConnection.CreateCommand;
    CommAtualizaXMLStatusEnvio.CommandType := TDBXCommandTypes.DbxSQL;
    CommAtualizaXMLStatusEnvio.Text := 'UPDATE SPED2012.DBO.SPED050 SET ';
    if email <> EmptyStr then
      CommAtualizaXMLStatusEnvio.Text := CommAtualizaXMLStatusEnvio.Text +
                                          Format('EMAIL = %s, ', [QuotedStr(LowerCase(email))]);

    CommAtualizaXMLStatusEnvio.Text := CommAtualizaXMLStatusEnvio.Text +
        Format('STATUSMAIL = 1 WHERE DOC_ID = %s', [QuotedStr(IntToStr(NF))]);

  finally
    if not CommAtualizaXMLStatusEnvio.IsPrepared then
      CommAtualizaXMLStatusEnvio.Prepare;

    CommAtualizaXMLStatusEnvio.ExecuteUpdate;
    Mensagem :=
      Format('Status da NF %d atualizado com sucesso! ' + #13 +
              'No próximo ciclo a mesma será enviada para o e-mail: %s.',
              [NF, email] );
    FreeAndNil(CommAtualizaXMLStatusEnvio);
    Result := True;


  end;
end;

function TDSServerModuleEstoque.CorrigePedidoDuplicado (NumPedido : string; out Mensagem : string ) : Boolean;
var
  CommPedido, CommVePedido : TDBXCommand;
  ReaderPedido : TDBXReader;
begin
  Result := False;

  sqlConnEstoque.Open;
  CommVePedido := sqlConnEstoque.DBXConnection.CreateCommand;
  CommVePedido.CommandType := TDBXCommandTypes.DbxSQL;
  CommVePedido.Text := 'SELECT * FROM SC9000 FORA WHERE D_E_L_E_T_ <> ' + QuotedStr('*') +
' AND C9_PEDIDO = ' + QuotedStr(NumPedido) + ' and C9_BLEST = ' + QuotedStr('') +
' AND  C9_PEDIDO+C9_LOTECTL  IN (SELECT C9_PEDIDO+C9_LOTECTL FROM SC9000 DENTRO1 WHERE C9_PEDIDO = ' +
  QuotedStr(NumPedido) + ' AND D_E_L_E_T_ <> ' + QuotedStr('*') +
  '	GROUP BY C9_PEDIDO+C9_LOTECTL HAVING COUNT (C9_LOTECTL) > 1)' +
'AND ABS(C9_SEQUEN)> (SELECT ABS(MIN(C9_SEQUEN)) FROM SC9000 DENTRO2 WHERE C9_PEDIDO = ' + QuotedStr(NumPedido) +
' AND D_E_L_E_T_ <> ' +  QuotedStr('*') + ' and FORA.C9_LOTECTL = dentro2.C9_LOTECTL and C9_BLEST = ' +
  QuotedStr('') + ' GROUP BY C9_PEDIDO+C9_LOTECTL HAVING COUNT (C9_LOTECTL) > 1) ';

  CommPedido := sqlConnEstoque.DBXConnection.CreateCommand;
  CommPedido.CommandType := TDBXCommandTypes.DbxSQL;
  CommPedido.Text := 'UPDATE FORA SET D_E_L_E_T_= ' + QuotedStr('*') + ' from SC9000 FORA ' +
    'WHERE FORA.D_E_L_E_T_ <> ' + QuotedStr('*') + ' AND FORA.C9_PEDIDO = '+ NumPedido + 'AND FORA.C9_BLEST = ' + QuotedStr('') +
    'AND FORA.C9_PEDIDO+FORA.C9_LOTECTL  IN (SELECT DENTRO1.C9_PEDIDO+DENTRO1.C9_LOTECTL FROM SC9000 DENTRO1 ' +
    'WHERE DENTRO1.C9_PEDIDO = ' + NumPedido + ' AND DENTRO1.D_E_L_E_T_ <> ' + QuotedStr('*') +
    'GROUP BY DENTRO1.C9_PEDIDO+DENTRO1.C9_LOTECTL HAVING COUNT (DENTRO1.C9_LOTECTL) > 1) AND ABS(FORA.C9_SEQUEN)> '+
    '(SELECT ABS(MIN(DENTRO2.C9_SEQUEN)) FROM SC9000 DENTRO2 WHERE DENTRO2.C9_PEDIDO = ' + NumPedido +
    ' AND DENTRO2.D_E_L_E_T_ <> ' + QuotedStr('*') + ' and DENTRO2.C9_BLEST = ' + QuotedStr('') +
    ' and FORA.C9_LOTECTL = DENTRO2.C9_LOTECTL GROUP BY DENTRO2.C9_PEDIDO+DENTRO2.C9_LOTECTL ' +
    'HAVING COUNT (DENTRO2.C9_LOTECTL) > 1)';

  if not CommVePedido.IsPrepared then
    CommVePedido.Prepare;

  try
    ReaderPedido := CommVePedido.ExecuteQuery;
    if Assigned(ReaderPedido) then
      begin
        if ReaderPedido.Next then
          begin
            if not CommPedido.IsPrepared then
              CommPedido.Prepare;
            try
              CommPedido.ExecuteUpdate;
              CommPedido.Free;
              Mensagem := 'Update executado com sucesso!';
              Result := True;

            except on E: Exception do
              Mensagem := E.Message
            end;
          end
        else
          begin
            Mensagem := 'Não localizado itens duplicados no pedido: ' + NumPedido + '.';
          end;
      end;
  Finally
    CommVePedido.Free;
  end;
end;

function TDSServerModuleEstoque.CorrigeWMSEmpenhoNegaMerc(NumPedido: string;
  out Mensagem: string): Boolean;
var
  commEmpenhoNega, commUpdate : TDBXCommand;
  Reader : TDBXReader;

begin
  Result := False;
  try
    sqlConnEstoque.Open;
    commEmpenhoNega := sqlConnEstoque.DBXConnection.CreateCommand;
    commEmpenhoNega.CommandType := TDBXCommandTypes.DBXSQL;
    commEmpenhoNega.Text := 'SELECT * FROM SC9000 WHERE C9_PEDIDO = ' +
          QuotedStr(NumPedido) + ' AND D_E_L_E_T_ <> ' + QuotedStr('*');

    if not commEmpenhoNega.isPrepared then
      commEmpenhoNega.Prepare;

    Reader := commEmpenhoNega.ExecuteQuery;
    commEmpenhoNega.Free;

    if Reader.Next then
      begin
        Mensagem := 'Cancele a liberação de itens deste pedido!';
        Result := False;
      end
    else
      begin
        commUpdate := sqlConnEstoque.DBXConnection.CreateCommand;
        commUpdate.CommandType := TDBXCommandTypes.DbxSQL;
        commUpdate.Text := 'UPDATE SC6000 SET C6_QTDEMP = 0 WHERE C6_QTDEMP <> 0 AND C6_NUM = ' +
          QuotedStr(NumPedido);
        if not commUpdate.IsPrepared then
          commUpdate.Prepare;

        commUpdate.ExecuteUpdate;
        Mensagem := 'Empenhos dos produtos ajustados para 0 no pedido ' + NumPedido + '.';
        Result := True;
        commUpdate.Free;
      end;
  except on E: Exception do
    Mensagem := E.Message;
  end;

end;

function TDSServerModuleEstoque.DeletaItemPedidoAFV(NumAFV, CodProduto: string;
  out Mensagem: string): Boolean;
var
  CommDeletaItem : TDBXCommand;
begin
  try
    try
      Result := False;
      sqlConnEstoque.Open;
      CommDeletaItem := sqlConnEstoque.DBXConnection.CreateCommand;
      CommDeletaItem.CommandType := TDBXCommandTypes.DbxSQL;
      CommDeletaItem.Text := Format('delete from AND_PEDIDOITEMERP where NUMPEDIDOAFV = %s and CODIGOPRODUTO = %s',
                              [QuotedStr(NumAFV), QuotedStr(CodProduto)]);
    finally
      if not CommDeletaItem.IsPrepared then
        CommDeletaItem.Prepare;

      CommDeletaItem.ExecuteUpdate;
      Result := True;
      Mensagem:= Format('Produto %s deletado do pedido %s com sucesso!',
                    [QuotedStr(CodProduto), QuotedStr(NumAFV)]);

    end;
  except on E: Exception do
    begin
      Mensagem := E.Message;
      Result := False;
    end;

  end;

end;

function TDSServerModuleEstoque.DeletaPedidoAFV(NumAFV, senha: string;
  out Mensagem: string): Boolean;
var
  CommDeletaPedido, commDeletaItens, commDeletaHeader : TDBXCommand;
begin
  try
    try
      Result := False;
      sqlConnEstoque.Open;
      commDeletaItens := sqlConnEstoque.DBXConnection.CreateCommand;
      commDeletaItens.CommandType := TDBXCommandTypes.DbxSQL;
      commDeletaItens.Text := Format('delete from AND_PEDIDOITEMERP where NUMPEDIDOAFV = %s', [QuotedStr(NumAFV)]);
      CommDeletaPedido := sqlConnEstoque.DBXConnection.CreateCommand;
      CommDeletaPedido.CommandType := TDBXCommandTypes.DbxSQL;
      CommDeletaPedido.Text := Format('delete from AND_PEDIDOERP where NUMPEDIDOAFV = %s', [QuotedStr(NumAFV)]);
      commDeletaHeader := sqlConnEstoque.DBXConnection.CreateCommand;
      commDeletaHeader.CommandType := TDBXCommandTypes.DbxSQL;
      commDeletaHeader.Text := Format('delete from AND_PEDIDOERP_HEADER where NUMPEDIDOAFV = %s', [QuotedStr(NumAFV)]);
    finally
      if not commDeletaItens.IsPrepared then
        commDeletaItens.Prepare;

      if not CommDeletaPedido.IsPrepared then
        CommDeletaPedido.Prepare;

      if not commDeletaHeader.IsPrepared then
        commDeletaHeader.Prepare;



      commDeletaItens.ExecuteUpdate;
      CommDeletaPedido.ExecuteUpdate;
      commDeletaHeader.ExecuteUpdate;
      Result := True;
      Mensagem:= Format('Pedido AFV %s deletado com sucesso!',
                    [QuotedStr(NumAFV)]);
    end;

  except on E: Exception do
    begin
      Mensagem := E.Message;
      Result := False;
    end;
  end;

end;

function TDSServerModuleEstoque.GetClientes(campo: integer;
  parametro: string): TDBXReader;
var
  commClientes : TDBXCommand;
begin
  try
    sqlConnEstoque.Open;
    commClientes := sqlConnEstoque.DBXConnection.CreateCommand;
    commClientes.CommandType := TDBXCommandTypes.DbxSQL;
    case campo of
      0: // Codigo
        begin
          commClientes.Text := 'select A1_COD, A1_CGC, A1_NOME, A1_END, A1_BAIRRO, A1_MUN, A1_TEL, A1_EMAIL, A1_MSBLQL, A3_COD +' +
                    QuotedStr(' - ') + '+ A3_NOME VENDEDOR, A1_LC, E4_DESCRI from SA1000 with(nolock) '                  +
                    'inner join SE4000 on E4_CODIGO = A1_COND inner join SA3000 on A3_COD = A1_VEND where SA1000.D_E_L_E_T_ <> ' +
                    QuotedStr('*') + ' and A1_COD = ' + QuotedStr(StrZero(parametro, 6));
        end;
      1: // Nome
        begin
          commClientes.Text := 'select A1_COD, A1_CGC, A1_NOME, A1_END, A1_BAIRRO, A1_MUN, A1_TEL, A1_EMAIL, A1_MSBLQL, A3_COD +' +
                    QuotedStr(' - ') + '+ A3_NOME VENDEDOR, A1_LC, E4_DESCRI from SA1000 with(nolock) '                  +
                    'inner join SE4000 on E4_CODIGO = A1_COND inner join SA3000 on A3_COD = A1_VEND where SA1000.D_E_L_E_T_ <> ' +
                    QuotedStr('*') + ' and A1_NOME Like ' + QuotedStr( parametro +'%');
        end;
    end;
  finally
    if not commClientes.IsPrepared then
      commClientes.Prepare;

    Result := commClientes.ExecuteQuery;
  end;
end;

function TDSServerModuleEstoque.GetDadosProdutividade(DataIni, DataFim: string;
  out Mensagem: string): TDBXReader;
var
  commProdutividade : TDBXCommand;
begin
  try
    sqlConnEstoque.Open;
    commProdutividade := sqlConnEstoque.DBXConnection.CreateCommand;
    commProdutividade.CommandType := TDBXCommandTypes.DbxSQL;
    commProdutividade.Text := 'select D2_EMISSAO, SUBSTRING(C5_HRETIQ,1,2) HORA_ETIQ, ' +
    'COUNT(Distinct(C5_NUM)) PEDS, sum(D2_QUANT)UNIDADES_SEPARADAS, Round(SUM(D2_TOTAL),2) R$ ' +
    'from sc5000 with(nolock) inner join SD2000 with(nolock) on D2_DOC = C5_NOTA and D2_SERIE = C5_SERIE ' +
    'and D2_PEDIDO = C5_NUM and D2_EMISSAO between ' + QuotedStr(DataIni)+ ' and ' + QuotedStr(DataIni)+ ' ' +
    'and SD2000.D_E_L_E_T_ <> ' + QuotedStr('*') + 'where SC5000.D_E_L_E_T_ <> ' + QuotedStr('*') +
    ' and C5_LIBEROK = ' + QuotedStr('S') + ' and C5_IMPRESS = ' + QuotedStr('S') + ' and C5_NOTA <> '+ QuotedStr('') +
    ' group by D2_EMISSAO, SUBSTRING(C5_HRETIQ,1,2) order by SUBSTRING(C5_HRETIQ,1,2), D2_EMISSAO;';

  finally
    if not commProdutividade.IsPrepared then
      commProdutividade.Prepare;
    Result := commProdutividade.ExecuteQuery;
    Mensagem := 'Dados gerados às ' + FormatDateTime('hh:nn', Now()) + ' do dia ' + FormatDateTime('dd/mm/yyyy', Now());
  end;

end;

function TDSServerModuleEstoque.GetDetalhesPedidoAFV(NUMAFV: string;
  out Mensagem: string): TDBXReader;
var
  CommDetalhesAFV : TDBXCommand;
begin
  try
    sqlConnEstoque.Open;
    CommDetalhesAFV := sqlConnEstoque.DBXConnection.CreateCommand;
    CommDetalhesAFV.CommandType := TDBXCommandTypes.DbxSQL;
    CommDetalhesAFV.Text := Format(
        'SELECT ap.NUMPEDIDOAFV, ap.DATAPEDIDO, ap.CODIGOCLIENTE, ap.CODIGOPRODUTO, ' +
        'ap.CODIGOTABPRECO, ap.QTDEVENDA, ap.VALORVENDA, ap.VALORBRUTO, ap.DESCONTOI, ' +
        'ap.CODIGOVENDEDORESP, ap.CESP_COMISSAO, ap.HORAINICIAL FROM AND_PEDIDOITEMERP ap ' +
        'where ap.NUMPEDIDOAFV = %s;', [QuotedStr(NUMAFV)]);
  finally
    if not CommDetalhesAFV.IsPrepared then
      CommDetalhesAFV.Prepare;

   Result := CommDetalhesAFV.ExecuteQuery;
   Mensagem := Format('Detalhes do Pedido: %s', [NumAFV]);
  end;

end;

function TDSServerModuleEstoque.GetFormulaVitoria(DataIni, DataFim: string;
  out Mensagem: string): TDBXReader;
var
  commFormulaVitoria : TDBXCommand;
begin
  try
    sqlConnEstoque.Open;
    commFormulaVitoria := sqlConnEstoque.DBXConnection.CreateCommand;
    commFormulaVitoria.CommandType := TDBXCommandTypes.DbxSQL;
    commFormulaVitoria.Text :=  'select ' + QuotedStr('66438011000166') + ' ' + QuotedStr('CNPJ DISTRIBUIDOR') +
    ', A3_COD ' + QuotedStr('MATRICULA COLABORADOR') + ', B1_CODBAR EAN, B1_DESC DESCRICAO, D2_QUANT QUANTIDADE, ' +
    'substring(D2_EMISSAO, 7,2)+' + QuotedStr('/')+ ' + substring(D2_EMISSAO, 5,2)+' + QuotedStr('/')+ '+substring(D2_EMISSAO, 1,4) DATA_VENDA, ' +
    'A1_CGC ' + QuotedStr('CNPJ PDV') + ', SUBSTRING(D2_EMISSAO, 5, 2) MES, SUBSTRING(D2_EMISSAO, 1, 4) ANO ' +
    'from SD2000  with(nolock) inner join SC5000 with(nolock) on C5_NOTA = D2_DOC and C5_SERIE = D2_SERIE ' +
    'and C5_EMISSAO between ' + QuotedStr('20140125') + ' and ' + QuotedStr(DataFim) + ' and C5_TIPOVEN in (' +
    QuotedStr('V') + ',' + QuotedStr('T') + ', ' + QuotedStr('A') + ') inner join SA1000 with(nolock) on A1_COD = D2_CLIENTE and A1_COD = C5_CLIENTE ' +
    'inner join SB1000 with(nolock) on B1_COD = D2_COD left join SA3000 with(nolock) on A3_COD = C5_VEND1 ' +
    'where D2_TIPO <> ' + QuotedStr('D') + ' and D2_EMISSAO between ' + QuotedStr(DataIni) + ' and ' +
    QuotedStr(DataFim) + ' and SD2000.D_E_L_E_T_ <> ' + QuotedStr('*') + ' and D2_GRUPO = ' + QuotedStr('6902') + ';';
  finally
    if not commFormulaVitoria.IsPrepared then
      commFormulaVitoria.Prepare;

    Result := commFormulaVitoria.ExecuteQuery;
    Mensagem := Format('Fórmula da vitória contendo dados de %s à %s', [
                          Copy(DataIni, 7, 2) + '/' + Copy(DataIni, 5, 2) + '/' + Copy(DataIni, 1, 4),
                          Copy(DataFim, 7, 2) + '/' + Copy(DataFim, 5, 2) + '/' + Copy(DataFim, 1, 4) ]);
  end;

end;

function TDSServerModuleEstoque.GetVendaLiquida(DataIni, DataFim: string;
  out Mensagem: string): TDBXReader;
var
  commVendaLiquida : TDBXCommand;
begin
  try
    sqlConnEstoque.Open;
    commVendaLiquida := sqlConnEstoque.DBXConnection.CreateCommand;
    commVendaLiquida.CommandType := TDBXCommandTypes.DbxSQL;
    commVendaLiquida.Text := '';
  finally
    if not commVendaLiquida.IsPrepared then
      commVendaLiquida.Prepare;

    Result := commVendaLiquida.ExecuteQuery;
  end;

end;

function TDSServerModuleEstoque.GetVendedores(campo: integer;
  parametro: string): TDBXReader;
var
  commVendedores : TDBXCommand;
begin
  try
    sqlConnEstoque.Open;
    commVendedores := sqlConnEstoque.DBXConnection.CreateCommand;
    commVendedores.CommandType := TDBXCommandTypes.DbxSQL;
    case campo of
      0: //Codigo
        begin
          commVendedores.Text :=  'select A3_GEREN GER,A3_COD VEND, A3_NOME VENDEDOR, A3_XSETOR SETOR, +'           +
          QuotedStr('(') + ' + substring(A3_CELULAR, 1, 2)+' + QuotedStr(')') + '+ substring(A3_CELULAR, 3, 4) + '  +
          QuotedStr(' - ') + ' + substring(A3_CELULAR, 7, 4) CEL_VIVO_CORP, +'                                      +
          QuotedStr('(') + ' + substring(A3_TEL, 1, 2) +' + QuotedStr(') ') + '+ substring(A3_TEL, 3, 4) + '        +
          QuotedStr(' - ') + '+ substring(A3_TEL, 7, 4) TEL, +'                                                     +
	        QuotedStr('(') + ' + substring(A3_XCELEMP, 1, 2) + ' + QuotedStr(') ') +'+ substring(A3_XCELEMP, 3, 4) + '+
          QuotedStr(' - ') + ' + substring(A3_XCELEMP, 7, 4) CEL_OUTRO, A3_END ENDERECO, A3_BAIRRO BAIRRO, '        +
          'substring(A3_CEP, 1,5) + '+ QuotedStr('-') + ' + substring(A3_CEP, 6,3) CEP, A3_MUN CIDADE, A3_EMAIL E_MAIL, ' +
          'substring(A3_XADMISS, 7,2) + '+ QuotedStr('-') + ' + substring(A3_XADMISS, 5,2) + ' + QuotedStr('-')     +
          ' + substring(A3_XADMISS, 1,4) DT_ADMIS from sa3000 with(nolock) where A3_MSBLQL <> 1 and SA3000.D_E_L_E_T_ <> ' +
          QuotedStr('*') + ' and A3_COD = ' + QuotedStr(StrZero(parametro, 6))
        end;
      1: //Nome
        begin
          commVendedores.Text :=  'select A3_GEREN GER,A3_COD VEND, A3_NOME VENDEDOR, A3_XSETOR SETOR, +'           +
          QuotedStr('(') + ' + substring(A3_CELULAR, 1, 2)+' + QuotedStr(')') + '+ substring(A3_CELULAR, 3, 4) + '  +
          QuotedStr(' - ') + ' + substring(A3_CELULAR, 7, 4) CEL_VIVO_CORP, +'                                      +
          QuotedStr('(') + ' + substring(A3_TEL, 1, 2) +' + QuotedStr(') ') + '+ substring(A3_TEL, 3, 4) + '        +
          QuotedStr(' - ') + '+ substring(A3_TEL, 7, 4) TEL, +'                                                     +
	        QuotedStr('(') + ' + substring(A3_XCELEMP, 1, 2) + ' + QuotedStr(') ') +'+ substring(A3_XCELEMP, 3, 4) + '+
          QuotedStr(' - ') + ' + substring(A3_XCELEMP, 7, 4) CEL_OUTRO, A3_END ENDERECO, A3_BAIRRO BAIRRO, '        +
          'substring(A3_CEP, 1,5) + '+ QuotedStr('-') + ' + substring(A3_CEP, 6,3) CEP, A3_MUN CIDADE, A3_EMAIL E_MAIL, ' +
          'substring(A3_XADMISS, 7,2) + '+ QuotedStr('-') + ' + substring(A3_XADMISS, 5,2) + ' + QuotedStr('-')     +
          ' + substring(A3_XADMISS, 1,4) DT_ADMIS from sa3000 with(nolock) where A3_MSBLQL <> 1 and SA3000.D_E_L_E_T_ <> ' +
          QuotedStr('*') + ' and A3_NOME LIKE ' + QuotedStr(UpperCase(parametro)+'%')
        end;
      2: //Gerente
        begin
          commVendedores.Text :=  'select A3_GEREN GER,A3_COD VEND, A3_NOME VENDEDOR, A3_XSETOR SETOR, +'           +
          QuotedStr('(') + ' + substring(A3_CELULAR, 1, 2)+' + QuotedStr(')') + '+ substring(A3_CELULAR, 3, 4) + '  +
          QuotedStr(' - ') + ' + substring(A3_CELULAR, 7, 4) CEL_VIVO_CORP, +'                                      +
          QuotedStr('(') + ' + substring(A3_TEL, 1, 2) +' + QuotedStr(') ') + '+ substring(A3_TEL, 3, 4) + '        +
          QuotedStr(' - ') + '+ substring(A3_TEL, 7, 4) TEL, +'                                                     +
	        QuotedStr('(') + ' + substring(A3_XCELEMP, 1, 2) + ' + QuotedStr(') ') +'+ substring(A3_XCELEMP, 3, 4) + '+
          QuotedStr(' - ') + ' + substring(A3_XCELEMP, 7, 4) CEL_OUTRO, A3_END ENDERECO, A3_BAIRRO BAIRRO, '        +
          'substring(A3_CEP, 1,5) + '+ QuotedStr('-') + ' + substring(A3_CEP, 6,3) CEP, A3_MUN CIDADE, A3_EMAIL E_MAIL, ' +
          'substring(A3_XADMISS, 7,2) + '+ QuotedStr('-') + ' + substring(A3_XADMISS, 5,2) + ' + QuotedStr('-')     +
          ' + substring(A3_XADMISS, 1,4) DT_ADMIS from sa3000 with(nolock) where A3_MSBLQL <> 1 and SA3000.D_E_L_E_T_ <> ' +
          QuotedStr('*') + ' and A3_GEREN = ' + QuotedStr(StrZero(parametro, 6))
        end;
    end;

  finally
    if not commVendedores.IsPrepared then
      commVendedores.Prepare;

    Result := commVendedores.ExecuteQuery;
  end;

end;

function TDSServerModuleEstoque.GetWMSExportOSSemSucesso(
  out Mensagem: string): TDBXReader;
var
  Comm : TDBXCommand;
begin
  try
    sqlConnEstoque.Open;
    Comm := sqlConnEstoque.DBXConnection.CreateCommand;
    Comm.CommandType := TDBXCommandTypes.DbxSQL;
    Comm.Text := 'select C5_NUM PEDIDO, C5_EMISSAO EMISSAO, C5_HRGRV ' +
       'HR_GRAVACAO, C5_HRIMP HR_ENVIO from SC5000 with(nolock) where ' +
       'C5_EMISSAO > GetDate() -7 and D_E_L_E_T_ <> ' + QuotedStr('*') + ' and ' +
       'C5_NOTA = ' + QuotedStr('') + 'and C5_NUM not in ' +
       '(select NUM_PEDIDO_INF from wms.dbo.IMS_HEADERORDEMSAIDA where ' +
       'DATA_INCLUSAO > Getdate()-7) and C5_IMPRESS = ' + QuotedStr('S') + ';'
  finally
    if not Comm.IsPrepared then
      Comm.Prepare;

    Result := Comm.ExecuteQuery;
    Mensagem := 'Pedidos que não chegaram no WMS';

  end;

end;

function TDSServerModuleEstoque.GetWMSItensOrdemSaidasRecusadas(
  out Mensagem: string): TDBXReader;
var
  Comm : TDBXCommand;
begin
  try
    try
      sqlConnEstoque.Open;
      Comm := sqlConnEstoque.DBXConnection.CreateCommand;
      Comm.CommandType := TDBXCommandTypes.DbxSQL;
      Comm.Text :=  'select i.SEQUENCIA SEQ_ITEM, h.num_pedido PEDIDO, ' +
         'h.NUM_ORD_SAI, i.SEQUENCIA_HEADER, i.COD_PRODUTO, B1_DESC ' +
         'APRESENTACAO, i.QTDE_PEDIDA, i.DESCR_ERRO, i.FLAG_PROCESSAMENTO, ' +
         'i.DATA_PROCESSAMENTO from wms.dbo.IMS_ITEMORDEMSAIDA i inner join ' +
         'wms.dbo.IMS_HEADERORDEMSAIDA h on h.NUM_ORD_SAI = i.NUM_ORD_SAI inner ' +
         'join SB1000 with(nolock) on B1_COD COLLATE DATABASE_DEFAULT = ' +
         'i.COD_PRODUTO WHERE (i.FLAG_PROCESSAMENTO = 2 or i.FLAG_PROCESSAMENTO = ' +
         '0) and i.NUM_ORD_SAI not in (select NUM_ORD_SAI from ' +
         'wms.dbo.IMS_HEADERORDEMSAIDA WHERE (FLAG_PROCESSAMENTO = 0 or ' +
         'FLAG_PROCESSAMENTO = 1)) '
    finally
      if not Comm.IsPrepared then
        Comm.Prepare;

      Result := Comm.ExecuteQuery;
      Mensagem := 'Itens de Pedidos com problemas'


    end;

  except on E: Exception do
    Mensagem := E.Message;
  end;

end;

function TDSServerModuleEstoque.GetWMSMovtosEstoqueItem(
  out Mensagem: string): TDBXReader;
var
  CommMovto : TDBXCommand;
begin
  try
    try
      sqlConnEstoque.Open;
      CommMovto := sqlConnEstoque.DBXConnection.CreateCommand;
      CommMovto.CommandType := TDBXCommandTypes.DbxSQL;
      CommMovto.Text := 'select * from wms.dbo.IMS_RETMOVTOESTOQUEITEM where ' +
         'FLAG_PROCESSAMENTO = 0';

    finally
      if not CommMovto.IsPrepared then
        CommMovto.Prepare;

      Result := CommMovto.ExecuteQuery;
      Mensagem := 'Relatório de Movimentacao de Estoque WMS';

    end;
  except on E: Exception do
    Mensagem := E.Message;
  end;


end;

function TDSServerModuleEstoque.GetWMSOrdemEntradaDivergencias(
  out Mensagem: string): TDBXReader;
var
  CommWMSOrdemEntradaDivergencias : TDBXCommand;
begin
  sqlConnEstoque.Close;
  try
    try
      sqlConnEstoque.Open;
      CommWMSOrdemEntradaDivergencias :=
         sqlConnEstoque.DBXConnection.CreateCommand;
      CommWMSOrdemEntradaDivergencias.CommandType := TDBXCommandTypes.DbxSQL;
      CommWMSOrdemEntradaDivergencias.Text := 'select h.nota_fiscal, h.serie, ' +
        'h.data_emissao, h.codigo_emit, rh.flag_divergencia, ' +
        'e.num_ord_ent, e.cod_produto, e.num_lote LOTE_NF, e.data_validade ' +
        'VALIDADE_NF, e.qtde_a_receber , r.num_lote LOTE_RECEBIDO, ' +
        'r.DATA_VALIDADE VALIDADE_REC, r.qtde_recebida, e.data_processamento, ' +
        'e.data_inclusao inclusao_entrada, r.data_inclusao inclusao_retorno ' +
        'from wms.dbo.ims_retitemxloteordementrada r ' +
        'inner join wms.dbo.ims_retheaderordementrada rh on rh.num_ord_ent = ' +
        'r.num_ord_ent inner join wms.dbo.ims_headerordementrada h on ' +
        'h.num_ord_ent = r.num_ord_ent inner join ' +
        'wms.dbo.ims_itemxloteordementrada ' +
        ' e on r.num_ord_ent = e.num_ord_ent and	e.cod_produto = r.cod_produto ' +
        'and e.num_lote = r.num_lote ' +
        //pegar só as diferencas
        'and e.qtde_a_receber <> r.qtde_recebida where r.FLAG_PROCESSAMENTO = ' +
        '0 and e.num_ord_ent = r.num_ord_ent union all ' +
//        'and FLAG_DIVERGENCIA = ' + QuotedStr('S') + ' union all ' +
        //-- itens que estão no retorno WMS e não estão no envio WMS
        'select h.nota_fiscal, h.serie, h.data_emissao, h.codigo_emit, ' +
        'rh.flag_divergencia, r.num_ord_ent, r.cod_produto,ISNULL(num_lote, '+
        QuotedStr('-') + '), ISNULL(data_VALIDADE,' + QuotedStr('') +
        '), ' + QuotedStr('0') + ' qtde_a_receber, ' +
        'r.num_lote, r.DATA_VALIDADE VALIDADE_REC,' +
        'r.qtde_recebida, r.DATA_PROCESSAMENTO, h.DATA_INCLUSAO, ' +
        'r.data_inclusao from wms.dbo.ims_retitemxloteordementrada r inner ' +
        'join wms.dbo.ims_retheaderordementrada rh on rh.num_ord_ent = ' +
//        'r.num_ord_ent and rh.FLAG_DIVERGENCIA = ' + QuotedStr('S') + ' inner'
        'r.num_ord_ent inner join wms.dbo.ims_headerordementrada h on ' +
        'h.num_ord_ent = r.num_ord_ent ' +
        'where r.FLAG_PROCESSAMENTO = 0 and r.num_lote not in( select ' +
        'd.num_lote from wms.dbo.ims_itemxloteordementrada d where ' +
        'd.num_ord_ent = r.num_ord_ent and r.cod_produto = d.cod_produto) order ' +
        'by e.cod_produto '
    finally
      if not CommWMSOrdemEntradaDivergencias.IsPrepared then
        CommWMSOrdemEntradaDivergencias.Prepare;

      Result := CommWMSOrdemEntradaDivergencias.ExecuteQuery;
      Mensagem := 'Lotes com divergências nas entradas';
    end;

  except on E: Exception do
    Mensagem := e.Message;

  end;

end;

function TDSServerModuleEstoque.GetWMSOrdemSaidaConferir(
  out Mensagem: string): TDBXReader;
var
  Comm : TDBXCommand;
begin
  try
    try
      sqlConnEstoque.Open;
      Comm := sqlConnEstoque.DBXConnection.CreateCommand;
      Comm.CommandType := TDBXCommandTypes.DbxSQL;
      Comm.Text := 'select C5_NUM, NUM_ORD_SAI, C5_EMISSAO, C5_HRGRV, ' +
         'h.DATA_PROCESSAMENTO, C5_IMPRESS, C5_HRIMP, C5_TRANSP, 	' +
         'h.FLAG_PROCESSAMENTO from wms.dbo.IMS_HEADERORDEMSAIDA h inner join ' +
         'SC5000 with(nolock) on C5_NUM = NUM_PEDIDO and C5_EMISSAO > GetDate()-10 and D_E_L_E_T_ = ' +
         QuotedStr('') + ' and C5_NOTA = ' + QuotedStr('') + ' where NUM_ORD_SAI ' +
         'not in ( select NUM_ORD_SAI from wms.dbo.IMS_RETHEADERORDEMSAIDA where ' +
         'FLAG_PROCESSAMENTO <> 0) and DATA_INCLUSAO > convert(nvarchar, GETDATE(' +
         '), 112) order by sequencia desc '
    finally
      if not Comm.IsPrepared then
        Comm.Prepare;

      Result := Comm.ExecuteQuery;
      Mensagem := 'Pedidos a serem conferidos no WMS';
    end;
  except on E: Exception do
    Mensagem := E.Message;
  end;

end;

function TDSServerModuleEstoque.GetWMSOrdemSaidasRecusadas(
  out Mensagem: string): TDBXReader;
var
  Comm : TDBXCommand;
begin
  try
    try
      sqlConnEstoque.Open;
      Comm := sqlConnEstoque.DBXConnection.CreateCommand;
      Comm.Text := 'select C5_NUM PEDIDO_ERP, NUM_ORD_SAI ORDEM_SAIDA, ' +
         'C5_EMISSAO EMISSAO_ERP, C5_HRGRV GRAVACAO_ERP, h.DATA_PROCESSAMENTO ' +
         'HR_WMS, C5_IMPRESS IMPRESS, C5_HRIMP HR_IMP, C5_TRANSP TRANSP_ERP, ' +
         'h.FLAG_PROCESSAMENTO, h.DESCR_ERRO from ' +
         'wms.dbo.IMS_HEADERORDEMSAIDA h inner join SC5000 with(nolock) on ' +
         'C5_NUM = NUM_PEDIDO and D_E_L_E_T_ <> '+ QuotedStr('*') + 'and ' +
         'C5_NOTA = ' + QuotedStr('') + 'where flag_processamento = 2 and ' +
         'NUM_ORD_SAI not in (select NUM_ORD_SAI from ' +
         'wms.dbo.IMS_HEADERORDEMSAIDA WHERE FLAG_PROCESSAMENTO = 0 or ' +
         'FLAG_PROCESSAMENTO = 1) ORDER BY DATA_PROCESSAMENTO desc;';

    finally
      if not Comm.IsPrepared then
        Comm.Prepare;

      Result := Comm.ExecuteQuery;
      Mensagem := 'Pedidos recusados no WMS - Acertar'

    end;
  except on E: Exception do
    Mensagem := E.Message;
  end;
end;

function TDSServerModuleEstoque.GetWMSOrdemSaidaToERP(
  out Mensagem: string): TDBXReader;
var
  Command : TDBXCommand;
begin
  try
    try
      sqlConnEstoque.Open;
      Command := sqlConnEstoque.DBXConnection.CreateCommand;
      Command.CommandType := TDBXCommandTypes.DbxSQL;
      Command.Text := 'select hos.NUM_ORD_SAI, hos.num_pedido PEDIDO, ' +
         'hos.COD_CLIENTE, hos.QTDE_ITENS, hos.DATA_INCLUSAO DT_TOWMS, ret.VOLUMES_TOTAL, ' +
         'ret.DATA_INCLUSAO DT_RET from wms.dbo.IMS_RETHEADERORDEMSAIDA ret left join ' +
         'wms.dbo.IMS_headerordemsaida hos on hos.num_ord_sai = ret.num_ord_sai ' +
         'WHERE ret.FLAG_PROCESSAMENTO = 0 order by PEDIDO';
    finally
      if not Command.IsPrepared then
        Command.Prepare;

      Result := Command.ExecuteQuery;
      Mensagem := 'Pedidos a retornar do WMS';


    end;
  except on E: Exception do
    Mensagem := E.Message;
  end;


end;

function TDSServerModuleEstoque.GetWMSPedidosRetornadosXHora(
  out Mensagem: string): TDBXReader;
var
  Comm : TDBXCommand;
begin
  try
    try
      sqlConnEstoque.Open;
      Comm := sqlConnEstoque.DBXConnection.CreateCommand;
      Comm.CommandType := TDBXCommandTypes.DbxSQL;
      Comm.Text := 'select DATEPART(HH, DATA_INCLUSAO) HORA_RETORNO, COUNT(' +
         'Distinct(NUM_ORD_SAI)) PROCESSADOS_WMS from ' +
         'wms.dbo.IMS_RETHEADERORDEMSAIDA where DATA_INCLUSAO > convert(' +
         'nvarchar, GETDATE(), 112) and FLAG_PROCESSAMENTO = 1 group by ' +
         'DATEPART(HH, DATA_INCLUSAO) order by HORA_RETORNO ';
    finally
      if not Comm.IsPrepared then
        Comm.Prepare;

      Result := Comm.ExecuteQuery;
      Mensagem := 'Pedidos processados por Hora';
    end;
  except on E: Exception do
    Mensagem := E.Message;
  end;

end;

function TDSServerModuleEstoque.GetXMLStatusEnvio(NF: integer;
  out Mensagem: string): TDBXReader;
var
  CommXMLStatusEnv : TDBXCommand;
begin
  Mensagem := EmptyStr;
 // Passar função de Buscar o XMLStatus na Sped050
 if (IntToStr(NF) = EmptyStr )or (NF = 0) then
  begin
    Mensagem := 'Valor do campo Nota Fiscal inválido!';
    Result := nil;

  end;

 try
  sqlConnEstoque.Open;
  CommXMLStatusEnv := sqlConnEstoque.DBXConnection.CreateCommand;
  CommXMLStatusEnv.CommandType := TDBXCommandTypes.DbxSQL;
  CommXMLStatusEnv.Text :=
        Format('select NFE_ID, DATE_NFE, TIME_NFE, DATE_ENFE, TIME_ENFE, TIME_GXML, STATUSMAIL, EMAIL ' +
            'from SPED2012.DBO.SPED050 with(nolock) where DATE_NFE between %s and GetDate() and DOC_ID = %u ',
            ['20140601', NF]);
 finally
  if not CommXMLStatusEnv.IsPrepared then
    CommXMLStatusEnv.Prepare;

  Result := CommXMLStatusEnv.ExecuteQuery;
 end;

end;

function TDSServerModuleEstoque.ZerarSTNF(Senha, NF: string;
  out Mensagem: string): Boolean;
var
  Script : TDBXCommand;
begin
  if Senha = '44752463' then
    begin
      try
        try
          sqlConnEstoque.Open;
          Script := sqlConnEstoque.DBXConnection.CreateCommand;
          Script.CommandType := TDBXCommandTypes.DbxSQL;
          Script.Text := Format('UPDATE SF3000 SET F3_ICMSRET=0,F3_BASERET=0 WHERE ' +
             'F3_NFISCAL = %s; UPDATE SF2000 SET F2_ICMSRET=0,F2_BRICMS=0 WHERE ' +
             'F2_DOC = %s; UPDATE SD2000 SET D2_ICMSRET=0,D2_BRICMS=0 WHERE ' +
             'D2_DOC = %s;', [QuotedStr(NF), QuotedStr(NF), QuotedStr(NF)]);
        finally
          if not Script.IsPrepared then
            Script.Prepare;

          Script.ExecuteUpdate;
          Mensagem := Format('ST da NF %s retirada com sucesso!', [NF]);
          FreeAndNil(Script);
          Result := True;

        end;
      except on E: Exception do
        Mensagem := E.Message;
      end;
    end
  else
    begin
      Result := False;
      Mensagem := 'Senha inválida!'
    end;



end;
function TDSServerModuleEstoque.ValidaCliente(CNPJ: string;
  out Mensagem: string): String;
var
  Comm : TDBXCommand;
  RDCli : TDBXReader;
begin
  try
    sqlConnEstoque.Open;
    comm := sqlConnEstoque.DBXConnection.CreateCommand;
    Comm.CommandType := TDBXCommandTypes.DbxSQL;
    Comm.Text := Format('Select A1_COD, A1_CGC, A1_MSBLQL, D_E_L_E_T_ from SA1000 with(nolock) ' +
                  'where A1_CGC = %s and D_E_L_E_T_ <> %s order by A1_COD', [QuotedStr(CNPJ), QuotedStr('*')]);                  
  finally
    if not Comm.IsPrepared then
      Comm.Prepare;

    RDCli := Comm.ExecuteQuery;
    if Assigned(RDCli) then
      begin
        RDCli.Next;
        Result := RDCli.Value[0].GetAnsiString;
        Mensagem := RDCli.GetOrdinal('A1_CGC').ToString;
        RDCli.Free;
      end;
  end;
end;
function TDSServerModuleEstoque.GetNFCliente(CodigoCliente, NF: string;
  out Mensagem: string): Boolean;
var
  Comm : TDBXCommand;
  Reader : TDBXReader;
begin
  try
    sqlConnEstoque.Open;
    Comm := sqlConnEstoque.DBXConnection.CreateCommand;
    Comm.CommandType := TDBXCommandTypes.DbxSQL;
    Comm.Text := Format('select f2_doc, f2_cliente from sf2000 with(nolock)' +
            'where f2_doc = %s and f2_cliente = %s and D_E_L_E_T_ <> %s ', 
            [QuotedStr(NF), QuotedStr(CodigoCliente), QuotedStr('*')] );
  finally
    if not Comm.IsPrepared then
      Comm.Prepare;

    Reader := Comm.ExecuteQuery;

    if Assigned(Reader) then
      begin
        Result := Reader.Next;
        Mensagem := Reader.Value[0].GetAnsiString; 
      end;
  end;
  
end;

function TDSServerModuleEstoque.ValidaSenhaDelPed(NumAFV, senha: string;
  out Mensagem: string): Boolean;
var
  chave : string;
begin
  Result := False;
  chave := IntToStr(StrToInt(AnsiMidStr(NumAFV, 1, 2)) + DayOfTheMonth(Now()))+
           IntToStr(StrToInt(AnsiMidStr(NumAFV, Length(NumAFV)-1, 2)) + MonthOfTheYear(Now())) ;
  if chave = senha then
    begin
      Result := True;
      Mensagem := 'Senha validada';
    end
  else
    begin
        Result := False;
        Mensagem := 'Senha Inválida!';
    end;

end;

function TDSServerModuleEstoque.GetAFVImportar(out MSG: string) : TDBXReader;
var
  commPeds : TDBXCommand;
begin
  try
    sqlConnEstoque.Open;
    commPeds := sqlConnEstoque.DBXConnection.CreateCommand;
    commPeds.CommandType := TDBXCommandTypes.DbxSQL;
    commPeds.Text := 'SELECT * FROM AND_PEDIDOERP_HEADER aph WHERE aph.STATUS IS null';
  finally
    if not commPeds.IsPrepared then
      commPeds.Prepare;

    Result := commPeds.ExecuteQuery;
    MSG := 'Pedidos de venda a importar';
  end;



end;

function TDSServerModuleEstoque.GetGiroSimples(Grupo, DataIni,
  DataFim: string): TDBXReader;
var
  CommGiro : TDBXCommand;
begin
  try
    sqlConnEstoque.Open;
    CommGiro := sqlconnEstoque.DBXConnection.CreateCommand;
    CommGiro.CommandType := TDBXCommandTypes.DbxSQL;

    if DataIni.IsEmpty then
      DataIni := FormatDateTime('yyyymmdd', Now());

    if DataFim.IsEmpty then
      DataFim := DataIni;

    CommGiro.Text := 'select CODIGO, EAN, DESCRICAO, ESTOQUE_VENDA, isnull(SUM(D2_QUANT), 0) QTD_VENDIDA ' +
      'from( select b1_cod CODIGO, B1_CODBAR EAN, b1_desc DESCRICAO, isnull(sum(b2_qatu),0) ESTOQUE_VENDA '       +
      'from sb1000 with(nolock) left join SB2000 with(nolock) on B2_COD = B1_COD and  SB2000.D_E_L_E_T_ = '       +
      QuotedStr('') + ' and b2_local in (' + QuotedStr('01') + ', ' + QuotedStr('02')                     +
      ') where b1_grupo <= ' + QuotedStr('9801') + ' and B1_MSBLQL <> 1 and sb1000.D_E_L_E_T_ = ' + QuotedStr('') +
      ' and B1_GRUPO in (' + Grupo + ') group by B1_COD, B1_CODBAR, B1_DESC) estoque ' +
      ' left join SD2000 with(nolock) on D2_COD = estoque.CODIGO and D2_EMISSAO BETWEEN ' + QuotedStr(DataIni) + ' AND ' + QuotedStr(DataFim) +
      ' AND D2_TIPO <> ' + QuotedStr('D') + ' AND D2_CLIENTE <> ' + QuotedStr('001668') + ' group by CODIGO, EAN, DESCRICAO, ESTOQUE_VENDA order by DESCRICAO ';

  finally
    if not CommGiro.IsPrepared then
      CommGiro.Prepare;
     Result := CommGiro.ExecuteQuery;
  end;

end;

end.

