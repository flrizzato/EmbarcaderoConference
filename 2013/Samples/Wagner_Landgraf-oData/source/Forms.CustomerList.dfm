object CustomersForm: TCustomersForm
  Left = 0
  Top = 0
  Caption = 'Customers'
  ClientHeight = 480
  ClientWidth = 622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    622
    480)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 520
    Top = 240
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 39
    Width = 607
    Height = 282
    Anchors = [akLeft, akTop, akRight]
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Name'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'City'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'State'
        Visible = True
      end
      item
        DropDownRows = 2
        Expanded = False
        FieldName = 'CustomerType.EnumName'
        PickList.Strings = (
          'Individual'
          'Store')
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CountryLookup'
        Width = 120
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 8
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 358
    Width = 670
    Height = 114
    DataSource = DataSource2
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Name'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Phone'
        Width = 150
        Visible = True
      end>
  end
  object DBNavigator2: TDBNavigator
    Left = 8
    Top = 327
    Width = 240
    Height = 25
    DataSource = DataSource2
    TabOrder = 3
  end
  object CustomersDataset: TAureliusDataset
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
        Name = 'City'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'State'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Country'
        DataType = ftVariant
      end
      item
        Name = 'CustomerType'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Contacts'
        Attributes = [faReadonly]
        DataType = ftDataSet
      end>
    Left = 320
    Top = 152
    object CustomersDatasetSelf: TAureliusEntityField
      FieldName = 'Self'
      ReadOnly = True
      Visible = False
    end
    object CustomersDatasetId: TIntegerField
      DisplayWidth = 5
      FieldName = 'Id'
      ReadOnly = True
      Required = True
    end
    object CustomersDatasetName: TStringField
      DisplayWidth = 25
      FieldName = 'Name'
      Required = True
      Size = 255
    end
    object CustomersDatasetCity: TStringField
      DisplayWidth = 20
      FieldName = 'City'
      Required = True
      Size = 255
    end
    object CustomersDatasetState: TStringField
      DisplayWidth = 5
      FieldName = 'State'
      Size = 255
    end
    object CustomersDatasetCountry: TAureliusEntityField
      FieldName = 'Country'
      Visible = False
    end
    object CustomersDatasetCustomerType: TIntegerField
      FieldName = 'CustomerType'
      Visible = False
    end
    object CustomersDatasetCustomerTypeEnumName: TStringField
      DisplayLabel = 'CustomerType'
      DisplayWidth = 15
      FieldName = 'CustomerType.EnumName'
      Size = 30
    end
    object CustomersDatasetCountryName: TStringField
      DisplayLabel = 'Country Name'
      DisplayWidth = 15
      FieldName = 'Country.Name'
      Size = 30
    end
    object CustomersDatasetCountryLookup: TStringField
      DisplayLabel = 'Country'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'CountryLookup'
      LookupDataSet = CountriesDataset
      LookupKeyFields = 'Self'
      LookupResultField = 'Name'
      KeyFields = 'Country'
      Size = 30
      Lookup = True
    end
    object CustomersDatasetContacts: TDataSetField
      FieldName = 'Contacts'
      ReadOnly = True
    end
  end
  object DataSource1: TDataSource
    DataSet = CustomersDataset
    Left = 224
    Top = 153
  end
  object CountriesDataset: TAureliusDataset
    FieldDefs = <>
    Left = 424
    Top = 152
  end
  object ContactsDataset: TAureliusDataset
    DatasetField = CustomersDatasetContacts
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
        Name = 'Phone'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Customer'
        DataType = ftVariant
      end>
    Left = 312
    Top = 400
    object ContactsDatasetSelf: TAureliusEntityField
      FieldName = 'Self'
      ReadOnly = True
    end
    object ContactsDatasetId: TIntegerField
      FieldName = 'Id'
      ReadOnly = True
      Required = True
    end
    object ContactsDatasetName: TStringField
      FieldName = 'Name'
      Required = True
      Size = 255
    end
    object ContactsDatasetPhone: TStringField
      FieldName = 'Phone'
      Size = 255
    end
    object ContactsDatasetCustomer: TAureliusEntityField
      FieldName = 'Customer'
    end
  end
  object DataSource2: TDataSource
    DataSet = ContactsDataset
    Left = 216
    Top = 400
  end
end
