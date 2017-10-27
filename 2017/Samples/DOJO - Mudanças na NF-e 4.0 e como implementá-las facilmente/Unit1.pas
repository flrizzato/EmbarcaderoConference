unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrNFeDANFEClass, ACBrNFeDANFeRLClass,
  ACBrBase, ACBrDFe, ACBrNFe, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnConfigurar: TButton;
    btnGerarXML: TButton;
    btnImprimir: TButton;
    ACBrNFe1: TACBrNFe;
    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    btnSalvarXML: TButton;
    SaveDialog1: TSaveDialog;
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnGerarXMLClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnSalvarXMLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  pcnConversao, pcnConversaoNFe, ACBrDFeSSL, blcksock, ACBrUtil;

{$R *.dfm}

procedure TForm1.btnConfigurarClick(Sender: TObject);
var
  PathApp, PathArqNFe, PathPDF, PathArquivos, PathSchemas, PathTmp: string;
begin
  // caminhos de pastas gerais
  PathApp        := ExtractFilePath(ParamStr(0));
  PathSchemas    := IncludeTrailingPathDelimiter(PathApp + 'SCHEMAS');

  // caminhos de pastas especificos por cnpj
  PathArqNFe   := IncludeTrailingPathDelimiter(PathApp + 'DOCUMENTOS');
  PathPDF      := IncludeTrailingPathDelimiter(PathArqNFe + 'PDF');
  PathArquivos := IncludeTrailingPathDelimiter(PathArqNFe + 'ARQUIVOS');
  PathTmp      := IncludeTrailingPathDelimiter(PathArqNFe + 'TMP');

  if not DirectoryExists(PathPDF) then
    ForceDirectories(PathPDF);

  if not DirectoryExists(PathArquivos) then
    ForceDirectories(PathArquivos);

  if not DirectoryExists(PathTmp) then
    ForceDirectories(PathTmp);

  // configuração do ACBRNFE
  ACBrNFe1.Configuracoes.Arquivos.AdicionarLiteral           := True;
  ACBrNFe1.Configuracoes.Arquivos.EmissaoPathNFe             := True;
  ACBrNFe1.Configuracoes.Arquivos.Salvar                     := True;
  ACBrNFe1.Configuracoes.Arquivos.SalvarApenasNFeProcessadas := False;
  ACBrNFe1.Configuracoes.Arquivos.SepararPorMes              := True;
  ACBrNFe1.Configuracoes.Arquivos.SepararPorCNPJ             := True;
  ACBrNFe1.Configuracoes.Arquivos.SepararPorModelo           := True;
  ACBrNFe1.Configuracoes.Arquivos.PathNFe                    := PathArquivos;
  ACBrNFe1.Configuracoes.Arquivos.PathInu                    := PathArquivos;
  ACBrNFe1.Configuracoes.Arquivos.PathEvento                 := PathArquivos;
  ACBrNFe1.Configuracoes.Arquivos.PathSalvar                 := PathArquivos;
  ACBrNFe1.Configuracoes.Arquivos.PathSchemas                := PathSchemas;

  ACBrNFe1.Configuracoes.Geral.Salvar   := True;
  ACBrNFe1.Configuracoes.Geral.ModeloDF := moNFe;
  ACBrNFe1.Configuracoes.Geral.VersaoDF := ve400;                 //<<----------
  ACBrNFe1.Configuracoes.Geral.SSLLib   := libCapicom;

  // tipo de conexão
  ACBrNFe1.SSL.SSLType := LT_TLSv1_2;                             //<<----------

  // propriedades para melhorar a aparência dos retornos de validaçã dos schemas
  // %TAGNIVEL%  : Representa o Nivel da TAG; ex: <transp><vol><lacres>
  // %TAG%       : Representa a TAG; ex: <nLacre>
  // %ID%        : Representa a ID da TAG; ex X34
  // %MSG%       : Representa a mensagem de alerta
  // %DESCRICAO% : Representa a Descrição da TAG
  ACBrNFe1.Configuracoes.Geral.ExibirErroSchema := True;
  ACBrNFe1.Configuracoes.Geral.FormatoAlerta    := '[ %TAGNIVEL%%TAG% ]   %DESCRICAO% - %MSG%';
  //ACBrNFe1.Configuracoes.Geral.FormatoAlerta    := 'Nível: %TAGNIVEL% Campo: %ID% %TAG% %DESCRICAO% - %MSG%';

  // certificado
  ACBrNFe1.Configuracoes.Certificados.NumeroSerie := '676411CD558408F15B63419DDBE2F7D8';
  ACBrNFe1.Configuracoes.Certificados.Senha       := '';

  // configurações gerais
  ACBrNFe1.Configuracoes.Geral.FormaEmissao := teNormal;

  ACBrNFe1.Configuracoes.WebServices.AguardarConsultaRet      := 5000; // tempo padrão que vai aguardar para consultar após enviar a NF-e
  ACBrNFe1.Configuracoes.WebServices.IntervaloTentativas      := 3000; // Intervalo entre as tentativas de envio
  ACBrNFe1.Configuracoes.WebServices.Tentativas               := 10;   // quantidade de tentativas de envio
  ACBrNFe1.Configuracoes.WebServices.AjustaAguardaConsultaRet := True; // ajustar "AguardarConsultaRet" com o valor retornado pelo webservice

  // webservices
  ACBrNFe1.Configuracoes.WebServices.UF         := 'PE';
  ACBrNFe1.Configuracoes.WebServices.Visualizar := False;
  ACBrNFe1.Configuracoes.WebServices.Ambiente   := taHomologacao;

  // proxy de acesso
  ACBrNFe1.Configuracoes.WebServices.ProxyHost := '';
  ACBrNFe1.Configuracoes.WebServices.ProxyPort := '';
  ACBrNFe1.Configuracoes.WebServices.ProxyUser := '';
  ACBrNFe1.Configuracoes.WebServices.ProxyPass := '';

  // DANFE
  ACBrNFe1.DANFE.TipoDANFE := tiRetrato;
  ACBrNFe1.DANFE.PathPDF   := PathPDF;
  ACBrNFe1.DANFE.Logo      := '';
  ACBrNFe1.DANFE.Site      := 'http://embarcaderoconference.com.br/';
  ACBrNFe1.DANFE.Email     := '';

  ShowMessage('Configuração efetuada com sucesso!');
