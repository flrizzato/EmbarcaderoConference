object Form1: TForm1
  Left = 628
  Top = 209
  ActiveControl = edValor1
  Caption = 'Form1'
  ClientHeight = 226
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbResultado: TLabel
    Left = 173
    Top = 134
    Width = 80
    Height = 13
    Caption = 'RESULTADO:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edValor1: TEdit
    Left = 26
    Top = 30
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'valor1'
  end
  object edValor2: TEdit
    Left = 156
    Top = 30
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'valor2'
  end
  object pbSomar: TButton
    Left = 66
    Top = 78
    Width = 75
    Height = 25
    Caption = '&Somar'
    TabOrder = 2
    OnClick = pbSomarClick
  end
  object pbSubtrair: TButton
    Left = 66
    Top = 110
    Width = 75
    Height = 25
    Caption = 'S&ubtrair'
    TabOrder = 3
    OnClick = pbSubtrairClick
  end
  object pbMultiplicar: TButton
    Left = 66
    Top = 141
    Width = 75
    Height = 25
    Caption = '&Multiplicar'
    TabOrder = 4
    OnClick = pbMultiplicarClick
  end
  object pbDividir: TButton
    Left = 66
    Top = 172
    Width = 75
    Height = 25
    Caption = '&Dividir'
    TabOrder = 5
    OnClick = pbDividirClick
  end
end
