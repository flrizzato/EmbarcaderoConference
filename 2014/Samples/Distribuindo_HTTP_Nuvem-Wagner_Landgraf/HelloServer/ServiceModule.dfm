object HelloServer: THelloServer
  OldCreateOrder = False
  AllowPause = False
  DisplayName = 'TMS Hello Server'
  OnShutdown = ServiceShutdown
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
end
