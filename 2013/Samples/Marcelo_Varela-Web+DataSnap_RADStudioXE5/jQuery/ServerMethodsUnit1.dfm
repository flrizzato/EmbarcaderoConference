object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 260
  Width = 437
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=Northwind'
      'User_Name=sa'
      'Password=sysdba'
      'Server=(local)'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 88
    Top = 56
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT CustomerID, CompanyName, ContactName, City FROM Customers' +
        '2')
    Left = 88
    Top = 104
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 224
    Top = 152
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 88
    Top = 152
  end
  object spCustomersInsert: TFDStoredProc
    Connection = FDConnection1
    StoredProcName = 'Northwind.dbo.spCustomersInsert'
    Left = 176
    Top = 104
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
end
