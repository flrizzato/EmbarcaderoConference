object dbgr: Tdbgr
  Left = 0
  Top = 0
  ClientHeight = 299
  ClientWidth = 630
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
    Left = 8
    Top = 13
    Width = 52
    Height = 13
    Caption = 'Username:'
  end
  object Label2: TLabel
    Left = 160
    Top = 13
    Width = 50
    Height = 13
    Caption = 'Password:'
  end
  object Label3: TLabel
    Left = 21
    Top = 64
    Width = 39
    Height = 13
    Caption = 'User Id:'
  end
  object lblSalary: TLabel
    Left = 233
    Top = 61
    Width = 227
    Height = 13
    AutoSize = False
    Caption = '<- Click to GetSalary'
  end
  object bConnect: TButton
    Left = 304
    Top = 6
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = bConnectClick
  end
  object Edit1: TEdit
    Left = 66
    Top = 8
    Width = 80
    Height = 21
    TabOrder = 1
    Text = 'Nelson'
  end
  object Edit2: TEdit
    Left = 218
    Top = 8
    Width = 80
    Height = 21
    TabOrder = 2
    Text = '250'
  end
  object Memo1: TMemo
    Left = 466
    Top = 8
    Width = 151
    Height = 121
    Lines.Strings = (
      'Note: you can use this data '
      'to test this sample:'
      ''
      'User, Pass, Id, Role'
      'Nelson, 250, 2, VP'
      'Reeves, 6, 36, Sales')
    TabOrder = 3
  end
  object Edit3: TEdit
    Left = 66
    Top = 59
    Width = 80
    Height = 21
    TabOrder = 4
    Text = '2'
  end
  object Button1: TButton
    Left = 152
    Top = 56
    Width = 75
    Height = 25
    Caption = 'GetSalary'
    TabOrder = 5
    OnClick = Button1Click
  end
  object bGetCustomers: TButton
    Left = 8
    Top = 104
    Width = 105
    Height = 25
    Caption = 'Get Customers'
    TabOrder = 6
    OnClick = bGetCustomersClick
  end
  object bSaveCustomers: TButton
    Left = 357
    Top = 104
    Width = 105
    Height = 25
    Caption = 'Save Customers'
    TabOrder = 7
    OnClick = bSaveCustomersClick
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 135
    Width = 609
    Height = 156
    DataSource = DataSource1
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 115
    Top = 104
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 9
  end
  object sqlCon: TSQLConnection
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
      'Filters={}'
      'DSAuthenticationUser=Reeves'
      'DSAuthenticationPassword=6')
    Left = 384
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = cds
    Left = 232
    Top = 192
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TServerMethods1'
    SQLConnection = sqlCon
    Left = 464
    Top = 8
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCustomer'
    RemoteServer = DSProviderConnection1
    Left = 304
    Top = 192
  end
  object smGetSalary: TSqlServerMethod
    Params = <
      item
        DataType = ftInteger
        Precision = 4
        Name = 'aUserId'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Precision = 8
        Name = 'ReturnParameter'
        ParamType = ptResult
        Size = 8
      end>
    SQLConnection = sqlCon
    ServerMethodName = 'TServerMethods1.GetSalary'
    Left = 384
    Top = 56
  end
end
