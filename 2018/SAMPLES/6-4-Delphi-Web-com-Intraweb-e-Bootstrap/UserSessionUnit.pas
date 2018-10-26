unit UserSessionUnit;

{
  This is a DataModule where you can add components or declare fields that are specific to 
  ONE user. Instead of creating global variables, it is better to use this datamodule. You can then
  access the it using UserSession.
}
interface

uses
  IWUserSessionBase, SysUtils, Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase;

type
  TIWUserSession = class(TIWUserSessionBase)
    FDConnection1: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQProdutos: TFDQuery;
    FDQProdutosCOD_PRODUTO: TIntegerField;
    FDQProdutosCOD_FABRICANTE: TIntegerField;
    FDQProdutosCOD_FORNECEDOR: TIntegerField;
    FDQProdutosCOD_GRUPO: TIntegerField;
    FDQProdutosCOD_NCM: TIntegerField;
    FDQProdutosPROD_CADASTRO: TDateField;
    FDQProdutosPROD_ATUALIZACAO: TDateField;
    FDQProdutosPROD_DESCRICAO: TStringField;
    FDQProdutosPROD_COD_BARRA: TStringField;
    FDQProdutosPROD_REF_FABRICA: TStringField;
    FDQProdutosPROD_NCM: TStringField;
    FDQProdutosPROD_UN: TStringField;
    FDQProdutosPROD_PESO_LIQ: TBCDField;
    FDQProdutosPROD_PESO_BRUTO: TBCDField;
    FDQProdutosPROD_CFOP_ENTRADA: TStringField;
    FDQProdutosPROD_ESTOQUE: TBCDField;
    FDQProdutosPROD_ALERTA: TBCDField;
    FDQProdutosPROD_LOCALIZACAO: TStringField;
    FDQProdutosPROD_ULTIMA_VENDA: TDateField;
    FDQProdutosPROD_ULTIMA_COMPRA: TDateField;
    FDQProdutosPROD_MARCA: TStringField;
    FDQProdutosPROD_FORNECDOR: TStringField;
    FDQProdutosPROD_GRUPO: TStringField;
    FDQProdutosPROD_CUSTO: TBCDField;
    FDQProdutosPROD_POR_IPI: TBCDField;
    FDQProdutosPROD_POR_FRETE: TBCDField;
    FDQProdutosPROD_POR_TRIB: TBCDField;
    FDQProdutosPROD_POR_ICMS_DEBITO: TBCDField;
    FDQProdutosPROD_POR_ICMS_CREDITO: TBCDField;
    FDQProdutosPROD_ICMS_PAGAR: TBCDField;
    FDQProdutosPROD_POR_FEDERAL: TBCDField;
    FDQProdutosPROD_POR_CUSTO_FIXO: TBCDField;
    FDQProdutosPROD_POR_COMISSAO: TBCDField;
    FDQProdutosPROD_PRECO_FINAL: TBCDField;
    FDQProdutosPROD_MARGEM_LUCRO: TBCDField;
    FDQProdutosPROD_PRECO_VENDA: TBCDField;
    FDQProdutosPROD_INFO_ADICIONAIS: TStringField;
    FDQProdutosPROD_IMAGEM: TStringField;
    FDQProdutosPROD_ORIGEM: TIntegerField;
    FDQProdutosPROD_CSOSN: TIntegerField;
    FDQProdutosPROD_PIS: TIntegerField;
    FDQProdutosPROD_COFINS: TIntegerField;
    FDQProdutosPROD_IPI: TIntegerField;
    FDQProdutosPROD_TOTAL_COMPRADO: TBCDField;
    FDQProdutosCOD_FINALIDADE: TIntegerField;
    FDQProdutosCOD_STATUS: TIntegerField;
    FDQProdutosCOD_LINHA: TIntegerField;
    FDQProdutosCOD_SIMILAR: TStringField;
    FDQProdutosPROD_SUBST_POR: TBCDField;
    FDQProdutosPROD_PROD_IMPOSTO: TBCDField;
    FDQProdutosCOD_CFOP: TIntegerField;
    FDQQuery: TFDQuery;
    FDQProdutos2: TFDQuery;
    FDQProdutos2COD_PRODUTO: TIntegerField;
    FDQProdutos2COD_FABRICANTE: TIntegerField;
    FDQProdutos2COD_FORNECEDOR: TIntegerField;
    FDQProdutos2COD_GRUPO: TIntegerField;
    FDQProdutos2COD_NCM: TIntegerField;
    FDQProdutos2PROD_CADASTRO: TDateField;
    FDQProdutos2PROD_ATUALIZACAO: TDateField;
    FDQProdutos2PROD_DESCRICAO: TStringField;
    FDQProdutos2PROD_COD_BARRA: TStringField;
    FDQProdutos2PROD_REF_FABRICA: TStringField;
    FDQProdutos2PROD_NCM: TStringField;
    FDQProdutos2PROD_UN: TStringField;
    FDQProdutos2PROD_PESO_LIQ: TBCDField;
    FDQProdutos2PROD_PESO_BRUTO: TBCDField;
    FDQProdutos2PROD_CFOP_ENTRADA: TStringField;
    FDQProdutos2PROD_ESTOQUE: TBCDField;
    FDQProdutos2PROD_ALERTA: TBCDField;
    FDQProdutos2PROD_LOCALIZACAO: TStringField;
    FDQProdutos2PROD_ULTIMA_VENDA: TDateField;
    FDQProdutos2PROD_ULTIMA_COMPRA: TDateField;
    FDQProdutos2PROD_MARCA: TStringField;
    FDQProdutos2PROD_FORNECDOR: TStringField;
    FDQProdutos2PROD_GRUPO: TStringField;
    FDQProdutos2PROD_CUSTO: TBCDField;
    FDQProdutos2PROD_POR_IPI: TBCDField;
    FDQProdutos2PROD_POR_FRETE: TBCDField;
    FDQProdutos2PROD_POR_TRIB: TBCDField;
    FDQProdutos2PROD_POR_ICMS_DEBITO: TBCDField;
    FDQProdutos2PROD_POR_ICMS_CREDITO: TBCDField;
    FDQProdutos2PROD_ICMS_PAGAR: TBCDField;
    FDQProdutos2PROD_POR_FEDERAL: TBCDField;
    FDQProdutos2PROD_POR_CUSTO_FIXO: TBCDField;
    FDQProdutos2PROD_POR_COMISSAO: TBCDField;
    FDQProdutos2PROD_PRECO_FINAL: TBCDField;
    FDQProdutos2PROD_MARGEM_LUCRO: TBCDField;
    FDQProdutos2PROD_PRECO_VENDA: TBCDField;
    FDQProdutos2PROD_INFO_ADICIONAIS: TStringField;
    FDQProdutos2PROD_IMAGEM: TStringField;
    FDQProdutos2PROD_ORIGEM: TIntegerField;
    FDQProdutos2PROD_CSOSN: TIntegerField;
    FDQProdutos2PROD_PIS: TIntegerField;
    FDQProdutos2PROD_COFINS: TIntegerField;
    FDQProdutos2PROD_IPI: TIntegerField;
    FDQProdutos2PROD_TOTAL_COMPRADO: TBCDField;
    FDQProdutos2COD_FINALIDADE: TIntegerField;
    FDQProdutos2COD_STATUS: TIntegerField;
    FDQProdutos2COD_LINHA: TIntegerField;
    FDQProdutos2COD_SIMILAR: TStringField;
    FDQProdutos2PROD_SUBST_POR: TBCDField;
    FDQProdutos2PROD_PROD_IMPOSTO: TBCDField;
    FDQProdutos2COD_CFOP: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
    GLBPK : Integer;
    GLBCrud : String;

    function MontaPaginacao(PagAtual, TotalPag, TotalRegistros : Integer): String;
    function AcaoMenu(Acao: String): String;
    function FB_ReturnNextCOD_ByGenerator(NomeGenerator: string): Longint;
    function FB_ReturnMAXCOD_ByTabela(Tabela: string): Longint;

  end;

