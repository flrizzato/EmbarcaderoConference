object DadosResource1: TDadosResource1
  OldCreateOrder = False
  Height = 355
  Width = 584
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=EC2014'
      'User_Name=sa'
      'Password=sysdba'
      'Server=localhost'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 64
    Top = 72
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 216
    Top = 16
  end
  object qrPessoa: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      'select * from Pessoa'
      'order by Nome')
    Left = 64
    Top = 120
    object qrPessoaCodigo: TIntegerField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrPessoaNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 50
    end
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 376
    Top = 16
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    Left = 240
    Top = 200
  end
end
