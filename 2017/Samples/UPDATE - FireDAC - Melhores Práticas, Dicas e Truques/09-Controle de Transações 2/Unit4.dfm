object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 478
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 49
    Width = 601
    Height = 185
    Align = alTop
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 234
    Width = 601
    Height = 203
    Align = alClient
    DataSource = DataSource2
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 601
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Transa'#231#227'o com Master/Detail'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object Panel2: TPanel
    Left = 0
    Top = 437
    Width = 601
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 3
    ExplicitLeft = 216
    ExplicitTop = 240
    ExplicitWidth = 185
    object Button1: TButton
      Left = 390
      Top = 5
      Width = 100
      Height = 32
      Caption = 'Apply'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 495
      Top = 5
      Width = 100
      Height = 32
      Caption = 'Refresh'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object Conexao: TFDConnection
    Params.Strings = (
      'ConnectionDef=CursoFireDAC')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 103
  end
  object FDQuery1: TFDQuery
    CachedUpdates = True
    Connection = Conexao
    SchemaAdapter = FDSchemaAdapter1
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    SQL.Strings = (
      'Select * From Clientes')
    Left = 128
    Top = 104
    object FDQuery1IdCliente: TFDAutoIncField
      FieldName = 'IdCliente'
      Origin = 'IdCliente'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery1Nome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 80
    end
    object FDQuery1Logradouro: TStringField
      FieldName = 'Logradouro'
      Origin = 'Logradouro'
      Size = 100
    end
    object FDQuery1Numero: TStringField
      FieldName = 'Numero'
      Origin = 'Numero'
      Size = 6
    end
    object FDQuery1IdBairro: TIntegerField
      FieldName = 'IdBairro'
      Origin = 'IdBairro'
    end
  end
  object FDQuery2: TFDQuery
    CachedUpdates = True
    IndexFieldNames = 'IdCliente'
    MasterSource = DataSource1
    MasterFields = 'IdCliente'
    DetailFields = 'IdCliente'
    Connection = Conexao
    SchemaAdapter = FDSchemaAdapter1
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    SQL.Strings = (
      'Select * From Telefones Where IdCliente = :IdCliente')
    Left = 200
    Top = 104
    ParamData = <
      item
        Name = 'IDCLIENTE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQuery2IdCliente: TIntegerField
      FieldName = 'IdCliente'
      Origin = 'IdCliente'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQuery2Numero: TStringField
      FieldName = 'Numero'
      Origin = 'Numero'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 128
    Top = 160
  end
  object DataSource2: TDataSource
    DataSet = FDQuery2
    Left = 200
    Top = 160
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    OnReconcileRow = FDSchemaAdapter1ReconcileRow
    Left = 320
    Top = 152
  end
end
