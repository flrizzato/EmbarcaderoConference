object DMSQLDialectAbstraction: TDMSQLDialectAbstraction
  OldCreateOrder = False
  Height = 273
  Width = 487
  object ConnectionFirebird: TFDConnection
    Params.Strings = (
      
        'Database=C:\ECON2018\7-3-FireDAC-Recursos-que-voc'#234'-n'#227'o-conhecia\' +
        '00 - DB\ECON2018.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 88
    Top = 32
  end
  object ConnectionPostgreSQL: TFDConnection
    Params.Strings = (
      'Database=econ2018'
      'User_Name=postgres'
      'Password=postgres'
      'Server=localhost'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 272
    Top = 32
  end
  object QueryFirebird: TFDQuery
    Connection = ConnectionFirebird
    Left = 88
    Top = 96
  end
  object QueryPostgreSQL: TFDQuery
    Connection = ConnectionPostgreSQL
    SQL.Strings = (
      'SELECT'
      #9'CONCAT('#39'#econ2018 '#39', descricao) AS NAME'
      'FROM'
      #9'dialect_abstraction'
      'LIMIT 5')
    Left = 272
    Top = 88
    object QueryPostgreSQLname: TWideMemoField
      AutoGenerateValue = arDefault
      DisplayWidth = 50
      FieldName = 'name'
      Origin = 'name'
      ReadOnly = True
      BlobType = ftWideMemo
      DisplayValue = dvFull
    end
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\10\bin\libpq.dll'
    Left = 400
    Top = 32
  end
end
