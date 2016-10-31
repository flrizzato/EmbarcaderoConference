object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'RemoteDB Client'
  ClientHeight = 498
  ClientWidth = 722
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    722
    498)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 36
    Height = 13
    Caption = 'Server:'
  end
  object edServer: TEdit
    Left = 56
    Top = 13
    Width = 289
    Height = 21
    TabOrder = 0
    Text = 'http://localhost/tms/dbdemos/data'
  end
  object btConnect: TButton
    Left = 351
    Top = 11
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 1
    OnClick = btConnectClick
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 48
    Width = 703
    Height = 258
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBImage1: TDBImage
    Left = 8
    Top = 312
    Width = 273
    Height = 178
    Anchors = [akLeft, akBottom]
    DataField = 'GRAPHIC'
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 3
  end
  object DBMemo1: TDBMemo
    Left = 287
    Top = 312
    Width = 424
    Height = 178
    Anchors = [akLeft, akRight, akBottom]
    DataField = 'NOTES'
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 4
  end
  object RemoteDBDatabase1: TRemoteDBDatabase
    Connected = False
    UserName = 'remotedb'
    Password = 'business'
    Left = 528
    Top = 8
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = XDataset1
    Left = 448
    Top = 8
  end
  object XDataset1: TXDataset
    Database = RemoteDBDatabase1
    SQL.Strings = (
      'Select * from Biolife')
    Params = <>
    Left = 616
    Top = 8
  end
end
