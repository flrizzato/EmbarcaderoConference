object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'XData Client'
  ClientHeight = 470
  ClientWidth = 637
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
    637
    470)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 43
    Height = 13
    Caption = 'Country:'
  end
  object Label2: TLabel
    Left = 208
    Top = 16
    Width = 31
    Height = 13
    Caption = 'Years:'
  end
  object edCountry: TEdit
    Left = 57
    Top = 13
    Width = 144
    Height = 21
    TabOrder = 0
    Text = 'Bahamas'
  end
  object btSearch: TButton
    Left = 335
    Top = 11
    Width = 75
    Height = 25
    Caption = 'Search'
    TabOrder = 2
    OnClick = btSearchClick
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 42
    Width = 621
    Height = 420
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CustNo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Company'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'City'
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'State'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Country'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LastInvoiceDate'
        Width = 116
        Visible = True
      end>
  end
  object edYears: TEdit
    Left = 254
    Top = 13
    Width = 75
    Height = 21
    TabOrder = 1
    Text = '20'
  end
  object AureliusDataset1: TAureliusDataset
    FieldDefs = <>
    Left = 384
    Top = 120
  end
  object DataSource1: TDataSource
    DataSet = AureliusDataset1
    Left = 464
    Top = 120
  end
end
