object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Exemplo EC2016'
  ClientHeight = 501
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 519
    Top = 43
    Width = 181
    Height = 19
    Cursor = crHandPoint
    Alignment = taRightJustify
    Caption = 'regys.silveira@gmail.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = Label1Click
  end
  object Label2: TLabel
    Left = 474
    Top = 78
    Width = 226
    Height = 19
    Cursor = crHandPoint
    Alignment = taRightJustify
    Caption = 'https://twitter.com/regyssilveira'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = Label1Click
  end
  object Label3: TLabel
    Left = 372
    Top = 112
    Width = 328
    Height = 19
    Cursor = crHandPoint
    Alignment = taRightJustify
    Caption = 'https://www.facebook.com/BlogRegysSilveira/'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = Label1Click
  end
  object Label4: TLabel
    Left = 385
    Top = 150
    Width = 315
    Height = 19
    Cursor = crHandPoint
    Alignment = taRightJustify
    Caption = 'https://www.youtube.com/user/regyssilveira'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = Label1Click
  end
  object Label5: TLabel
    Left = 264
    Top = 184
    Width = 436
    Height = 19
    Cursor = crHandPoint
    Alignment = taRightJustify
    Caption = 'https://br.linkedin.com/in/r'#233'gys-borges-da-silveira-b5584527'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = Label1Click
  end
  object Label6: TLabel
    Left = 250
    Top = 355
    Width = 450
    Height = 96
    Alignment = taRightJustify
    AutoSize = False
    Caption = 
      'Este demo visa demonstrar as propriedades necess'#225'rias ao preench' +
      'imento para emiss'#227'o de uma nota fiscal eletr'#244'nica simples, quais' +
      'quer d'#250'vidas referente ao componente ACBr devem ser sanadas util' +
      'izando o f'#243'rum ACBr em http://www.projetoacbr.com.br/forum'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object btnConfigurar: TButton
    Left = 50
    Top = 90
    Width = 171
    Height = 41
    Caption = 'Configurar'
    TabOrder = 1
    OnClick = btnConfigurarClick
  end
  object btnEmitirNota: TButton
    Left = 50
    Top = 184
    Width = 171
    Height = 41
    Caption = 'Emitir NFe'
    TabOrder = 3
    OnClick = btnEmitirNotaClick
  end
  object btnCancelarNota: TButton
    Left = 50
    Top = 278
    Width = 171
    Height = 41
    Caption = 'Cancelar NFe'
    TabOrder = 5
    OnClick = btnCancelarNotaClick
  end
  object btnInutilizarNumeracao: TButton
    Left = 50
    Top = 325
    Width = 171
    Height = 41
    Caption = 'Inutilizar Numera'#231#227'o'
    TabOrder = 6
    OnClick = btnInutilizarNumeracaoClick
  end
  object btnStatusServico: TButton
    Left = 50
    Top = 137
    Width = 171
    Height = 41
    Caption = 'Status Webservice'
    TabOrder = 2
    OnClick = btnStatusServicoClick
  end
  object btnSelecionarCertificado: TButton
    Left = 50
    Top = 43
    Width = 171
    Height = 41
    Caption = 'Selecionar Certificado'
    TabOrder = 0
    OnClick = btnSelecionarCertificadoClick
  end
  object btnConsultarNFe: TButton
    Left = 50
    Top = 231
    Width = 171
    Height = 41
    Caption = 'Consultar NFe'
    TabOrder = 4
    OnClick = btnConsultarNFeClick
  end
  object btnCartaCorrecao: TButton
    Left = 50
    Top = 372
    Width = 171
    Height = 41
    Caption = 'Carta de Corre'#231#227'o'
    TabOrder = 7
    OnClick = btnCartaCorrecaoClick
  end
  object btnImprimirNFe: TButton
    Left = 50
    Top = 419
    Width = 171
    Height = 41
    Caption = 'Imprimir NFe'
    TabOrder = 8
    OnClick = btnImprimirNFeClick
  end
  object ACBrNFe1: TACBrNFe
    MAIL = ACBrMail1
    Configuracoes.Geral.SSLLib = libCapicomDelphiSoap
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.IncluirQRCodeXMLNFCe = False
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    DANFE = ACBrNFeDANFEFR1
    Left = 35
    Top = 10
  end
  object ACBrMail1: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = CP1252
    Left = 35
    Top = 60
  end
  object ACBrNFeDANFEFR1: TACBrNFeDANFEFR
    ACBrNFe = ACBrNFe1
    MostrarPreview = True
    MostrarStatus = True
    TipoDANFE = tiSemGeracao
    NumCopias = 1
    ImprimeNomeFantasia = False
    ImprimirDescPorc = False
    ImprimirTotalLiquido = True
    MargemInferior = 0.800000000000000000
    MargemSuperior = 0.800000000000000000
    MargemEsquerda = 0.600000000000000000
    MargemDireita = 0.510000000000000000
    CasasDecimais.Formato = tdetInteger
    CasasDecimais._qCom = 2
    CasasDecimais._vUnCom = 2
    CasasDecimais._Mask_qCom = '###,###,###,##0.00'
    CasasDecimais._Mask_vUnCom = '###,###,###,##0.00'
    ExibirResumoCanhoto = False
    FormularioContinuo = False
    TamanhoFonte_DemaisCampos = 10
    ProdutosPorPagina = 0
    ImprimirDetalhamentoEspecifico = True
    NFeCancelada = False
    ImprimirItens = True
    ViaConsumidor = True
    TamanhoLogoHeight = 0
    TamanhoLogoWidth = 0
    RecuoEndereco = 0
    RecuoEmpresa = 0
    LogoemCima = False
    TamanhoFonteEndereco = 0
    RecuoLogo = 0
    TributosSeparadamente = False
    EspessuraBorda = 1
    ExibirTotalTributosItem = False
    ExibeCampoFatura = True
    TributosPercentual = ptValorProdutos
    ImprimirUnQtVlComercial = False
    Detalhado = False
    DescricaoViaEstabelec = 'Via do Consumidor'
    ExpandirDadosAdicionaisAuto = False
    ImprimirDadosArma = True
    QuebraLinhaEmDetalhamentoEspecifico = True
    IncorporarBackgroundPdf = True
    IncorporarFontesPdf = True
    Left = 35
    Top = 110
  end
end
