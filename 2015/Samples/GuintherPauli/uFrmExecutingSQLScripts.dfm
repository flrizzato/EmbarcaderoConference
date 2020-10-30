object FrmExecutingSQLScripts: TFrmExecutingSQLScripts
  Left = 0
  Top = 0
  Caption = 'Executing SQL Scripts'
  ClientHeight = 363
  ClientWidth = 493
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object mmScript: TMemo
    Left = 0
    Top = 0
    Width = 493
    Height = 193
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'create table CLIENTES(ID integer not null '
      'primary key, NOME varchar(100));'
      'insert into CLIENTES values(1,'#39'GUINTHER'#39');'
      'insert into CLIENTES values(2,'#39'RUDOLFO'#39');'
      'insert into CLIENTES values(3,'#39'FERNANDO'#39');'
      'insert into CLIENTES values(4,'#39'FABIO'#39');'
      ''
      ''
      ''
      '')
    ParentFont = False
    TabOrder = 0
  end
  object btnExecute: TButton
    Left = 8
    Top = 146
    Width = 75
    Height = 25
    Caption = 'Execute'
    TabOrder = 1
    OnClick = btnExecuteClick
  end
  object grid: TDBGrid
    Left = 0
    Top = 193
    Width = 493
    Height = 170
    Align = alClient
    DataSource = ds
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Script: TFDScript
    SQLScripts = <>
    Connection = DM.con
    ScriptDialog = scriptDlg
    Params = <>
    Macros = <>
    Left = 344
    Top = 160
  end
  object tbl: TFDTable
    CachedUpdates = True
    Connection = DM.con
    Left = 200
    Top = 160
  end
  object ds: TDataSource
    DataSet = tbl
    Left = 272
    Top = 160
  end
  object scriptDlg: TFDGUIxScriptDialog
    Provider = 'Forms'
    Left = 408
    Top = 160
  end
end
