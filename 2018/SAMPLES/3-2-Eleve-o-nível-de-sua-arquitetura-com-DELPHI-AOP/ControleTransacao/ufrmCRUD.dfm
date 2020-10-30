object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Transactional Aspect'
  ClientHeight = 245
  ClientWidth = 763
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 11
    Height = 13
    Caption = 'ID'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 39
    Height = 13
    Caption = 'Campo1'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 8
    Top = 88
    Width = 39
    Height = 13
    Caption = 'Campo2'
    FocusControl = DBEdit3
  end
  object Memo1: TMemo
    Left = 284
    Top = 0
    Width = 479
    Height = 245
    Align = alRight
    TabOrder = 0
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 24
    Width = 134
    Height = 21
    DataField = 'ID'
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBEdit2: TDBEdit
    Left = 8
    Top = 64
    Width = 264
    Height = 21
    DataField = 'Campo1'
    DataSource = DataSource1
    TabOrder = 2
  end
  object DBEdit3: TDBEdit
    Left = 8
    Top = 104
    Width = 264
    Height = 21
    DataField = 'Campo2'
    DataSource = DataSource1
    TabOrder = 3
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 131
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 4
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 176
    object FDMemTable1ID: TIntegerField
      FieldName = 'ID'
    end
    object FDMemTable1Campo1: TStringField
      FieldName = 'Campo1'
      Size = 250
    end
    object FDMemTable1Campo2: TStringField
      FieldName = 'Campo2'
      Size = 250
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 104
    Top = 176
  end
end
