object frmServer: TfrmServer
  Left = 271
  Top = 114
  Caption = 'Servidor XE7 - Landerson Gomes '
  ClientHeight = 193
  ClientWidth = 516
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 216
    Top = 13
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Image1: TImage
    Left = 0
    Top = 72
    Width = 516
    Height = 121
    Align = alBottom
    Stretch = True
    ExplicitTop = 64
  end
  object ButtonStart: TButton
    Left = 24
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 105
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object EditPort: TEdit
    Left = 251
    Top = 10
    Width = 70
    Height = 21
    TabOrder = 2
    Text = '2013'
  end
  object ButtonOpenBrowser: TButton
    Left = 392
    Top = 8
    Width = 107
    Height = 25
    Caption = 'Open Browser'
    TabOrder = 3
    OnClick = ButtonOpenBrowserClick
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 344
    Top = 8
  end
end
