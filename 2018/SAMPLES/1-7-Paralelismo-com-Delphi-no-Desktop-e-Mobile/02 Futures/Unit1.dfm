object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 258
  ClientWidth = 567
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 23
  object Label1: TLabel
    Left = 40
    Top = 104
    Width = 130
    Height = 23
    Caption = 'Resultado geral'
  end
  object Label2: TLabel
    Left = 40
    Top = 152
    Width = 99
    Height = 23
    Caption = 'Resultado A'
  end
  object Label3: TLabel
    Left = 40
    Top = 181
    Width = 99
    Height = 23
    Caption = 'Resultado B'
  end
  object Label4: TLabel
    Left = 40
    Top = 210
    Width = 99
    Height = 23
    Caption = 'Resultado C'
  end
  object Button1: TButton
    Left = 40
    Top = 32
    Width = 97
    Height = 33
    Caption = 'Normal'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 295
    Top = 32
    Width = 146
    Height = 33
    Caption = 'Future async'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 143
    Top = 32
    Width = 146
    Height = 33
    Caption = 'Future sync'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 336
    Top = 112
  end
end
