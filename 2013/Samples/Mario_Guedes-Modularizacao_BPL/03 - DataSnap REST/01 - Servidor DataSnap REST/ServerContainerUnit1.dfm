object ServerContainer1: TServerContainer1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 271
  Width = 415
  object DSServer1: TDSServer
    AutoStart = False
    Left = 96
    Top = 11
  end
  object DSHTTPService1: TDSHTTPService
    HttpPort = 8080
    DSContext = 'DC2013/'
    RESTContext = 'OlaMundo/'
    Server = DSServer1
    Filters = <>
    Left = 96
    Top = 79
  end
end
