inherited mdiSender: TmdiSender
  Caption = 'mdiSender'
  ClientHeight = 475
  ClientWidth = 806
  OnActivate = FormActivate
  OnClose = FormClose
  ExplicitWidth = 822
  ExplicitHeight = 514
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 806
    Height = 475
    ActivePage = tabSender
    Align = alClient
    TabOrder = 0
    object tabSender: TTabSheet
      Caption = 'Push Sender'
      object Splitter1: TSplitter
        Left = 0
        Top = 291
        Width = 798
        Height = 5
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 293
        ExplicitWidth = 799
      end
      object pnlToolbar: TPanel
        Left = 0
        Top = 0
        Width = 798
        Height = 131
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label5: TLabel
          Left = 0
          Top = 74
          Width = 125
          Height = 13
          Caption = 'Push Notification Message'
        end
        object Label6: TLabel
          Left = 0
          Top = 18
          Width = 85
          Height = 13
          Caption = 'Authorization Key'
        end
        object Label1: TLabel
          Left = 480
          Top = 33
          Width = 306
          Height = 41
          AutoSize = False
          Caption = 
            '<- Veja no slide n'#250'mero 20 da apresenta'#231#227'o onde fica esse token ' +
            'no seu projeto do Firebase (https://console.firebase.google.com/' +
            ')'
          WordWrap = True
        end
        object Button1: TButton
          Left = 480
          Top = 87
          Width = 153
          Height = 25
          Action = acSend
          TabOrder = 0
        end
        object edtMsg: TEdit
          Left = 0
          Top = 90
          Width = 473
          Height = 21
          TabOrder = 1
        end
        object Button3: TButton
          Left = 640
          Top = 86
          Width = 153
          Height = 25
          Action = acSendAll
          TabOrder = 2
        end
        object edtAuthKey: TEdit
          Left = 0
          Top = 30
          Width = 473
          Height = 21
          TabOrder = 3
          Text = '????????????????'
        end
      end
      object gridRegistry: TStringGrid
        Tag = 10
        Left = 0
        Top = 131
        Width = 798
        Height = 160
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
          80
          64
          64
          70
          64
          64)
        RowHeights = (
          24
          24)
      end
      object mmLog: TMemo
        Left = 0
        Top = 296
        Width = 798
        Height = 151
        Align = alBottom
        TabOrder = 2
      end
    end
  end
  object tblRegistry: TFDTable
    IndexFieldNames = 'DeviceId'
    Connection = dmPushDB.conApp
    UpdateOptions.UpdateTableName = 'pushmanager.registry'
    TableName = 'pushmanager.registry'
    Left = 316
    Top = 136
    object tblRegistryDeviceId: TWideStringField
      DisplayWidth = 64
      FieldName = 'DeviceId'
      Origin = 'DeviceId'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 32
    end
    object tblRegistryDeviceToken: TWideStringField
      AutoGenerateValue = arDefault
      DisplayWidth = 64
      FieldName = 'DeviceToken'
      Origin = 'DeviceToken'
      Size = 200
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
  object BindSourceDB1: TBindSourceDB
    DataSet = tblRegistry
    ScopeMappings = <>
    Left = 400
    Top = 240
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 116
    Top = 197
    object LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      GridControl = gridRegistry
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
          Width = 80
        end
        item
          MemberName = 'OSName'
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
  object alServer: TActionList
    OnUpdate = alServerUpdate
    Left = 256
    Top = 136
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
    object acSend: TAction
      Caption = '&Send to Selected'
      OnExecute = acSendExecute
    end
    object acSendAll: TAction
      Caption = 'Send to All'
      OnExecute = acSendAllExecute
    end
    object acSendRandom: TAction
      Caption = 'Send &Random'
      OnExecute = acSendRandomExecute
    end
  end
  object pmRegistry: TPopupMenu
    Left = 500
    Top = 184
    object OpenBrowser1: TMenuItem
      Action = acOpenRegistry
    end
    object Refresh1: TMenuItem
      Action = acRefreshRegistry
    end
    object Close1: TMenuItem
      Action = acCloseRegistry
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object acSendRandom1: TMenuItem
      Action = acSendRandom
    end
  end
  object nHTTP: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    AllowCookies = True
    HandleRedirects = True
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 176
    Top = 352
  end
  object nHTTPReq: TNetHTTPRequest
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    Client = nHTTP
    Left = 248
    Top = 352
  end
end
