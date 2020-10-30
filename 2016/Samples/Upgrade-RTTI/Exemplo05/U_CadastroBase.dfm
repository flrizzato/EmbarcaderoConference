object F_CadastroBase: TF_CadastroBase
  Left = 0
  Top = 0
  Caption = 'Formulario Base'
  ClientHeight = 291
  ClientWidth = 526
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
    Top = 250
    Width = 526
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      AlignWithMargins = True
      Left = 432
      Top = 3
      Width = 91
      Height = 35
      Align = alRight
      Caption = 'Sair'
      TabOrder = 0
      OnClick = BitBtn1Click
      ExplicitLeft = 431
    end
    object BitBtn2: TBitBtn
      AlignWithMargins = True
      Left = 335
      Top = 3
      Width = 91
      Height = 35
      Align = alRight
      Caption = 'Salvar'
      TabOrder = 1
      OnClick = BitBtn2Click
      ExplicitLeft = 333
    end
  end
end
