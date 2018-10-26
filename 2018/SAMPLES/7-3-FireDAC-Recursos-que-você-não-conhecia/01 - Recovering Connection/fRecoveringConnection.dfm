object FrmRecoveringConnection: TFrmRecoveringConnection
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '01 - Recovering Connection'
  ClientHeight = 439
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object memLog: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 95
    Width = 394
    Height = 341
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object panTest: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 49
    Width = 394
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object chcAutoReconnect: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 192
      Height = 34
      Align = alLeft
      Caption = 'AutoReconnect'
      TabOrder = 0
    end
    object btnPing: TButton
      AlignWithMargins = True
      Left = 201
      Top = 3
      Width = 190
      Height = 34
      Align = alClient
      Caption = 'Ping'
      TabOrder = 1
      OnClick = btnPingClick
    end
  end
  object panConnection: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 394
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    object btnConnect: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 190
      Height = 34
      Align = alLeft
      Caption = 'Connect'
      TabOrder = 0
      OnClick = btnConnectClick
    end
    object btnDisconnect: TButton
      AlignWithMargins = True
      Left = 201
      Top = 3
      Width = 190
      Height = 34
      Align = alRight
      Caption = 'Disconnect'
      TabOrder = 1
      OnClick = btnDisconnectClick
    end
  end
  object Connection: TFDConnection
    Params.Strings = (
      
        'Database=C:\ECON2018\7-3-FireDAC-Recursos-que-voc'#234'-n'#227'o-conhecia\' +
        '00 - DB\ECON2018.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=local'
      'Server=127.0.0.1'
      'DriverID=FB')
    LoginPrompt = False
    OnLost = ConnectionLost
    OnRestored = ConnectionRestored
    OnRecover = ConnectionRecover
    AfterConnect = ConnectionAfterConnect
    BeforeConnect = ConnectionBeforeConnect
    AfterDisconnect = ConnectionAfterDisconnect
    Left = 184
    Top = 216
  end
end
