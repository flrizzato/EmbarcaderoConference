object DataModule2: TDataModule2
  OldCreateOrder = False
  Height = 382
  Width = 505
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select * from Clientes')
    Left = 176
    Top = 32
    object FDQuery1Id: TFDAutoIncField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery1Nome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 50
    end
    object FDQuery1DataNascimento: TDateField
      FieldName = 'DataNascimento'
      Origin = 'DataNascimento'
      Required = True
    end
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select * from Produtos')
    Left = 176
    Top = 80
    object FDQuery2Id: TFDAutoIncField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery2Produto: TStringField
      FieldName = 'Produto'
      Origin = 'Produto'
      Required = True
      Size = 50
    end
    object FDQuery2Valor: TBCDField
      FieldName = 'Valor'
      Origin = 'Valor'
      Required = True
      Precision = 16
      Size = 2
    end
  end
  object FDQuery4: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evMode, evAutoClose]
    FetchOptions.Mode = fmAll
    FetchOptions.AutoClose = False
    SQL.Strings = (
      'select * from Clientes'
      'select * from Produtos')
    Left = 352
    Top = 32
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=DelphiExtreme'
      'User_Name=sa'
      'Password=732154Al#'
      'Server=localhost'
      'OSAuthent=No'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 64
    Top = 40
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 64
    Top = 88
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 64
    Top = 136
  end
  object FDMemTable1: TFDMemTable
    Tag = 1
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 256
    Top = 32
  end
  object FDMemTable2: TFDMemTable
    Tag = 1
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 256
    Top = 80
  end
  object FDMemTable4: TFDMemTable
    Tag = 2
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 424
    Top = 32
  end
  object FDMemTable5: TFDMemTable
    Tag = 2
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 424
    Top = 80
  end
end
