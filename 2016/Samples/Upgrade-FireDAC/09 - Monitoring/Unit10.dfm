object Form10: TForm10
  Left = 0
  Top = 0
  Caption = 'Form10'
  ClientHeight = 493
  ClientWidth = 481
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
    Top = 16
    Width = 456
    Height = 401
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
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
      'MonitorBy=Remote'
      'ConnectionDef=EMPLOYEE')
    LoginPrompt = False
    Left = 61
    Top = 32
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 64
    Top = 192
  end
  object FDQuery1: TFDQuery
    Connection = EmployeeConnection
    SQL.Strings = (
      'select * from Country')
    Left = 64
    Top = 136
  end
  object FDMoniRemoteClientLink1: TFDMoniRemoteClientLink
    Tracing = True
    Left = 64
    Top = 88
  end
end
