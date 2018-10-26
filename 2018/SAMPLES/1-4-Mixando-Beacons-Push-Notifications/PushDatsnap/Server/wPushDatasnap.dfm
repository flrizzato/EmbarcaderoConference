object wmPushServer: TwmPushServer
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end>
  Height = 230
  Width = 415
  object DSPushServer: TDSServer
    Left = 96
    Top = 11
  end
  object DSPushServerClass: TDSServerClass
    OnGetClass = DSPushServerClassGetClass
    Server = DSPushServer
    LifeCycle = 'Invocation'
    Left = 200
    Top = 11
  end
  object DSRESTWebDispatcher1: TDSRESTWebDispatcher
    Server = DSPushServer
    Left = 96
    Top = 128
  end
end
