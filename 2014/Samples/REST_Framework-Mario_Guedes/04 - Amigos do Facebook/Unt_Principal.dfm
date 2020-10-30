object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'EC2014 :: REST Framework :: Consumindo a API do Facebook'
  ClientHeight = 555
  ClientWidth = 907
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 536
    Width = 907
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 901
    Height = 81
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Panel1'
    Color = clWhite
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      901
      81)
    object Label1: TLabel
      Left = 820
      Top = 40
      Width = 69
      Height = 25
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 8
      Top = 10
      Width = 75
      Height = 55
      Caption = 'Processar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object eAccessToken: TEdit
      Left = 104
      Top = 13
      Width = 785
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Text = 
        'CAACEdEose0cBAAABXh3xBihUDBrIbfk4lXoZACwpHWv3eLeZBieDPZAJLevvbQP' +
        'Y6Y3c6j6HMILLYwxHqBrAeQcJ4i2pZANxd2DqYr5kexdy2abPpuYyorAZCYMGv28' +
        '7zmVWOHsvrYgos7LCS2vxWrpd8aAPwaHyYJYf8KtKvxII3x3SjlihZAZA1qu2Ncn' +
        'Knh26vteInKMRsqJiXqi5ZAea'
      TextHint = 'Coloque aqui o ACCESS TOKEN'
    end
  end
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 90
    Width = 901
    Height = 443
    Align = alClient
    Color = clInfoBk
    DrawingStyle = gdsGradient
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
