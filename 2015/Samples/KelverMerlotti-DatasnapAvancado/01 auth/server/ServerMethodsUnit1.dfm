object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 229
  Width = 349
  object Con: TFDConnection
    Params.Strings = (
      'Database=D:\CodeRage X USA\Samples\EMPLOYEE.GDB'
      'Password=masterkey'
      'User_Name=SYSDBA'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object qrySalary: TFDQuery
    Connection = Con
    SQL.Strings = (
      'select salary from employee where emp_no = :IdUser')
    Left = 32
    Top = 88
    ParamData = <
      item
        Name = 'IDUSER'
        DataType = ftSmallint
        ParamType = ptInput
        Value = Null
      end>
    object qrySalarySALARY: TBCDField
      FieldName = 'SALARY'
      Origin = 'SALARY'
      Required = True
      Precision = 18
      Size = 2
    end
  end
  object qryCustomer: TFDQuery
    Connection = Con
    FetchOptions.AssignedValues = [evUnidirectional]
    FetchOptions.Unidirectional = True
    SQL.Strings = (
      'select * from customer')
    Left = 144
    Top = 88
    object qryCustomerCUST_NO: TIntegerField
      FieldName = 'CUST_NO'
      Origin = 'CUST_NO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryCustomerCUSTOMER: TStringField
      FieldName = 'CUSTOMER'
      Origin = 'CUSTOMER'
      Required = True
      Size = 25
    end
    object qryCustomerCONTACT_FIRST: TStringField
      FieldName = 'CONTACT_FIRST'
      Origin = 'CONTACT_FIRST'
      Size = 15
    end
    object qryCustomerCONTACT_LAST: TStringField
      FieldName = 'CONTACT_LAST'
      Origin = 'CONTACT_LAST'
    end
    object qryCustomerPHONE_NO: TStringField
      FieldName = 'PHONE_NO'
      Origin = 'PHONE_NO'
    end
    object qryCustomerADDRESS_LINE1: TStringField
      FieldName = 'ADDRESS_LINE1'
      Origin = 'ADDRESS_LINE1'
      Size = 30
    end
    object qryCustomerADDRESS_LINE2: TStringField
      FieldName = 'ADDRESS_LINE2'
      Origin = 'ADDRESS_LINE2'
      Size = 30
    end
    object qryCustomerCITY: TStringField
      FieldName = 'CITY'
      Origin = 'CITY'
      Size = 25
    end
    object qryCustomerSTATE_PROVINCE: TStringField
      FieldName = 'STATE_PROVINCE'
      Origin = 'STATE_PROVINCE'
      Size = 15
    end
    object qryCustomerCOUNTRY: TStringField
      FieldName = 'COUNTRY'
      Origin = 'COUNTRY'
      Size = 15
    end
    object qryCustomerPOSTAL_CODE: TStringField
      FieldName = 'POSTAL_CODE'
      Origin = 'POSTAL_CODE'
      Size = 12
    end
    object qryCustomerON_HOLD: TStringField
      FieldName = 'ON_HOLD'
      Origin = 'ON_HOLD'
      FixedChar = True
      Size = 1
    end
  end
  object dspCustomer: TDataSetProvider
    DataSet = qryCustomer
    UpdateMode = upWhereKeyOnly
    Left = 144
    Top = 144
  end
end
