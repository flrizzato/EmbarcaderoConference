object mdiServer: TmdiServer
  Left = 0
  Top = 0
  Caption = 'mdiServer'
  ClientHeight = 441
  ClientWidth = 637
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pcServer: TPageControl
    Left = 0
    Top = 0
    Width = 637
    Height = 441
    ActivePage = tabServer
    Align = alClient
    TabOrder = 0
    OnChange = pcServerChange
    object tabServer: TTabSheet
      Caption = 'Server'
      DesignSize = (
        629
        413)
      object Label1: TLabel
        Left = 21
        Top = 48
        Width = 20
        Height = 13
        Caption = 'Port'
      end
      object Label2: TLabel
        Left = 16
        Top = 18
        Width = 70
        Height = 13
        Caption = 'HTTP Server'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel1: TBevel
        Left = 16
        Top = 40
        Width = 291
        Height = 5
        Shape = bsTopLine
      end
      object lblAddress: TLabel
        Left = 119
        Top = 51
        Width = 189
        Height = 13
        Cursor = crHandPoint
        Alignment = taRightJustify
        AutoSize = False
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = lblAddressClick
      end
      object Label3: TLabel
        Left = 16
        Top = 106
        Width = 61
        Height = 13
        Caption = 'Server Log'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel2: TBevel
        Left = 16
        Top = 128
        Width = 291
        Height = 5
        Shape = bsTopLine
      end
      object edtPort: TEdit
        Left = 47
        Top = 45
        Width = 42
        Height = 21
        NumbersOnly = True
        TabOrder = 0
        Text = '8088'
        OnChange = edtPortChange
      end
      object mmLog: TMemo
        Left = 16
        Top = 144
        Width = 594
        Height = 257
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 1
      end
      object chkLog: TCheckBox
        Left = 240
        Top = 104
        Width = 66
        Height = 17
        Caption = 'Show Log'
        TabOrder = 2
        OnClick = chkLogClick
      end
      object Button1: TButton
        Left = 173
        Top = 16
        Width = 63
        Height = 22
        Action = acWebStart
        TabOrder = 3
      end
      object Button2: TButton
        Left = 242
        Top = 16
        Width = 63
        Height = 22
        Action = acWebStop
        TabOrder = 4
      end
    end
    object tabRegistry: TTabSheet
      Caption = 'Registry'
      ImageIndex = 1
      object pnlToolbar: TPanel
        Left = 0
        Top = 0
        Width = 629
        Height = 31
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label4: TLabel
          Left = 109
          Top = 10
          Width = 22
          Height = 13
          Caption = 'Secs'
        end
        object lblTime: TLabel
          Left = 197
          Top = 10
          Width = 12
          Height = 13
          Caption = '...'
        end
        object chkRefresh: TCheckBox
          Left = 0
          Top = 8
          Width = 89
          Height = 17
          Caption = 'Auto Refresh'
          TabOrder = 0
          OnClick = chkRefreshClick
        end
        object Edit1: TEdit
          Left = 136
          Top = 6
          Width = 24
          Height = 21
          TabOrder = 1
          Text = '2'
        end
        object udResfresh: TUpDown
          Left = 160
          Top = 6
          Width = 16
          Height = 21
          Associate = Edit1
          Min = 2
          Max = 60
          Position = 2
          TabOrder = 2
        end
      end
      object StringGrid1: TStringGrid
        Tag = 10
        Left = 0
        Top = 31
        Width = 629
        Height = 382
        Align = alClient
        ColCount = 10
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing]
        PopupMenu = pmRegistry
        TabOrder = 1
        ColWidths = (
          70
          70
          100
          100
          70
          70
          64
          70
          64
          64)
        RowHeights = (
          24
          24)
      end
    end
  end
  object alServer: TActionList
    OnUpdate = alServerUpdate
    Left = 152
    Top = 80
    object acWebStart: TAction
      Caption = '&Start'
      OnExecute = acWebStartExecute
    end
    object acWebStop: TAction
      Caption = 'St&op'
      OnExecute = acWebStopExecute
    end
    object acOpenBrowser: TAction
      Caption = 'Open &Browser'
    end
    object acOpenRegistry: TAction
      Caption = '&Open'
      OnExecute = acOpenRegistryExecute
    end
    object acCloseRegistry: TAction
      Caption = '&Close'
      OnExecute = acCloseRegistryExecute
    end
    object acRefreshRegistry: TAction
      Caption = '&Refresh'
      OnExecute = acRefreshRegistryExecute
    end
  end
  object tblRegistry: TFDTable
    IndexFieldNames = 'DeviceId'
    Connection = dmPushDB.conApp
    UpdateOptions.UpdateTableName = 'pushmanager.registry'
    TableName = 'pushmanager.registry'
    Left = 236
    Top = 80
    object tblRegistryDeviceId: TWideStringField
      FieldName = 'DeviceId'
      Origin = 'DeviceId'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 32
    end
    object tblRegistryDeviceToken: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'DeviceToken'
      Origin = 'DeviceToken'
      Size = 200
    end
    object tblRegistryDeviceType: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'DeviceType'
      Origin = 'DeviceType'
      Size = 40
    end
    object tblRegistryOSName: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'OSName'
      Origin = 'OSName'
      Size = 10
    end
    object tblRegistryOSVersion: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'OSVersion'
      Origin = 'OSVersion'
    end
    object tblRegistryPushEnabled: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'PushEnabled'
      Origin = 'PushEnabled'
      Size = 1
    end
    object tblRegistryUserName: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'UserName'
      Origin = 'UserName'
      Size = 60
    end
    object tblRegistryUserEmail: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'UserEmail'
      Origin = 'UserEmail'
      Size = 60
    end
    object tblRegistryDTInsert: TSQLTimeStampField
      AutoGenerateValue = arDefault
      FieldName = 'DTInsert'
      Origin = 'DTInsert'
    end
    object tblRegistryDTUpdate: TSQLTimeStampField
      AutoGenerateValue = arDefault
      FieldName = 'DTUpdate'
      Origin = 'DTUpdate'
    end
  end
  object tmrRefresh: TTimer
    Enabled = False
    OnTimer = tmrRefreshTimer
    Left = 156
    Top = 136
  end
  object pmRegistry: TPopupMenu
    Left = 396
    Top = 104
    object OpenBrowser1: TMenuItem
      Action = acOpenRegistry
    end
    object Refresh1: TMenuItem
      Action = acRefreshRegistry
    end
    object Close1: TMenuItem
      Action = acCloseRegistry
    end
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = tblRegistry
    ScopeMappings = <>
    Left = 280
    Top = 224
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 356
    Top = 5
    object LinkGridToDataSourceBindSourceDB12: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      GridControl = StringGrid1
      Columns = <
        item
          MemberName = 'DeviceId'
          Width = 70
        end
        item
          MemberName = 'DeviceToken'
          Width = 70
        end
        item
          MemberName = 'UserName'
          Width = 100
        end
        item
          MemberName = 'UserEmail'
          Width = 100
        end
        item
          MemberName = 'DeviceType'
          Width = 70
        end
        item
          MemberName = 'OSName'
          Width = 70
        end
        item
          MemberName = 'OSVersion'
        end
        item
          MemberName = 'PushEnabled'
          Width = 70
        end
        item
          MemberName = 'DTInsert'
        end
        item
          MemberName = 'DTUpdate'
        end>
    end
  end
end
