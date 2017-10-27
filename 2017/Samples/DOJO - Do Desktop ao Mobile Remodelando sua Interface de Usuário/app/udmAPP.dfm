object dmAPP: TdmAPP
  OldCreateOrder = False
  Height = 416
  Width = 215
  object client: TRESTClient
    BaseURL = 'http://192.168.25.12:8080'
    Params = <>
    HandleRedirects = True
    ProxyPort = 8080
    Left = 88
    Top = 48
  end
  object request: TRESTRequest
    Client = client
    Params = <>
    Resource = 'datasnap/rest/tpos/listamesas'
    Response = response
    SynchronizedEvents = False
    Left = 88
    Top = 96
  end
  object response: TRESTResponse
    Left = 88
    Top = 152
  end
end
