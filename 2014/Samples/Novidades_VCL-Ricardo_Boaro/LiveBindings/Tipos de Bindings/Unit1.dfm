object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 448
  ClientWidth = 706
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BindNavigator1: TBindNavigator
    Left = 48
    Top = 48
    Width = 240
    Height = 25
    Orientation = orHorizontal
    TabOrder = 0
  end
  object BindSourceDB1: TBindSourceDB
    ScopeMappings = <>
    Left = 200
    Top = 256
  end
  object PrototypeBindSource1: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <>
    ScopeMappings = <>
    Left = 344
    Top = 256
  end
  object BindSourceDBX1: TBindSourceDBX
    SubSQLDataSet.Params = <>
    SubClientDataSet.Aggregates = <>
    SubClientDataSet.Params = <>
    ScopeMappings = <>
    Left = 456
    Top = 320
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 104
    Top = 296
  end
  object AdapterBindSource1: TAdapterBindSource
    AutoActivate = True
    ScopeMappings = <>
    Left = 568
    Top = 256
  end
end
