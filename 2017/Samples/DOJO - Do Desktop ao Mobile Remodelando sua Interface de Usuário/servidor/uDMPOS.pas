unit uDMPOS;

interface

uses
  System.SysUtils,
  System.Classes,
  ACBrBase,
  ACBrDFe,
  ACBrNFe,
  ACBrNFeConfiguracoes,
  pcnConversaoNFe,
  pcnConversao,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  REST.Response.Adapter,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Client,
  System.IOUtils,
  VCL.Dialogs;

type
  TdmPOS = class(TDataModule)
    ACBrNFe: TACBrNFe;
    mtblProdutos: TFDMemTable;
    mtblMesas: TFDMemTable;
    mtblMesasmesa: TIntegerField;
    mtblMesasstatus: TBooleanField;
    mtblMesasvalor: TFloatField;
    mtblProdutosproduto: TIntegerField;
    mtblProdutosdescricao: TStringField;
    mtblProdutosvalor: TFloatField;
    mtblVendas: TFDMemTable;
    IntegerField1: TIntegerField;
    mtblVendasproduto: TIntegerField;
    mtblVendasqtd: TIntegerField;
    mtblVendasvalorunitario: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure inicializamesas;
    procedure inicializaprodutos;
    procedure configuraDFe;
    { Private declarations }
  public
    function GeraNFCe(): Boolean;
    { Public declarations }
  end;

var
  dmPOS: TdmPOS;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmPOS }

procedure TdmPOS.DataModuleCreate(Sender: TObject);
begin
  inicializamesas;
  inicializaprodutos;
  configuraDFe;
end;

procedure TdmPOS.configuraDFe;
var
  Configuracoes: TConfiguracoesNFe;
begin
  Configuracoes := TConfiguracoesNFe.Create(ACBrNFe);

