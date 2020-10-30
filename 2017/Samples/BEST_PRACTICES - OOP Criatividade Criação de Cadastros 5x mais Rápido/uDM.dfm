object DM: TDM
  OldCreateOrder = False
  Height = 409
  Width = 594
  object DBConn: TSQLConnection
    ConnectionName = 'MySQLConnection'
    DriverName = 'MySQL'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=MySQL'
      'HostName=localhost'
      'User_Name=root'
      'Password=1234'
      'ServerCharSet='
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Compressed=False'
      'Encrypted=False'
      'ConnectTimeout=60'
      'Database=CRUD')
    Left = 264
    Top = 152
  end
end
