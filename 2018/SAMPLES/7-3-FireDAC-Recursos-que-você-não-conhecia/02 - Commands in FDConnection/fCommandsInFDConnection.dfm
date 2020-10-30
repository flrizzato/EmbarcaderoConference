object FrmCommandsInFDConnection: TFrmCommandsInFDConnection
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '02 - Commands In FDConnection'
  ClientHeight = 93
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnExecSQLScalar: TButton
    AlignWithMargins = True
    Left = 3
    Top = 49
    Width = 394
    Height = 40
    Align = alTop
    Caption = 'ExecSQLScalar'
    TabOrder = 0
    OnClick = btnExecSQLScalarClick
  end
  object btnExecSQL: TButton
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 394
    Height = 40
    Align = alTop
    Caption = 'ExecSQL'
    TabOrder = 1
    OnClick = btnExecSQLClick
  end
end
