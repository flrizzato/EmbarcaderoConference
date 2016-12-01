unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, ACBrMail, ACBrBase, ACBrDFe, ACBrNFe, ACBrNFeDANFEFRDM,
  ACBrNFeDANFEClass, ACBrNFeDANFEFR;

type
  TfrmPrincipal = class(TForm)
    btnConfigurar: TButton;
    btnEmitirNota: TButton;
    btnCancelarNota: TButton;
    btnInutilizarNumeracao: TButton;
    btnStatusServico: TButton;
    ACBrNFe1: TACBrNFe;
    ACBrMail1: TACBrMail;
    btnSelecionarCertificado: TButton;
    btnConsultarNFe: TButton;
    btnCartaCorrecao: TButton;
    ACBrNFeDANFEFR1: TACBrNFeDANFEFR;
    btnImprimirNFe: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnStatusServicoClick(Sender: TObject);
    procedure btnEmitirNotaClick(Sender: TObject);
    procedure btnCancelarNotaClick(Sender: TObject);
    procedure btnInutilizarNumeracaoClick(Sender: TObject);
    procedure btnSelecionarCertificadoClick(Sender: TObject);
    procedure btnConsultarNFeClick(Sender: TObject);
    procedure btnCartaCorrecaoClick(Sender: TObject);
    procedure btnImprimirNFeClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    function ValueIn(Value: Integer; const Values: array of Integer): Boolean;
  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  pcnConversao, pcnConversaoNFe, ACBrDFeSSL, ACBrUtil, System.StrUtils,
  Winapi.ShellAPI;

{$R *.dfm}