implementation

{$R *.dfm}

uses U_IWFormIndex, IWAppForm, U_IWFormTableManual, U_IWFormFinal;


function TIWUserSession.AcaoMenu(Acao: String): String;
begin
  if Acao = 'Encerrar' then
  begin
    Webapplication.terminateandredirect('https://marcelogirattocursos.com.br/');
//    TIWAppForm(WebApplication.ActiveForm).Release;
//    TIWFormLogin.Create(WebApplication).Show;
  end;

  if Acao = 'Inicio' then
  begin
    TIWAppForm(WebApplication.ActiveForm).Release;
    TIWFormIndex.Create(WebApplication).Show;
  end;

  if Acao = 'Produtos' then
  begin
    TIWAppForm(WebApplication.ActiveForm).Release;
    TIWFormTableManual.Create(WebApplication).Show;
  end;

  if Acao = 'Final' then
  begin
    TIWAppForm(WebApplication.ActiveForm).Release;
    TIWFormFinal.Create(WebApplication).Show;
  end;
end;

function TIWUserSession.MontaPaginacao(PagAtual, TotalPag, TotalRegistros : Integer): String;
var
  Resultado : String;
begin
   Resultado :=             '    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 text-left"> '+#13+#10;
   Resultado := Resultado + '           <br /><small class="bg-info">Listagem com ' + FormatCurr(',0', TotalRegistros ) + ' Registro(s)</small> '+#13+#10;
   Resultado := Resultado + '    </div> '+#13+#10;
   Resultado := Resultado + '    <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 text-right"> '+#13+#10;
   Resultado := Resultado + '<nav aria-label="Page navigation"> '+#13+#10+
                            '  <ul class="pagination"> '+#13+#10;

   if (PagAtual <= 1) then
     Resultado := Resultado + '    <li class="page-item disabled"><a class="page-link">Início</a></li> '+#13+#10+
                              '    <li class="page-item disabled"><a class="page-link">Anterior</a></li> '+#13+#10
   else
     Resultado := Resultado + '    <li class="page-item"><a class="page-link" onclick="SubmitClickConfirm(''BOTAOPAGINA'', ''I'' , true, '''');">Início</a></li> '+#13+#10+
                              '    <li class="page-item"><a class="page-link" onclick="SubmitClickConfirm(''BOTAOPAGINA'', ''A'' , true, '''');">Anterior</a></li> '+#13+#10;

   if (PagAtual = TotalPag) then
     Resultado := Resultado + '    <li class="page-item disabled"><a class="page-link">Próxima</a></li> '+#13+#10+
                              '    <li class="page-item disabled"><a class="page-link">Última</a></li> '+#13+#10
   else
     Resultado := Resultado + '    <li class="page-item"><a class="page-link" onclick="SubmitClickConfirm(''BOTAOPAGINA'', ''P'' , true, '''');">Próxima</a></li> '+#13+#10+
                              '    <li class="page-item"><a class="page-link" onclick="SubmitClickConfirm(''BOTAOPAGINA'', ''U'' , true, '''');">Última</a></li> '+#13+#10;

   Resultado := Resultado + '  </ul> '+#13+#10+
                            '</nav> '+#13+#10;
   Resultado := Resultado + '    </div> '+#13+#10;

   Result := Resultado;
