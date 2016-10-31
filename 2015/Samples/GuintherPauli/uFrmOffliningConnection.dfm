object FrmOffliningConnection: TFrmOffliningConnection
  Left = 0
  Top = 0
  Caption = 'Offlining Connection'
  ClientHeight = 228
  ClientWidth = 452
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TDBGrid
    Left = 0
    Top = 0
    Width = 452
    Height = 228
    Align = alClient
    DataSource = ds
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object qry: TFDQuery
    Connection = DM.con
    Left = 48
    Top = 24
  end
  object ds: TDataSource
    DataSet = qry
    Left = 120
    Top = 24
  end
end
