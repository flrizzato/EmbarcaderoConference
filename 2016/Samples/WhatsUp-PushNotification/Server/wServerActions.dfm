object wmServerActions: TwmServerActions
  OldCreateOrder = False
  Actions = <
    item
      Name = 'log'
      PathInfo = '/*'
      OnAction = wmServerActionslogAction
    end
    item
      Name = 'waAlive'
      PathInfo = '/alive'
      OnAction = wmServerActionswaAliveAction
    end
    item
      MethodType = mtPost
      Name = 'waRegister'
      PathInfo = '/reg'
      OnAction = wmAppwaRegisterAction
    end>
  Height = 230
  Width = 415
end
