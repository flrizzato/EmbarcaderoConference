object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 363
  Height = 182
  Color = clBtnFace
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object Image1: TImage
    Left = 10
    Top = 3
    Width = 65
    Height = 57
  end
  object Label1: TLabel
    Left = 88
    Top = 27
    Width = 89
    Height = 33
    Caption = 'Label1'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Memo1: TMemo
    Left = 10
    Top = 66
    Width = 343
    Height = 103
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Andale Sans for VST'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 0
  end
  object Timer1: TTimer
    Interval = 30000
    OnTimer = Timer1Timer
    Left = 248
    Top = 16
  end
end
