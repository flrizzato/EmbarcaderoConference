object IWServerController: TIWServerController
  OldCreateOrder = False
  AppName = 'MyApp'
  Description = 'My IntraWeb Application'
  DisplayName = 'IntraWeb Application'
  Port = 99
  ServerResizeTimeout = 0
  ShowLoadingAnimation = True
  SessionTimeout = 10
  LockSessionTimeout = 30000
  SSLOptions.NonSSLRequest = nsAccept
  SSLOptions.Port = 0
  SSLOptions.SSLVersions = []
  Version = '15.0.8'
  AllowMultipleSessionsPerUser = False
  JavaScriptOptions.jQueryVersion = '1.12.4'
  SecurityOptions.CheckSameIP = False
  RestartExpiredSession = True
  OnNewSession = IWServerControllerBaseNewSession
  Height = 310
  Width = 342
end