{*******************************************************************************
Função para retornar se um valor está dentro de um array de inteiros
*******************************************************************************}
function TfrmPrincipal.ValueIn(Value: Integer; const Values: array of Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(Values) to High(Values) do
  begin
    if Value = Values[I] then
    begin
      Result := True;
      Break;
    end;
  end;
end;


{*******************************************************************************
  SELEÇÃO DE CERTIFICADO:
    - Código de exemplo demonstrando como selecionar um certificado
      util para uma tela de configuração onde você grava o numero de serie
      do certificado para usar depois nas configurações
*******************************************************************************}
procedure TfrmPrincipal.btnSelecionarCertificadoClick(Sender: TObject);
begin
  ShowMessage('Número de série do Certificado: ' + ACBrNFe1.SSL.SelecionarCertificado);
end;


{*******************************************************************************
  CONFIGURACAO DO COMPONENTE NFE
    - Rotina completa de configuração do componente ACBrNFe
*******************************************************************************}
procedure TfrmPrincipal.btnConfigurarClick(Sender: TObject);
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
  ACBrNFe1.Configuracoes.Arquivos.AdicionarLiteral           := True;           // adiciona o literal NFe ao nome do arquivo
  ACBrNFe1.Configuracoes.Arquivos.EmissaoPathNFe             := True;           //
  ACBrNFe1.Configuracoes.Arquivos.Salvar                     := True;           // salva os xml nos diretorios configurados
  ACBrNFe1.Configuracoes.Arquivos.SalvarApenasNFeProcessadas := False;          // Se True salva somente as NF-es processadas e autorizadas/denegadas
  ACBrNFe1.Configuracoes.Arquivos.SepararPorMes              := True;           // cria um diretorio para o mes
  ACBrNFe1.Configuracoes.Arquivos.SepararPorCNPJ             := True;           // cria um diretorio para o cnpj do emitente
  ACBrNFe1.Configuracoes.Arquivos.SepararPorModelo           := True;           // cria um diretorio por modelo de nota (65/55)
  ACBrNFe1.Configuracoes.Arquivos.PathSalvar                 := PathArquivos;   // diretório raiz da NFe
  ACBrNFe1.Configuracoes.Arquivos.PathNFe                    := PathArquivos;   // diretorio onde serão gravadas as NFes emitidas
  ACBrNFe1.Configuracoes.Arquivos.PathInu                    := PathArquivos;   // diretorio onde serão gravadas as inutilizações
  ACBrNFe1.Configuracoes.Arquivos.PathEvento                 := PathArquivos;   // diretorio onde serão gravados os eventos
  ACBrNFe1.Configuracoes.Arquivos.PathSchemas                := PathSchemas;    // diretorio onde estão os schemas da NFe

  ACBrNFe1.Configuracoes.Geral.Salvar   := True;                                // se true grava os arquivos enviados e recebidos para e do webservice
  ACBrNFe1.Configuracoes.Geral.ModeloDF := moNFe;                               // modelo do DF-e (NFe ou NFCe
  ACBrNFe1.Configuracoes.Geral.VersaoDF := ve310;                               // versão da NFe
  ACBrNFe1.Configuracoes.Geral.SSLLib   := libCapicom;                          // tipo de lib usada para emitir a NFe: libOpenSSL, libCapicom, libCapicomDelphiSoap

  // propriedades para melhorar a aparência dos retornos de validaçã dos schemas
  // %TAGNIVEL%  : Representa o Nivel da TAG; ex: <transp><vol><lacres>
  // %TAG%       : Representa a TAG; ex: <nLacre>
  // %ID%        : Representa a ID da TAG; ex X34
  // %MSG%       : Representa a mensagem de alerta
  // %DESCRICAO% : Representa a Descrição da TAG
  ACBrNFe1.Configuracoes.Geral.ExibirErroSchema := False; // se True retorna o erro completo do schema
  ACBrNFe1.Configuracoes.Geral.FormatoAlerta    := '[ %TAGNIVEL%%TAG% ]   %DESCRICAO% - %MSG%';

  // certificado
  ACBrNFe1.Configuracoes.Certificados.NumeroSerie := ACBrNFe1.SSL.SelecionarCertificado;
  ACBrNFe1.Configuracoes.Certificados.Senha       := ''; // informe a senha se houver

  // configurações gerais
  ACBrNFe1.Configuracoes.Geral.FormaEmissao := teNormal;                        // tipo de emissão da NFe, usar quando deseja entrar em contingencia ou similar

  ACBrNFe1.Configuracoes.WebServices.AguardarConsultaRet      := 5000; // tempo padrão que vai aguardar para consultar após enviar a NF-e
  ACBrNFe1.Configuracoes.WebServices.IntervaloTentativas      := 3000; // Intervalo entre as tentativas de envio
  ACBrNFe1.Configuracoes.WebServices.Tentativas               := 10;   // quantidade de tentativas de envio
  ACBrNFe1.Configuracoes.WebServices.AjustaAguardaConsultaRet := True; // ajustar "AguardarConsultaRet" com o valor retornado pelo webservice

  // webservice
  ACBrNFe1.Configuracoes.WebServices.UF         := 'MG';
  ACBrNFe1.Configuracoes.WebServices.Visualizar := False;      // se True mostra as mensagens de status durante a troca de informações com webservice
  ACBrNFe1.Configuracoes.WebServices.Ambiente   := taProducao; // informar se produção ou homologação

  // proxy de acesso (somente se a rede obrigar)
  ACBrNFe1.Configuracoes.WebServices.ProxyHost := '';
  ACBrNFe1.Configuracoes.WebServices.ProxyPort := '';
  ACBrNFe1.Configuracoes.WebServices.ProxyUser := '';
  ACBrNFe1.Configuracoes.WebServices.ProxyPass := '';

  // DANFE
  ACBrNFe1.DANFE.TipoDANFE := tiRetrato;
  ACBrNFe1.DANFE.PathPDF   := PathPDF;
  ACBrNFe1.DANFE.Logo      := '';
  ACBrNFe1.DANFE.Site      := 'http://www.meusite.com.br';
  ACBrNFe1.DANFE.Email     := 'email@email.com.br';

  // Envio de email
  ACBrMail1.From     := 'emailremetente@email.com.br';
  ACBrMail1.FromName := 'Nome do Remetente';
  ACBrMail1.Host     := 'smpt.seuservidor.com.br';
  ACBrMail1.Port     := '587';
  ACBrMail1.Username := 'seu_usuario';
  ACBrMail1.Password := 'sua_senha';
  ACBrMail1.SetSSL   := True;
  ACBrMail1.SetTLS   := False;
end;


{*******************************************************************************
  VERIFICAÇÃO DE STATUS DO WEBSERVICE
    - Exemplo de como consultar o status do webservice para saber se está
      tudo ok ou não com o webservice.
      Obs.: não se deve ficar chamando a consulta de status com muita frequencia
      pois corresse o risco de cair na regra de uso indevido.
*******************************************************************************}
procedure TfrmPrincipal.btnStatusServicoClick(Sender: TObject);
var
  Mensagem: string;
  CodigoStatus: Integer;
begin
  ACBrNFe1.WebServices.StatusServico.Executar;

  CodigoStatus := ACBrNFe1.WebServices.StatusServico.cStat;
  case CodigoStatus of
    107: // serviço em operação
      begin
        Mensagem := Trim(
          Format('Código:%d'#13'Mensagem: %s'#13'Tempo médio: %d segundo(s)', [
            ACBrNFe1.WebServices.StatusServico.cStat,
            ACBrNFe1.WebServices.StatusServico.xMotivo,
            ACBrNFe1.WebServices.StatusServico.TMed
          ])
        );

        MessageDlg(Mensagem, mtInformation, [mbOK], 0);
      end;

    108, 109: // serviço paralisado temporariamente (108) ou sem previsão (109)
      begin
        Mensagem := Trim(
          Format('Código:%d'#13'Motivo: %s'#13'%s', [
            ACBrNFe1.WebServices.StatusServico.cStat,
            ACBrNFe1.WebServices.StatusServico.xMotivo,
            ACBrNFe1.WebServices.StatusServico.xObs
          ])
        );

        MessageDlg(Mensagem, mtError, [mbOK], 0);
      end;
  else
    // qualquer outro retorno
    if CodigoStatus > 0 then
    begin
      Mensagem := Trim(
        Format('Webservice indisponível:'#13'Código:%d'#13'Motivo: %s'#13'%s', [
          ACBrNFe1.WebServices.StatusServico.cStat,
          ACBrNFe1.WebServices.StatusServico.xMotivo,
          ACBrNFe1.WebServices.StatusServico.xObs
        ])
      );
    end
    else
    begin
      Mensagem := 'Webservice indisponível e retorno em branco, tente novamente!';
    end;

    MessageDlg(Mensagem, mtInformation, [mbOK], 0);
  end;
