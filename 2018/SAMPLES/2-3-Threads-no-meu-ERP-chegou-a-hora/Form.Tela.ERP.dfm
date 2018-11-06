object frmTelaERP: TfrmTelaERP
  Left = 0
  Top = 0
  Caption = 'Tela ERP'
  ClientHeight = 575
  ClientWidth = 754
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
  object Splitter1: TSplitter
    Left = 0
    Top = 525
    Width = 754
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = -8
    ExplicitTop = 411
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 231
    Width = 754
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = 8
    ExplicitTop = -2
  end
  object Splitter3: TSplitter
    Left = 0
    Top = 418
    Width = 754
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = -16
    ExplicitTop = 229
  end
  object PanelControles: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 531
    Width = 748
    Height = 41
    Align = alBottom
    TabOrder = 0
    object ButtonEnviarEmail: TBitBtn
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 141
      Height = 33
      Align = alLeft
      Caption = 'Enviar Email'
      TabOrder = 0
    end
    object ButtonGeraPedido: TBitBtn
      AlignWithMargins = True
      Left = 151
      Top = 4
      Width = 141
      Height = 33
      Align = alLeft
      Caption = 'Gerar Pedido'
      TabOrder = 1
    end
    object ButtonAprovarPedido: TBitBtn
      AlignWithMargins = True
      Left = 298
      Top = 4
      Width = 141
      Height = 33
      Align = alLeft
      Caption = 'Aprovar Pedido'
      TabOrder = 2
    end
  end
  object PanelInfoCliente: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 424
    Width = 748
    Height = 98
    Align = alBottom
    TabOrder = 1
    object Splitter5: TSplitter
      Left = 386
      Top = 26
      Height = 71
      Align = alRight
      ExplicitLeft = 376
      ExplicitTop = -32
      ExplicitHeight = 100
    end
    object Label3: TLabel
      Left = 1
      Top = 1
      Width = 746
      Height = 25
      Align = alTop
      Alignment = taCenter
      Caption = 'Compras e Projetos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 182
    end
    object DBGridCompras: TDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 29
      Width = 379
      Height = 65
      Align = alClient
      DataSource = dtsCompras
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object DBGrid2: TDBGrid
      AlignWithMargins = True
      Left = 392
      Top = 29
      Width = 352
      Height = 65
      Align = alRight
      DataSource = dtsProjetos
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object PanelCliente: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 237
    Width = 748
    Height = 178
    Align = alClient
    TabOrder = 2
    object Label2: TLabel
      Left = 1
      Top = 1
      Width = 746
      Height = 25
      Align = alTop
      Alignment = taCenter
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 64
    end
    object DBGridCliente: TDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 29
      Width = 740
      Height = 145
      Align = alClient
      DataSource = dtsCliente
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object PanelPesquisa: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 748
    Height = 225
    Align = alTop
    TabOrder = 3
    object Splitter4: TSplitter
      Left = 341
      Top = 1
      Height = 223
      Align = alRight
      ExplicitLeft = 376
      ExplicitTop = 64
      ExplicitHeight = 100
    end
    object PanelFiltroPesquisa: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 334
      Height = 217
      Align = alClient
      TabOrder = 0
      object Label1: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 326
        Height = 19
        Align = alTop
        Caption = 'Pesquisa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 61
      end
      object EditPesquisa: TEdit
        AlignWithMargins = True
        Left = 4
        Top = 29
        Width = 326
        Height = 21
        Align = alTop
        TabOrder = 0
      end
      object ButtonCarregarTela: TButton
        Left = 16
        Top = 109
        Width = 185
        Height = 36
        Caption = 'Carregar Tela'
        TabOrder = 1
        OnClick = ButtonCarregarTelaClick
      end
      object ButtonCarregarTh: TButton
        Left = 16
        Top = 151
        Width = 185
        Height = 36
        Caption = 'Carregar Tela Th'
        TabOrder = 2
        OnClick = ButtonCarregarThClick
      end
    end
    object PanelGrafico: TPanel
      Left = 344
      Top = 1
      Width = 403
      Height = 223
      Align = alRight
      TabOrder = 1
      object LabelCotacao: TLabel
        Left = 1
        Top = 1
        Width = 401
        Height = 25
        Align = alTop
        Alignment = taCenter
        Caption = 'Cota'#231#227'o - HH:MM:SS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 194
      end
      object DBChart1: TDBChart
        AlignWithMargins = True
        Left = -1
        Top = 29
        Width = 400
        Height = 190
        Title.Text.Strings = (
          'TDBChart')
        Align = alRight
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series1: TLineSeries
          DataSource = dmdTelaERP.memCotacao
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          XValues.ValueSource = 'data'
          YValues.Name = 'Y'
          YValues.Order = loNone
          YValues.ValueSource = 'valor'
        end
      end
    end
  end
  object dtsCliente: TDataSource
    DataSet = dmdTelaERP.qryCliente
    Left = 368
    Top = 296
  end
  object dtsCotacao: TDataSource
    DataSet = dmdTelaERP.memCotacao
    Left = 440
    Top = 96
  end
  object TimerOpen: TTimer
    Enabled = False
    OnTimer = TimerOpenTimer
    Left = 616
    Top = 288
  end
  object dtsCompras: TDataSource
    DataSet = dmdTelaERP.qryCompras
    Left = 200
    Top = 456
  end
  object dtsProjetos: TDataSource
    DataSet = dmdTelaERP.qryProjeto
    Left = 520
    Top = 456
  end
end
