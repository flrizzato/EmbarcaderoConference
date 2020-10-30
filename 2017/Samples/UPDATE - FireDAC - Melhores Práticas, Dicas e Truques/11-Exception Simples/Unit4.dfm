object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 405
  ClientWidth = 685
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 23
  object Button1: TButton
    Left = 3
    Top = 8
    Width = 674
    Height = 41
    Caption = 'Gerar Exce'#231#227'o'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 3
    Top = 55
    Width = 674
    Height = 342
    Lines.Strings = (
      '')
    TabOrder = 1
  end
  object Con: TFDConnection
    Params.Strings = (
      'ConnectionDef=ExtremeDelphi')
    LoginPrompt = False
    Left = 265
    Top = 162
  end
end