end;


procedure TfrmPrincipal.Label1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PWideChar(TLabel(Sender).Caption), '', '', 1);
end;

{*******************************************************************************
  EMISSÃO DE NF-E
    - Exemplo de preenchimento e emissão de uma NF-e comum
*******************************************************************************}
procedure TfrmPrincipal.btnEmitirNotaClick(Sender: TObject);
var
  MsgMotivoDenegacao: String;
  ErrosRegraNegocio: String;
  ConverteOk: Boolean;
  StatusNota: Integer;
  NumeroLote: String;
  MsgRetorno: String;
  I: Integer;
begin
  ACBrNFe1.NotasFiscais.Clear;
  with ACBrNFe1.NotasFiscais.Add.NFe do
  begin
    // Ambiente
    Ide.tpAmb     := ACBrNFe1.Configuracoes.WebServices.Ambiente;
    Ide.verProc   := '1.0.0.0';
    Ide.tpImp     := TpcnTipoImpressao.tiRetrato;
    Ide.tpEmis    := TpcnTipoEmissao.teNormal;
    Ide.tpNF      := TpcnTipoNFe.tnSaida;
    Ide.finNFe    := TpcnFinalidadeNFe.fnNormal;
    Ide.indPag    := TpcnIndicadorPagamento.ipVista;

    // Identificação da nota fiscal eletrônica
    Ide.modelo    := 55;
    Ide.cNF       := 1;
    Ide.nNF       := 1;
    Ide.serie     := 1;
    Ide.natOp     := 'VENDA DE MERCADORIA';
    Ide.dEmi      := Now;
    Ide.dSaiEnt   := Date;
    Ide.hSaiEnt   := Time;
    Ide.cUF       := UFtoCUF('MG');
    Ide.cMunFG    := 3104007;

    // identificação do EMITENTE
    Emit.CRT               := TpcnCRT.crtRegimeNormal;
    Emit.xNome             := 'RAZAO SOCIAL DO EMITENTE';
    Emit.xFant             := 'NOME FANTASIA DO EMITENTE';
    Emit.CNPJCPF           := '11222333000155';
    Emit.IE                := '1234567890';
    Emit.IEST              := '';
    Emit.CNAE              := '0';
    Emit.IM                := '';
    Emit.EnderEmit.fone    := '1122223333';
    Emit.EnderEmit.xLgr    := 'ENDERECO DO EMITENTE';
    Emit.EnderEmit.nro     := 'SN';
    Emit.EnderEmit.xCpl    := 'COMPLEMENTO';
    Emit.EnderEmit.xBairro := 'BAIRRO';
    Emit.EnderEmit.xMun    := 'ARAXA';
    Emit.EnderEmit.cMun    := 3104007;
    Emit.EnderEmit.UF      := 'MG';
    Emit.EnderEmit.CEP     := 11222333;
    Emit.enderEmit.cPais   := 1058;
    Emit.enderEmit.xPais   := 'BRASIL';

    // informações do destinatário da nota fiscal
    Dest.xNome             := 'NOME OU RAZAO SOCIAL DO DESTINATARIO';
    Dest.CNPJCPF           := '11122233399';
    Dest.ISUF              := '';
    Dest.EnderDest.Fone    := '1122223333';
    Dest.EnderDest.xLgr    := 'ENDERECO DO DESTINATARIO';
    Dest.EnderDest.nro     := 'SN';
    Dest.EnderDest.xCpl    := '';
    Dest.EnderDest.xBairro := 'BAIRRO';
    Dest.EnderDest.xMun    := 'ARAXA';
    Dest.EnderDest.cMun    := 3104007;
    Dest.EnderDest.UF      := 'MG';
    Dest.EnderDest.CEP     := 11222333;
    Dest.EnderDest.cPais   := 1058;
    Dest.EnderDest.xPais   := 'Brasil';
    Dest.indIEDest         := inNaoContribuinte;
    Dest.IE                := '';

    if Dest.EnderDest.UF = 'EX' then
      Ide.idDest := doExterior
    else
    begin
      if Emit.EnderEmit.UF = Dest.EnderDest.UF then
        Ide.idDest := doInterna
      else
        Ide.idDest := doInterestadual;
    end;

    // Informações do frete
    Transp.modFrete := TpcnModalidadeFrete.mfSemFrete;

    // Informações dos volumes tranportados
    Transp.Transporta.xNome    := '';
    Transp.Transporta.CNPJCPF  := '';
    Transp.Transporta.IE       := '';
    Transp.Transporta.xEnder   := '';
    Transp.Transporta.xMun     := '';
    Transp.Transporta.UF       := '';

    // Informações do veículo
    Transp.veicTransp.placa := '';
    Transp.veicTransp.UF    := '';
    Transp.veicTransp.RNTC  := '';

    // Volumes transportados ( pode ser mais de um, faça um novo add para cada um
    Transp.Vol.Clear;
    for I := 1 to 3 do
    begin
      with Transp.Vol.Add do
      begin
        qVol  := 1;
        esp   := 'especie';
        marca := 'marca';
        nVol  := 'volume';
        pesoL := 1.234;
        pesoB := 1.234;
      end;
    end;

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
    Total.ICMSTot.vProd      := 0.00;
    Total.ICMSTot.vNF        := 0.00;

    // informações complementares
    InfAdic.infCpl := 'observações que deseja informar na nota';

    // itens da nota fiscal ( faça uma .add para cada item da nota )
    Det.Clear;
    for I := 1 to 3 do // simulando a adição de 3 itens
    begin
      with Det.Add do
      begin
        Prod.nItem    := I;
        Prod.cProd    := 'Cod123456789';
        Prod.cEAN     := '7894561233214';
        Prod.xProd    := 'DESCRICAO DO PRODUTO';
        Prod.NCM      := '99';
        Prod.EXTIPI   := '';
        Prod.CFOP     := '5102';
        Prod.uCom     := 'UN';
        Prod.qCom     := 1;
        Prod.vUnCom   := 1.23;
        Prod.vProd    := Prod.qCom * Prod.vUnCom;
        Prod.cEANTrib := '7894561233214';
        Prod.uTrib    := 'UN';
        Prod.qTrib    := 1;
        Prod.vUnTrib  := 1.23;
        Prod.vFrete   := 0.00;
        Prod.vSeg     := 0.00;
        Prod.vOutro   := 0.00;
        Prod.vDesc    := 0.00;

        infAdProd     := 'OBSERVAÇÃO ADICIONAL DO PRODUTO QUANDO DESEJAR';

        // Tributação do ICMS
        with Imposto do
        begin
          // origem da mercadoria
          ICMS.orig := TpcnOrigemMercadoria.oeNacional;

          // situação tributária
          if Emit.CRT = crtSimplesNacional then
          begin
            // campos do simples nacional
            ICMS.CSOSN := StrToCSOSNIcms(ConverteOk, '102');
            if not ConverteOk then
              raise Exception.Create('Situação tributária no simples nacional desconhecida.');

            ICMS.pCredSN     := 0.00;
            ICMS.vCredICMSSN := 0.00;
          end
          else
          begin
            // icms normal
            ICMS.CST := StrToCSTICMS(ConverteOk, '00');
            if not ConverteOk then
              raise Exception.Create('Situação tributária desconhecida.');

            ICMS.modBC  := dbiValorOperacao;
            ICMS.vBC    := 1.23;
            ICMS.pICMS  := 7.00;
            ICMS.vICMS  := 0.09;
            ICMS.pRedBC := 0.00;
          end;

          // icms st
          ICMS.modBCST := dbisMargemValorAgregado;
          ICMS.vBCST   := 0.00;
          ICMS.pICMSST := 0.00;
          ICMS.vICMSST := 0.00;
          ICMS.pMVAST  := 0.00;
          ICMS.pRedBCST:= 0.00;

          // imposto do IPI
          IPI.CST := StrToCSTIPI(ConverteOk, '99');
          if not ConverteOk then
            raise Exception.Create('Situação tributária do IPI desconhecida.');

          IPI.cEnq  := '';
          IPI.vBC   := 0.00;
          IPI.pIPI  := 0.00;
          IPI.vIPI  := 0.00;

          // imposto do pis
          PIS.CST := StrToCSTPIS(ConverteOk, '07');
          if not ConverteOk then
            raise Exception.Create('Situação tributária do PIS desconhecida.');

          PIS.vBC  := 0.00;
          PIS.pPIS := 0.00;
          PIS.vPIS := 0.00;

          // imposto do cofins
          COFINS.CST := StrToCSTCOFINS(ConverteOk, '07');
          if not ConverteOk then
            raise Exception.Create('Situação tributária do COFINS desconhecida.');

          COFINS.vBC     := 0.00;
          COFINS.pCOFINS := 0.00;
          COFINS.vCOFINS := 0.00;
        end;
      end;
    end;
  end;

  // validar o schema da NFe
  try
    ACBrNFe1.NotasFiscais.Validar;
  except
    on E: Exception do
    begin
      raise Exception.Create(
        IfThen(
          ACBrNFe1.NotasFiscais.Items[0].ErroValidacao <> '',
          ACBrNFe1.NotasFiscais.Items[0].ErroValidacao,
          E.Message
        )
      );
    end;
  end;

  // validação das regras de negócio, as validações seguem o manual da NF-e
  ACBrNFe1.NotasFiscais.ValidarRegrasdeNegocios(ErrosRegraNegocio);
  if ErrosRegraNegocio <> '' then
    raise Exception.Create(ErrosRegraNegocio);

  // Criar novo número de lote
  NumeroLote := FormatDateTime('yyyymmddhhmmss', NOW);

  // enviar o lote de notas fiscias
  if ACBrNFe1.Enviar(NumeroLote, False) then
  begin
    // guardar o status da nota atual
    StatusNota := ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.cStat;

    MsgRetorno := '';
    if ValueIn(StatusNota, [100, 150, 110, 301, 302]) then
    begin
      // dados que considero importante gravar no banco de dados
      // ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF;
      // ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.serie;
      // ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.chNFe;
      // ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.nProt;
      // ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.dhRecbto;
      // ACBrNFe1.NotasFiscais.Items[0].XML;
      // ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.xMotivo;

      // efetuar o tratamento das notas conforme o status
      case StatusNota of
        100, 150:
          begin
            MsgRetorno :=
              'Nota fiscal autorizada:' + sLineBreak +
              Format('Número: %9.9d    Série: %3.3d    Data: %s', [
                  ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF,
                  ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.serie,
                  FormatDateTime('dd/mm/yyyy', ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.dEmi)
              ]) + sLineBreak;
          end;

        110, 301, 302:
          begin
            case StatusNota of
              110: MsgMotivoDenegacao := '110 - Nota fiscal denegada';
              301: MsgMotivoDenegacao := '301 - Irregularidade fiscal do emitente';
              302: MsgMotivoDenegacao := '302 - Irregularidade fiscal do destinatário';
            end;

            MsgRetorno :=
              Format('Número: %9.9d    Série: %3.3d    Data: %s    Motivo: %s', [
                  ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF,
                  ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.serie,
                  FormatDateTime('dd/mm/yyyy', ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.dEmi),
                  MsgMotivoDenegacao
              ]) + sLineBreak;
          end;
      end;
    end
    else
    begin
      MsgRetorno :=
        Format('Número: %9.9d    Série: %3.3d    Data: %s    ', [
            ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF,
            ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.serie,
            FormatDateTime('dd/mm/yyyy', ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.dEmi)
        ]) +
        String(ACBrNFe1.NotasFiscais.Items[0].Msg) +
        sLineBreak;
    end;

    // atualizar tela
    if MsgRetorno <> '' then
      Application.MessageBox(PWideChar(MsgRetorno), 'Envio NF-e', MB_ICONINFORMATION + MB_OK);
  end;
