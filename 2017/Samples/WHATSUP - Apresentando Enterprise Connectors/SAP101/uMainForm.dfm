object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'SAP 101'
  ClientHeight = 394
  ClientWidth = 733
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 5
    Top = 45
    Width = 723
    Height = 344
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'MANDT'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MATNR'
        Width = 155
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SPRAS'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAKTX'
        Width = 225
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAKTG'
        Width = 225
        Visible = True
      end>
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 723
    Height = 30
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 698
    object SpeedButton3: TSpeedButton
      AlignWithMargins = True
      Left = 5
      Top = 0
      Width = 105
      Height = 30
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Open'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton3Click
      ExplicitLeft = 0
    end
    object SpeedButton1: TSpeedButton
      AlignWithMargins = True
      Left = 360
      Top = 0
      Width = 105
      Height = 30
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Apply Updates'
      Flat = True
      OnClick = SpeedButton1Click
      ExplicitLeft = 353
      ExplicitTop = 5
      ExplicitHeight = 40
    end
    object SpeedButton2: TSpeedButton
      AlignWithMargins = True
      Left = 470
      Top = 0
      Width = 105
      Height = 30
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Cancel Updates'
      Flat = True
      OnClick = SpeedButton2Click
      ExplicitLeft = 450
    end
    object DBNavigator1: TDBNavigator
      AlignWithMargins = True
      Left = 115
      Top = 0
      Width = 240
      Height = 30
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      DataSource = DataSource1
      Align = alLeft
      Flat = True
      TabOrder = 0
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 544
    Top = 168
  end
  object DataSource1: TDataSource
    DataSet = MaktView
    Left = 448
    Top = 112
  end
  object CdatasapConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=CDataSAP')
    Connected = True
    LoginPrompt = False
    Left = 541
    Top = 62
  end
  object MaktView: TFDQuery
    Connection = CdatasapConnection
    SQL.Strings = (
      'SELECT * FROM CData.SAP.MAKT')
    Left = 541
    Top = 118
    object MaktViewMANDT: TWideStringField
      FieldName = 'MANDT'
      Origin = 'MANDT'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 6
    end
    object MaktViewMATNR: TWideStringField
      FieldName = 'MATNR'
      Origin = 'MATNR'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 36
    end
    object MaktViewSPRAS: TWideStringField
      FieldName = 'SPRAS'
      Origin = 'SPRAS'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object MaktViewMAKTX: TWideStringField
      FieldName = 'MAKTX'
      Origin = 'MAKTX'
      Size = 80
    end
    object MaktViewMAKTG: TWideStringField
      FieldName = 'MAKTG'
      Origin = 'MAKTG'
      Size = 80
    end
  end
  object FDPhysCDataSAPDriverLink1: TFDPhysCDataSAPDriverLink
    DriverID = 'CDataSAP'
    Left = 544
    Top = 224
  end
end
