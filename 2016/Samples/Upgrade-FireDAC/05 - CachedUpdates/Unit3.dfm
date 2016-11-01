object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'CachedUpdates'
  ClientHeight = 515
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 632
    Top = 23
    Width = 54
    Height = 23
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 712
    Top = 23
    Width = 54
    Height = 23
    Caption = 'Label2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 0
    Width = 593
    Height = 193
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 207
    Width = 336
    Height = 25
    DataSource = DataSource1
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh, nbApplyUpdates, nbCancelUpdates]
    TabOrder = 1
  end
  object Button1: TButton
    Left = 439
    Top = 207
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 526
    Top = 207
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button2Click
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 280
    Width = 601
    Height = 217
    DataSource = DataSource2
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button3: TButton
    Left = 350
    Top = 207
    Width = 75
    Height = 25
    Caption = 'Delta'
    TabOrder = 5
    OnClick = Button3Click
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 248
    Width = 97
    Height = 17
    Caption = 'Inser'#231#227'o'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object CheckBox2: TCheckBox
    Left = 128
    Top = 248
    Width = 97
    Height = 17
    Caption = 'Modifica'#231#227'o'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object CheckBox3: TCheckBox
    Left = 240
    Top = 248
    Width = 97
    Height = 17
    Caption = 'Exclus'#227'o'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object Button4: TButton
    Left = 632
    Top = 56
    Width = 121
    Height = 25
    Caption = 'UndoLastChange'
    TabOrder = 9
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 632
    Top = 87
    Width = 121
    Height = 25
    Caption = 'RevertRecord'
    TabOrder = 10
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 632
    Top = 118
    Width = 121
    Height = 25
    Caption = 'SavePoint'
    TabOrder = 11
    OnClick = Button6Click
  end
  object ListBox1: TListBox
    Left = 632
    Top = 160
    Width = 121
    Height = 337
    ItemHeight = 13
    TabOrder = 12
    OnDblClick = ListBox1DblClick
  end
  object CursofiredacConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=CursoFireDAC')
    Connected = True
    LoginPrompt = False
    Left = 124
    Top = 36
  end
  object FDQuery1: TFDQuery
    Active = True
    AfterScroll = FDQuery1AfterScroll
    CachedUpdates = True
    Connection = CursofiredacConnection
    SQL.Strings = (
      'Select * from Clientes')
    Left = 120
    Top = 88
    object FDQuery1IdCliente: TFDAutoIncField
      FieldName = 'IdCliente'
      Origin = 'IdCliente'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery1Nome: TStringField
      DisplayWidth = 30
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 80
    end
    object FDQuery1Logradouro: TStringField
      DisplayWidth = 30
      FieldName = 'Logradouro'
      Origin = 'Logradouro'
      Size = 100
    end
    object FDQuery1Numero: TStringField
      FieldName = 'Numero'
      Origin = 'Numero'
      Size = 6
    end
    object FDQuery1IdBairro: TIntegerField
      FieldName = 'IdBairro'
      Origin = 'IdBairro'
    end
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 120
    Top = 144
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 160
    Top = 336
  end
  object DataSource2: TDataSource
    DataSet = FDMemTable1
    Left = 160
    Top = 384
  end
end
