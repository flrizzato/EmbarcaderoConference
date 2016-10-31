object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 321
  ClientWidth = 533
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
    Left = 24
    Top = 29
    Width = 75
    Height = 13
    Caption = 'Local Relat'#243'rios'
  end
  object BitBtn1: TBitBtn
    Left = 24
    Top = 152
    Width = 217
    Height = 25
    Caption = 'Ativar Servidor'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object Edit1: TEdit
    Left = 24
    Top = 48
    Width = 297
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object frxReportServer1: TfrxReportServer
    Active = False
    PrintPDF = True
    Print = True
    SocketOpen = True
    ConfigFileName = 'config.xml'
    Left = 88
    Top = 96
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 200
    Top = 96
  end
end
