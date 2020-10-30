object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 357
  ClientWidth = 615
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
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
    Left = 224
    Top = 23
  end
  object DataSource1: TDataSource
    Left = 288
    Top = 24
  end
  object FDQuery1: TFDQuery
    Connection = FbrestConnection
    Left = 304
    Top = 184
  end
end
