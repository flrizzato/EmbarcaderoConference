object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 299
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
  object DBGrid1: TDBGrid
    Left = 24
    Top = 40
    Width = 585
    Height = 233
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 104
    Top = 9
    Width = 275
    Height = 25
    DataSource = DataSource1
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh, nbApplyUpdates]
    TabOrder = 1
  end
  object Button1: TButton
    Left = 23
    Top = 10
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 2
    OnClick = Button1Click
  end
  object SQLConnection1: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=23.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
    Connected = True
    Left = 104
    Top = 136
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TServerMethods1'
    Connected = True
    SQLConnection = SQLConnection1
    Left = 208
    Top = 136
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    RemoteServer = DSProviderConnection1
    Left = 312
    Top = 136
    object ClientDataSet1EMP_NO: TSmallintField
      FieldName = 'EMP_NO'
    end
    object ClientDataSet1FIRST_NAME: TStringField
      FieldName = 'FIRST_NAME'
      Required = True
      Size = 15
    end
    object ClientDataSet1LAST_NAME: TStringField
      FieldName = 'LAST_NAME'
      Required = True
    end
    object ClientDataSet1PHONE_EXT: TStringField
      FieldName = 'PHONE_EXT'
      Size = 4
    end
    object ClientDataSet1HIRE_DATE: TSQLTimeStampField
      FieldName = 'HIRE_DATE'
    end
    object ClientDataSet1DEPT_NO: TStringField
      FieldName = 'DEPT_NO'
      Required = True
      FixedChar = True
      Size = 3
    end
    object ClientDataSet1JOB_CODE: TStringField
      FieldName = 'JOB_CODE'
      Required = True
      Size = 5
    end
    object ClientDataSet1JOB_GRADE: TSmallintField
      FieldName = 'JOB_GRADE'
      Required = True
    end
    object ClientDataSet1JOB_COUNTRY: TStringField
      FieldName = 'JOB_COUNTRY'
      Required = True
      Size = 15
    end
    object ClientDataSet1SALARY: TBCDField
      FieldName = 'SALARY'
      Required = True
      Precision = 18
      Size = 2
    end
    object ClientDataSet1FULL_NAME: TStringField
      FieldName = 'FULL_NAME'
      ReadOnly = True
      Size = 37
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 392
    Top = 136
  end
end
