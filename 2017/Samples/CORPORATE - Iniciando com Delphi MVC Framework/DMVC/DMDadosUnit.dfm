object DMDados: TDMDados
  OldCreateOrder = False
  Height = 265
  Width = 402
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 112
    Top = 184
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 312
    Top = 184
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=Northwind'
      'User_Name=sa'
      'Password=sysdba'
      'Server=localhost'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 16
  end
  object spCustomerINSERT: TFDStoredProc
    Connection = FDConnection1
    StoredProcName = 'Northwind.dbo.spCustomerINSERT'
    Left = 296
    Top = 24
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        ParamType = ptResult
      end
      item
        Position = 2
        Name = '@CustomerID'
        DataType = ftFixedWideChar
        ParamType = ptInput
        Size = 5
      end
      item
        Position = 3
        Name = '@CompanyName'
        DataType = ftWideString
        ParamType = ptInput
        Size = 40
      end
      item
        Position = 4
        Name = '@ContactName'
        DataType = ftWideString
        ParamType = ptInput
        Size = 30
      end
      item
        Position = 5
        Name = '@City'
        DataType = ftWideString
        ParamType = ptInput
        Size = 15
      end>
  end
  object spCustomerUPDATE: TFDStoredProc
    Connection = FDConnection1
    StoredProcName = 'Northwind.dbo.spCustomerUPDATE'
    Left = 296
    Top = 72
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        ParamType = ptResult
      end
      item
        Position = 2
        Name = '@CustomerID'
        DataType = ftFixedWideChar
        ParamType = ptInput
        Size = 5
      end
      item
        Position = 3
        Name = '@CompanyName'
        DataType = ftWideString
        ParamType = ptInput
        Size = 40
      end
      item
        Position = 4
        Name = '@ContactName'
        DataType = ftWideString
        ParamType = ptInput
        Size = 30
      end
      item
        Position = 5
        Name = '@City'
        DataType = ftWideString
        ParamType = ptInput
        Size = 15
      end>
  end
  object spCustomerDELETE: TFDStoredProc
    Connection = FDConnection1
    StoredProcName = 'Northwind.dbo.spCustomerDELETE'
    Left = 296
    Top = 120
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        ParamType = ptResult
      end
      item
        Position = 2
        Name = '@CustomerID'
        DataType = ftFixedWideChar
        ParamType = ptInput
        Size = 5
      end>
  end
  object spCustomersSELECT: TFDStoredProc
    Connection = FDConnection1
    StoredProcName = 'Northwind.dbo.spCustomersSELECT'
    Left = 184
    Top = 72
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        ParamType = ptResult
        Value = 0
      end>
    object spCustomersSELECTCustomerID: TWideStringField
      FieldName = 'CustomerID'
      Origin = 'CustomerID'
      Required = True
      FixedChar = True
      Size = 5
    end
    object spCustomersSELECTCompanyName: TWideStringField
      FieldName = 'CompanyName'
      Origin = 'CompanyName'
      Required = True
      Size = 40
    end
    object spCustomersSELECTContactName: TWideStringField
      FieldName = 'ContactName'
      Origin = 'ContactName'
      Size = 30
    end
    object spCustomersSELECTCity: TWideStringField
      FieldName = 'City'
      Origin = 'City'
      Size = 15
    end
  end
end
