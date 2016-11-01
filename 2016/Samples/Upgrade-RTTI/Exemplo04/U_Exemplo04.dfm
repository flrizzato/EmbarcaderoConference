object F_Exemplo04: TF_Exemplo04
  Left = 0
  Top = 0
  Caption = 'Exemplo04 - Gerador de Documentos'
  ClientHeight = 396
  ClientWidth = 654
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 648
    Height = 41
    Align = alTop
    TabOrder = 0
    object btnGerarDocto: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 640
      Height = 33
      Align = alClient
      Caption = 'Gerar Documento'
      TabOrder = 0
      OnClick = btnGerarDoctoClick
    end
  end
  object MDocumento: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 50
    Width = 648
    Height = 343
    Align = alClient
    TabOrder = 1
  end
end
