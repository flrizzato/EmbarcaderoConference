object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 551
  ClientWidth = 627
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 23
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 612
    Height = 41
    Caption = 'Listar Tabelas (FDConnection)'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 8
    Top = 55
    Width = 300
    Height = 137
    ItemHeight = 23
    TabOrder = 1
    OnClick = ListBox1Click
  end
  object ListBox2: TListBox
    Left = 320
    Top = 55
    Width = 300
    Height = 137
    ItemHeight = 23
    TabOrder = 2
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 245
    Width = 611
    Height = 144
    DataSource = DataSource1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -19
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button2: TButton
    Left = 8
    Top = 198
    Width = 612
    Height = 41
    Caption = 'Listar Tabelas (FDMetaInfoQuery)'
    TabOrder = 4
    OnClick = Button2Click
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 395
    Width = 611
    Height = 148
    DataSource = DataSource2
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -19
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Conexao: TFDConnection
    Params.Strings = (
      'MetaDefCatalog=*'
      'MetaDefSchema=*'
      'ConnectionDef=CursoFireDAC')
    Connected = True
    LoginPrompt = False
    Left = 135
    Top = 288
  end
  object FDMetaInfoQuery1: TFDMetaInfoQuery
    AfterScroll = FDMetaInfoQuery1AfterScroll
    Connection = Conexao
    Left = 280
    Top = 280
    object FDMetaInfoQuery1RECNO: TIntegerField
      FieldName = 'RECNO'
      ReadOnly = True
    end
    object FDMetaInfoQuery1CATALOG_NAME: TWideStringField
      FieldName = 'CATALOG_NAME'
      ReadOnly = True
      Visible = False
      Size = 128
    end
    object FDMetaInfoQuery1SCHEMA_NAME: TWideStringField
      FieldName = 'SCHEMA_NAME'
      ReadOnly = True
      Visible = False
      Size = 128
    end
    object FDMetaInfoQuery1TABLE_NAME: TWideStringField
      FieldName = 'TABLE_NAME'
      ReadOnly = True
      Size = 128
    end
    object FDMetaInfoQuery1TABLE_TYPE: TIntegerField
      FieldName = 'TABLE_TYPE'
      ReadOnly = True
    end
    object FDMetaInfoQuery1TABLE_SCOPE: TIntegerField
      FieldName = 'TABLE_SCOPE'
      ReadOnly = True
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMetaInfoQuery1
    Left = 280
    Top = 328
  end
  object FDMetaInfoQuery2: TFDMetaInfoQuery
    Connection = Conexao
    MetaInfoKind = mkTableFields
    Left = 416
    Top = 280
    object FDMetaInfoQuery2RECNO: TIntegerField
      FieldName = 'RECNO'
      ReadOnly = True
      Visible = False
    end
    object FDMetaInfoQuery2CATALOG_NAME: TWideStringField
      FieldName = 'CATALOG_NAME'
      ReadOnly = True
      Visible = False
      Size = 128
    end
    object FDMetaInfoQuery2SCHEMA_NAME: TWideStringField
      FieldName = 'SCHEMA_NAME'
      ReadOnly = True
      Visible = False
      Size = 128
    end
    object FDMetaInfoQuery2TABLE_NAME: TWideStringField
      FieldName = 'TABLE_NAME'
      ReadOnly = True
      Visible = False
      Size = 128
    end
    object FDMetaInfoQuery2COLUMN_NAME: TWideStringField
      FieldName = 'COLUMN_NAME'
      ReadOnly = True
      Size = 128
    end
    object FDMetaInfoQuery2COLUMN_POSITION: TIntegerField
      FieldName = 'COLUMN_POSITION'
      ReadOnly = True
    end
    object FDMetaInfoQuery2COLUMN_DATATYPE: TIntegerField
      FieldName = 'COLUMN_DATATYPE'
      ReadOnly = True
    end
    object FDMetaInfoQuery2COLUMN_TYPENAME: TWideStringField
      FieldName = 'COLUMN_TYPENAME'
      ReadOnly = True
      Size = 128
    end
    object FDMetaInfoQuery2COLUMN_ATTRIBUTES: TLongWordField
      FieldName = 'COLUMN_ATTRIBUTES'
      ReadOnly = True
    end
    object FDMetaInfoQuery2COLUMN_PRECISION: TIntegerField
      FieldName = 'COLUMN_PRECISION'
      ReadOnly = True
    end
    object FDMetaInfoQuery2COLUMN_SCALE: TIntegerField
      FieldName = 'COLUMN_SCALE'
      ReadOnly = True
    end
    object FDMetaInfoQuery2COLUMN_LENGTH: TIntegerField
      FieldName = 'COLUMN_LENGTH'
      ReadOnly = True
    end
  end
  object DataSource2: TDataSource
    DataSet = FDMetaInfoQuery2
    Left = 416
    Top = 328
  end
end
