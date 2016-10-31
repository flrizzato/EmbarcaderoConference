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
      'OSAuthent=Yes'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object fQryPessoa: TFDQuery
    Connection = fdConnSqlServer
    Left = 120
    Top = 8
  end
  object fQryClassePessoa: TFDQuery
    Connection = fdConnSqlServer
    Left = 120
    Top = 64
  end
  object fQryPessoas: TFDQuery
    Connection = fdConnSqlServer
    Left = 120
    Top = 120
  end
  object dspPessoas: TDataSetProvider
    DataSet = fQryPessoas
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 216
    Top = 120
  end
  object cdsPessoas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPessoas'
    Left = 312
    Top = 120
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 216
    Top = 24
  end
end
