object FormThreading: TFormThreading
  Left = 0
  Top = 0
  Caption = 'System.Threading'
  ClientHeight = 305
  ClientWidth = 586
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 32
    Top = 24
    Width = 129
    Height = 25
    Caption = 'Delayed Message'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 32
    Top = 64
    Width = 129
    Height = 25
    Caption = 'Wait for all'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 224
    Top = 24
    Width = 129
    Height = 25
    Caption = 'Future'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Memo1: TMemo
    Left = 224
    Top = 66
    Width = 354
    Height = 231
    TabOrder = 3
  end
end
