object FrmETL: TFrmETL
  Left = 0
  Top = 0
  Caption = 'ETL'
  ClientHeight = 385
  ClientWidth = 552
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
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 552
    Height = 385
    ActivePage = tabSource
    Align = alClient
    TabOrder = 0
    object tabSource: TTabSheet
      Caption = 'Source'
      ImageIndex = 2
      object gridSource: TDBGrid
        Left = 0
        Top = 0
        Width = 544
        Height = 357
        Align = alClient
        DataSource = ds
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object btnMoveDataSet: TButton
        Left = 440
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Move'
        TabOrder = 1
        OnClick = btnMoveDataSetClick
      end
    end
    object tabTxt: TTabSheet
      Caption = 'TXT'
      object Button1: TButton
        Left = 96
        Top = 184
        Width = 75
        Height = 25
        Caption = 'Button1'
        TabOrder = 0
      end
      object mmDados: TMemo
        Left = 0
        Top = 0
        Width = 544
        Height = 357
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        ExplicitTop = 171
        ExplicitHeight = 186
      end
    end
    object tabDataSet: TTabSheet
      Caption = 'DataSet'
      ImageIndex = 1
      object gridDataSet: TDBGrid
        Left = 0
        Top = 0
        Width = 544
        Height = 357
        Align = alClient
        DataSource = dsDataSet
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object tabSQL: TTabSheet
      Caption = 'SQL'
      ImageIndex = 3
      object gridSQL: TDBGrid
        Left = 0
        Top = 0
        Width = 544
        Height = 357
        Align = alClient
        DataSource = dsSQL
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  object qry: TFDQuery
    ConstraintsEnabled = True
    Connection = DM.con
    SQL.Strings = (
      'select DEPT_NO, FIRST_NAME, LAST_NAME from EMPLOYEE')
    Left = 32
    Top = 208
  end
  object BatchMove: TFDBatchMove
    Reader = Reader
    Writer = txtWriter
    Mappings = <>
    Left = 192
    Top = 208
  end
  object Reader: TFDBatchMoveDataSetReader
    DataSet = qry
    Left = 112
    Top = 208
  end
  object datasetWriter: TFDBatchMoveDataSetWriter
    Direct = True
    DataSet = memTable
    Left = 280
    Top = 136
  end
  object ds: TDataSource
    DataSet = qry
    Left = 32
    Top = 272
  end
  object txtWriter: TFDBatchMoveTextWriter
    FileName = '.\dados.txt'
    DataDef.Fields = <>
    Left = 280
    Top = 288
  end
  object sqlWriter: TFDBatchMoveSQLWriter
    Connection = DM.con
    TableName = 'TARGET'
    Left = 280
    Top = 208
  end
  object tbl: TFDTable
    Connection = DM.con
    Left = 368
    Top = 208
  end
  object dsSQL: TDataSource
    DataSet = tbl
    Left = 448
    Top = 216
  end
  object memTable: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 368
    Top = 136
  end
  object dsDataSet: TDataSource
    DataSet = memTable
    Left = 448
    Top = 144
  end
end
