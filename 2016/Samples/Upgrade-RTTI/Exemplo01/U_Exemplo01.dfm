object F_Exemplo01: TF_Exemplo01
  Left = 0
  Top = 0
  Caption = 'Listar Dados Objetos - RTTI'
  ClientHeight = 374
  ClientWidth = 496
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Propriedades: TLabel
    Left = 8
    Top = 45
    Width = 63
    Height = 13
    Caption = 'Propriedades'
  end
  object Métodos: TLabel
    Left = 8
    Top = 263
    Width = 41
    Height = 13
    Caption = 'M'#233'todos'
  end
  object Campos: TLabel
    Left = 8
    Top = 154
    Width = 38
    Height = 13
    Caption = 'Campos'
  end
  object MPropriedades: TMemo
    Left = 8
    Top = 59
    Width = 476
    Height = 89
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object MCampos: TMemo
    Left = 8
    Top = 168
    Width = 476
    Height = 89
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object MMetodos: TMemo
    Left = 8
    Top = 277
    Width = 476
    Height = 89
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object BtnListaForm: TButton
    Left = 8
    Top = 8
    Width = 161
    Height = 25
    Caption = 'Listar Dados - TForm'
    TabOrder = 3
    OnClick = BtnListaFormClick
  end
  object BtnListaClasse: TButton
    Left = 175
    Top = 8
    Width = 154
    Height = 25
    Caption = 'Listar Dados - MinhaClasse'
    TabOrder = 4
    OnClick = BtnListaClasseClick
  end
  object BtnObterProp: TButton
    Left = 335
    Top = 8
    Width = 149
    Height = 25
    Caption = 'Obter Propriedade'
    TabOrder = 5
    OnClick = BtnObterPropClick
  end
end
