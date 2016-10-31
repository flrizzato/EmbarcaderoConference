object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 292
  ClientWidth = 569
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
    Width = 569
    Height = 145
    Align = alTop
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = DBGrid1TitleClick
  end
  object Button1: TButton
    Left = 89
    Top = 151
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 151
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 2
    OnClick = Button2Click
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Public\Documents\RAD Studio\12.0\Samples\Data\' +
        'dbdemos.gdb'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=IB')
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtFmtBCD
        TargetDataType = dtUInt64
      end
      item
        SourceDataType = dtDateTimeStamp
        TargetDataType = dtDate
      end>
    Connected = True
    LoginDialog = FDGUIxLoginDialog1
    Left = 48
    Top = 32
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvCmdExecMode]
    ResourceOptions.CmdExecMode = amAsync
    SQL.Strings = (
      'select * from orders')
    Left = 48
    Top = 96
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 48
    Top = 200
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 304
    Top = 232
  end
  object FDGUIxLoginDialog1: TFDGUIxLoginDialog
    Provider = 'Forms'
    HistoryEnabled = True
    Left = 168
    Top = 208
  end
  object FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink
    FileName = 
      'C:\Users\Diego\Documents\RAD Studio\Projects\FireDac\Win32\Debug' +
      '\trace1.txt'
    ShowTraces = False
    Tracing = True
    Left = 248
    Top = 160
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 448
    Top = 184
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 360
    Top = 160
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 264
    Top = 48
  end
end
