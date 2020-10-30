object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Mestre Detalhe'
  ClientHeight = 474
  ClientWidth = 530
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
    Top = 8
    Width = 514
    Height = 184
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 238
    Width = 514
    Height = 187
    DataSource = DataSource2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 198
    Width = 510
    Height = 34
    DataSource = DataSource1
    TabOrder = 2
  end
  object DBNavigator2: TDBNavigator
    Left = 8
    Top = 432
    Width = 510
    Height = 34
    DataSource = DataSource2
    TabOrder = 3
  end
  object DataSource1: TDataSource
    DataSet = DataModule7.FDQueryMestre
    Left = 208
    Top = 96
  end
  object DataSource2: TDataSource
    DataSet = DataModule7.FDQueryDetalhe
    Left = 240
    Top = 256
  end
end
