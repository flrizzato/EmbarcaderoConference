object WebModule1: TWebModule1
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end>
  Height = 294
  Width = 499
  object DSServer1: TDSServer
    Left = 120
    Top = 43
  end
  object DSHTTPWebDispatcher1: TDSHTTPWebDispatcher
    Server = DSServer1
    Filters = <>
    OnHTTPTrace = DSHTTPWebDispatcher1HTTPTrace
    WebDispatch.PathInfo = 'datasnap*'
    Left = 120
    Top = 107
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 224
    Top = 43
  end
end
