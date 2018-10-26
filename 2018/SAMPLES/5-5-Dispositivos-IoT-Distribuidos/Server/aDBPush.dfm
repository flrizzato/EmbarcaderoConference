object dmPush: TdmPush
  OldCreateOrder = False
  Height = 366
  Width = 547
  object dbPush: TFDConnection
    ConnectionName = 'DBPushConn'
    Params.Strings = (
      'Database=Notificacao'
      'User_Name=sa'
      'Password=Laercio123'
      'Server=PCLAERCIO\EXPREXEDITION'
      'DriverID=MSSQL')
    LoginPrompt = False
    BeforeConnect = dbPushBeforeConnect
    Left = 40
    Top = 16
  end
  object qryGetDevice: TFDQuery
    Connection = dbPush
    SQL.Strings = (
      'select * '
      'from push'
      'where'
      'device_id = :device_id')
    Left = 192
    Top = 16
    ParamData = <
      item
        Name = 'DEVICE_ID'
        DataType = ftString
        ParamType = ptInput
        Value = Null
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
    Left = 192
    Top = 120
    ParamData = <
      item
        Name = 'USER_ID'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DEVICE_ID'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryGetDevices: TFDQuery
    Connection = dbPush
    SQL.Strings = (
      'select * '
      'from push')
    Left = 192
    Top = 64
  end
  object nHTTP: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    AllowCookies = True
    HandleRedirects = True
    UserAgent = 'Ofertas do Dia Push Sender/1.0'
    Left = 400
    Top = 33
  end
  object nHTTPReq: TNetHTTPRequest
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    Client = nHTTP
    Left = 472
    Top = 33
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
    Left = 192
    Top = 232
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
    Left = 136
    Top = 288
    ParamData = <
      item
        Name = 'DEVICE_TOKEN'
        DataType = ftString
        ParamType = ptInput
        Value = Null
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
    Left = 248
    Top = 288
    ParamData = <
      item
        Name = 'DEVICE_TOKEN'
        DataType = ftString
        ParamType = ptInput
        Value = Null
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
    Left = 192
    Top = 176
    ParamData = <
      item
        Name = 'USER_ID'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 408
    Top = 176
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 408
    Top = 104
  end
  object SQLConnectionQDT: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=webservice.qdtec.com.br'
      'Port=8094'
      'CommunicationProtocol=http'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
    Left = 408
    Top = 248
    UniqueId = '{56BE49FC-D58F-4170-B743-BD23ED08B242}'
  end
end
