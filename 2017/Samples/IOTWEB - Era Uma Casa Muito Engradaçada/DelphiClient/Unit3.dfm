object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 153
  ClientWidth = 257
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
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 251
    Height = 147
    Align = alClient
    Caption = 'Ativar'
    TabOrder = 0
    OnClick = Button1Click
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 161
    ExplicitHeight = 121
  end
  object IdUDPServer1: TIdUDPServer
    Bindings = <>
    DefaultPort = 8888
    OnUDPRead = IdUDPServer1UDPRead
    Left = 48
    Top = 24
  end
end
