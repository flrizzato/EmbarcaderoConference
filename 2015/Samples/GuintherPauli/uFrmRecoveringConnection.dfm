object FrmRecoveringConnection: TFrmRecoveringConnection
  Left = 0
  Top = 0
  Caption = 'Recovering Connection'
  ClientHeight = 200
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnPing: TButton
    Left = 112
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Ping'
    TabOrder = 0
    OnClick = btnPingClick
  end
end
