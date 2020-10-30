object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Demo Embarcadero Conference 2017'
  ClientHeight = 362
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnConfigurar: TButton
    Left = 30
    Top = 25
    Width = 136
    Height = 25
    Caption = 'Configurar'
    TabOrder = 0
    OnClick = btnConfigurarClick
  end
  object btnGerarXML: TButton
    Left = 30
    Top = 56
    Width = 136
    Height = 25
    Caption = 'Gerar XML'
    TabOrder = 1
    OnClick = btnGerarXMLClick
  end
  object btnImprimir: TButton
    Left = 30
    Top = 118
    Width = 136
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 3
    OnClick = btnImprimirClick
  end
  object btnSalvarXML: TButton
    Left = 30
    Top = 87
    Width = 136
    Height = 25
    Caption = 'Salvar XML'
    TabOrder = 2
    OnClick = btnSalvarXMLClick
  end
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    DANFE = ACBrNFeDANFeRL1
    Left = 270
    Top = 55
  end
  object ACBrNFeDANFeRL1: TACBrNFeDANFeRL
    ACBrNFe = ACBrNFe1
    MostrarPreview = True
    MostrarStatus = True
    TipoDANFE = tiRetrato
    NumCopias = 1
    ImprimeNomeFantasia = False
    ImprimirDescPorc = False
    ImprimirTotalLiquido = True
    MargemInferior = 0.700000000000000000
    MargemSuperior = 0.700000000000000000
    MargemEsquerda = 0.700000000000000000
    MargemDireita = 0.700000000000000000
    CasasDecimais.Formato = tdetInteger
    CasasDecimais._qCom = 4
    CasasDecimais._vUnCom = 4
    CasasDecimais._Mask_qCom = ',0.00'
    CasasDecimais._Mask_vUnCom = ',0.00'
    ExibirResumoCanhoto = False
    FormularioContinuo = False
    TamanhoFonte_DemaisCampos = 8
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
    LarguraCodProd = 54
    ExibirEAN = False
    QuebraLinhaEmDetalhamentoEspecifico = True
    ExibeCampoFatura = False
    ImprimirUnQtVlComercial = iuComercial
    ImprimirDadosDocReferenciados = True
    Left = 270
    Top = 100
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.xml'
    Filter = 'arquivos xml|*.xml'
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Title = 'Salvar arquivo'
    Left = 295
    Top = 185
  end
end
