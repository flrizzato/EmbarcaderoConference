object FrmLocalSQL: TFrmLocalSQL
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '06 - Local SQL'
  ClientHeight = 371
  ClientWidth = 760
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
    Width = 754
    Height = 63
    Align = alTop
    Caption = 'Execute'
    TabOrder = 0
    OnClick = btnExecuteFirebirdClick
    ExplicitTop = 159
    ExplicitWidth = 394
  end
  object griFirebird: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 72
    Width = 754
    Height = 296
    Align = alClient
    DataSource = DataSource
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DataSource: TDataSource
    DataSet = DMLocalSQL.VendasFull
    Left = 40
    Top = 344
  end
end
