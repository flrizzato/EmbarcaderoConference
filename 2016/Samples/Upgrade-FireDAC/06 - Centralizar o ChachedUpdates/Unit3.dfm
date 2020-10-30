object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 350
  ClientWidth = 796
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 780
    Height = 137
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 151
    Width = 780
    Height = 153
    DataSource = DataSource2
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 632
    Top = 312
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Cancel: TButton
    Left = 713
    Top = 312
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = CancelClick
  end
  object CursofiredacConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=CursoFireDAC')
    Connected = True
    LoginPrompt = False
    Left = 492
    Top = 65
  end
  object FDQuery1: TFDQuery
    Active = True
    CachedUpdates = True
    Connection = CursofiredacConnection
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      'Select * From Clientes')
    Left = 464
    Top = 168
    object FDQuery1IdCliente: TFDAutoIncField
      FieldName = 'IdCliente'
      Origin = 'IdCliente'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery1Nome: TStringField
      DisplayWidth = 40
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 80
    end
    object FDQuery1Logradouro: TStringField
      DisplayWidth = 40
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
    Active = True
    CachedUpdates = True
    IndexFieldNames = 'IdCliente'
    MasterSource = DataSource1
    MasterFields = 'IdCliente'
    Connection = CursofiredacConnection
    SchemaAdapter = FDSchemaAdapter1
    FetchOptions.AssignedValues = [evDetailCascade]
    FetchOptions.DetailCascade = True
    SQL.Strings = (
      'Select * From Telefones Where IdCliente = :IdCliente')
    Left = 568
    Top = 168
    ParamData = <
      item
        Name = 'IDCLIENTE'
        DataType = ftAutoInc
        ParamType = ptInput
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
    Left = 464
    Top = 216
  end
  object DataSource2: TDataSource
    DataSet = FDQuery2
    Left = 568
    Top = 216
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    Left = 648
    Top = 200
  end
end
