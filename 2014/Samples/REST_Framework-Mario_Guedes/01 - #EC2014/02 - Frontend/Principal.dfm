object fPrincipal: TfPrincipal
  Left = 0
  Top = 0
  Caption = 'Monitora'#231#227'o em Tempo Real do Twitter'
  ClientHeight = 528
  ClientWidth = 979
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 973
    Height = 73
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Panel1'
    Color = clWhite
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    ExplicitWidth = 885
    DesignSize = (
      973
      73)
    object Label2: TLabel
      Left = 809
      Top = 16
      Width = 147
      Height = 39
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = '#EC2014'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 727
    end
    object Label3: TLabel
      Left = 8
      Top = 16
      Width = 587
      Height = 19
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Exemplo descaradamente copiado do Luis Cipriani @lfcipriani'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 499
    end
    object Label1: TLabel
      Left = 89
      Top = 44
      Width = 302
      Height = 16
      Caption = '*Se o se perfil for privado n'#227'o aparecer'#225' aqui.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lQuantidade: TLabel
      Left = 552
      Top = 16
      Width = 195
      Height = 39
      Caption = 'lQuantidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 8
      Top = 41
      Width = 75
      Height = 25
      Caption = '&Ativar'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object fpStreaming: TFlowPanel
    AlignWithMargins = True
    Left = 3
    Top = 82
    Width = 973
    Height = 443
    Align = alClient
    BevelInner = bvLowered
    Caption = 'fpStreaming'
    Locked = True
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ShowCaption = False
    TabOrder = 1
    ExplicitWidth = 885
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
    Left = 116
    Top = 108
  end
end
