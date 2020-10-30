object FiredacResourceResource1: TFiredacResourceResource1
  OldCreateOrder = False
  Height = 374
  Width = 546
  object EmployeeConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=EMPLOYEE')
    LoginPrompt = False
    Left = 71
    Top = 38
  end
  object CustomerTable: TFDQuery
    CachedUpdates = True
    Connection = EmployeeConnection
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      'SELECT * FROM CUSTOMER')
    Left = 226
    Top = 36
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    Left = 336
    Top = 40
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 216
    Top = 136
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 312
    Top = 144
  end
end