{$REGION 'Configurações gerais'}
  Configuracoes.Geral.ModeloDF := moNFCe;
  Configuracoes.Geral.VersaoDF := ve310;
  Configuracoes.Geral.AtualizarXMLCancelado := false;
  Configuracoes.Geral.IdCSC := '000001';
  Configuracoes.Geral.CSC := '0123456789';
  Configuracoes.Geral.IncluirQRCodeXMLNFCe := true;
  Configuracoes.Geral.FormaEmissao := teNormal;
  Configuracoes.WebServices.UF := 'AM';
  Configuracoes.WebServices.Ambiente := taHomologacao;
{$ENDREGION}
{$REGION 'Configuração de Diretórios'}
  Configuracoes.Arquivos.PathNFe := TPath.Combine(TDirectory.GetCurrentDirectory, 'notas');
  if not TDirectory.Exists(Configuracoes.Arquivos.PathNFe) then
    TDirectory.CreateDirectory(Configuracoes.Arquivos.PathNFe);

  Configuracoes.Arquivos.PathSalvar := TPath.Combine(Configuracoes.Arquivos.PathNFe, 'xml');
  if not TDirectory.Exists(Configuracoes.Arquivos.PathSalvar) then
    TDirectory.CreateDirectory(Configuracoes.Arquivos.PathSalvar);

  Configuracoes.Arquivos.PathSchemas := TPath.Combine(TDirectory.GetCurrentDirectory, 'schemas');
  if not TDirectory.Exists(Configuracoes.Arquivos.PathSchemas) then
  begin
    ShowMessage('Diretório de schemas não encontrado!!' + #13 + Configuracoes.Arquivos.PathSchemas);
  end;
{$ENDREGION}
  ACBrNFe.Configuracoes := Configuracoes;
end;

function TdmPOS.GeraNFCe(): Boolean;
var
  numero_item: integer;
  valor_total_nf: extended;
  valor_total_icms: extended;
begin
  configuraDFe;

  ACBrNFe.NotasFiscais.Clear;

  with ACBrNFe.NotasFiscais.Add.NFe do
  begin
    Ide.cNF := 1; // Caso não seja preenchido será gerado um número aleatório pelo componente
    Ide.natOp := 'VENDA';
    Ide.indPag := ipVista;
    Ide.modelo := 65;
    Ide.serie := 1;
    Ide.nNF := 1;
    Ide.dEmi := now;
    Ide.dSaiEnt := now;
    Ide.hSaiEnt := now;
    Ide.tpNF := tnSaida;
    Ide.tpEmis := teNormal;
    Ide.tpAmb := taHomologacao;
    Ide.cUF := UFtoCUF('AM');
    Ide.cMunFG := 100;
    Ide.finNFe := fnNormal;
    Ide.tpImp := tiNFCe;
    Ide.indFinal := cfConsumidorFinal;
    Ide.indPres := pcPresencial;

    Emit.CNPJCPF := '11351739000164';
    Emit.IE := '';
    Emit.xNome := 'NMOTECH INFORMATICA';
    Emit.xFant := 'NMOTECH INFORMATICA';

    Emit.EnderEmit.fone := '51992358577';
    Emit.EnderEmit.CEP := 92200600;
    Emit.EnderEmit.xLgr := 'Rua Dr Tancredo Neves';
    Emit.EnderEmit.nro := '160';
    Emit.EnderEmit.xCpl := '';
    Emit.EnderEmit.xBairro := 'Fatima';
    Emit.EnderEmit.cMun := 100;
    Emit.EnderEmit.xMun := 'CANOAS';
    Emit.EnderEmit.UF := 'RS';
    Emit.EnderEmit.cPais := 1058;
    Emit.EnderEmit.xPais := 'BRASIL';

    Emit.IEST := '';
    Emit.CRT := crtRegimeNormal;

    Dest.CNPJCPF := '05481336000137';
    Dest.ISUF := '';
    Dest.xNome := 'D.J. COM. E LOCAÇÃO DE SOFTWARES LTDA - ME';

    Dest.EnderDest.fone := '1533243333';
    Dest.EnderDest.CEP := 18270170;
    Dest.EnderDest.xLgr := 'Rua Coronel Aureliano de Camargo';
    Dest.EnderDest.nro := '973';
    Dest.EnderDest.xCpl := '';
    Dest.EnderDest.xBairro := 'Centro';
    Dest.EnderDest.cMun := 3554003;
    Dest.EnderDest.xMun := 'Tatuí';
    Dest.EnderDest.UF := 'SP';
    Dest.EnderDest.cPais := 1058;
    Dest.EnderDest.xPais := 'BRASIL';

    // Adicionando Produtos
    mtblProdutos.First;
    numero_item := 0;
    valor_total_nf := 0;
    valor_total_icms := 0;

    while not mtblProdutos.Eof do
    begin
      Inc(numero_item);

      // busca a descricao do produto
      mtblProdutos.Filtered := false;
      mtblProdutos.Filter := 'produto=' + mtblVendasproduto.AsString;
      mtblProdutos.Filtered := true;

      with Det.Add do
      begin
        Prod.nItem := numero_item;
        Prod.cProd := '123456';
        Prod.cEAN := '7896523206646';
        Prod.xProd := mtblProdutosdescricao.AsString;
        Prod.NCM := '94051010'; // Tabela NCM disponível em  http://www.receita.fazenda.gov.br/Aliquotas/DownloadArqTIPI.htm
        Prod.EXTIPI := '';
        Prod.CFOP := '5101';
        Prod.uCom := 'UN';
        Prod.qCom := mtblVendasqtd.AsInteger;
        Prod.vUnCom := mtblProdutosvalor.AsFloat;
        Prod.vProd := mtblProdutosvalor.AsFloat * mtblVendasqtd.AsInteger;

        valor_total_nf := valor_total_nf + Prod.vProd;

        Prod.cEANTrib := '7896523206646';
        Prod.uTrib := 'UN';
        Prod.qTrib := 1;
        Prod.vUnTrib := Prod.vProd;

        Prod.vOutro := 0;
        Prod.vFrete := 0;
        Prod.vSeg := 0;
        Prod.vDesc := 0;

        Prod.CEST := '1111111';

        with Imposto do
        begin
          // lei da transparencia nos impostos
          vTotTrib := 0;

          with ICMS do
          begin
            CST := cst00;
            ICMS.orig := oeNacional;
            ICMS.modBC := dbiValorOperacao;
            ICMS.vBC := Prod.vProd;
            ICMS.pICMS := 18;
            ICMS.vICMS := (Prod.vProd * ICMS.pICMS) / 100;
            ICMS.modBCST := dbisMargemValorAgregado;
            ICMS.pMVAST := 0;
            ICMS.pRedBCST := 0;
            ICMS.vBCST := 0;
            ICMS.pICMSST := 0;
            ICMS.vICMSST := 0;
            ICMS.pRedBC := 0;

            valor_total_icms := valor_total_icms + ICMS.vICMS;

            // partilha do ICMS e fundo de probreza
            with ICMSUFDest do
            begin
              vBCUFDest := 0.00;
              pFCPUFDest := 0.00;
              pICMSUFDest := 0.00;
              pICMSInter := 0.00;
              pICMSInterPart := 0.00;
              vFCPUFDest := 0.00;
              vICMSUFDest := 0.00;
              vICMSUFRemet := 0.00;
            end;
          end;
        end;
      end;
    end;
    total.ICMSTot.vBC := valor_total_nf;
    total.ICMSTot.vICMS := valor_total_icms;
    total.ICMSTot.vBCST := 0;
    total.ICMSTot.vST := 0;
    total.ICMSTot.vProd := valor_total_nf;
    total.ICMSTot.vFrete := 0;
    total.ICMSTot.vSeg := 0;
    total.ICMSTot.vDesc := 0;
    total.ICMSTot.vII := 0;
    total.ICMSTot.vIPI := 0;
    total.ICMSTot.vPIS := 0;
    total.ICMSTot.vCOFINS := 0;
    total.ICMSTot.vOutro := 0;
    total.ICMSTot.vNF := valor_total_nf;

    // partilha do icms e fundo de probreza
    total.ICMSTot.vFCPUFDest := 0.00;
    total.ICMSTot.vICMSUFDest := 0.00;
    total.ICMSTot.vICMSUFRemet := 0.00;

    total.ISSQNtot.vServ := 0;
    total.ISSQNtot.vBC := 0;
    total.ISSQNtot.vISS := 0;
    total.ISSQNtot.vPIS := 0;
    total.ISSQNtot.vCOFINS := 0;

    Transp.modFrete := mfSemFrete; // NFC-e não pode ter FRETE

    with pag.Add do // PAGAMENTOS apenas para NFC-e
    begin
      tPag := fpDinheiro;
      vPag := valor_total_nf;
    end;

    InfAdic.infCpl := '';
    InfAdic.infAdFisco := '';
  end;

  ACBrNFe.NotasFiscais.GerarNFe;
  result := ACBrNFe.Enviar(1, true, false);
end;

procedure TdmPOS.inicializamesas;
var
  iMesa: integer;
  lMesa: Boolean;
begin
  mtblMesas.CreateDataSet;
  lMesa := false;

  for iMesa := 1 to 10 do
  begin

    mtblMesas.Insert;
    mtblMesas.FieldByName('mesa').AsInteger := iMesa; // Numero da mesa

    if (iMesa = 1) or (iMesa = 4) or (iMesa = 5) or (iMesa = 8) then
      lMesa := true
    else
      lMesa := false;
    mtblMesas.FieldByName('status').AsBoolean := lMesa; // true = ocupada, false = desocupada
    if lMesa then
      mtblMesas.FieldByName('valor').AsFloat := 5 * iMesa // valor total gasto na mesa
    else
      mtblMesas.FieldByName('valor').AsFloat := 0; // valor total gasto na mesa

    mtblMesas.Post;
  end;
end;

procedure TdmPOS.inicializaprodutos;
begin
  mtblProdutos.CreateDataSet;

  mtblProdutos.Insert;
  mtblProdutos.FieldByName('produto').AsInteger := 123; // Codigo do produto
  mtblProdutos.FieldByName('descricao').AsString := 'X Coração de Frango';
  mtblProdutos.FieldByName('valor').AsFloat := 10;
  mtblProdutos.Post;

  mtblProdutos.Insert;
  mtblProdutos.FieldByName('produto').AsInteger := 321; // Codigo do produto
  mtblProdutos.FieldByName('descricao').AsString := 'X Frango com catupiry';
  mtblProdutos.FieldByName('valor').AsFloat := 20;
  mtblProdutos.Post;

  mtblProdutos.Insert;
  mtblProdutos.FieldByName('produto').AsInteger := 3646; // Codigo do produto
  mtblProdutos.FieldByName('descricao').AsString := 'X Tudo';
  mtblProdutos.FieldByName('valor').AsFloat := 10;
  mtblProdutos.Post;

  mtblProdutos.Insert;
  mtblProdutos.FieldByName('produto').AsInteger := 444; // Codigo do produto
  mtblProdutos.FieldByName('descricao').AsString := 'X Churrasco Galdeirio';
  mtblProdutos.FieldByName('valor').AsFloat := 30;
  mtblProdutos.Post;

  mtblProdutos.Insert;
  mtblProdutos.FieldByName('produto').AsInteger := 456; // Codigo do produto
  mtblProdutos.FieldByName('descricao').AsString := 'Refrigerante lata';
  mtblProdutos.FieldByName('valor').AsFloat := 4;
  mtblProdutos.Post;

  mtblProdutos.Insert;
  mtblProdutos.FieldByName('produto').AsInteger := 6969; // Codigo do produto
  mtblProdutos.FieldByName('descricao').AsString := 'Brigadeiro de colher';
  mtblProdutos.FieldByName('valor').AsFloat := 6.00;
  mtblProdutos.Post;
end;

end.
