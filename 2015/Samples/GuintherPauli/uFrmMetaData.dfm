object FrmMetaData: TFrmMetaData
  Left = 0
  Top = 0
  Caption = 'Querying Metadata'
  ClientHeight = 447
  ClientWidth = 909
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
  object Label1: TLabel
    Left = 272
    Top = 19
    Width = 64
    Height = 13
    Caption = 'MetaInfoKind'
  end
  object Label2: TLabel
    Left = 16
    Top = 19
    Width = 69
    Height = 13
    Caption = 'Escolha tabela'
  end
  object boxTabelas: TComboBox
    Left = 102
    Top = 16
    Width = 145
    Height = 21
    TabOrder = 0
  end
  object grid: TDBGrid
    Left = 0
    Top = 56
    Width = 909
    Height = 391
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = ds
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object boxInfoKind: TComboBox
    Left = 358
    Top = 16
    Width = 145
    Height = 21
    TabOrder = 2
    OnChange = boxInfoKindChange
  end
  object metaInfo: TFDMetaInfoQuery
    Connection = DM.con
    Left = 560
    Top = 8
  end
  object ds: TDataSource
    DataSet = metaInfo
    Left = 636
    Top = 8
  end
end
