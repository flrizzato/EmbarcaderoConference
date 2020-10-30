object DMMacros: TDMMacros
  OldCreateOrder = False
  Height = 273
  Width = 246
  object Connection: TFDConnection
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
  object Query: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'SELECT'
      #9'FIRST 5'
      #9'*'
      'FROM'
      #9'DIALECT_ABSTRACTION')
    Left = 88
    Top = 96
  end
end
