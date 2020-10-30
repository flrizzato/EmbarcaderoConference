object Form1: TForm1
  Left = 127
  Top = 92
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsNone
  Caption = 'FISH FACTS'
  ClientHeight = 558
  ClientWidth = 755
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -19
  Font.Name = 'Segoe UI Light'
  Font.Style = []
  OldCreateOrder = True
  ShowHint = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 25
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 755
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 265
    ExplicitTop = 58
    ExplicitWidth = 335
    object Label1: TLabel
      Left = 5
      Top = 4
      Width = 56
      Height = 13
      Caption = 'About the'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBLabel2: TDBText
      Left = 67
      Top = 4
      Width = 99
      Height = 13
      AutoSize = True
      DataField = 'Common_Name'
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 755
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 637
    DesignSize = (
      755
      49)
    object lbStyle: TLabel
      Left = 8
      Top = 11
      Width = 105
      Height = 25
      Caption = 'Change Style'
    end
    object cbStyles: TComboBox
      Left = 127
      Top = 8
      Width = 218
      Height = 33
      TabOrder = 0
      Text = 'cbStyles'
      OnClick = cbStylesClick
    end
    object Button1: TButton
      Left = 640
      Top = 18
      Width = 99
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 71
    Width = 755
    Height = 202
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 637
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 259
      Height = 202
      Hint = 'Scroll grid below to see other fish'
      Align = alLeft
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      ExplicitLeft = 8
      ExplicitHeight = 250
      object DBLabel1: TDBText
        Left = 4
        Top = 183
        Width = 249
        Height = 24
        DataField = 'Common_Name'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -19
        Font.Name = 'MS Serif'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object DBImage1: TDBImage
        Left = 1
        Top = 1
        Width = 257
        Height = 200
        Hint = 'Scroll grid below to see other fish'
        Align = alClient
        DataField = 'Graphic'
        DataSource = DataSource1
        TabOrder = 0
        ExplicitLeft = -5
        ExplicitWidth = 259
        ExplicitHeight = 250
      end
    end
    object Panel6: TPanel
      Left = 259
      Top = 0
      Width = 496
      Height = 202
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 1
      ExplicitLeft = 265
      ExplicitTop = 85
      ExplicitWidth = 336
      ExplicitHeight = 193
      object DBMemo1: TDBMemo
        Left = 1
        Top = 1
        Width = 494
        Height = 200
        Align = alClient
        BorderStyle = bsNone
        Color = clSilver
        Ctl3D = False
        DataField = 'Notes'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitLeft = 0
        ExplicitTop = 6
        ExplicitWidth = 376
        ExplicitHeight = 248
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 273
    Width = 755
    Height = 285
    Hint = 'Scroll up/down to see other fish!'
    Align = alClient
    Ctl3D = True
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'CATEGORY'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SPECIES_NAME'
        Width = 255
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LENGTH__CM_'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LENGTH_IN'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMMON_NAME'
        Width = 700
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    DataSet = IBTable1
    Left = 115
    Top = 121
  end
  object IBTable1: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction1
    Active = True
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'SPECIES_NO'
        DataType = ftFloat
      end
      item
        Name = 'CATEGORY'
        DataType = ftWideString
        Size = 15
      end
      item
        Name = 'COMMON_NAME'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'SPECIES_NAME'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'LENGTH__CM_'
        DataType = ftFloat
      end
      item
        Name = 'LENGTH_IN'
        DataType = ftFloat
      end
      item
        Name = 'NOTES'
        DataType = ftWideMemo
        Size = 8
      end
      item
        Name = 'GRAPHIC'
        DataType = ftBlob
        Size = 8
      end>
    IndexDefs = <
      item
        Name = 'BIOLIFE0'
        Fields = 'SPECIES_NO'
        Options = [ixUnique]
      end>
    ReadOnly = True
    StoreDefs = True
    TableName = 'BIOLIFE'
    UniDirectional = False
    Left = 48
    Top = 120
    object IBTable1CATEGORY: TIBStringField
      DisplayLabel = 'Category'
      FieldName = 'CATEGORY'
      Size = 15
    end
    object IBTable1SPECIES_NAME: TIBStringField
      DisplayLabel = 'Species Name'
      FieldName = 'SPECIES_NAME'
      Size = 40
    end
    object IBTable1LENGTH__CM_: TFloatField
      DisplayLabel = 'Length (cm)'
      FieldName = 'LENGTH__CM_'
    end
    object IBTable1LENGTH_IN: TFloatField
      DisplayLabel = 'Length_In'
      FieldName = 'LENGTH_IN'
      DisplayFormat = '0.00'
    end
    object IBTable1COMMON_NAME: TIBStringField
      DisplayLabel = 'Common Name'
      FieldName = 'COMMON_NAME'
      Size = 30
    end
    object IBTable1NOTES: TMemoField
      DisplayLabel = 'Notes'
      FieldName = 'NOTES'
      BlobType = ftMemo
      Size = 8
    end
    object IBTable1GRAPHIC: TBlobField
      DisplayLabel = 'Graphic'
      FieldName = 'GRAPHIC'
      Size = 8
    end
  end
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = 
      'C:\Users\Administrador\Documents\RAD Studio\10.0\Samples\Data\db' +
      'demos.gdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    ServerType = 'IBServer'
    Left = 48
    Top = 64
  end
  object IBTransaction1: TIBTransaction
    Active = True
    DefaultDatabase = IBDatabase1
    Left = 112
    Top = 64
  end
end
