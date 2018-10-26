object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Exemplo de Publica'#231#227'o e Assinatura'
  ClientHeight = 533
  ClientWidth = 612
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 21
  object Memo1: TMemo
    Left = 12
    Top = 12
    Width = 588
    Height = 410
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 12
    Top = 456
    Width = 113
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'CONECTAR'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 134
    Top = 456
    Width = 112
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'ENVIAR'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 255
    Top = 459
    Width = 345
    Height = 29
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 3
    Text = 'Ol'#225' Mundo!'
  end
end
