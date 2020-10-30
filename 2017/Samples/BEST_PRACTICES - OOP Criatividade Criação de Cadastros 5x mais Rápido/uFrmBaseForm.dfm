object FrmBaseForm: TFrmBaseForm
  Left = 131
  Top = 93
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderIcons = [biMinimize]
  BorderStyle = bsToolWindow
  Caption = 'FrmBaseForm'
  ClientHeight = 388
  ClientWidth = 599
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object FadeIn: TTimer
    Enabled = False
    Interval = 10
    OnTimer = FadeInTimer
    Left = 28
    Top = 16
  end
  object FadeOut: TTimer
    Enabled = False
    Interval = 10
    OnTimer = FadeOutTimer
    Left = 78
    Top = 16
  end
end
