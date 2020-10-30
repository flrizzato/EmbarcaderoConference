object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'JumpList'
  ClientHeight = 438
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 104
    Width = 418
    Height = 334
    Align = alBottom
    ItemHeight = 13
    TabOrder = 0
  end
  object JumpList1: TJumpList
    AutoRefresh = True
    Enabled = True
    ApplicationID = 'JumpListAppID'
    CustomCategories = <
      item
        CategoryName = 'Dropped Files'
        Items = <
          item
            FriendlyName = 'Sample'
            Arguments = 'SampleParameters'
          end
          item
            FriendlyName = 'Segundo'
            Arguments = 'SegundoParametro'
          end>
      end>
    ShowRecent = True
    ShowFrequent = True
    TaskList = <>
    Left = 32
    Top = 32
  end
end
