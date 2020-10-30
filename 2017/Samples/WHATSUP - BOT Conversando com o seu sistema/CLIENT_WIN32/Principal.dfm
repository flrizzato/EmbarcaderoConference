object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'SQC - Sistema de Qualquer Coisa'
  ClientHeight = 662
  ClientWidth = 949
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 643
    Width = 949
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 542
    Height = 637
    Align = alLeft
    BevelInner = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 516
      Width = 532
      Height = 116
      Align = alBottom
      BevelOuter = bvLowered
      Caption = 'Panel2'
      ShowCaption = False
      TabOrder = 0
      object Memo2: TMemo
        Left = 1
        Top = 1
        Width = 415
        Height = 114
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        Lines.Strings = (
          'Memo2')
        ParentFont = False
        TabOrder = 0
      end
      object Panel3: TPanel
        Left = 416
        Top = 1
        Width = 115
        Height = 114
        Align = alRight
        BevelOuter = bvNone
        Caption = 'Panel3'
        ShowCaption = False
        TabOrder = 1
        object Button1: TButton
          Left = 22
          Top = 8
          Width = 75
          Height = 65
          Caption = 'Button1'
          TabOrder = 0
          OnClick = Button1Click
        end
      end
    end
    object Memo1: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 87
      Width = 532
      Height = 423
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object Panel4: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 532
      Height = 76
      Align = alTop
      Caption = 'Severiiinu!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
  object MainMenu1: TMainMenu
    Left = 888
    Top = 40
    object Financeiro1: TMenuItem
      Caption = '&Financeiro'
    end
    object Estoque1: TMenuItem
      Caption = '&Estoque'
    end
    object Vendas1: TMenuItem
      Caption = '&Vendas'
    end
    object N1: TMenuItem
      Caption = '&?'
    end
  end
  object RESTClient1: TRESTClient
    BaseURL = 'https://api.dialogflow.com/v1'
    Params = <>
    HandleRedirects = True
    Left = 728
    Top = 176
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkHTTPHEADER
        name = 'Authorization'
        Options = [poDoNotEncode]
        Value = 'Bearer a37d11b5889b446ea2fd7da6e716c6fb '
      end>
    Resource = 'query'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 640
    Top = 256
  end
  object RESTResponse1: TRESTResponse
    Left = 808
    Top = 256
  end
end
