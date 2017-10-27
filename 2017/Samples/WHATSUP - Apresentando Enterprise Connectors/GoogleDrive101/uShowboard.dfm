object fmShowboard: TfmShowboard
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'fmShowboard'
  ClientHeight = 555
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 504
    Width = 445
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    DesignSize = (
      445
      51)
    object Button1: TButton
      Left = 180
      Top = 12
      Width = 85
      Height = 25
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'I see'
      ModalResult = 11
      TabOrder = 0
      ExplicitWidth = 75
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 445
    Height = 504
    Align = alClient
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 1
  end
end
