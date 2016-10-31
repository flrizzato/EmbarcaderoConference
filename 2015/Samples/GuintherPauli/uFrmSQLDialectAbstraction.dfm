object FrmSQLDialectAbstraction: TFrmSQLDialectAbstraction
  Left = 0
  Top = 0
  Caption = 'SQL Dialect Abstraction'
  ClientHeight = 275
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TDBGrid
    Left = 0
    Top = 65
    Width = 470
    Height = 210
    Align = alClient
    DataSource = ds
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object radio: TRadioGroup
    Left = 0
    Top = 0
    Width = 470
    Height = 65
    Align = alTop
    Items.Strings = (
      'SQL Server'
      'Firebird')
    TabOrder = 1
  end
  object btnOpen: TButton
    Left = 368
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 2
    OnClick = btnOpenClick
  end
  object ds: TDataSource
    DataSet = qry
    Left = 120
    Top = 128
  end
  object qry: TFDQuery
    Connection = DM.con
    SQL.Strings = (
      '{IF FIREBIRD} SELECT RDB$RELATION_NAME FROM RDB$RELATIONS {fi}'
      '{IF MSSQL} SELECT NAME FROM SYS.OBJECTS {fi}')
    Left = 56
    Top = 120
  end
end
