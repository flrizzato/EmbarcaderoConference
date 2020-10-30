object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 475
  ClientWidth = 591
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 575
    Height = 169
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Memo1: TMemo
    Left = 8
    Top = 183
    Width = 575
    Height = 281
    Lines.Strings = (
      '')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object CursofiredacConnection: TFDConnection
    Params.Strings = (
      'MonitorBy=Custom'
      'ConnectionDef=CursoFireDAC')
    Connected = True
    LoginPrompt = False
    Left = 138
    Top = 207
  end
  object FDQBairros: TFDQuery
    Active = True
    Connection = CursofiredacConnection
    SQL.Strings = (
      'Select * From Bairros')
    Left = 392
    Top = 32
  end
  object FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink
    FileName = 'trace1.txt'
    FileColumns = [tiRefNo, tiTime, tiObjID, tiMsgText]
    Left = 136
    Top = 256
  end
  object DataSource1: TDataSource
    DataSet = FDQBairros
    Left = 392
    Top = 80
  end
  object FDMoniRemoteClientLink1: TFDMoniRemoteClientLink
    Left = 136
    Top = 304
  end
  object FDMoniCustomClientLink1: TFDMoniCustomClientLink
    OnOutput = FDMoniCustomClientLink1Output
    Tracing = True
    Left = 136
    Top = 352
  end
end
