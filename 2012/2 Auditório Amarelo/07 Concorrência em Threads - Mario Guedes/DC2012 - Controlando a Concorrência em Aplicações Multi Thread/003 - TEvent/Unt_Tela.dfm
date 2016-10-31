object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Exemplo de Utiliza'#231#227'o do TEvent'
  ClientHeight = 324
  ClientWidth = 385
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 385
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = 208
    ExplicitTop = 192
    ExplicitWidth = 185
    object Button1: TButton
      Left = 16
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Sinalizar!'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 41
    Width = 385
    Height = 264
    Align = alClient
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    ExplicitLeft = 72
    ExplicitTop = 144
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 305
    Width = 385
    Height = 19
    Panels = <>
    ExplicitLeft = 192
    ExplicitTop = 256
    ExplicitWidth = 0
  end
end
