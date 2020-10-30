object dmPush: TdmPush
  OldCreateOrder = False
  Height = 366
  Width = 638
  object dbPush: TFDConnection
    ConnectionName = 'DBPushConn'
    Params.Strings = (
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=localhost'
      'Port=3050'
      'CharacterSet=ISO8859_1'
      'Database=D:\SRC\DROID\PushDatasnap\DB\PUSH.FDB'
      'DriverID=FB')
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object qryGetDevice: TFDQuery
    Connection = dbPush
    SQL.Strings = (
      'select * '
      'from push'
      'where'
      'device_id = :device_id')
    Left = 104
    Top = 24
    ParamData = <
      item
        Name = 'DEVICE_ID'
        ParamType = ptInput
      end>
  end
  object qryUpdateDevice: TFDQuery
    CachedUpdates = True
    Connection = dbPush
    SQL.Strings = (
      'select * '
      'from push'
      'where'
      'user_id = :user_id'
      'and device_id = :device_id')
    Left = 104
    Top = 128
    ParamData = <
      item
        Name = 'DEVICE_ID'
        ParamType = ptInput
      end
      item
        Name = 'USER_ID'
        DataType = ftLargeint
        ParamType = ptInput
      end>
  end
  object qryGetDevices: TFDQuery
    Connection = dbPush
    SQL.Strings = (
      'select * '
      'from push')
    Left = 104
    Top = 72
  end
  object nHTTP: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    AllowCookies = True
    HandleRedirects = True
    UserAgent = 'Ofertas do Dia Push Sender/1.0'
    Left = 368
    Top = 25
  end
  object nHTTPReq: TNetHTTPRequest
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    Client = nHTTP
    Left = 440
    Top = 25
  end
  object qrySendToAll: TFDQuery
    CachedUpdates = True
    Connection = dbPush
    FetchOptions.AssignedValues = [evRecordCountMode, evLiveWindowParanoic]
    FetchOptions.RecordCountMode = cmTotal
    FetchOptions.LiveWindowParanoic = False
    SQL.Strings = (
      'select * '
      'from push'
      'where receive_push = '#39'S'#39
      'and os_name = :os_name')
    Left = 104
    Top = 240
    ParamData = <
      item
        Name = 'OS_NAME'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qryUpdatePushSuccess: TFDQuery
    CachedUpdates = True
    Connection = dbPush
    SQL.Strings = (
      'update'
      'push'
      'set'
      'nu_send_success = nu_send_success + 1,'
      'dt_send_success = current_timestamp,'
      'nu_send_fail = null,'
      'dt_send_fail = null'
      'where'
      'device_token = :device_token')
    Left = 48
    Top = 296
    ParamData = <
      item
        Name = 'DEVICE_TOKEN'
        ParamType = ptInput
      end>
  end
  object qryUpdatePushFail: TFDQuery
    CachedUpdates = True
    Connection = dbPush
    SQL.Strings = (
      'update'
      'push'
      'set'
      'nu_send_fail = nu_send_fail + 1,'
      'dt_send_fail = current_timestamp'
      'where'
      'device_token = :device_token')
    Left = 160
    Top = 296
    ParamData = <
      item
        Name = 'DEVICE_TOKEN'
        ParamType = ptInput
      end>
  end
  object qrySendToUser: TFDQuery
    CachedUpdates = True
    Connection = dbPush
    FetchOptions.AssignedValues = [evRecordCountMode, evLiveWindowParanoic]
    FetchOptions.RecordCountMode = cmTotal
    FetchOptions.LiveWindowParanoic = False
    SQL.Strings = (
      'select * '
      'from push'
      'where receive_push = '#39'S'#39
      'and user_id = :user_id')
    Left = 104
    Top = 184
    ParamData = <
      item
        Name = 'USER_ID'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qryUserDevices: TFDQuery
    Connection = dbPush
    SQL.Strings = (
      'select user_id, device_id, device_model, os_name, os_ver '
      'from push'
      'where user_id = :user_id')
    Left = 196
    Top = 72
    ParamData = <
      item
        Name = 'USER_ID'
        ParamType = ptInput
      end>
  end
  object qryUpdatePush: TFDQuery
    CachedUpdates = True
    Connection = dbPush
    SQL.Strings = (
      'select * '
      'from push'
      'where'
      'device_id = :device_id')
    Left = 196
    Top = 128
    ParamData = <
      item
        Name = 'DEVICE_ID'
        ParamType = ptInput
      end>
  end
end
