object dmDB: TdmDB
  OldCreateOrder = False
  Height = 249
  Width = 432
  object dbPush: TFDConnection
    ConnectionName = 'DBConn'
    Params.Strings = (
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=localhost'
      'Port=3050'
      'CharacterSet=ISO8859_1'
      'Database=D:\SRC\RRA\ETC\RRA\PushDatasnap\DB\push.db'
      'DriverID=FB')
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object tblPush: TFDTable
    IndexName = 'PK_PUSH'
    Connection = dbPush
    UpdateOptions.UpdateTableName = 'PUSH'
    TableName = 'PUSH'
    Left = 104
    Top = 24
  end
end
