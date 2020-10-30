object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Asynchronous Command'
  ClientHeight = 366
  ClientWidth = 644
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 573
    Top = 8
    Width = 63
    Height = 23
    Alignment = taRightJustify
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Open: TButton
    Left = 520
    Top = 280
    Width = 116
    Height = 45
    Caption = 'Open'
    TabOrder = 0
    OnClick = OpenClick
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 37
    Width = 628
    Height = 237
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 280
    Width = 506
    Height = 45
    Caption = 'Op'#231#245'es'
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'Normal'
      'amAsync'
      'amCancelDialog')
    TabOrder = 2
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 337
    Width = 644
    Height = 29
    Align = alBottom
    TabOrder = 3
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=EC-2014'
      'User_Name=sa'
      'Password=732154Al#'
      'Server=localhost'
      'OSAuthent=No'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 72
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 64
    Top = 120
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 64
    Top = 168
  end
  object FDQuery1: TFDQuery
    BeforeOpen = FDQuery1BeforeOpen
    AfterOpen = FDQuery1AfterOpen
    AfterGetRecords = FDQuery1AfterGetRecords
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select top 1500000 * from Clientes cross join produtos')
    Left = 280
    Top = 72
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 512
    Top = 80
  end
  object FDGUIxAsyncExecuteDialog1: TFDGUIxAsyncExecuteDialog
    Provider = 'Forms'
    Caption = 'FireDAC - EC 2013'
    Prompt = 'Aguarde... '
    Left = 512
    Top = 136
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 280
    Top = 128
  end
end
