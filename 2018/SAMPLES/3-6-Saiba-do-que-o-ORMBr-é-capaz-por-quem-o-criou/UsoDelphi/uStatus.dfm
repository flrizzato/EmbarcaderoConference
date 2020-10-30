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
      
        'Database=D:\ORMBr Diversos\Live-08062017\Database\Firebird\DB_LI' +
        'VE.FDB'
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Left = 156
    Top = 42
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 230
    Top = 42
  end
  object dtsStatus: TDataSource
    AutoEdit = False
    DataSet = FDStatus
    Left = 426
    Top = 168
  end
  object FDStatus: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from tab_status')
    Left = 364
    Top = 168
    object FDStatusID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDStatusDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 30
    end
  end
end
