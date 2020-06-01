object View2View: TView2View
  Left = 0
  Top = 0
  Caption = 'View2View'
  ClientHeight = 152
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 48
    Top = 54
    Width = 330
    Height = 21
    TabOrder = 0
    TextHint = 'Mensagem a enviar'
  end
  object Button1: TButton
    Left = 239
    Top = 81
    Width = 139
    Height = 25
    Caption = 'Enviar ViewEvent'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 48
    Top = 81
    Width = 185
    Height = 25
    Caption = 'Windows Notification'
    TabOrder = 2
    OnClick = Button2Click
  end
end
