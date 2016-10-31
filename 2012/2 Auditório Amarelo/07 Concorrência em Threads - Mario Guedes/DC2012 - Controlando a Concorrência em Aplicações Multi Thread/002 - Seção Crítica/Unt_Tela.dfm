object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Exemplo de Utiliza'#231#227'o de Se'#231#227'o Cr'#237'tica'
  ClientHeight = 443
  ClientWidth = 504
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 504
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Iniciar Pilha'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 89
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cliente A'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 170
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cliente B'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 251
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cliente C'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 332
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cliente D'
      TabOrder = 4
      OnClick = Button5Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 424
    Width = 504
    Height = 19
    Panels = <>
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 504
    Height = 88
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 17
      Width = 69
      Height = 25
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 56
      Width = 69
      Height = 25
      Caption = 'Label2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 129
    Width = 504
    Height = 295
    Align = alClient
    Lines.Strings = (
      'Exemplo produzido para o Delphi Conference 2012'
      '23/10/2012'
      ''
      'M'#225'rio Guedes - mario.guedes@arrayof.com.br'
      ''
      'Este exemplo mostra a aplica'#231#227'o dos seguintes conceitos:'
      ''
      '-> Uso do TCriticalSection'
      '-> Maneira correta de finalizar uma thread'
      '   -> Terminate'
      '   -> WaitFor'
      '-> Fila de objetos gen'#233'rica (FIFO)'
      ''
      '')
    ReadOnly = True
    TabOrder = 3
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 272
    Top = 96
  end
end
