object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Incremento e Decremento de vari'#225'vel Integer'
  ClientHeight = 366
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 53
    Width = 502
    Height = 313
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 502
    Height = 53
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 304
      Top = 15
      Width = 54
      Height = 19
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 8
      Top = 15
      Width = 137
      Height = 25
      Caption = 'Exemplo '
      TabOrder = 0
      OnClick = Button1Click
    end
    object CheckBox1: TCheckBox
      Left = 151
      Top = 19
      Width = 97
      Height = 17
      Caption = 'Thread Safe'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
  end
  object Timer1: TTimer
    Left = 256
    Top = 64
  end
end
