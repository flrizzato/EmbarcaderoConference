object frmTranslate: TfrmTranslate
  Left = 0
  Top = 0
  Caption = 'frmTranslate'
  ClientHeight = 473
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 41
    Width = 635
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 130
    ExplicitWidth = 343
  end
  object memSource: TMemo
    Left = 0
    Top = 136
    Width = 635
    Height = 89
    Align = alTop
    Lines.Strings = (
      'memSource')
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
    ExplicitLeft = 1
    ExplicitTop = 251
  end
  object memDest: TMemo
    Left = 32
    Top = 330
    Width = 479
    Height = 89
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 41
    Align = alTop
    TabOrder = 2
    ExplicitTop = -6
    object btnTraduzir: TButton
      Left = 97
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Traduzir'
      TabOrder = 0
      OnClick = btnTraduzirClick
    end
    object btnFalar: TButton
      Left = 8
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Falar'
      TabOrder = 1
      OnClick = btnFalarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 44
    Width = 635
    Height = 92
    Align = alTop
    Caption = 'Panel2'
    TabOrder = 3
    ExplicitTop = 133
    object WebBrowser: TWebBrowser
      Left = 1
      Top = 1
      Width = 633
      Height = 90
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 8
      ExplicitTop = -7
      ControlData = {
        4C000000021F0000840300000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object pgcAudio: TPageProducer
    HTMLDoc.Strings = (
      '<html>'
      '<style>'
      '  body {background-color:  #000000;}'
      '</style>'
      '<body>'
      
        '   <audio id="Fala" controls preload="auto"> --style="display: n' +
        'one"> '
      '     <source id="Teste_mp3"  type="audio/mpeg">'
      '   </audio>'
      ' </body>'
      '</html>')
    Left = 560
    Top = 168
  end
end
