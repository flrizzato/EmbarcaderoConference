object DMDados: TDMDados
  OldCreateOrder = False
  Height = 260
  Width = 419
  object fdConnSqlServer: TFDConnection
    Params.Strings = (
      'Server=MANOELED-596462\SQLEXPRESS'
      'Database=DelphiConference'
      'User_Name=sa'
      'Password=326414ms'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object fQryPessoas: TFDQuery
    Connection = fdConnSqlServer
    Left = 120
    Top = 8
  end
end
