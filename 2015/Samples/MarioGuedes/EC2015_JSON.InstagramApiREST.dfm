object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 428
  Width = 576
  object RESTClient1: TRESTClient
    Authenticator = OAuth2Authenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://api.instagram.com'
    Params = <>
    HandleRedirects = True
    Left = 248
    Top = 160
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'tag_name'
      end>
    Resource = 'v1/tags/{tag_name}/media/recent'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 144
    Top = 264
  end
  object RESTResponse1: TRESTResponse
    Left = 368
    Top = 264
  end
  object OAuth2Authenticator1: TOAuth2Authenticator
    Left = 248
    Top = 64
  end
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    DefaultPort = 9090
    OnCommandGet = IdHTTPServer1CommandGet
    Left = 52
    Top = 56
  end
end
