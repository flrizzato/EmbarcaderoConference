object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Servidor DataSnap Stand-alone'
  ClientHeight = 98
  ClientWidth = 389
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Iniciar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ComboBox1: TComboBox
    Left = 89
    Top = 10
    Width = 145
    Height = 21
    TabOrder = 1
    Text = '8080'
    Items.Strings = (
      '8080'
      '8081'
      '8082'
      '')
  end
  object DSServer1: TDSServer
    AutoStart = False
    Left = 24
    Top = 40
  end
  object DSHTTPService1: TDSHTTPService
    Server = DSServer1
    Filters = <>
    SessionTimeout = 120000
    Left = 104
    Top = 40
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 184
    Top = 40
  end
end
