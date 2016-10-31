object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 262
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 58
    Height = 13
    Caption = 'Echo String:'
  end
  object Label2: TLabel
    Left = 272
    Top = 16
    Width = 28
    Height = 13
    Caption = 'Filter:'
  end
  object Label3: TLabel
    Left = 456
    Top = 16
    Width = 103
    Height = 13
    Caption = '<- click to test filters!'
  end
  object Label4: TLabel
    Left = 16
    Top = 56
    Width = 55
    Height = 13
    Caption = 'Recs/Page:'
  end
  object lblPage: TLabel
    Left = 267
    Top = 56
    Width = 37
    Height = 13
    Caption = 'Page: 1'
  end
  object eEchoStr: TEdit
    Left = 80
    Top = 13
    Width = 177
    Height = 21
    TabOrder = 0
    Text = 'abcdefghijklmnopqrstuvwxyz'
  end
  object eFilter: TEdit
    Left = 306
    Top = 13
    Width = 63
    Height = 21
    TabOrder = 1
    Text = 'ss.c=5'
  end
  object bEchoString: TButton
    Left = 384
    Top = 11
    Width = 57
    Height = 25
    Caption = 'Echo'
    TabOrder = 2
    OnClick = bEchoStringClick
  end
  object seRecordsPerPage: TSpinEdit
    Left = 80
    Top = 53
    Width = 58
    Height = 22
    MaxValue = 50
    MinValue = 0
    TabOrder = 3
    Value = 5
  end
  object bGetCustomers: TButton
    Left = 152
    Top = 51
    Width = 89
    Height = 25
    Caption = 'Get Customers'
    TabOrder = 4
    OnClick = bGetCustomersClick
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 82
    Width = 601
    Height = 167
    DataSource = DataSource1
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object bPrior: TButton
    Left = 328
    Top = 51
    Width = 33
    Height = 25
    Caption = '<'
    TabOrder = 6
    OnClick = bPriorClick
  end
  object bNext: TButton
    Left = 360
    Top = 51
    Width = 33
    Height = 25
    Caption = '>'
    TabOrder = 7
    OnClick = bNextClick
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 320
    Top = 136
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 416
    Top = 136
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 368
    Top = 152
  end
end
