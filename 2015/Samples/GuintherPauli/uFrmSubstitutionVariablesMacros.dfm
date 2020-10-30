object FrmSubstitutionVariablesMacros: TFrmSubstitutionVariablesMacros
  Left = 0
  Top = 0
  Caption = 'Substitution Variables Macros'
  ClientHeight = 241
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object boxTableName: TComboBox
    Left = 24
    Top = 24
    Width = 145
    Height = 21
    TabOrder = 0
    Items.Strings = (
      'DEPARTMENT'
      'EMPLOYEE'
      'COUNTRY')
  end
  object Open: TButton
    Left = 184
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 1
    OnClick = OpenClick
  end
  object grid: TDBGrid
    Left = 0
    Top = 72
    Width = 486
    Height = 169
    Align = alBottom
    DataSource = ds
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object qry: TFDQuery
    Connection = DM.con
    SQL.Strings = (
      '{IF FIREBIRD} SELECT RDB$RELATION_NAME FROM RDB$RELATIONS {fi}'
      '{IF MSSQL} SELECT NAME FROM SYS.OBJECTS {fi}')
    Left = 280
    Top = 16
  end
  object ds: TDataSource
    DataSet = qry
    Left = 344
    Top = 16
  end
end
