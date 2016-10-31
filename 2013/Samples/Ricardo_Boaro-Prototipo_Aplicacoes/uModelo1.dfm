object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 487
  ClientWidth = 820
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Tag = 9
    Left = 0
    Top = 160
    Width = 820
    Height = 327
    Align = alBottom
    ColCount = 9
    FixedCols = 0
    RowCount = 201
    TabOrder = 0
    ColWidths = (
      64
      64
      64
      64
      64
      64
      64
      64
      64)
  end
  object NavigatorPrototypeBindSource1: TBindNavigator
    Left = 0
    Top = 0
    Width = 820
    Height = 25
    DataSource = PrototypeBindSource1
    Align = alTop
    Orientation = orHorizontal
    TabOrder = 1
    ExplicitLeft = 280
    ExplicitTop = 40
    ExplicitWidth = 240
  end
  object PrototypeBindSource1: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Bitmap1'
        FieldType = ftBitmap
        Generator = 'Bitmaps'
        ReadOnly = False
      end
      item
        Name = 'BoolField1'
        FieldType = ftBoolean
        Generator = 'Booleans'
        ReadOnly = False
      end
      item
        Name = 'Color1'
        FieldType = ftUInteger
        Generator = 'Colors'
        ReadOnly = False
      end
      item
        Name = 'ColorsName1'
        Generator = 'ColorsNames'
        ReadOnly = False
      end
      item
        Name = 'ContactBitmapL1'
        FieldType = ftBitmap
        Generator = 'ContactBitmapsL'
        ReadOnly = False
      end
      item
        Name = 'ContactName1'
        Generator = 'ContactNames'
        ReadOnly = False
      end
      item
        Name = 'ContactTitle1'
        Generator = 'ContactTitles'
        ReadOnly = False
      end
      item
        Name = 'CurrencyField1'
        FieldType = ftCurrency
        Generator = 'Currency'
        ReadOnly = False
      end
      item
        Name = 'DateField1'
        FieldType = ftDate
        Generator = 'Date'
        ReadOnly = False
      end>
    ScopeMappings = <>
    Left = 56
    Top = 16
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 20
    Top = 5
    object LinkGridToDataSourcePrototypeBindSource1: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = PrototypeBindSource1
      GridControl = StringGrid1
      AutoBufferCount = False
      Columns = <>
    end
  end
end
