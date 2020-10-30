object Dtm: TDtm
  OldCreateOrder = False
  Height = 357
  Width = 479
  object MtClientes: TFDMemTable
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 48
    Top = 32
    object MtClientesIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object MtClientesNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 60
    end
  end
  object MtTelefones: TFDMemTable
    CachedUpdates = True
    IndexFieldNames = 'IDCLIENTE'
    MasterSource = DataSource1
    MasterFields = 'IDCLIENTE'
    DetailFields = 'IDCLIENTE'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 48
    Top = 88
    object MtTelefonesIDTELEFONE: TIntegerField
      FieldName = 'IDTELEFONE'
      Origin = 'IDTELEFONE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object MtTelefonesIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
      Required = True
    end
    object MtTelefonesNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Required = True
    end
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 384
    Top = 32
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 384
    Top = 88
  end
  object DataSource1: TDataSource
    DataSet = MtClientes
    Left = 144
    Top = 64
  end
end
