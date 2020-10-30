object Dtm: TDtm
  OldCreateOrder = False
  Height = 306
  Width = 429
  object FDConnINTERBASE: TFDConnection
    Params.Strings = (
      'Database=C:\Programacao\EC 2014\Bancos\EC-2014.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=localhost'
      'DriverID=IB')
    LoginPrompt = False
    Left = 56
    Top = 16
  end
  object FDConnMSSQL: TFDConnection
    Params.Strings = (
      'Database=EC-2014'
      'User_Name=sa'
      'Password=732154Al#'
      'Server=localhost'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 160
    Top = 16
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Programacao\EC 2014\Bancos\SQLite'
      'OpenMode=ReadWrite'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 56
    Top = 160
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'Select '
      '  * '
      'from '
      '  Local.TabVendas'
      'inner join Local.TabClientes On'
      '  Local.TabVendas.IdCliente = Local.TabClientes.Id')
    Left = 144
    Top = 160
  end
  object FDLocalSQL1: TFDLocalSQL
    SchemaName = 'Local'
    Connection = FDConnection1
    Active = True
    DataSets = <
      item
        DataSet = SqlClientes
        Name = 'TabClientes'
      end
      item
        DataSet = SqlVendas
        Name = 'TabVendas'
      end>
    Left = 56
    Top = 208
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 312
    Top = 200
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 312
    Top = 144
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 312
    Top = 80
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 312
    Top = 24
  end
  object SqlClientes: TFDQuery
    Connection = FDConnINTERBASE
    SQL.Strings = (
      'select * from Clientes')
    Left = 56
    Top = 72
  end
  object SqlVendas: TFDQuery
    Connection = FDConnMSSQL
    SQL.Strings = (
      'select * from vendas')
    Left = 160
    Top = 72
  end
end
