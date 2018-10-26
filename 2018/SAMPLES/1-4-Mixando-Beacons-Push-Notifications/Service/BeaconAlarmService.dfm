object DMDistAlarmService: TDMDistAlarmService
  OldCreateOrder = False
  OnCreate = AndroidServiceCreate
  OnDestroy = AndroidServiceDestroy
  OnStartCommand = AndroidServiceStartCommand
  Height = 186
  Width = 324
  object BeaconMain: TBeacon
    ModeExtended = [iBeacons]
    MonitorizedRegions = <>
    BeaconDeathTime = 10
    SPC = 0.500000000000000000
    ScanningTime = 1250
    CalcMode = Raw
    OnBeaconEnter = BeaconMainBeaconEnter
    OnBeaconExit = BeaconMainBeaconExit
    OnBeaconProximity = BeaconMainBeaconProximity
    Left = 60
    Top = 40
  end
  object NotificationCenterMain: TNotificationCenter
    Left = 220
    Top = 40
  end
  object DSRestConnection1: TDSRestConnection
    Host = 'agilesoftware.com.br'
    Port = 8089
    LoginPrompt = False
    Left = 120
    Top = 98
    UniqueId = '{FC07D9A3-6C41-4E66-9D39-B821CFA23612}'
  end
end
