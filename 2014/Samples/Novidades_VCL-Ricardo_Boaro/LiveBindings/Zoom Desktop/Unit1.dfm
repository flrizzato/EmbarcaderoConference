object Form1: TForm1
  Left = 0
  Top = 0
  ClientHeight = 382
  ClientWidth = 655
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 272
    Top = 200
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '12'
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 176
    Top = 24
    Width = 289
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = 'Delphi XE6'
  end
  object TrackBar1: TTrackBar
    Left = 176
    Top = 120
    Width = 289
    Height = 45
    Max = 30
    Min = 8
    Position = 8
    TabOrder = 2
    OnChange = TrackBar1Change
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 104
    Top = 176
    object BindExpression1: TBindExpression
      Category = 'Binding Expressions'
      ControlComponent = Edit2
      SourceComponent = Edit1
      SourceExpression = 'Text'
      ControlExpression = 'Font.Size'
      NotifyOutputs = False
      Direction = dirSourceToControl
    end
    object BindExpression2: TBindExpression
      Category = 'Binding Expressions'
      ControlComponent = Edit2
      SourceComponent = TrackBar1
      SourceExpression = 'Position'
      ControlExpression = 'Font.Size'
      NotifyOutputs = False
      Direction = dirSourceToControl
    end
    object BindExpression3: TBindExpression
      Category = 'Binding Expressions'
      ControlComponent = Edit1
      SourceComponent = TrackBar1
      SourceExpression = 'Position'
      ControlExpression = 'Text'
      NotifyOutputs = False
      Direction = dirSourceToControl
    end
  end
end
