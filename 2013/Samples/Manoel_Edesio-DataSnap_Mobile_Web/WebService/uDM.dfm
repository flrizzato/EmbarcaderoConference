object DMdados: TDMdados
  OldCreateOrder = False
  Height = 305
  Width = 470
  object sqlDInamico: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqlConexao
    Left = 48
    Top = 80
  end
  object sqlDinamico2: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqlConexao
    Left = 48
    Top = 136
  end
  object sqlConexao: TSQLConnection
    ConnectionName = 'MSSQLConnection'
    DriverName = 'MSSQL'
    Params.Strings = (
      'SchemaOverride=sa.dbo'
      'DriverName=MSSQL'
      'HostName=ServerName'
      'DataBase=Database Name'
      'User_Name=user'
      'Password=password'
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'OS Authentication=False'
      'Prepare SQL=False'
      'ConnectTimeout=60'
      'Mars_Connection=False')
    Left = 48
    Top = 24
  end
end
