object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 429
  ClientWidth = 685
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 23
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 685
    Height = 193
    Align = alTop
    DataSource = DtsClientes
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -19
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 193
    Width = 685
    Height = 183
    Align = alClient
    DataSource = DtsFone
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -19
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 376
    Width = 685
    Height = 53
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 2
    object Button1: TButton
      Left = 444
      Top = 7
      Width = 113
      Height = 41
      Caption = 'Refresh'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 566
      Top = 7
      Width = 113
      Height = 41
      Caption = 'Apply'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=Teste'
      'User_Name=sa'
      'Password=732154Al#'
      'Server=(local)'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 16
  end
  object FDQueryClientes: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      'Select * from Clientes')
    Left = 56
    Top = 64
    object FDQueryClientesIdCliente: TIntegerField
      FieldName = 'IdCliente'
      Origin = 'IdCliente'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQueryClientesNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Size = 50
    end
  end
  object FDQueryTelefones: TFDQuery
    CachedUpdates = True
    MasterSource = DtsClientes
    MasterFields = 'IdCliente'
    DetailFields = 'IdCliente'
    Connection = FDConnection1
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      'Select * from Fone where IdCliente = :IdCliente')
    Left = 192
    Top = 208
    ParamData = <
      item
        Name = 'IDCLIENTE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryTelefonesIdCliente: TIntegerField
      FieldName = 'IdCliente'
      Origin = 'IdCliente'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQueryTelefonesFone: TStringField
      FieldName = 'Fone'
      Origin = 'Fone'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 15
    end
  end
  object DtsClientes: TDataSource
    DataSet = FDQueryClientes
    Left = 56
    Top = 112
  end
  object DtsFone: TDataSource
    DataSet = FDQueryTelefones
    Left = 192
    Top = 256
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    OnReconcileRow = FDSchemaAdapter1ReconcileRow
    Left = 336
    Top = 224
  end
end
