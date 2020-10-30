object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Spotify API Rest'
  ClientHeight = 546
  ClientWidth = 937
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
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 931
    Height = 121
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Login'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      931
      121)
    object Image1: TImage
      Left = 858
      Top = 14
      Width = 61
      Height = 57
      Anchors = [akTop, akRight]
      Stretch = True
      ExplicitLeft = 628
    end
    object Label1: TLabel
      Left = 712
      Top = 14
      Width = 137
      Height = 19
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Nome do usu'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 482
    end
    object Label2: TLabel
      Left = 812
      Top = 39
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Label2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 582
    end
    object Label3: TLabel
      Left = 24
      Top = 72
      Width = 31
      Height = 13
      Caption = 'OAuth'
    end
    object Label4: TLabel
      Left = 112
      Top = 71
      Width = 19
      Height = 13
      Caption = 'GET'
    end
    object Label5: TLabel
      Left = 200
      Top = 71
      Width = 19
      Height = 13
      Caption = 'GET'
    end
    object Label6: TLabel
      Left = 296
      Top = 71
      Width = 19
      Height = 13
      Caption = 'GET'
    end
    object Label7: TLabel
      Left = 384
      Top = 71
      Width = 26
      Height = 13
      Caption = 'POST'
    end
    object Label8: TLabel
      Left = 472
      Top = 71
      Width = 19
      Height = 13
      Caption = 'GET'
    end
    object Label9: TLabel
      Left = 552
      Top = 71
      Width = 19
      Height = 13
      Caption = 'PUT'
    end
    object Button1: TButton
      Left = 87
      Top = 12
      Width = 75
      Height = 53
      Caption = 'Meu Perfil'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 8
      Top = 12
      Width = 73
      Height = 54
      Caption = 'Autoriza'#231#227'o'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 168
      Top = 12
      Width = 89
      Height = 53
      Caption = 'Meus '#193'lbuns'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 263
      Top = 12
      Width = 90
      Height = 53
      Caption = 'Playlists'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 359
      Top = 13
      Width = 82
      Height = 52
      Caption = 'Adicionar Playlist'
      TabOrder = 4
      WordWrap = True
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 447
      Top = 14
      Width = 75
      Height = 51
      Caption = 'Recuperar Playlist'
      TabOrder = 5
      WordWrap = True
      OnClick = Button6Click
    end
    object Edit1: TEdit
      Left = 359
      Top = 90
      Width = 325
      Height = 21
      Alignment = taCenter
      TabOrder = 6
    end
    object Button7: TButton
      Left = 528
      Top = 14
      Width = 75
      Height = 51
      Caption = 'Editar Playlist'
      TabOrder = 7
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 609
      Top = 14
      Width = 75
      Height = 52
      Caption = 'Excluir Playlist'
      TabOrder = 8
      OnClick = Button8Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 527
    Width = 937
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 130
    Width = 931
    Height = 394
    ActivePage = TabSheet3
    Align = alClient
    Style = tsButtons
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Resultado'
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 923
        Height = 363
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Response'
      ImageIndex = 2
      object Memo3: TMemo
        Left = 0
        Top = 0
        Width = 923
        Height = 363
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Consolas'
        Font.Style = []
        Lines.Strings = (
          'Memo3')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
  object RESTClient1: TRESTClient
    Authenticator = OAuth2Authenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'https://api.spotify.com'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 436
    Top = 140
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Resource = 'v1/me'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 352
    Top = 216
  end
  object RESTResponse1: TRESTResponse
    Left = 512
    Top = 220
  end
  object OAuth2Authenticator1: TOAuth2Authenticator
    TokenType = ttBEARER
    Left = 604
    Top = 140
  end
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    DefaultPort = 9090
    OnCommandGet = IdHTTPServer1CommandGet
    Left = 60
    Top = 228
  end
  object RESTRequest2: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        name = 'offset'
        Value = '0'
      end>
    Resource = 'v1/me/tracks'
    Response = RESTResponse2
    SynchronizedEvents = False
    Left = 348
    Top = 296
  end
  object RESTResponse2: TRESTResponse
    Left = 516
    Top = 296
  end
  object RESTRequest3: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'user_id'
        Options = [poAutoCreated]
      end
      item
        name = 'offset'
        Value = '0'
      end>
    Resource = 'v1/users/{user_id}/playlists'
    Response = RESTResponse3
    SynchronizedEvents = False
    Left = 348
    Top = 380
  end
  object RESTResponse3: TRESTResponse
    ContentType = 'application/json'
    Left = 516
    Top = 380
  end
  object RESTRequest4: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'user_id'
        Options = [poAutoCreated]
      end>
    Resource = 'v1/users/{user_id}/playlists'
    Response = RESTResponse4
    SynchronizedEvents = False
    Left = 344
    Top = 456
  end
  object RESTResponse4: TRESTResponse
    Left = 520
    Top = 456
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 64
    Top = 288
  end
end
