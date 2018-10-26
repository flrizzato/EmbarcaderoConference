object FrmSQLDialectAbstraction: TFrmSQLDialectAbstraction
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '04 - SQL Dialect Abstraction'
  ClientHeight = 439
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 394
    Height = 433
    ActivePage = tabFirebird
    Align = alClient
    TabOrder = 0
    OnChange = PageControlChange
    object tabFirebird: TTabSheet
      Caption = 'Firebird'
      object memSQLFirebird: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 380
        Height = 100
        Align = alTop
        Lines.Strings = (
          'SELECT'
          #9'FIRST 5'
          #9'('#39'#econ2018 '#39' || DESCRICAO) AS NAME'
          'FROM'
          #9'DIALECT_ABSTRACTION')
        TabOrder = 0
      end
      object btnExecuteFirebird: TButton
        AlignWithMargins = True
        Left = 3
        Top = 109
        Width = 380
        Height = 44
        Align = alTop
        Caption = 'Execute'
        TabOrder = 1
        OnClick = btnExecuteFirebirdClick
      end
      object griFirebird: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 159
        Width = 380
        Height = 243
        Align = alClient
        DataSource = DSFirebird
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object tabPostgreSQL: TTabSheet
      Caption = 'PostgreSQL'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object memSQLPostgreSQL: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 380
        Height = 100
        Align = alTop
        Lines.Strings = (
          'SELECT'
          #9'CONCAT('#39'#econ2018 '#39', descricao) AS NAME'
          'FROM'
          #9'dialect_abstraction'
          'LIMIT 5')
        TabOrder = 0
      end
      object btnExecutePostgreSQL: TButton
        AlignWithMargins = True
        Left = 3
        Top = 109
        Width = 380
        Height = 44
        Align = alTop
        Caption = 'Execute'
        TabOrder = 1
        OnClick = btnExecutePostgreSQLClick
      end
      object griPostgreSQL: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 159
        Width = 380
        Height = 243
        Align = alClient
        DataSource = DSPostgreSQL
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object tabFireDAC: TTabSheet
      Caption = 'FireDAC'
      ImageIndex = 2
      object memSQLFireDAC: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 380
        Height = 100
        Align = alTop
        Lines.Strings = (
          'SELECT'
          '{IF FB} FIRST 5 {FI}'
          #9'{concat('#39'#econ2018 '#39', descricao)} AS NAME'
          'FROM'
          #9'dialect_abstraction'
          '{IF PG} LIMIT 5 {FI}')
        TabOrder = 0
      end
      object btnExecuteFireDAC: TButton
        AlignWithMargins = True
        Left = 3
        Top = 109
        Width = 380
        Height = 44
        Align = alTop
        Caption = 'Execute'
        TabOrder = 1
        OnClick = btnExecuteFireDACClick
      end
      object griFireDACPostgreSQL: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 283
        Width = 380
        Height = 118
        Align = alTop
        DataSource = DSPostgreSQL
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object griFireDACFirebird: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 159
        Width = 380
        Height = 118
        Align = alTop
        DataSource = DSFirebird
        TabOrder = 3
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  object DSFirebird: TDataSource
    DataSet = DMSQLDialectAbstraction.QueryFirebird
    Left = 40
    Top = 344
  end
  object DSPostgreSQL: TDataSource
    DataSet = DMSQLDialectAbstraction.QueryPostgreSQL
    Left = 112
    Top = 344
  end
end
