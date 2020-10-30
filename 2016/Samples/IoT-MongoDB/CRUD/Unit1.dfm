object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 429
  ClientWidth = 704
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 57
    Width = 704
    Height = 239
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 704
    Height = 57
    Align = alTop
    TabOrder = 1
    object Button1: TButton
      Left = 64
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Insert'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 145
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Select'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 226
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Update'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 307
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Remove'
      TabOrder = 3
      OnClick = Button4Click
    end
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 296
    Width = 704
    Height = 133
    Align = alBottom
    DataSource = DataSource2
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=Mongo')
    Left = 408
    Top = 8
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 440
    Top = 8
  end
  object FDPhysMongoDriverLink1: TFDPhysMongoDriverLink
    Left = 472
    Top = 8
  end
  object FDMongoDataSet1: TFDMongoDataSet
    FormatOptions.AssignedValues = [fvStrsTrim2Len]
    FormatOptions.StrsTrim2Len = True
    Connection = FDConnection1
    Left = 520
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = FDMongoDataSet1
    Left = 576
    Top = 80
  end
  object DataSource2: TDataSource
    Left = 568
    Top = 352
  end
end
