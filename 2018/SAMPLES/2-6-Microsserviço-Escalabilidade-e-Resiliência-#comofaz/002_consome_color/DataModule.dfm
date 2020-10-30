object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 618
  Width = 795
  object RESTClient1: TRESTClient
    BaseURL = 'http://localhost'
    Params = <>
    HandleRedirects = True
    Left = 176
    Top = 64
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Resource = 'api/v1/texemplo/exemplo'
    Response = RESTResponse1
    Timeout = 5000
    SynchronizedEvents = False
    Left = 64
    Top = 144
  end
  object RESTResponse1: TRESTResponse
    Left = 256
    Top = 136
  end
end
