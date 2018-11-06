object frmSyncWays: TfrmSyncWays
  Left = 0
  Top = 0
  Caption = 'Sync ways'
  ClientHeight = 356
  ClientWidth = 681
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
  object PanelInterlock: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 675
    Height = 41
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 582
    object LabelResultado: TLabel
      AlignWithMargins = True
      Left = 607
      Top = 4
      Width = 64
      Height = 33
      Align = alRight
      Caption = 'Ler Valor'
      OnClick = LabelResultadoClick
      ExplicitLeft = 629
      ExplicitHeight = 19
    end
    object ButtonInterlock: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 168
      Height = 33
      Align = alLeft
      Caption = 'Add - Interlock'
      TabOrder = 0
      OnClick = ButtonInterlockClick
    end
    object CheckBoxInterlock: TCheckBox
      Left = 175
      Top = 1
      Width = 97
      Height = 39
      Align = alLeft
      Caption = 'Interlock'
      TabOrder = 1
    end
  end
  object PanelCriticalSec: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 50
    Width = 675
    Height = 41
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 582
    object ButtonCriticalSec: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 168
      Height = 33
      Align = alLeft
      Caption = 'Critical Section'
      TabOrder = 0
      OnClick = ButtonCriticalSecClick
    end
  end
  object PanelErros: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 97
    Width = 675
    Height = 40
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    ExplicitWidth = 582
    object ButtonErros: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 168
      Height = 32
      Align = alLeft
      Caption = 'Erros em Th'
      TabOrder = 0
      OnClick = ButtonErrosClick
    end
    object ButtonErrosTentaTrat: TButton
      AlignWithMargins = True
      Left = 498
      Top = 4
      Width = 173
      Height = 32
      Align = alRight
      Caption = 'Tratar erros?!'
      TabOrder = 1
      Visible = False
      OnClick = ButtonErrosTentaTratClick
      ExplicitLeft = 405
    end
  end
end
