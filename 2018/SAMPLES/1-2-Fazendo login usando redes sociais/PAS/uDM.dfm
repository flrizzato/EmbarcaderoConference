object dm: Tdm
  OldCreateOrder = False
  Height = 450
  Width = 517
  object IdHTTPServer1: TIdHTTPServer
    Active = True
    Bindings = <>
    DefaultPort = 9090
    OnCommandError = IdHTTPServer1CommandError
    OnCommandGet = IdHTTPServer1CommandGet
    Left = 248
    Top = 26
  end
  object RESTClient1: TRESTClient
    Authenticator = OAuth2Authenticator1
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    UserAgent = 
      'Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 5 Build/JOP40D) ' +
      'AppleWebKit/535.19 (KHTML, like Gecko; googleweblight) Chrome/38' +
      '.0.1025.166 Mobile Safari/535.19'
    Left = 152
    Top = 24
  end
  object RESTRequest1: TRESTRequest
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8'
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    Timeout = 0
    SynchronizedEvents = False
    Left = 152
    Top = 80
  end
  object RESTResponse1: TRESTResponse
    Left = 152
    Top = 136
  end
  object OAuth2Authenticator1: TOAuth2Authenticator
    AccessToken = 
      'ya29.GlsuBmTbYtb51z52zmn_YGYlJNuujehd4gKpTPvv6dAoBHPch1DWP6NpGuE' +
      'BTdK5xKB7UrI4D7EzI5HXmDGJIW2tfWpb-m7T0L5v1_1kRpErxnbwSR4GePwh0Hp' +
      't'
    Left = 152
    Top = 184
  end
  object RESTClientPhoto: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    ContentType = 'application/x-www-form-urlencoded'
    Params = <>
    HandleRedirects = True
    Left = 43
    Top = 355
  end
  object RESTRequestPhoto: TRESTRequest
    Client = RESTClientPhoto
    Method = rmPOST
    Params = <
      item
        name = 'name'
        Value = 'test'
      end
      item
        name = 'login'
        Value = 'test'
      end
      item
        name = 'email'
        Value = 'email'
      end
      item
        name = 'password'
        Value = 'password'
      end
      item
        name = 'confirm_password'
        Value = 'password'
      end
      item
        name = 'status'
        Value = '1'
      end>
    Response = RESTResponsePhoto
    SynchronizedEvents = False
    Left = 59
    Top = 371
  end
  object RESTResponsePhoto: TRESTResponse
    ContentType = 'text/html'
    Left = 51
    Top = 363
  end
end
