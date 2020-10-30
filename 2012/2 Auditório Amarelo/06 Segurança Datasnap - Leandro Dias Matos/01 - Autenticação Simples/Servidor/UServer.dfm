object frmServer: TfrmServer
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Servidor DataSnap - Autentica'#231#227'o'
  ClientHeight = 183
  ClientWidth = 396
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
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 396
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    BorderStyle = bsSingle
    Caption = 'Autentica'#231#227'o -> "DSServer"'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object pnlClient: TPanel
    Left = 0
    Top = 41
    Width = 396
    Height = 142
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
    object lblProtocolo: TLabel
      Left = 184
      Top = 6
      Width = 92
      Height = 16
      AutoSize = False
      Caption = '000.000.0.000'
      Color = clHotLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label1: TLabel
      Left = 19
      Top = 6
      Width = 135
      Height = 16
      Caption = 'Protocolo do Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 19
      Top = 40
      Width = 144
      Height = 16
      Caption = 'IP da Maquina Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblIP: TLabel
      Left = 184
      Top = 40
      Width = 92
      Height = 16
      Caption = '000.000.0.000'
      Color = clHotLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblAcesso: TLabel
      Left = 184
      Top = 75
      Width = 92
      Height = 16
      Caption = '000.000.0.000'
      Color = clHotLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblSessao: TLabel
      Left = 184
      Top = 110
      Width = 92
      Height = 16
      Caption = '000.000.0.000'
      Color = clHotLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label4: TLabel
      Left = 19
      Top = 110
      Width = 89
      Height = 16
      Caption = 'ID da Sess'#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 19
      Top = 75
      Width = 61
      Height = 16
      Caption = 'Liberado:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DSServer: TDSServer
    OnConnect = DSServerConnect
    Left = 320
    Top = 48
  end
  object DSTCPServerTransport: TDSTCPServerTransport
    Server = DSServer
    Filters = <>
    Left = 320
    Top = 104
  end
end
