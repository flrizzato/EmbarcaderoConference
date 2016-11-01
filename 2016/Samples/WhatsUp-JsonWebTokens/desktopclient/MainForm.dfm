object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Client using JWT'
  ClientHeight = 250
  ClientWidth = 368
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
    368
    250)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 97
    Height = 25
    Caption = 'List Artists'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 39
    Width = 352
    Height = 203
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Name'
        Width = 303
        Visible = True
      end>
  end
  object edUser: TComboBox
    Left = 159
    Top = 10
    Width = 57
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 1
    Text = 'user'
    OnChange = edUserChange
    Items.Strings = (
      'user'
      'admin')
    ExplicitLeft = 287
  end
  object edPassword: TEdit
    Left = 222
    Top = 10
    Width = 57
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 2
    Text = 'user'
    ExplicitLeft = 350
  end
  object Button2: TButton
    Left = 285
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Login'
    TabOrder = 3
    OnClick = Button2Click
    ExplicitLeft = 413
  end
  object DataSource1: TDataSource
    DataSet = AureliusDataset1
    Left = 232
    Top = 152
  end
  object AureliusDataset1: TAureliusDataset
    FieldDefs = <>
    OnObjectInsert = AureliusDataset1ObjectInsert
    OnObjectUpdate = AureliusDataset1ObjectUpdate
    OnObjectRemove = AureliusDataset1ObjectRemove
    CreateSelfField = False
    IncludeUnmappedObjects = False
    Left = 152
    Top = 152
  end
end
