object MainDM: TMainDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 355
  Width = 541
  object DSRestCnn: TDSRestConnection
    Host = 'localhost'
    Port = 8080
    LoginPrompt = False
    Left = 48
    Top = 24
    UniqueId = '{28F9CEF3-146B-47A4-AA5B-2836DB3C80CA}'
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 152
    Top = 24
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 280
    Top = 24
  end
  object CaseMemTable: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 48
    Top = 80
    object CaseMemTableId: TWideStringField
      FieldName = 'Id'
      Size = 4000
    end
    object CaseMemTableIsDeleted: TShortintField
      FieldName = 'IsDeleted'
    end
    object CaseMemTableCaseNumber: TWideStringField
      FieldName = 'CaseNumber'
      Size = 4000
    end
    object CaseMemTableContactId: TWideStringField
      FieldName = 'ContactId'
      Size = 4000
    end
    object CaseMemTableAccountId: TWideStringField
      FieldName = 'AccountId'
      Size = 4000
    end
    object CaseMemTableAssetId: TWideStringField
      FieldName = 'AssetId'
      Size = 4000
    end
    object CaseMemTableParentId: TWideStringField
      FieldName = 'ParentId'
      Size = 4000
    end
    object CaseMemTableSuppliedName: TWideStringField
      FieldName = 'SuppliedName'
      Size = 4000
    end
    object CaseMemTableSuppliedEmail: TWideStringField
      FieldName = 'SuppliedEmail'
      Size = 4000
    end
    object CaseMemTableSuppliedPhone: TWideStringField
      FieldName = 'SuppliedPhone'
      Size = 4000
    end
    object CaseMemTableSuppliedCompany: TWideStringField
      FieldName = 'SuppliedCompany'
      Size = 4000
    end
    object CaseMemTableType: TWideStringField
      FieldName = 'Type'
      Size = 4000
    end
    object CaseMemTableStatus: TWideStringField
      FieldName = 'Status'
      Size = 4000
    end
    object CaseMemTableReason: TWideStringField
      FieldName = 'Reason'
      Size = 4000
    end
    object CaseMemTableOrigin: TWideStringField
      FieldName = 'Origin'
      Size = 4000
    end
    object CaseMemTableSubject: TWideStringField
      FieldName = 'Subject'
      Size = 4000
    end
    object CaseMemTablePriority: TWideStringField
      FieldName = 'Priority'
      Size = 4000
    end
    object CaseMemTableDescription: TWideStringField
      FieldName = 'Description'
      Size = 4000
    end
    object CaseMemTableIsClosed: TShortintField
      FieldName = 'IsClosed'
    end
    object CaseMemTableClosedDate: TWideStringField
      FieldName = 'ClosedDate'
      Size = 4000
    end
    object CaseMemTableIsEscalated: TShortintField
      FieldName = 'IsEscalated'
    end
    object CaseMemTableOwnerId: TWideStringField
      FieldName = 'OwnerId'
      Size = 4000
    end
    object CaseMemTableCreatedDate: TWideStringField
      FieldName = 'CreatedDate'
      Size = 4000
    end
    object CaseMemTableCreatedById: TWideStringField
      FieldName = 'CreatedById'
      Size = 4000
    end
    object CaseMemTableLastModifiedDate: TWideStringField
      FieldName = 'LastModifiedDate'
      Size = 4000
    end
    object CaseMemTableLastModifiedById: TWideStringField
      FieldName = 'LastModifiedById'
      Size = 4000
    end
    object CaseMemTableSystemModstamp: TWideStringField
      FieldName = 'SystemModstamp'
      Size = 4000
    end
    object CaseMemTableContactPhone: TWideStringField
      FieldName = 'ContactPhone'
      Size = 4000
    end
    object CaseMemTableContactMobile: TWideStringField
      FieldName = 'ContactMobile'
      Size = 4000
    end
    object CaseMemTableContactEmail: TWideStringField
      FieldName = 'ContactEmail'
      Size = 4000
    end
    object CaseMemTableContactFax: TWideStringField
      FieldName = 'ContactFax'
      Size = 4000
    end
    object CaseMemTableLastViewedDate: TWideStringField
      FieldName = 'LastViewedDate'
      Size = 4000
    end
    object CaseMemTableLastReferencedDate: TWideStringField
      FieldName = 'LastReferencedDate'
      Size = 4000
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 392
    Top = 24
  end
end