end;

procedure TForm1.btnGerarXMLClick(Sender: TObject);
var
  ConverteOk: Boolean;
  MsgImpostoNota: String;
  ErrosRegraNegocio: string;
begin
  ACBrNFe1.NotasFiscais.Clear;
  with ACBrNFe1.NotasFiscais.Add.NFe do
  begin
    // Ambiente
    Ide.tpAmb   := ACBrNFe1.Configuracoes.WebServices.Ambiente;
    Ide.verProc := '1.0.0.0';
    Ide.tpImp   := ACBrNFe1.DANFE.TipoDANFE;
    Ide.tpEmis  := teNormal;
    Ide.tpNF    := tnSaida;
    Ide.finNFe  := fnNormal;

    // Identificação da nota fiscal eletrônica
    Ide.modelo    := 55;
    Ide.cNF       := 1;
    Ide.nNF       := 1;
    Ide.serie     := 1;
    Ide.natOp     := 'venda';
    Ide.dEmi      := Date;
    Ide.dSaiEnt   := Now;
    Ide.cUF       := 26;
    Ide.cMunFG    := 2611606;
    Ide.idDest    := doInterna;
    Ide.indFinal  := TpcnConsumidorFinal.cfConsumidorFinal;

    // identificação do EMITENTE
    Emit.xNome             := 'empresa teste';
    Emit.xFant             := 'empresa teste';
    Emit.CNPJCPF           := '17.733.830/0001-20';
    Emit.IE                := '052118754';
    Emit.IEST              := '';
    Emit.CNAE              := '4639701';
    Emit.IM                := '';
    Emit.EnderEmit.fone    := '(11)2222-3333';
    Emit.EnderEmit.xLgr    := 'endereco';
    Emit.EnderEmit.nro     := 'sn';
    Emit.EnderEmit.xCpl    := '';
    Emit.EnderEmit.xBairro := 'bairro';
    Emit.EnderEmit.xMun    := 'recife';
    Emit.EnderEmit.cMun    := 2611606;
    Emit.EnderEmit.UF      := 'PE';
    Emit.EnderEmit.CEP     := 50790900;
    Emit.enderEmit.cPais   := 1058;
    Emit.enderEmit.xPais   := 'BRASIL';
    Emit.CRT               := crtRegimeNormal;

    // informações do destinatário da nota fiscal
    Dest.xNome             := 'embarcadero conferece';
    Dest.CNPJCPF           := '84915170659';
    Dest.ISUF              := '';
    Dest.EnderDest.Fone    := '';
    Dest.EnderDest.xLgr    := 'endereco';
    Dest.EnderDest.nro     := 'sn';
    Dest.EnderDest.xCpl    := '';
    Dest.EnderDest.xBairro := 'bairro';
    Dest.EnderDest.xMun    := 'recife';
    Dest.EnderDest.cMun    := 2611606;
    Dest.EnderDest.UF      := 'PE';
    Dest.EnderDest.CEP     := 50790900;
    Dest.EnderDest.cPais   := 1058;
    Dest.EnderDest.xPais   := 'Brasil';
    Dest.indIEDest         := inNaoContribuinte;
    Dest.IE                := '';

    // Informações do frete
    Transp.modFrete := mfSemFrete;

    // Totais da nota fiscal
    Total.ICMSTot.vBC        := 0.00;
    Total.ICMSTot.vICMS      := 0.00;
    Total.ICMSTot.vFrete     := 0.00;
    Total.ICMSTot.vSeg       := 0.00;
    Total.ICMSTot.vOutro     := 0.00;
    Total.ICMSTot.vDesc      := 0.00;
    Total.ICMSTot.vBCST      := 0.00;
    Total.ICMSTot.vST        := 0.00;
    Total.ICMSTot.vIPI       := 0.00;
    Total.ICMSTot.vPIS       := 0.00;
    Total.ICMSTot.vCOFINS    := 0.00;
    Total.ICMSTot.vProd      := 10.00;
    Total.ICMSTot.vNF        := 10.00;

    // informações complementares
    InfAdic.infCpl     := '';
    InfAdic.infAdFisco := '';

    InfAdic.infCpl := '';

