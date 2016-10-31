object FrmCacheUpdate: TFrmCacheUpdate
  Left = 0
  Top = 0
  Caption = 'Cache e Update'
  ClientHeight = 440
  ClientWidth = 674
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 674
    Height = 440
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Edit'
      ExplicitLeft = 8
      ExplicitTop = 28
      object Label1: TLabel
        Left = 24
        Top = 24
        Width = 46
        Height = 13
        Caption = 'DEPT_NO'
        FocusControl = DBEdit1
      end
      object Label2: TLabel
        Left = 24
        Top = 64
        Width = 66
        Height = 13
        Caption = 'DEPARTMENT'
        FocusControl = DBEdit2
      end
      object Label3: TLabel
        Left = 24
        Top = 104
        Width = 58
        Height = 13
        Caption = 'HEAD_DEPT'
        FocusControl = DBEdit3
      end
      object Label4: TLabel
        Left = 24
        Top = 144
        Width = 50
        Height = 13
        Caption = 'MNGR_NO'
        FocusControl = DBEdit4
      end
      object Label5: TLabel
        Left = 24
        Top = 184
        Width = 39
        Height = 13
        Caption = 'BUDGET'
        FocusControl = DBEdit5
      end
      object Label6: TLabel
        Left = 24
        Top = 224
        Width = 52
        Height = 13
        Caption = 'LOCATION'
        FocusControl = DBEdit6
      end
      object Label7: TLabel
        Left = 24
        Top = 264
        Width = 55
        Height = 13
        Caption = 'PHONE_NO'
        FocusControl = DBEdit7
      end
      object DBEdit1: TDBEdit
        Left = 24
        Top = 40
        Width = 43
        Height = 21
        DataField = 'DEPT_NO'
        DataSource = ds
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 24
        Top = 80
        Width = 329
        Height = 21
        DataField = 'DEPARTMENT'
        DataSource = ds
        TabOrder = 1
      end
      object DBEdit3: TDBEdit
        Left = 24
        Top = 120
        Width = 43
        Height = 21
        DataField = 'HEAD_DEPT'
        DataSource = ds
        TabOrder = 2
      end
      object DBEdit4: TDBEdit
        Left = 24
        Top = 160
        Width = 134
        Height = 21
        DataField = 'MNGR_NO'
        DataSource = ds
        TabOrder = 3
      end
      object DBEdit5: TDBEdit
        Left = 24
        Top = 200
        Width = 134
        Height = 21
        DataField = 'BUDGET'
        DataSource = ds
        TabOrder = 4
      end
      object DBEdit6: TDBEdit
        Left = 24
        Top = 240
        Width = 199
        Height = 21
        DataField = 'LOCATION'
        DataSource = ds
        TabOrder = 5
      end
      object DBEdit7: TDBEdit
        Left = 24
        Top = 280
        Width = 264
        Height = 21
        DataField = 'PHONE_NO'
        DataSource = ds
        TabOrder = 6
      end
      object DBNavigator1: TDBNavigator
        Left = 24
        Top = 320
        Width = 240
        Height = 25
        DataSource = ds
        TabOrder = 7
      end
      object btnApply: TButton
        Left = 392
        Top = 139
        Width = 103
        Height = 25
        Caption = 'Apply'
        TabOrder = 8
        OnClick = btnApplyClick
      end
      object mmStatus: TMemo
        Left = 392
        Top = 21
        Width = 233
        Height = 96
        TabOrder = 9
      end
      object btnUndoLastChange: TButton
        Left = 392
        Top = 219
        Width = 103
        Height = 25
        Caption = 'UndoLastChange'
        TabOrder = 10
        OnClick = btnUndoLastChangeClick
      end
      object btnSavePoint: TButton
        Left = 392
        Top = 179
        Width = 103
        Height = 25
        Caption = 'SavePoint'
        TabOrder = 11
        OnClick = btnSavePointClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Data'
      ImageIndex = 1
      object gridData: TDBGrid
        Left = 0
        Top = 64
        Width = 666
        Height = 348
        Align = alBottom
        DataSource = dsData
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object btnGetData: TButton
        Left = 16
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Data'
        TabOrder = 1
        OnClick = btnGetDataClick
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Delta'
      ImageIndex = 2
      object gridDelta: TDBGrid
        Left = 0
        Top = 64
        Width = 666
        Height = 348
        Align = alBottom
        DataSource = dsDelta
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object btnGetDelta: TButton
        Left = 16
        Top = 11
        Width = 75
        Height = 25
        Caption = 'Delta'
        TabOrder = 1
        OnClick = btnGetDeltaClick
      end
    end
  end
  object qry: TFDQuery
    CachedUpdates = True
    Connection = DM.con
    UpdateObject = upd
    SQL.Strings = (
      'select * from DEPARTMENT')
    Left = 144
    Top = 128
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
    OnStateChange = dsStateChange
    Left = 72
    Top = 128
  end
  object upd: TFDUpdateSQL
    Connection = DM.con
    InsertSQL.Strings = (
      'INSERT INTO DEPARTMENT'
      '(DEPT_NO, DEPARTMENT, HEAD_DEPT, MNGR_NO, '
      '  BUDGET, LOCATION, PHONE_NO)'
      
        'VALUES (:NEW_DEPT_NO, :NEW_DEPARTMENT, :NEW_HEAD_DEPT, :NEW_MNGR' +
        '_NO, '
      '  :NEW_BUDGET, :NEW_LOCATION, :NEW_PHONE_NO)')
    ModifySQL.Strings = (
      'UPDATE DEPARTMENT'
      
        'SET DEPT_NO = :NEW_DEPT_NO, DEPARTMENT = :NEW_DEPARTMENT, HEAD_D' +
        'EPT = :NEW_HEAD_DEPT, '
      
        '  MNGR_NO = :NEW_MNGR_NO, BUDGET = :NEW_BUDGET, LOCATION = :NEW_' +
        'LOCATION, '
      '  PHONE_NO = :NEW_PHONE_NO'
      'WHERE DEPT_NO = :OLD_DEPT_NO')
    DeleteSQL.Strings = (
      'DELETE FROM DEPARTMENT'
      'WHERE DEPT_NO = :OLD_DEPT_NO')
    FetchRowSQL.Strings = (
      
        'SELECT DEPT_NO, DEPARTMENT, HEAD_DEPT, MNGR_NO, BUDGET, LOCATION' +
        ', PHONE_NO'
      'FROM DEPARTMENT'
      'WHERE DEPT_NO = :DEPT_NO')
    Left = 200
    Top = 128
  end
  object memDelta: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 256
    Top = 272
  end
  object memData: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 256
    Top = 200
  end
  object dsData: TDataSource
    DataSet = memData
    Left = 328
    Top = 200
  end
  object dsDelta: TDataSource
    DataSet = memDelta
    Left = 328
    Top = 272
  end
end
