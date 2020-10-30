object btnParallelFor: TbtnParallelFor
  Left = 0
  Top = 0
  ActiveControl = btnFor
  Caption = 'TParallel.For'
  ClientHeight = 306
  ClientWidth = 703
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    703
    306)
  PixelsPerInch = 96
  TextHeight = 23
  object btnFor: TButton
    Left = 16
    Top = 16
    Width = 177
    Height = 35
    Caption = 'for'
    TabOrder = 0
    OnClick = btnForClick
  end
  object ListBox1: TListBox
    Left = 216
    Top = 16
    Width = 473
    Height = 275
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 23
    TabOrder = 5
  end
  object btnParallelFor: TButton
    Left = 16
    Top = 56
    Width = 177
    Height = 35
    Caption = 'parallel for - good'
    TabOrder = 1
    OnClick = btnParallelForClick
  end
  object btnAsyncParallelFor: TButton
    Left = 16
    Top = 144
    Width = 177
    Height = 35
    Caption = 'async parallel for'
    TabOrder = 3
    OnClick = btnAsyncParallelForClick
  end
  object btnParalleForBad: TButton
    Left = 16
    Top = 96
    Width = 177
    Height = 35
    Caption = 'parallel for - bad'
    TabOrder = 2
    OnClick = btnParalleForBadClick
  end
  object btnParallelForException: TButton
    Left = 16
    Top = 192
    Width = 177
    Height = 35
    Caption = 'parallel for exception'
    TabOrder = 4
    OnClick = btnParallelForExceptionClick
  end
end
