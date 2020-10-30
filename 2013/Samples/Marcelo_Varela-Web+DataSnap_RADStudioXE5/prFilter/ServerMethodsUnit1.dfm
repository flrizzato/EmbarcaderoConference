object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 219
  Width = 458
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=Northwind'
      'User_Name=sa'
      'Password=sysdba'
      'Server=(local)'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 88
    Top = 56
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT CustomerID, CompanyName, ContactName, City FROM Customers')
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
end
