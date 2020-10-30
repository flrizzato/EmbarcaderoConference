object FrmSaveToFile: TFrmSaveToFile
  Left = 0
  Top = 0
  Caption = 'SaveToFile'
  ClientHeight = 375
  ClientWidth = 634
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
    Left = 0
    Top = 0
    Width = 634
    Height = 375
    Align = alClient
    DataSource = ds
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnSaveXML: TButton
    Left = 506
    Top = 80
    Width = 89
    Height = 25
    Caption = 'Save to XML'
    TabOrder = 1
    OnClick = btnSaveXMLClick
  end
  object btnSaveJSON: TButton
    Left = 506
    Top = 111
    Width = 89
    Height = 25
    Caption = 'Save to JSON'
    TabOrder = 2
    OnClick = btnSaveJSONClick
  end
  object btnLoadXML: TButton
    Left = 506
    Top = 142
    Width = 89
    Height = 25
    Caption = 'Load XML'
    TabOrder = 3
    OnClick = btnLoadXMLClick
  end
  object btnLoadJSON: TButton
    Left = 506
    Top = 173
    Width = 89
    Height = 25
    Caption = 'Load JSON'
    TabOrder = 4
    OnClick = btnLoadJSONClick
  end
  object btnOpen: TButton
    Left = 506
    Top = 17
    Width = 89
    Height = 25
    Caption = 'Open'
    TabOrder = 5
    OnClick = btnOpenClick
  end
  object btnClose: TButton
    Left = 506
    Top = 48
    Width = 89
    Height = 25
    Caption = 'Close'
    TabOrder = 6
    OnClick = btnCloseClick
  end
  object qry: TFDQuery
    Connection = DM.con
    SQL.Strings = (
      'select * from EMPLOYEE')
    Left = 48
    Top = 88
  end
  object ds: TDataSource
    DataSet = qry
    Left = 104
    Top = 88
  end
  object bin: TFDStanStorageBinLink
    Left = 296
    Top = 192
  end
  object xml: TFDStanStorageXMLLink
    Left = 296
    Top = 248
  end
  object json: TFDStanStorageJSONLink
    Left = 296
    Top = 136
  end
end
