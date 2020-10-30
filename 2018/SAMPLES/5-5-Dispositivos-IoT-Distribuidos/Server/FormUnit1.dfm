object Form1: TForm1
  AlignWithMargins = True
  Left = 271
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Server DataSnap Push'
  ClientHeight = 182
  ClientWidth = 357
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 195
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object ButtonStart: TButton
    Left = 8
    Top = 24
    Width = 120
    Height = 35
    Caption = 'I N I C I A R'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 8
    Top = 65
    Width = 120
    Height = 35
    Caption = 'P A R A R'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object EditPort: TEdit
    Left = 105
    Top = 192
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '8181'
  end
  object ButtonOpenBrowser: TButton
    Left = 232
    Top = 190
    Width = 107
    Height = 25
    Caption = 'Open Browser'
    TabOrder = 3
    OnClick = ButtonOpenBrowserClick
  end
  object PanelStatus: TPanel
    Left = 0
    Top = 120
    Width = 357
    Height = 62
    Align = alBottom
    Color = 4227072
    ParentBackground = False
    TabOrder = 4
    object LabelCloud: TLabel
      Left = 1
      Top = 1
      Width = 355
      Height = 60
      Margins.Top = 20
      Margins.Bottom = 20
      Align = alClient
      Alignment = taCenter
      Caption = 'Cloud '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -37
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitTop = 22
    end
  end
  object Button1: TButton
    Left = 232
    Top = 47
    Width = 51
    Height = 27
    Caption = 'UDP'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 151
    Top = 49
    Width = 75
    Height = 25
    Caption = 'Push'
    TabOrder = 6
    OnClick = Button2Click
  end
  object EditIP: TEdit
    Left = 152
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 7
    Text = '192.168.43.80'
  end
  object Conectar: TButton
    Left = 279
    Top = 78
    Width = 71
    Height = 25
    Caption = 'Conectar'
    TabOrder = 8
    OnClick = ConectarClick
  end
  object EditIPControladora: TEdit
    Left = 151
    Top = 20
    Width = 121
    Height = 21
    TabOrder = 9
    Text = '192.168.43.110'
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 48
    Top = 120
  end
  object IdUDPServer: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = IdUDPServerUDPRead
    Left = 280
    Top = 112
  end
end
