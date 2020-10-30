object SC: TSC
  OldCreateOrder = False
  Height = 235
  Width = 407
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    Left = 183
    Top = 11
  end
  object DSServer1: TDSServer
    ChannelResponseTimeout = 0
    Left = 96
    Top = 11
  end
end
