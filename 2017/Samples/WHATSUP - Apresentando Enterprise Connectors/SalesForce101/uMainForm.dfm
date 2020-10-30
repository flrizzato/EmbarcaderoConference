object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'SalesForce 101'
  ClientHeight = 394
  ClientWidth = 708
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 5
    Top = 45
    Width = 698
    Height = 344
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MasterRecordId'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AccountId'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LastName'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FirstName'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Salutation'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Name'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OtherStreet'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OtherCity'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OtherState'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OtherPostalCode'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OtherCountry'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OtherLatitude'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OtherLongitude'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OtherGeocodeAccuracy'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MailingStreet'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MailingCity'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MailingState'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MailingPostalCode'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MailingCountry'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MailingLatitude'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MailingLongitude'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MailingGeocodeAccuracy'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Phone'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fax'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MobilePhone'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HomePhone'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OtherPhone'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AssistantPhone'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ReportsToId'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Email'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Title'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Department'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AssistantName'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LeadSource'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Birthdate'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Description'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OwnerId'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CreatedDate'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CreatedById'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LastModifiedDate'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LastModifiedById'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SystemModstamp'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LastActivityDate'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LastCURequestDate'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LastCUUpdateDate'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LastViewedDate'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LastReferencedDate'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EmailBouncedReason'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EmailBouncedDate'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IsEmailBounced'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PhotoUrl'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Jigsaw'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JigsawContactId'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CleanStatus'
        Width = 155
        Visible = True
      end>
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 698
    Height = 30
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object SpeedButton3: TSpeedButton
      AlignWithMargins = True
      Left = 5
      Top = 0
      Width = 105
      Height = 30
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Open'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton3Click
      ExplicitLeft = 0
    end
    object SpeedButton1: TSpeedButton
      AlignWithMargins = True
      Left = 360
      Top = 0
      Width = 105
      Height = 30
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Apply Updates'
      Flat = True
      OnClick = SpeedButton1Click
      ExplicitLeft = 353
      ExplicitTop = 5
      ExplicitHeight = 40
    end
    object SpeedButton2: TSpeedButton
      AlignWithMargins = True
      Left = 470
      Top = 0
      Width = 105
      Height = 30
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Cancel Updates'
      Flat = True
      OnClick = SpeedButton2Click
      ExplicitLeft = 450
    end
    object DBNavigator1: TDBNavigator
      AlignWithMargins = True
      Left = 115
      Top = 0
      Width = 240
      Height = 30
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      DataSource = DataSource1
      Align = alLeft
      Flat = True
      TabOrder = 0
      ExplicitLeft = 111
      ExplicitTop = 2
      ExplicitHeight = 40
    end
  end
  object CdatasfConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=CDataSF')
    LoginPrompt = False
    Left = 546
    Top = 65
  end
  object ContactTable: TFDQuery
    CachedUpdates = True
    Connection = CdatasfConnection
    SQL.Strings = (
      'SELECT * FROM CData.Salesforce.Contact')
    Left = 546
    Top = 113
    object ContactTableId: TWideStringField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 36
    end
    object ContactTableIsDeleted: TBooleanField
      FieldName = 'IsDeleted'
      Origin = 'IsDeleted'
      Required = True
    end
    object ContactTableMasterRecordId: TWideStringField
      FieldName = 'MasterRecordId'
      Origin = 'MasterRecordId'
      Size = 36
    end
    object ContactTableAccountId: TWideStringField
      FieldName = 'AccountId'
      Origin = 'AccountId'
      Size = 36
    end
    object ContactTableLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'LastName'
      Required = True
      Size = 160
    end
    object ContactTableFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'FirstName'
      Size = 80
    end
    object ContactTableSalutation: TWideStringField
      FieldName = 'Salutation'
      Origin = 'Salutation'
      Size = 80
    end
    object ContactTableName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 242
    end
    object ContactTableOtherStreet: TWideStringField
      FieldName = 'OtherStreet'
      Origin = 'OtherStreet'
      Size = 510
    end
    object ContactTableOtherCity: TWideStringField
      FieldName = 'OtherCity'
      Origin = 'OtherCity'
      Size = 80
    end
    object ContactTableOtherState: TWideStringField
      FieldName = 'OtherState'
      Origin = 'OtherState'
      Size = 160
    end
    object ContactTableOtherPostalCode: TWideStringField
      FieldName = 'OtherPostalCode'
      Origin = 'OtherPostalCode'
      Size = 40
    end
    object ContactTableOtherCountry: TWideStringField
      FieldName = 'OtherCountry'
      Origin = 'OtherCountry'
      Size = 160
    end
    object ContactTableOtherLatitude: TFloatField
      FieldName = 'OtherLatitude'
      Origin = 'OtherLatitude'
    end
    object ContactTableOtherLongitude: TFloatField
      FieldName = 'OtherLongitude'
      Origin = 'OtherLongitude'
    end
    object ContactTableOtherGeocodeAccuracy: TWideStringField
      FieldName = 'OtherGeocodeAccuracy'
      Origin = 'OtherGeocodeAccuracy'
      Size = 80
    end
    object ContactTableMailingStreet: TWideStringField
      FieldName = 'MailingStreet'
      Origin = 'MailingStreet'
      Size = 510
    end
    object ContactTableMailingCity: TWideStringField
      FieldName = 'MailingCity'
      Origin = 'MailingCity'
      Size = 80
    end
    object ContactTableMailingState: TWideStringField
      FieldName = 'MailingState'
      Origin = 'MailingState'
      Size = 160
    end
    object ContactTableMailingPostalCode: TWideStringField
      FieldName = 'MailingPostalCode'
      Origin = 'MailingPostalCode'
      Size = 40
    end
    object ContactTableMailingCountry: TWideStringField
      FieldName = 'MailingCountry'
      Origin = 'MailingCountry'
      Size = 160
    end
    object ContactTableMailingLatitude: TFloatField
      FieldName = 'MailingLatitude'
      Origin = 'MailingLatitude'
    end
    object ContactTableMailingLongitude: TFloatField
      FieldName = 'MailingLongitude'
      Origin = 'MailingLongitude'
    end
    object ContactTableMailingGeocodeAccuracy: TWideStringField
      FieldName = 'MailingGeocodeAccuracy'
      Origin = 'MailingGeocodeAccuracy'
      Size = 80
    end
    object ContactTablePhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'Phone'
      Size = 80
    end
    object ContactTableFax: TWideStringField
      FieldName = 'Fax'
      Origin = 'Fax'
      Size = 80
    end
    object ContactTableMobilePhone: TWideStringField
      FieldName = 'MobilePhone'
      Origin = 'MobilePhone'
      Size = 80
    end
    object ContactTableHomePhone: TWideStringField
      FieldName = 'HomePhone'
      Origin = 'HomePhone'
      Size = 80
    end
    object ContactTableOtherPhone: TWideStringField
      FieldName = 'OtherPhone'
      Origin = 'OtherPhone'
      Size = 80
    end
    object ContactTableAssistantPhone: TWideStringField
      FieldName = 'AssistantPhone'
      Origin = 'AssistantPhone'
      Size = 80
    end
    object ContactTableReportsToId: TWideStringField
      FieldName = 'ReportsToId'
      Origin = 'ReportsToId'
      Size = 36
    end
    object ContactTableEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'Email'
      Size = 160
    end
    object ContactTableTitle: TWideStringField
      FieldName = 'Title'
      Origin = 'Title'
      Size = 256
    end
    object ContactTableDepartment: TWideStringField
      FieldName = 'Department'
      Origin = 'Department'
      Size = 160
    end
    object ContactTableAssistantName: TWideStringField
      FieldName = 'AssistantName'
      Origin = 'AssistantName'
      Size = 80
    end
    object ContactTableLeadSource: TWideStringField
      FieldName = 'LeadSource'
      Origin = 'LeadSource'
      Size = 80
    end
    object ContactTableBirthdate: TSQLTimeStampField
      FieldName = 'Birthdate'
      Origin = 'Birthdate'
    end
    object ContactTableDescription: TWideMemoField
      FieldName = 'Description'
      Origin = 'Description'
      BlobType = ftWideMemo
      Size = 64000
    end
    object ContactTableOwnerId: TWideStringField
      FieldName = 'OwnerId'
      Origin = 'OwnerId'
      Required = True
      Size = 36
    end
    object ContactTableCreatedDate: TSQLTimeStampField
      FieldName = 'CreatedDate'
      Origin = 'CreatedDate'
      Required = True
    end
    object ContactTableCreatedById: TWideStringField
      FieldName = 'CreatedById'
      Origin = 'CreatedById'
      Required = True
      Size = 36
    end
    object ContactTableLastModifiedDate: TSQLTimeStampField
      FieldName = 'LastModifiedDate'
      Origin = 'LastModifiedDate'
      Required = True
    end
    object ContactTableLastModifiedById: TWideStringField
      FieldName = 'LastModifiedById'
      Origin = 'LastModifiedById'
      Required = True
      Size = 36
    end
    object ContactTableSystemModstamp: TSQLTimeStampField
      FieldName = 'SystemModstamp'
      Origin = 'SystemModstamp'
      Required = True
    end
    object ContactTableLastActivityDate: TSQLTimeStampField
      FieldName = 'LastActivityDate'
      Origin = 'LastActivityDate'
    end
    object ContactTableLastCURequestDate: TSQLTimeStampField
      FieldName = 'LastCURequestDate'
      Origin = 'LastCURequestDate'
    end
    object ContactTableLastCUUpdateDate: TSQLTimeStampField
      FieldName = 'LastCUUpdateDate'
      Origin = 'LastCUUpdateDate'
    end
    object ContactTableLastViewedDate: TSQLTimeStampField
      FieldName = 'LastViewedDate'
      Origin = 'LastViewedDate'
    end
    object ContactTableLastReferencedDate: TSQLTimeStampField
      FieldName = 'LastReferencedDate'
      Origin = 'LastReferencedDate'
    end
    object ContactTableEmailBouncedReason: TWideStringField
      FieldName = 'EmailBouncedReason'
      Origin = 'EmailBouncedReason'
      Size = 510
    end
    object ContactTableEmailBouncedDate: TSQLTimeStampField
      FieldName = 'EmailBouncedDate'
      Origin = 'EmailBouncedDate'
    end
    object ContactTableIsEmailBounced: TBooleanField
      FieldName = 'IsEmailBounced'
      Origin = 'IsEmailBounced'
      Required = True
    end
    object ContactTablePhotoUrl: TWideStringField
      FieldName = 'PhotoUrl'
      Origin = 'PhotoUrl'
      Size = 510
    end
    object ContactTableJigsaw: TWideStringField
      FieldName = 'Jigsaw'
      Origin = 'Jigsaw'
      Size = 40
    end
    object ContactTableJigsawContactId: TWideStringField
      FieldName = 'JigsawContactId'
      Origin = 'JigsawContactId'
      Size = 40
    end
    object ContactTableCleanStatus: TWideStringField
      FieldName = 'CleanStatus'
      Origin = 'CleanStatus'
      Size = 80
    end
    object ContactTableLevel__c: TWideStringField
      FieldName = 'Level__c'
      Origin = 'Level__c'
      Size = 510
    end
    object ContactTableLanguages__c: TWideStringField
      FieldName = 'Languages__c'
      Origin = 'Languages__c'
      Size = 200
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 544
    Top = 168
  end
  object FDPhysCDataSalesforceDriverLink1: TFDPhysCDataSalesforceDriverLink
    DriverID = 'CDataSalesforce'
    Left = 544
    Top = 232
  end
  object DataSource1: TDataSource
    DataSet = ContactTable
    Left = 448
    Top = 112
  end
end
