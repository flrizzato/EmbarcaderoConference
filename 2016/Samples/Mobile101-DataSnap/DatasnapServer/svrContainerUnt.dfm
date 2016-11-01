object svrContainer: TsvrContainer
  OldCreateOrder = False
  Height = 271
  Width = 415
  object DSServer1: TDSServer
    ChannelResponseTimeout = 1200000
    Left = 96
    Top = 11
  end
  object DSServerClass2: TDSServerClass
    OnGetClass = DSServerClass2GetClass
    Server = DSServer1
    Left = 168
    Top = 16
  end
  object DSServerClassCliente: TDSServerClass
    OnGetClass = DSServerClassClienteGetClass
    Server = DSServer1
    Left = 296
    Top = 24
  end
end
