object ServerContainer1: TServerContainer1
  OldCreateOrder = False
  Height = 271
  Width = 415
  object DSServer1: TDSServer
    Left = 96
    Top = 11
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    Left = 200
    Top = 11
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=DB_FDD_LOCAL')
    Connected = True
    LoginPrompt = False
    Left = 192
    Top = 120
  end
end
