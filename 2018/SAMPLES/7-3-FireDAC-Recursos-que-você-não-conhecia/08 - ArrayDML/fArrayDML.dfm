object FrmArrayDML: TFrmArrayDML
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '08 - ArrayDML'
  ClientHeight = 142
  ClientWidth = 515
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
    Width = 509
    Height = 63
    Align = alTop
    Caption = 'Insert'
    TabOrder = 0
    OnClick = btnExecuteFirebirdClick
    ExplicitLeft = -239
    ExplicitWidth = 754
  end
  object btnArrayDML: TButton
    AlignWithMargins = True
    Left = 3
    Top = 72
    Width = 509
    Height = 63
    Align = alTop
    Caption = 'ArrayDML'
    TabOrder = 1
    OnClick = btnArrayDMLClick
    ExplicitLeft = 6
    ExplicitTop = 11
  end
end
