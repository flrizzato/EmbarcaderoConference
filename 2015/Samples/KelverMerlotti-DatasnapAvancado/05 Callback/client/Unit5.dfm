object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Form5'
  ClientHeight = 232
  ClientWidth = 564
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
  object Label1: TLabel
    Left = 16
    Top = 176
    Width = 53
    Height = 13
    Caption = 'ManagerID'
  end
  object Label2: TLabel
    Left = 16
    Top = 203
    Width = 50
    Height = 13
    Caption = 'CallBackID'
  end
  object Label3: TLabel
    Left = 288
    Top = 176
    Width = 53
    Height = 13
    Caption = 'ManagerID'
  end
  object Label4: TLabel
    Left = 288
    Top = 203
    Width = 50
    Height = 13
    Caption = 'CallBackID'
  end
  object Label5: TLabel
    Left = 24
    Top = 31
    Width = 31
    Height = 13
    Caption = 'Label5'
  end
  object ProgressBar1: TProgressBar
    Left = 24
    Top = 8
    Width = 513
    Height = 17
    MarqueeInterval = 1
    Step = 1
    TabOrder = 0
  end
  object Button1: TButton
    Left = 24
    Top = 79
    Width = 75
    Height = 25
    Caption = 'GetReport'
    TabOrder = 1
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 24
    Top = 58
    Width = 121
    Height = 15
    Caption = 'Connected to server'
    TabOrder = 2
    OnClick = CheckBox1Click
  end
  object eManagerID: TEdit
    Left = 75
    Top = 173
    Width = 158
    Height = 21
    TabOrder = 3
  end
  object eCallBackId: TEdit
    Left = 75
    Top = 200
    Width = 158
    Height = 21
    TabOrder = 4
  end
  object eManagerIDDest: TEdit
    Left = 347
    Top = 173
    Width = 158
    Height = 21
    TabOrder = 5
  end
  object eCallbackIdDest: TEdit
    Left = 347
    Top = 200
    Width = 158
    Height = 21
    TabOrder = 6
  end
  object SpinEdit1: TSpinEdit
    Left = 16
    Top = 128
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 7
    Value = 0
  end
  object Button2: TButton
    Left = 143
    Top = 126
    Width = 114
    Height = 25
    Caption = 'Send To Channel'
    TabOrder = 8
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 263
    Top = 126
    Width = 147
    Height = 25
    Caption = 'Send to specific Id'
    TabOrder = 9
    OnClick = Button3Click
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
        '.Data.DbxClientDriver,Version=20.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}'
      'DSAuthenticationUser=admin'
      'DSAuthenticationPassword=123')
    AfterConnect = SQLConnection1AfterConnect
    BeforeDisconnect = SQLConnection1BeforeDisconnect
    Left = 400
    Top = 56
    UniqueId = '{C015E74D-AB08-446C-B761-6C048E65ADC2}'
  end
  object DSClientCallbackChannelManager1: TDSClientCallbackChannelManager
    DSHostname = 'localhost'
    DSPort = '211'
    CommunicationProtocol = 'tcp/ip'
    ChannelName = 'CanalDesbravador'
    ManagerId = '989976.417368.255461'
    UserName = 'admin'
    Password = '123'
    Left = 464
    Top = 80
  end
end
