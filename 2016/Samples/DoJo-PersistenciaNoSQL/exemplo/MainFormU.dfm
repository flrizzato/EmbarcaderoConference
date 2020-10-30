object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Form7'
  ClientHeight = 299
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 17
    Width = 235
    Height = 33
    Caption = 'Redis Autocomplete'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edtWord: TEdit
    Left = 8
    Top = 56
    Width = 273
    Height = 21
    TabOrder = 0
    OnChange = edtWordChange
    OnExit = edtWordChange
  end
  object ListBox1: TListBox
    Left = 8
    Top = 78
    Width = 273
    Height = 182
    ItemHeight = 13
    ScrollWidth = 10
    TabOrder = 1
    Visible = False
    OnKeyUp = ListBox1KeyUp
  end
end
