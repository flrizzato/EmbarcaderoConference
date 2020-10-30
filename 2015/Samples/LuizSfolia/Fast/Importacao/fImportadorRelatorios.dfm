object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 228
  ClientWidth = 558
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 34
    Width = 80
    Height = 13
    Caption = 'Relatorio Origem'
  end
  object Label2: TLabel
    Left = 40
    Top = 114
    Width = 82
    Height = 13
    Caption = 'Relatorio Destino'
  end
  object SpeedButton1: TSpeedButton
    Left = 362
    Top = 53
    Width = 23
    Height = 22
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 362
    Top = 132
    Width = 23
    Height = 22
    OnClick = SpeedButton2Click
  end
  object edtOrigem: TButtonedEdit
    Left = 40
    Top = 53
    Width = 321
    Height = 21
    RightButton.Visible = True
    TabOrder = 0
    Text = 'edtOrigem'
  end
  object BitBtn1: TBitBtn
    Left = 40
    Top = 80
    Width = 105
    Height = 25
    Caption = 'Converter <=>'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object edtDestino: TButtonedEdit
    Left = 40
    Top = 133
    Width = 321
    Height = 21
    RightButton.Visible = True
    TabOrder = 2
    Text = 'edtOrigem'
  end
  object OpenDialog1: TOpenDialog
    Left = 424
    Top = 16
  end
  object SaveDialog1: TSaveDialog
    Left = 432
    Top = 72
  end
end