end;


{*******************************************************************************
  CONSULTA NF-E
    - Exemplo de como consultar uma nota utilizando o XML, util quando
      você tem algum erro durante o envio e precisa saber se a nfe foi ou não
      autorizada.
*******************************************************************************}
procedure TfrmPrincipal.btnConsultarNFeClick(Sender: TObject);
var
  MensagemErro: String;
  MsgMotivoDenegacao: String;
  Status: Integer;
  ChaveNFe: String;
begin
  // limpar notas fiscais
  ACBrNFe1.NotasFiscais.Clear;

  // carregar o XML da nota
  ACBrNFe1.NotasFiscais.LoadFromString('string do xml da nfe', False);     // utilizar quando você grava o XML no BD e tem a string do XML
  // ou
  //ACBrNFe1.NotasFiscais.LoadFromFile('caminho do arquivo xml', False);   // utilizar quando você quer usar o arquivo XML da NFe

  // efetuar a consulta ao webservice de consulta
  ACBrNFe1.Consultar;

  // Tratamento do status retornado
  Status   := ACBrNFe1.WebServices.Consulta.cStat;
  ChaveNFe := ACBrNFe1.NotasFiscais[0].NFe.procNFe.chNFe;
  case Status of
    100:
      begin
        // NOTA FISCAL AUTORIZADA PARA USO
        // ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.chNFe;
        // ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.nProt;
        // ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.dhRecbto;
        // ACBrNFe1.NotasFiscais.Items[0].XML;
        // ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cNF;
      end;

    101:
      begin
        // NOTA FISCAL CANCELADA
        // ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.nProt;
        // ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.dhRecbto;
        // ACBrNFe1.NotasFiscais.Items[0].XML;
      end;

    110, 301, 302:
      begin
        // NOTA FISCAL DENEGADA PARA USO (GERALMENTE POR PROBLEMAS FISCAIS COM O EMITENTE OU DESTINATÁRIO)
        // Esta nota tem valor fiscal mas não permite trafegar com a mercadoria e não gera imposto

        case Status of
          110: MsgMotivoDenegacao := '110 - Nota fiscal denegada';
          301: MsgMotivoDenegacao := '301 - Irregularidade fiscal do emitente';
          302: MsgMotivoDenegacao := '302 - Irregularidade fiscal do destinatário';
        end;

        // ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.chNFe;
        // ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.nProt;
        // ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.dhRecbto;
        // ACBrNFe1.NotasFiscais.Items[0].XML;
        // ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cNF;
      end;
  else
    MessageDlg(ACBrNFe1.WebServices.Consulta.Msg, mtError, [mbOK], 0);
  end;
