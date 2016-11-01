object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Exemplo 02'
  ClientHeight = 343
  ClientWidth = 522
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 311
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object SpeedButton1: TSpeedButton
    Left = 8
    Top = 273
    Width = 497
    Height = 31
    Caption = 'Alterar Caption/Text'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 8
    Top = 305
    Width = 497
    Height = 27
    Caption = 'Chamar Metodo Button1'
    OnClick = SpeedButton2Click
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 257
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 39
    Width = 257
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 8
    Top = 66
    Width = 257
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 8
    Top = 93
    Width = 257
    Height = 21
    TabOrder = 3
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 8
    Top = 120
    Width = 257
    Height = 21
    TabOrder = 4
    Text = 'Edit4'
  end
  object Memo1: TMemo
    Left = 8
    Top = 147
    Width = 257
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 5
  end
  object RadioGroup1: TRadioGroup
    Left = 311
    Top = 55
    Width = 185
    Height = 105
    Caption = 'RadioGroup1'
    Items.Strings = (
      'Item01'
      'Item02'
      'Item03')
    TabOrder = 6
  end
  object GroupBox1: TGroupBox
    Left = 311
    Top = 164
    Width = 185
    Height = 105
    Caption = 'GroupBox1'
    TabOrder = 7
  end
end
