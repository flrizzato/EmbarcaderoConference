object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'frmDojo'
  ClientHeight = 513
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnConecta: TButton
    Left = 40
    Top = 480
    Width = 257
    Height = 25
    Caption = 'Conectar com o REDIS'
    TabOrder = 0
    OnClick = btnConectaClick
  end
  object Edit1: TEdit
    Left = 16
    Top = 8
    Width = 321
    Height = 21
    TabOrder = 1
    OnKeyPress = Edit1KeyPress
  end
  object Memo1: TMemo
    Left = 16
    Top = 56
    Width = 321
    Height = 369
    TabOrder = 2
  end
end
