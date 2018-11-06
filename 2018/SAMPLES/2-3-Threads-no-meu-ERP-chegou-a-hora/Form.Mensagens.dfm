object frmMensagens: TfrmMensagens
  Left = 0
  Top = 0
  Caption = 'Mensagens'
  ClientHeight = 430
  ClientWidth = 706
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
  object PanelControles: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 700
    Height = 41
    Align = alTop
    TabOrder = 0
    object LabelQuantidade: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 113
      Height = 33
      Align = alLeft
      Caption = 'Quantidade de Threads'
      Layout = tlCenter
      ExplicitHeight = 13
    end
    object EditQtdTh: TEdit
      AlignWithMargins = True
      Left = 123
      Top = 11
      Width = 121
      Height = 19
      Margins.Top = 10
      Margins.Bottom = 10
      Align = alLeft
      TabOrder = 0
      TextHint = 'Default = 1'
      OnKeyDown = EditQtdThKeyDown
      ExplicitHeight = 21
    end
    object ButtonExecutar: TButton
      AlignWithMargins = True
      Left = 385
      Top = 4
      Width = 112
      Height = 33
      Align = alRight
      Caption = 'Executar'
      TabOrder = 1
      OnClick = ButtonExecutarClick
    end
    object ButtonExecutarTh: TButton
      AlignWithMargins = True
      Left = 503
      Top = 4
      Width = 112
      Height = 33
      Align = alRight
      Caption = 'Em Th'
      TabOrder = 2
      OnClick = ButtonExecutarThClick
    end
    object ButtonLimpar: TButton
      AlignWithMargins = True
      Left = 621
      Top = 4
      Width = 75
      Height = 33
      Align = alRight
      Caption = 'Limpar'
      TabOrder = 3
      OnClick = ButtonLimparClick
    end
  end
  object FlowPanelLabels: TFlowPanel
    AlignWithMargins = True
    Left = 3
    Top = 97
    Width = 460
    Height = 330
    Align = alClient
    TabOrder = 1
    ExplicitTop = 50
    ExplicitHeight = 377
  end
  object MemoLog: TMemo
    AlignWithMargins = True
    Left = 469
    Top = 97
    Width = 234
    Height = 330
    Align = alRight
    TabOrder = 2
    ExplicitTop = 50
    ExplicitHeight = 377
  end
  object PanelOption: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 50
    Width = 700
    Height = 41
    Align = alTop
    TabOrder = 3
    ExplicitLeft = 126
    object RadioButtonSemSync: TRadioButton
      Left = 4
      Top = 12
      Width = 113
      Height = 17
      Caption = 'Op'#231#227'o 1 - Sem Sync'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButtonComSync: TRadioButton
      Left = 164
      Top = 12
      Width = 149
      Height = 17
      Caption = 'Op'#231#227'o 2 - Com Sync/10'
      TabOrder = 1
    end
    object RadioButtonNovosTh: TRadioButton
      Left = 363
      Top = 12
      Width = 182
      Height = 17
      Caption = 'Op'#231#227'o 3 - Criando novos Threads'
      TabOrder = 2
    end
  end
end
