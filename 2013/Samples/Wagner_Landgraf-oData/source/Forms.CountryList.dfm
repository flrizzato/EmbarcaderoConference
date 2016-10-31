object CountriesForm: TCountriesForm
  Left = 0
  Top = 0
  Caption = 'CountriesForm'
  ClientHeight = 243
  ClientWidth = 257
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 8
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 39
    Width = 240
    Height = 196
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Name'
        Width = 148
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CountryCode'
        Width = 53
        Visible = True
      end>
  end
  object CountriesDataset: TAureliusDataset
    FieldDefs = <
      item
        Name = 'Self'
        Attributes = [faReadonly]
        DataType = ftVariant
      end
      item
        Name = 'Id'
        Attributes = [faReadonly, faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Name'
        Attributes = [faRequired]
        DataType = ftString
        Size = 255
      end
      item
        Name = 'CountryCode'
        DataType = ftInteger
      end>
    Left = 144
    Top = 168
    object CountriesDatasetSelf: TAureliusEntityField
      FieldName = 'Self'
      ReadOnly = True
      Visible = False
    end
    object CountriesDatasetId: TIntegerField
      FieldName = 'Id'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object CountriesDatasetName: TStringField
      FieldName = 'Name'
      Required = True
      Size = 255
    end
    object CountriesDatasetCountryCode: TIntegerField
      DisplayLabel = 'Code'
      FieldName = 'CountryCode'
    end
  end
  object DataSource1: TDataSource
    DataSet = CountriesDataset
    Left = 48
    Top = 168
  end
end
