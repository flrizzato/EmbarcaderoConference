object fFrondEnd: TfFrondEnd
  Left = 0
  Top = 0
  Caption = 'Delphi Conference 2012 - Programa'#231#227'o Baseado em Regras'
  ClientHeight = 530
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object mResultado: TMemo
    Left = 0
    Top = 97
    Width = 688
    Height = 392
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -27
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    Lines.Strings = (
      'mResultado')
    ParentFont = False
    TabOrder = 0
    WordWrap = False
    ExplicitLeft = 8
    ExplicitTop = 103
    ExplicitHeight = 373
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 97
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object Button1: TButton
      Left = 8
      Top = 56
      Width = 669
      Height = 26
      Cursor = crHandPoint
      Caption = '- Imprimir Exemplo -'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 8
      Top = 16
      Width = 129
      Height = 25
      Caption = 'Linha 000'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 143
      Top = 16
      Width = 129
      Height = 25
      Caption = 'Linha 001'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 278
      Top = 16
      Width = 129
      Height = 25
      Caption = 'Linha 002'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 413
      Top = 16
      Width = 129
      Height = 25
      Caption = 'Linha 003'
      TabOrder = 4
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 548
      Top = 16
      Width = 129
      Height = 25
      Caption = 'Linha 999'
      TabOrder = 5
      OnClick = Button6Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 489
    Width = 688
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    Caption = 'Panel2'
    Color = 8454143
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    ExplicitTop = 464
    DesignSize = (
      688
      41)
    object LinkLabel1: TLinkLabel
      Left = 8
      Top = 18
      Width = 110
      Height = 17
      Caption = 
        '<a href="http://www.embarcadero.com.br">Embarcadero do Brasil</a' +
        '>'
      TabOrder = 0
      OnLinkClick = LinkLabel1LinkClick
    end
    object LinkLabel2: TLinkLabel
      Left = 282
      Top = 10
      Width = 123
      Height = 20
      Caption = 
        '<a href="http://eugostododelphi.blogspot.com.br">Eu Gosto do Del' +
        'phi</a>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnLinkClick = LinkLabel1LinkClick
    end
    object LinkLabel3: TLinkLabel
      Left = 585
      Top = 18
      Width = 92
      Height = 17
      Anchors = [akTop, akRight]
      Caption = '<a href="www.tdstecnologiasp.com.br">TDS Tecnologia SP</a>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnLinkClick = LinkLabel1LinkClick
    end
  end
end
