object frmExternos: TfrmExternos
  Left = 0
  Top = 0
  Caption = 'Externos'
  ClientHeight = 426
  ClientWidth = 745
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
  object PanelSalvaArq: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 739
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 160
    ExplicitTop = 128
    ExplicitWidth = 185
    object ButtonSalvaArq: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 173
      Height = 33
      Align = alLeft
      Caption = 'Salvar Arquivos'
      TabOrder = 0
    end
  end
  object PanelCarregaArq: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 50
    Width = 739
    Height = 41
    Align = alTop
    TabOrder = 1
    ExplicitLeft = 4
    ExplicitTop = 0
    ExplicitWidth = 731
    object ButtonCarregaArq: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 173
      Height = 33
      Align = alLeft
      Caption = 'Carrega Arquivos'
      TabOrder = 0
    end
  end
end