//    with Ide.NFref.Add do
//    begin
//      refNFe := 'xxxxxxxxxx';
//    end;

    // itens da nota fiscal
    with Det.Add do
    begin
      Prod.nItem    := 1;
      Prod.cProd    := '1';
      Prod.cEAN     := '';
      Prod.xProd    := 'Produto teste';
      Prod.NCM      := '02102000';
      Prod.EXTIPI   := '';
      Prod.CFOP     := '5102';
      Prod.uCom     := 'UN';
      Prod.qCom     := 1;
      Prod.vUnCom   := 10.00;
      Prod.vProd    := 10.00;
      Prod.cEANTrib := '';
      Prod.uTrib    := 'UN';
      Prod.qTrib    := 1;
      Prod.vUnTrib  := 10.00;
      Prod.vFrete   := 0.00;
      Prod.vSeg     := 0.00;
      Prod.vOutro   := 0.00;
      Prod.vDesc    := 0.00;
      infAdProd     := '';

      // Tributação do ICMS
      with Imposto do
      begin
        // origem da mercadoria
        ICMS.orig := oeNacional;

        // situação tributária
        if Emit.CRT = crtRegimeNormal then
        begin
          // ICMS normal
          ICMS.CST         := cst40;
          ICMS.modBC       := dbiValorOperacao;
          ICMS.vBC         := 0.00;
          ICMS.pICMS       := 0.00;
          ICMS.vICMS       := 0.00;
          ICMS.pRedBC      := 0.00;
        end
        else
        begin
          // campos do simples nacional
          ICMS.CSOSN       := csosn102;
          ICMS.pCredSN     := 0.00;
          ICMS.vCredICMSSN := 0.00;
        end;

        ICMS.modBCST := dbisMargemValorAgregado;
        ICMS.vBCST   := 0.00;
        ICMS.pICMSST := 0.00;
        ICMS.vICMSST := 0.00;
        ICMS.pMVAST  := 0.00;
        ICMS.pRedBCST:= 0.00;

        // imposto do IPI
        IPI.CST  := ipi00;
        IPI.cEnq := '';
        IPI.vBC  := 0.00;
        IPI.pIPI := 0.00;
        IPI.vIPI := 0.00;

        // imposto do pis
        PIS.CST  := pis07;
        PIS.vBC  := 0.00;
        PIS.pPIS := 0.00;
        PIS.vPIS := 0.00;

        // imposto do cofins
        COFINS.CST     := cof07;
        COFINS.vBC     := 0.00;
        COFINS.pCOFINS := 0.00;
        COFINS.vCOFINS := 0.00;
      end;
    end;

    with pag.Add do
    begin
      tPag := fpDinheiro;
      vPag := 25.00;
    end;

    pag.vTroco := 15.00
  end;

  if ACBrNFe1.NotasFiscais.Count <= 0 then
    raise Exception.Create('Nenhuma nota eletrônica em aberto foi selecionada!');

  ACBrNFe1.NotasFiscais.GerarNFe;
  if ACBrNFe1.NotasFiscais.Items[0].Alertas <> '' then
    raise Exception.Create(ACBrNFe1.NotasFiscais.Items[0].Alertas);

  try
    ACBrNFe1.NotasFiscais.Assinar;
    ACBrNFe1.NotasFiscais.Validar;
  except
    on E: Exception do
    begin
      raise Exception.Create(
        E.Message + sLineBreak +
        ACBrNFe1.NotasFiscais.Items[0].ErroValidacaoCompleto
      );
    end;
  end;

  ACBrNFe1.NotasFiscais.ValidarRegrasdeNegocios(ErrosRegraNegocio);
  if not ErrosRegraNegocio.Trim.IsEmpty then
    raise Exception.Create(ErrosRegraNegocio);

  ShowMessage('Nota gerada com sucesso efetuada com sucesso!');
end;

procedure TForm1.btnImprimirClick(Sender: TObject);
begin
  ACBrNFe1.NotasFiscais[0].Imprimir;
end;

procedure TForm1.btnSalvarXMLClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    WriteToTXT(SaveDialog1.FileName, ACBrNFe1.NotasFiscais[0].XML, False);
    ShowMessage('Arquivo gravado com sucesso!');
  end;
end;

end.
