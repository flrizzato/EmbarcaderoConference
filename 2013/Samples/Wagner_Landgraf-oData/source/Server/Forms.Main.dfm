object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Customers Server'
  ClientHeight = 191
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btStart: TButton
    Left = 8
    Top = 8
    Width = 89
    Height = 25
    Action = StartAction
    TabOrder = 0
  end
  object btStop: TButton
    Left = 103
    Top = 8
    Width = 75
    Height = 25
    Action = StopAction
    TabOrder = 1
  end
  object ActionList1: TActionList
    Left = 192
    Top = 104
    object StartAction: TAction
      Caption = 'Start'
      OnExecute = StartActionExecute
      OnUpdate = StartActionUpdate
    end
    object StopAction: TAction
      Caption = 'Stop'
      OnExecute = StopActionExecute
      OnUpdate = StopActionUpdate
    end
  end
end
