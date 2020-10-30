object FrmBathMove: TFrmBathMove
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '07 - BathMove'
  ClientHeight = 71
  ClientWidth = 323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnExecuteFirebird: TButton
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 317
    Height = 63
    Align = alTop
    Caption = 'Execute'
    TabOrder = 0
    OnClick = btnExecuteFirebirdClick
  end
end
