object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Est'#225'tico'
  ClientHeight = 351
  ClientWidth = 604
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 24
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Abrir'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 72
    Width = 553
    Height = 257
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object FbrestConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=FBRest')
    Connected = True
    LoginPrompt = False
    Left = 304
    Top = 39
  end
  object ContatoTable: TFDQuery
    Connection = FbrestConnection
    SQL.Strings = (
      'SELECT * FROM CONTATO')
    Left = 304
    Top = 87
  end
  object DataSource1: TDataSource
    DataSet = ContatoTable
    Left = 304
    Top = 168
  end
end
