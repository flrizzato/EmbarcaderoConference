object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 498
  ClientWidth = 862
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 846
    Height = 441
    DataSource = dtsStatus
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 12
    Top = 455
    Width = 840
    Height = 35
    DataSource = dtsStatus
    TabOrder = 1
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 86
    Top = 42
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\ORMBr ECON\Database\Firebird\DB_LIVE.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 154
    Top = 42
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 230
    Top = 42
  end
  object FDStatus: TFDMemTable
    AfterPost = FDStatusAfterPost
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 354
    Top = 166
  end
  object dtsStatus: TDataSource
    AutoEdit = False
    DataSet = FDStatus
    Left = 426
    Top = 168
  end
end
