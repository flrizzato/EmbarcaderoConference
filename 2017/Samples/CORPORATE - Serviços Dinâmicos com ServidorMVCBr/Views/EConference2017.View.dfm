object EConference2017View: TEConference2017View
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Embarcadero Conference 2017'
  ClientHeight = 562
  ClientWidth = 777
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 327
    Top = 313
    Width = 13
    Height = 25
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 95
    Top = 318
    Width = 61
    Height = 13
    Caption = 'Qtd.TopRow'
  end
  object Label3: TLabel
    Left = 504
    Top = 311
    Width = 24
    Height = 13
    Caption = 'Filtro'
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 777
    Height = 257
    Align = alTop
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 257
    Width = 777
    Height = 50
    DataSource = DataSource1
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
    Align = alTop
    TabOrder = 1
  end
  object Button1: TButton
    Left = 8
    Top = 313
    Width = 81
    Height = 25
    Caption = 'Abre Tabela'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 346
    Width = 81
    Height = 25
    Caption = 'Fecha Tabela'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 222
    Top = 313
    Width = 99
    Height = 25
    Caption = 'Conta Registro'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 159
    Top = 315
    Width = 57
    Height = 21
    TabOrder = 5
    Text = '10'
  end
  object Memo1: TMemo
    Left = 372
    Top = 459
    Width = 397
    Height = 95
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Acessando servidor na Amazom, BD Firebird'
      ''
      'ServidorMVCBr OData - Restful'
      'http://mvcbr.ddns.com.br:8080/OData/OData.svc/cliente'
      ''
      'http://www.tireideletra.com.br')
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
  end
  object Memo2: TMemo
    Left = 8
    Top = 459
    Width = 310
    Height = 95
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Se inscreva nos canais:'
      ''
      'https://www.youtube.com/c/KlebersonToro'
      ''
      'https://www.youtube.com/user/amarrillo51'
      ''
      '')
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
  end
  object MemoExecucao: TMemo
    Left = 8
    Top = 377
    Width = 761
    Height = 76
    Lines.Strings = (
      'MemoExecucao')
    ReadOnly = True
    TabOrder = 8
  end
  object EdtPesquisa: TEdit
    Left = 504
    Top = 330
    Width = 184
    Height = 21
    TabOrder = 9
  end
  object BitBtn1: TBitBtn
    Left = 694
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Aplic.Filtro'
    TabOrder = 10
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 159
    Top = 346
    Width = 75
    Height = 25
    Caption = 'ApplyUpdates'
    TabOrder = 11
    OnClick = BitBtn2Click
  end
  object Button4: TButton
    Left = 246
    Top = 346
    Width = 75
    Height = 25
    Caption = 'Pedido'
    TabOrder = 12
    OnClick = Button4Click
  end
  object EdtCampo: TEdit
    Left = 372
    Top = 320
    Width = 93
    Height = 21
    TabOrder = 13
    Text = 'EdtCampo'
  end
  object EdtOpera: TEdit
    Left = 372
    Top = 350
    Width = 93
    Height = 21
    TabOrder = 14
    Text = 'containing'
  end
  object DBGrid2: TDBGrid
    Left = 372
    Top = 0
    Width = 320
    Height = 257
    DataSource = DataSource3
    TabOrder = 15
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Visible = False
  end
  object DataSource1: TDataSource
    DataSet = ODataFDMemTable1
    Left = 64
    Top = 160
  end
  object ODataDatasetBuilder1: TODataDatasetBuilder
    Dataset = ODataFDMemTable1
    Params = <>
    BaseURL = 'http://mvcbr.ddns.com.br:8080'
    ServicePrefix = '/OData'
    Service = '/OData.svc'
    ResourceName = 'CLIENTES'
    Resource = <
      item
        Resource = 'CLIENTES'
        ResourceParams = <>
      end>
    TopRows = 0
    SkipRows = 0
    Count = False
    AfterExecute = ODataDatasetBuilder1AfterExecute
    Left = 64
    Top = 56
  end
  object ODataFDMemTable1: TODataFDMemTable
    AfterInsert = ODataFDMemTable1AfterInsert
    FieldDefs = <
      item
        Name = 'codigo'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'razao'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'endereco'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'bairro'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'cidade'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'uf'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'tel01'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ativo'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'id_cliente'
        DataType = ftFloat
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    KeyFields = 'codigo'
    Left = 64
    Top = 104
  end
  object ODataDatasetBuilder2: TODataDatasetBuilder
    Dataset = ODataFDMemTable2
    Params = <>
    BaseURL = 'http://mvcbr.ddns.com.br:8080'
    ServicePrefix = '/OData'
    Service = '/OData.svc'
    ResourceName = 'PEDIDO'
    Resource = <
      item
        Resource = 'PEDIDO'
        ResourceParams = <>
      end>
    TopRows = 0
    SkipRows = 0
    Count = False
    Left = 272
    Top = 48
  end
  object ODataFDMemTable2: TODataFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 272
    Top = 104
  end
  object DataSource2: TDataSource
    DataSet = ODataFDMemTable2
    OnDataChange = DataSource2DataChange
    Left = 272
    Top = 152
  end
  object ODataDatasetBuilder3: TODataDatasetBuilder
    Dataset = ODataFDMemTable3
    Params = <>
    BaseURL = 'http://mvcbr.ddns.com.br:8080'
    ServicePrefix = '/OData'
    Service = '/OData.svc'
    ResourceName = 'PEDIDO_ITENS'
    Resource = <
      item
        Resource = 'PEDIDO_ITENS'
        ResourceParams = <>
      end>
    TopRows = 0
    SkipRows = 0
    Count = False
    Left = 408
    Top = 48
  end
  object ODataFDMemTable3: TODataFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 408
    Top = 104
  end
  object DataSource3: TDataSource
    DataSet = ODataFDMemTable3
    Left = 408
    Top = 160
  end
end
