object FormParallelFor: TFormParallelFor
  Left = 206
  Top = 147
  Width = 437
  Height = 496
  HorzScrollBar.Range = 44
  HorzScrollBar.Tracking = True
  VertScrollBar.Range = 89
  Caption = 'ParallelFor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object btnPlainForLoop: TButton
    Left = 24
    Top = 24
    Width = 185
    Height = 25
    Caption = 'btnPlainForLoop'
    TabOrder = 0
    OnClick = btnPlainForLoopClick
  end
  object Memo1: TMemo
    Left = 24
    Top = 64
    Width = 376
    Height = 369
    TabOrder = 1
  end
  object btnParallelForLoop: TButton
    Left = 215
    Top = 24
    Width = 185
    Height = 25
    Caption = 'btnParallelForLoop'
    TabOrder = 2
    OnClick = btnParallelForLoopClick
  end
end
