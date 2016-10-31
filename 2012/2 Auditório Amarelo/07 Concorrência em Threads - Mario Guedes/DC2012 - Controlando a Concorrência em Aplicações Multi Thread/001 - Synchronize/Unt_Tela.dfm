object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Exemplo do Uso de Synchronize'
  ClientHeight = 420
  ClientWidth = 563
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 563
    Height = 59
    Align = alTop
    BevelInner = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Button1: TButton
      Left = 11
      Top = 18
      Width = 134
      Height = 25
      Caption = 'Iniciar processamento'
      TabOrder = 0
      OnClick = Button1Click
    end
    object CheckBox1: TCheckBox
      Left = 151
      Top = 22
      Width = 122
      Height = 17
      Caption = 'Usar Synchronize'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 59
    Width = 563
    Height = 56
    Align = alTop
    Caption = 'Recurso cr'#237'tico: TGauge'
    TabOrder = 1
    object gGaugeCritico: TGauge
      Left = 3
      Top = 30
      Width = 550
      Height = 20
      Progress = 0
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 115
    Width = 563
    Height = 305
    Align = alClient
    Lines.Strings = (
      'Exemplo produzido para o Delphi Conference 2012'
      '23/10/2012'
      ''
      'M'#225'rio Guedes - mario.guedes@arrayof.com.br'
      ''
      'Este exemplo mostra a aplica'#231#227'o dos seguintes conceitos:'
      ''
      '-> Uso do Synchronize'
      '-> Evento OnTerminate da classe TThread'
      '-> Propriedade FreeOnTerminate da classe TThread'
      '-> M'#225'scara de Afinidade para Thread'
      ''
      ''
      'Observa'#231#245'es:'
      '-----------'
      ''
      '  No cen'#225'rio proposto o uso do Synchronize se mostrar pior pois'
      '  a thread de exemplo faz um uso intensivo dela o que acaba por'
      '  congelar a aplica'#231#227'o como um todo.'
      ''
      '  Apesar de aparentemente ser melhor n'#227'o usar a sincroniza'#231#227'o os'
      '  erros s'#227'o imprevis'#237'veis. Talvez nunca d'#234' erro. Talvez n'#227'o'
      '  percebamos um erro.')
    ReadOnly = True
    TabOrder = 2
  end
end
