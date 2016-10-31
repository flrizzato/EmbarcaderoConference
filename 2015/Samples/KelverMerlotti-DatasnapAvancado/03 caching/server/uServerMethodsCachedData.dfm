object smCachedData: TsmCachedData
  OldCreateOrder = False
  Height = 255
  Width = 403
  object qryCountry: TFDQuery
    Connection = Con
    FetchOptions.AssignedValues = [evUnidirectional]
    FetchOptions.Unidirectional = True
    SQL.Strings = (
      'select * from country')
    Left = 120
    Top = 40
    object qryCountryCOUNTRY: TStringField
      FieldName = 'COUNTRY'
      Origin = 'COUNTRY'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 15
    end
    object qryCountryCURRENCY: TStringField
      FieldName = 'CURRENCY'
      Origin = 'CURRENCY'
      Required = True
      Size = 10
    end
  end
  object Con: TFDConnection
    Params.Strings = (
      'Database=D:\CodeRage X USA\Samples\EMPLOYEE.GDB'
      'Password=masterkey'
      'User_Name=SYSDBA'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 40
  end
  object memCountry: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 120
    Top = 96
  end
end
