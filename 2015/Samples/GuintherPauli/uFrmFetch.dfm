object FrmFetch: TFrmFetch
  Left = 0
  Top = 0
  Caption = 'Fetch'
  ClientHeight = 456
  ClientWidth = 654
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
    Left = 24
    Top = 72
    Width = 46
    Height = 13
    Caption = 'DEPT_NO'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 24
    Top = 112
    Width = 66
    Height = 13
    Caption = 'DEPARTMENT'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 24
    Top = 152
    Width = 58
    Height = 13
    Caption = 'HEAD_DEPT'
    FocusControl = DBEdit3
  end
  object Label4: TLabel
    Left = 24
    Top = 192
    Width = 50
    Height = 13
    Caption = 'MNGR_NO'
    FocusControl = DBEdit4
  end
  object Label5: TLabel
    Left = 24
    Top = 232
    Width = 39
    Height = 13
    Caption = 'BUDGET'
    FocusControl = DBEdit5
  end
  object Label6: TLabel
    Left = 24
    Top = 272
    Width = 52
    Height = 13
    Caption = 'LOCATION'
    FocusControl = DBEdit6
  end
  object Label7: TLabel
    Left = 24
    Top = 312
    Width = 55
    Height = 13
    Caption = 'PHONE_NO'
    FocusControl = DBEdit7
  end
  object Label8: TLabel
    Left = 448
    Top = 168
    Width = 19
    Height = 13
    Caption = 'Size'
  end
  object DBEdit1: TDBEdit
    Left = 24
    Top = 88
    Width = 43
    Height = 21
    DataField = 'DEPT_NO'
    DataSource = ds
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 24
    Top = 128
    Width = 329
    Height = 21
    DataField = 'DEPARTMENT'
    DataSource = ds
    TabOrder = 1
  end
  object DBEdit3: TDBEdit
    Left = 24
    Top = 168
    Width = 43
    Height = 21
    DataField = 'HEAD_DEPT'
    DataSource = ds
    TabOrder = 2
  end
  object DBEdit4: TDBEdit
    Left = 24
    Top = 208
    Width = 134
    Height = 21
    DataField = 'MNGR_NO'
    DataSource = ds
    TabOrder = 3
  end
  object DBEdit5: TDBEdit
    Left = 24
    Top = 248
    Width = 251
    Height = 21
    DataField = 'BUDGET'
    DataSource = ds
    TabOrder = 4
  end
  object DBEdit6: TDBEdit
    Left = 24
    Top = 288
    Width = 199
    Height = 21
    DataField = 'LOCATION'
    DataSource = ds
    TabOrder = 5
  end
  object DBEdit7: TDBEdit
    Left = 24
    Top = 328
    Width = 264
    Height = 21
    DataField = 'PHONE_NO'
    DataSource = ds
    TabOrder = 6
  end
  object DBNavigator1: TDBNavigator
    Left = 24
    Top = 368
    Width = 240
    Height = 25
    DataSource = ds
    TabOrder = 7
  end
  object btnOpen: TButton
    Left = 32
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 8
    OnClick = btnOpenClick
  end
  object btnClose: TButton
    Left = 120
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 9
    OnClick = btnCloseClick
  end
  object boxMode: TComboBox
    Left = 240
    Top = 18
    Width = 145
    Height = 21
    TabOrder = 10
    Items.Strings = (
      'fmManual'
      'fmOnDemand'
      'fmAll'
      'fmExactRecsMax')
  end
  object btnFetchNext: TButton
    Left = 448
    Top = 100
    Width = 75
    Height = 25
    Caption = 'FetchNext'
    TabOrder = 11
    OnClick = btnFetchNextClick
  end
  object btnFetchAll: TButton
    Left = 448
    Top = 131
    Width = 75
    Height = 25
    Caption = 'FetchAll'
    TabOrder = 12
    OnClick = btnFetchAllClick
  end
  object boxSize: TComboBox
    Left = 485
    Top = 165
    Width = 67
    Height = 21
    Style = csDropDownList
    ItemIndex = 2
    TabOrder = 13
    Text = '3'
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5')
  end
  object qry: TFDQuery
    CachedUpdates = True
    Connection = DM.con
    SQL.Strings = (
      'select * from DEPARTMENT')
    Left = 480
    Top = 24
    object qryDEPT_NO: TStringField
      FieldName = 'DEPT_NO'
      Origin = 'DEPT_NO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryDEPARTMENT: TStringField
      FieldName = 'DEPARTMENT'
      Origin = 'DEPARTMENT'
      Required = True
      Size = 25
    end
    object qryHEAD_DEPT: TStringField
      FieldName = 'HEAD_DEPT'
      Origin = 'HEAD_DEPT'
      FixedChar = True
      Size = 3
    end
    object qryMNGR_NO: TSmallintField
      FieldName = 'MNGR_NO'
      Origin = 'MNGR_NO'
    end
    object qryBUDGET: TBCDField
      FieldName = 'BUDGET'
      Origin = 'BUDGET'
      Precision = 18
      Size = 2
    end
    object qryLOCATION: TStringField
      FieldName = 'LOCATION'
      Origin = 'LOCATION'
      Size = 15
    end
    object qryPHONE_NO: TStringField
      FieldName = 'PHONE_NO'
      Origin = 'PHONE_NO'
    end
  end
  object ds: TDataSource
    DataSet = qry
    Left = 416
    Top = 24
  end
end
