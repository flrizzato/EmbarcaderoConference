object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 348
  Width = 472
  object FDCnn: TFDConnection
    Params.Strings = (
      'User=fernando.rizzato@gmail.com'
      'Password=756969fL#'
      'SecurityToken=7NsPnOgzyXkMh3K8e7drp4rh'
      'AutoCache=True'
      'DriverID=CDataSalesforce')
    LoginPrompt = False
    Left = 56
    Top = 16
  end
  object CaseTable: TFDQuery
    Connection = FDCnn
    SQL.Strings = (
      'SELECT * FROM CData.Salesforce."Case" ORDER BY CaseNumber')
    Left = 55
    Top = 71
    object CaseTableId: TWideStringField
      FieldName = 'Id'
      Size = 4000
    end
    object CaseTableIsDeleted: TShortintField
      FieldName = 'IsDeleted'
    end
    object CaseTableCaseNumber: TWideStringField
      FieldName = 'CaseNumber'
      Size = 4000
    end
    object CaseTableContactId: TWideStringField
      FieldName = 'ContactId'
      Size = 4000
    end
    object CaseTableAccountId: TWideStringField
      FieldName = 'AccountId'
      Size = 4000
    end
    object CaseTableAssetId: TWideStringField
      FieldName = 'AssetId'
      Size = 4000
    end
    object CaseTableParentId: TWideStringField
      FieldName = 'ParentId'
      Size = 4000
    end
    object CaseTableSuppliedName: TWideStringField
      FieldName = 'SuppliedName'
      Size = 4000
    end
    object CaseTableSuppliedEmail: TWideStringField
      FieldName = 'SuppliedEmail'
      Size = 4000
    end
    object CaseTableSuppliedPhone: TWideStringField
      FieldName = 'SuppliedPhone'
      Size = 4000
    end
    object CaseTableSuppliedCompany: TWideStringField
      FieldName = 'SuppliedCompany'
      Size = 4000
    end
    object CaseTableType: TWideStringField
      FieldName = 'Type'
      Size = 4000
    end
    object CaseTableStatus: TWideStringField
      FieldName = 'Status'
      Size = 4000
    end
    object CaseTableReason: TWideStringField
      FieldName = 'Reason'
      Size = 4000
    end
    object CaseTableOrigin: TWideStringField
      FieldName = 'Origin'
      Size = 4000
    end
    object CaseTableSubject: TWideStringField
      FieldName = 'Subject'
      Size = 4000
    end
    object CaseTablePriority: TWideStringField
      FieldName = 'Priority'
      Size = 4000
    end
    object CaseTableDescription: TWideStringField
      FieldName = 'Description'
      Size = 4000
    end
    object CaseTableIsClosed: TShortintField
      FieldName = 'IsClosed'
    end
    object CaseTableClosedDate: TWideStringField
      FieldName = 'ClosedDate'
      Size = 4000
    end
    object CaseTableIsEscalated: TShortintField
      FieldName = 'IsEscalated'
    end
    object CaseTableOwnerId: TWideStringField
      FieldName = 'OwnerId'
      Size = 4000
    end
    object CaseTableCreatedDate: TWideStringField
      FieldName = 'CreatedDate'
      Size = 4000
    end
    object CaseTableCreatedById: TWideStringField
      FieldName = 'CreatedById'
      Size = 4000
    end
    object CaseTableLastModifiedDate: TWideStringField
      FieldName = 'LastModifiedDate'
      Size = 4000
    end
    object CaseTableLastModifiedById: TWideStringField
      FieldName = 'LastModifiedById'
      Size = 4000
    end
    object CaseTableSystemModstamp: TWideStringField
      FieldName = 'SystemModstamp'
      Size = 4000
    end
    object CaseTableContactPhone: TWideStringField
      FieldName = 'ContactPhone'
      Size = 4000
    end
    object CaseTableContactMobile: TWideStringField
      FieldName = 'ContactMobile'
      Size = 4000
    end
    object CaseTableContactEmail: TWideStringField
      FieldName = 'ContactEmail'
      Size = 4000
    end
    object CaseTableContactFax: TWideStringField
      FieldName = 'ContactFax'
      Size = 4000
    end
    object CaseTableLastViewedDate: TWideStringField
      FieldName = 'LastViewedDate'
      Size = 4000
    end
    object CaseTableLastReferencedDate: TWideStringField
      FieldName = 'LastReferencedDate'
      Size = 4000
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 200
    Top = 16
  end
  object FDPhysCDataSalesforceDriverLink1: TFDPhysCDataSalesforceDriverLink
    DriverID = 'CDataSalesforce'
    Left = 200
    Top = 72
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 200
    Top = 136
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 200
    Top = 192
  end
end