end;


{*******************************************************************************
  CANCELAMENTO DE NF-E
    - Exemplo de cancelamento de uma NFe
*******************************************************************************}
procedure TfrmPrincipal.btnCancelarNotaClick(Sender: TObject);
var
  DataHoraEvento: TDateTime;
  NumeroLote: Integer;
begin
  // numero do lote de envio
  DataHoraEvento := NOW;
  NumeroLote     := StrToInt(FormatDateTime('yymmddhhmm', NOW));

  // carregar o XML da nota
  ACBrNFe1.NotasFiscais.LoadFromString('string do xml da nfe', False);     // utilizar quando você grava o XML no BD e tem a string do XML
  // ou
  //ACBrNFe1.NotasFiscais.LoadFromFile('caminho do arquivo xml', False);   // utilizar quando você quer usar o arquivo XML da NFe

  // envio da carta de correção
  ACBrNFe1.EventoNFe.Evento.Clear;
  ACBrNFe1.EventoNFe.idLote := NumeroLote;

  with ACBrNFe1.EventoNFe.Evento.Add do
  begin
    infEvento.CNPJ            := '11222333000155'; // cnpj do emitente da nota
    infEvento.dhEvento        := DataHoraEvento;
    infEvento.tpEvento        := teCancelamento;
    infEvento.chNFe           := ACBrNFe1.NotasFiscais[0].NFe.procNFe.chNFe;
    infEvento.detEvento.nProt := ACBrNFe1.NotasFiscais[0].NFe.procNFe.nProt;
    infEvento.detEvento.xJust := 'Texto justificando o cancelamento, minimo de 15 caracteres';
  end;

  if ACBrNFe1.EnviarEvento(NumeroLote) then
  begin
    with ACBrNFe1.WebServices do
    begin
      if EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat <> 135 then
      begin
        raise Exception.CreateFmt(
          'Ocorreu o seguinte erro ao cancelar a nota fiscal eletrônica:'  + sLineBreak +
          'Código:%d' + sLineBreak +
          'Motivo: %s', [
            EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat,
            EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo
        ]);
      end;
    end;
  end
  else
  begin
    with ACBrNFe1.WebServices.EnvEvento do
    begin
      raise Exception.Create(
        'Ocorreram erros ao tentar efetuar o cancelamento:' + sLineBreak +
        'Lote: '     + IntToStr(EventoRetorno.idLote) + sLineBreak +
        'Ambiente: ' + TpAmbToStr(EventoRetorno.tpAmb) + sLineBreak +
        'Orgao: '    + IntToStr(EventoRetorno.cOrgao) + sLineBreak +
        sLineBreak +
        'Status: '   + IntToStr(EventoRetorno.cStat) + sLineBreak +
        'Motivo: '   + EventoRetorno.xMotivo
      );
    end;
  end;
