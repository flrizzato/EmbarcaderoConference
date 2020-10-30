object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 258
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 23
  object Label1: TLabel
    Left = 16
    Top = 80
    Width = 54
    Height = 23
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 16
    Top = 24
    Width = 105
    Height = 33
    Caption = 'Normal'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 152
    Width = 281
    Height = 31
    TabOrder = 1
    Text = 'Edit1'
  end
  object Button2: TButton
    Left = 144
    Top = 24
    Width = 113
    Height = 33
    Caption = 'Task'
    TabOrder = 2
    OnClick = Button2Click
  end
end
