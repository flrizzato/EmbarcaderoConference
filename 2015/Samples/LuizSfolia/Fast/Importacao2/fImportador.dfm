object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Importador de Relat'#243'rios'
  ClientHeight = 292
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 25
    Top = 0
    Width = 385
    Height = 87
    Caption = 'Modo 1'
    TabOrder = 0
    object Label3: TLabel
      Left = 16
      Top = 35
      Width = 103
      Height = 13
      Caption = 'Abrir IDE Fast Report'
    end
    object BitBtn1: TBitBtn
      Left = 279
      Top = 30
      Width = 75
      Height = 25
      Caption = 'Importar'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 25
    Top = 104
    Width = 385
    Height = 167
    Caption = 'Modo 2'
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 21
      Width = 34
      Height = 13
      Caption = 'Origem'
    end
    object SpeedButton1: TSpeedButton
      Left = 331
      Top = 40
      Width = 23
      Height = 22
      OnClick = SpeedButton1Click
    end
    object Label2: TLabel
      Left = 16
      Top = 69
      Width = 36
      Height = 13
      Caption = 'Destino'
    end
    object SpeedButton2: TSpeedButton
      Left = 331
      Top = 88
      Width = 23
      Height = 22
      OnClick = SpeedButton2Click
    end
    object edtOrigem: TEdit
      Left = 16
      Top = 40
      Width = 313
      Height = 21
      TabOrder = 0
    end
    object edtDestino: TEdit
      Left = 16
      Top = 88
      Width = 313
      Height = 21
      TabOrder = 1
    end
    object BitBtn2: TBitBtn
      Left = 279
      Top = 126
      Width = 75
      Height = 25
      Caption = 'Importar'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 2
      OnClick = BitBtn2Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 40
    Top = 216
  end
  object SaveDialog1: TSaveDialog
    Left = 104
    Top = 216
  end
end
