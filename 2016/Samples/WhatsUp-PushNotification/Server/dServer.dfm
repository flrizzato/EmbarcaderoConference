object dmPushDB: TdmPushDB
  OldCreateOrder = False
  Height = 214
  Width = 502
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 416
    Top = 24
  end
  object conApp: TFDConnection
    ConnectionName = 'dbApp'
    Params.Strings = (
      'Database='
      'User_Name='
      'Password='
      'Server='
      'CharacterSet=utf8'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object qryUpdRegistry: TFDQuery
    Connection = conApp
    SQL.Strings = (
      'insert into registry'
      
        '(DeviceId, DeviceToken, DeviceType, OSName, OSVersion, PushEnabl' +
        'ed, UserName, UserEmail)'
      'values'
      
        '(:DeviceId, :DeviceToken, :DeviceType, :OSName, :OSVersion, :Pus' +
        'hEnabled, :UserName, :UserEmail)'
      'on duplicate key'
      'update'
      'DeviceToken = :DeviceToken,'
      'DeviceType = :DeviceType,'
      'OSName = :OSName,'
      'OSVersion = :OSVersion,'
      'PushEnabled = :PushEnabled,'
      'UserName = :UserName,'
      'UserEmail = :UserEmail,'
      'DTUpdate = CURRENT_TIMESTAMP')
    Left = 128
    Top = 25
    ParamData = <
      item
        Name = 'DEVICEID'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'DEVICETOKEN'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'DEVICETYPE'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'OSNAME'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'OSVERSION'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PUSHENABLED'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'USERNAME'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'USEREMAIL'
        DataType = ftString
        ParamType = ptInput
      end>
  end
end
