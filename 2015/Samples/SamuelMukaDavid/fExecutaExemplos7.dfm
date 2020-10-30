object frmExecutaExemplos7: TfrmExecutaExemplos7
  Left = 0
  Top = 0
  Caption = 'frmExecutaExemplos7'
  ClientHeight = 300
  ClientWidth = 421
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 8
    Width = 49
    Height = 13
    Caption = 'Exemplo 7'
  end
  object rdgTipo: TRadioGroup
    Left = 32
    Top = 32
    Width = 161
    Height = 105
    Caption = 'rdgTipo'
    ItemIndex = 0
    Items.Strings = (
      'TXT'
      'XML'
      'JSon')
    TabOrder = 0
  end
  object btnExemplo7: TButton
    Left = 224
    Top = 32
    Width = 169
    Height = 25
    Caption = 'Exemplo 7'
    TabOrder = 1
    OnClick = btnExemplo7Click
  end
  object btnExemplo7Admin: TButton
    Left = 224
    Top = 80
    Width = 169
    Height = 25
    Caption = 'Exemplo7 Administrador'
    TabOrder = 2
    OnClick = btnExemplo7AdminClick
  end
  object btnExemplo7Helper: TButton
    Left = 224
    Top = 131
    Width = 169
    Height = 25
    Caption = 'Exemplo 7 Helper'
    TabOrder = 3
    OnClick = btnExemplo7HelperClick
  end
end
