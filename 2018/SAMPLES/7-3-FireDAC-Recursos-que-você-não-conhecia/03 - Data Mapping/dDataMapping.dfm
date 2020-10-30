object DMDataMapping: TDMDataMapping
  OldCreateOrder = False
  Height = 215
  Width = 329
  object Connection: TFDConnection
    Params.Strings = (
      
        'Database=C:\ECON2018\7-3-FireDAC-Recursos-que-voc'#234'-n'#227'o-conhecia\' +
        '00 - DB\ECON2018.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'MonitorBy=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 56
    Top = 48
  end
  object Query: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'SELECT * FROM MAPPING')
    Left = 56
    Top = 120
  end
end