end;


{*******************************************************************************
  INUTILIZAÇÃO DE NUMERAÇÃO
    - Exemplo de inutilização de numeração, deve ser utilizado quando pula a
      numeração da nota, lembrando que existem prazos para a inutilização
*******************************************************************************}
procedure TfrmPrincipal.btnInutilizarNumeracaoClick(Sender: TObject);
begin
  ACBrNFe1.WebServices.Inutiliza(
    '11222333000155', // cnpj do emitente da NFe
    'Texto justificando a inutilização da numeração, minimo de 15 caracteres',
    2016,
    55,
    1,
    1000,
    1010
  );

  if ACBrNFe1.WebServices.Inutilizacao.cStat = 102 then
  begin
    // ACBrNFe1.WebServices.Inutilizacao.Protocolo,
    // ACBrNFe1.WebServices.Inutilizacao.dhRecbto,
    // ACBrNFe1.WebServices.Inutilizacao.XML_ProcInutNFe
  end
  else
  begin
    raise Exception.CreateFmt(
      'Código:%d' + sLineBreak + 'Motivo: %s', [
        ACBrNFe1.WebServices.Inutilizacao.cStat,
        ACBrNFe1.WebServices.Inutilizacao.xMotivo
    ]);
  end;
end;


{*******************************************************************************
  CARTA DE CORREÇÃO DE NF-E
    - Exemplo de preenchimento de uma carta de correção, podem ser feitas
      até 20 correções para uma mesma NF-e, lembre-se que a última correção
      sobrepõe as anteriores, então a última sempre deve conter todas as
      correções passadas e atual.
*******************************************************************************}
procedure TfrmPrincipal.btnCartaCorrecaoClick(Sender: TObject);
var
  DataHoraEvento: TDateTime;
  NumeroLote: Integer;
