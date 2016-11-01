object Form9: TForm9
  Left = 0
  Top = 0
  Caption = 'Form9'
  ClientHeight = 473
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 19
  object DBGrid1: TDBGrid
    Left = 8
    Top = 16
    Width = 456
    Height = 401
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 437
    Width = 97
    Height = 17
    Caption = 'Ativar'
    TabOrder = 1
    OnClick = CheckBox1Click
  end
  object EmployeeConnection: TFDConnection
    Params.Strings = (
      'MonitorBy=FlatFile'
      'ConnectionDef=EMPLOYEE')
    Connected = True
    LoginPrompt = False
    Left = 61
    Top = 32
  end
  object FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink
    FileName = 'c:\temp\Trace01.txt'
    FileAppend = True
    Tracing = True
    Left = 64
    Top = 80
  end
  object FDQuery1: TFDQuery
    Connection = EmployeeConnection
    SQL.Strings = (
      'select * from Country')
    Left = 64
    Top = 136
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 64
    Top = 192
  end
end
