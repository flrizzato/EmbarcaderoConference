object DMBathMove: TDMBathMove
  OldCreateOrder = False
  Height = 265
  Width = 576
  object ConnectionFirebird: TFDConnection
    Params.Strings = (
      
        'Database=C:\ECON2018\7-3-FireDAC-Recursos-que-voc'#234'-n'#227'o-conhecia\' +
        '00 - DB\ECON2018.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
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
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\10\bin\libpq.dll'
    Left = 389
    Top = 32
  end
  object SQLWriter: TFDBatchMoveSQLWriter
    Connection = ConnectionPostgreSQL
    Left = 272
    Top = 96
  end
  object FDBatchMove: TFDBatchMove
    Reader = DataSetReader
    Writer = SQLWriter
    Options = [poClearDest, poIdentityInsert, poCreateDest, poSkipUnmatchedDestFields]
    Mappings = <>
    LogFileName = 'Data.log'
    Left = 168
    Top = 184
  end
  object DataSetReader: TFDBatchMoveDataSetReader
    DataSet = Query
    Left = 88
    Top = 144
  end
  object Query: TFDQuery
    Connection = ConnectionFirebird
    SQL.Strings = (
      'SELECT'
      '    *'
      'FROM'
      '    MUNICIPIO')
    Left = 88
    Top = 88
  end
end