begin
  // numero do lote de envio
  DataHoraEvento := NOW;
  NumeroLote     := StrToInt(FormatDateTime('yymmddhhmm', NOW));

  // xml da nota fiscal eletronica para ser atualizado
  // carregar o XML da nota
  ACBrNFe1.NotasFiscais.LoadFromString('string do xml da nfe', False);     // utilizar quando você grava o XML no BD e tem a string do XML
  // ou
  //ACBrNFe1.NotasFiscais.LoadFromFile('caminho do arquivo xml', False);   // utilizar quando você quer usar o arquivo XML da NFe

  // envio da carta de correção
  ACBrNFe1.EventoNFe.Evento.Clear;
  ACBrNFe1.EventoNFe.idLote := NumeroLote;

  with ACBrNFe1.EventoNFe.Evento.Add do
  begin
    infEvento.CNPJ                := '11222333000155'; // cnpj do emitente da NFe
    infEvento.dhEvento            := DataHoraEvento;
    infEvento.tpEvento            := teCCe;
    infEvento.chNFe               := ACBrNFe1.NotasFiscais[0].NFe.procNFe.chNFe;
    infEvento.nSeqEvento          := 1; // numero sequencial de correção, podem ser feita até 20 correçoes em uma mesma nfe
    infEvento.detEvento.xCorrecao := 'Texto da correção, deve englobar todas as correções anteriores';
  end;

  if ACBrNFe1.EnviarEvento(NumeroLote) then
  begin
    with ACBrNFe1.WebServices do
    begin
      if EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat <> 135 then
      begin
        raise Exception.CreateFmt(
          'Ocorreu o seguinte erro enviar a correção da nota fiscal eletrônica:'  + sLineBreak +
          'Código:%d' + sLineBreak +
          'Motivo: %s', [
            EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat,
            EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo
        ]);
      end;
    end;
  end
  else
  begin
    with ACBrNFe1.WebServices.EnvEvento do
    begin
      raise Exception.Create(
        'Ocorreram erros ao tentar efetuar a Carta de Correção:' + sLineBreak +
        'Lote: '     + IntToStr(EventoRetorno.idLote) + sLineBreak +
        'Ambiente: ' + TpAmbToStr(EventoRetorno.tpAmb) + sLineBreak +
        'Orgao: '    + IntToStr(EventoRetorno.cOrgao) + sLineBreak +
        sLineBreak +
        'Status: '   + IntToStr(EventoRetorno.cStat) + sLineBreak +
        'Motivo: '   + EventoRetorno.xMotivo
      );
    end;
  end;
end;


{*******************************************************************************
  IMPRESSÃO DE NFE
*******************************************************************************}
procedure TfrmPrincipal.btnImprimirNFeClick(Sender: TObject);
begin
  ACBrNFe1.NotasFiscais.Clear;

  // carregar o XML da nota
  ACBrNFe1.NotasFiscais.LoadFromString('string do xml da nfe', False);     // utilizar quando você grava o XML no BD e tem a string do XML
  // ou
  //ACBrNFe1.NotasFiscais.LoadFromFile('caminho do arquivo xml', False);   // utilizar quando você quer usar o arquivo XML da NFe

  ACBrNFe1.DANFE.MostrarPreview := True; // se false imprime diretamente
  ACBrNFe1.NotasFiscais[0].Imprimir;
end;

end.
