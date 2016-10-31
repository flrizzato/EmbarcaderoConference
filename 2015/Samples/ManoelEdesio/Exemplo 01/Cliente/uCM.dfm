object CM: TCM
  OldCreateOrder = False
  Height = 448
  Width = 432
  object DSRestConnection1: TDSRestConnection
    Host = 'cpro28908.publiccloud.com.br'
    Port = 211
    LoginPrompt = False
    Left = 72
    Top = 32
    UniqueId = '{6C709619-9909-42D9-A60D-10E643FDA015}'
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 72
    Top = 112
  end
  object tblCliente: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.UpdateTableName = 'TB_CLIENTE'
    Left = 192
    Top = 32
  end
  object tblProdutos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.UpdateTableName = 'TB_CLIENTE'
    Left = 192
    Top = 112
  end
end