end;

function TIWUserSession.FB_ReturnMAXCOD_ByTabela(Tabela: string): Longint;
var
  SQL: TStringList;
  Qry: TFDQuery;
label
  FIM;
begin
{$I-}


  Result := 0;

  Qry:= TFDQuery.Create(nil);
  Qry.Connection := FDConnection1;

  SQL := TstringList.Create;
  Result := 0;

  SQL.Add('Select Max(cod_'+Tabela+') as NEWID from '+Tabela);
  Qry.Open(SQL.Text);

  Result := StrToInt(Qry.FieldValues['NEWID']) +1 ;


  SQL.Free;

end;

function TIWUserSession.FB_ReturnNextCOD_ByGenerator(NomeGenerator: string): Longint;
var
  SQL: TStringList;
  Qry: TFDQuery;
label
  FIM;
begin
{$I-}

  Qry:= TFDQuery.Create(nil);
  Qry.Connection := FDConnection1;

  SQL := TstringList.Create;
  Result := 0;

  SQL.Add('SELECT GEN_ID(' + NomeGenerator + ', 1) AS NEWID FROM RDB$DATABASE');
  Qry.Open(SQL.Text);

  Result := StrToInt(Qry.FieldValues['NEWID']);

  if Result <= 0 then
    Result := 0;

FIM:
  SQL.Free;

end;

end.