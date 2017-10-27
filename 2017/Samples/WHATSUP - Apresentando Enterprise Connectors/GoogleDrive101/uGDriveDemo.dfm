object fmGDriveSimpleDemo: TfmGDriveSimpleDemo
  Left = 0
  Top = 0
  Caption = 'CData FireDAC components for Google Drive Simple  Demo'
  ClientHeight = 597
  ClientWidth = 913
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object paInfo: TPanel
    Left = 0
    Top = 0
    Width = 913
    Height = 125
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      913
      125)
    object Label3: TLabel
      Left = 24
      Top = 22
      Width = 769
      Height = 59
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      Caption = 
        'The CData FireDAC Components for Google Drive 2017 integrate Goo' +
        'gle Drive RAD Studio. The component models the Google Drive API ' +
        'as relational tables. After Establishing a Connection you can br' +
        'owse tables and execute queries. The components abstract the und' +
        'erlying data source into tables, views, and stored procedures th' +
        'at can be used to both retrieve and update data.'
      WordWrap = True
    end
    object Label4: TLabel
      Left = 24
      Top = 68
      Width = 151
      Height = 13
      Caption = 'http://www.cdata.com/firedac/'
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 578
    Width = 913
    Height = 19
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 125
    Width = 913
    Height = 128
    ActivePage = TabSheet2
    Align = alTop
    TabOrder = 2
    object TabSheet2: TTabSheet
      Caption = 'Google Drive File System'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 905
        Height = 100
        Align = alClient
        BevelOuter = bvNone
        Caption = ' '
        ParentBackground = False
        TabOrder = 0
        object Label2: TLabel
          Left = 10
          Top = 49
          Width = 56
          Height = 13
          Caption = 'Search text'
        end
        object Button3: TButton
          Left = 202
          Top = 4
          Width = 88
          Height = 39
          Action = acBrowseDocs
          TabOrder = 0
        end
        object Button4: TButton
          Left = 697
          Top = 4
          Width = 80
          Height = 39
          Action = acDownloadFile
          TabOrder = 1
        end
        object Button5: TButton
          Left = 697
          Top = 51
          Width = 80
          Height = 39
          Action = acFileUpload
          TabOrder = 2
        end
        object Button8: TButton
          Left = 602
          Top = 51
          Width = 88
          Height = 39
          Action = acCreateFolder
          TabOrder = 3
        end
        object Button9: TButton
          Left = 106
          Top = 4
          Width = 89
          Height = 39
          Action = acBrowseFolders
          TabOrder = 4
        end
        object Button10: TButton
          Left = 10
          Top = 4
          Width = 89
          Height = 39
          Action = acBrowseFiles
          TabOrder = 5
        end
        object Button2: TButton
          Left = 809
          Top = 4
          Width = 75
          Height = 39
          Action = acFolderSTree
          TabOrder = 6
        end
        object Button1: TButton
          Left = 602
          Top = 4
          Width = 89
          Height = 39
          Action = acFilePermissions
          TabOrder = 7
        end
        object Button6: TButton
          Left = 297
          Top = 4
          Width = 88
          Height = 39
          Action = acBrowsePhotos
          TabOrder = 8
        end
        object Button7: TButton
          Left = 393
          Top = 4
          Width = 88
          Height = 39
          Action = acBrowseSheets
          TabOrder = 9
        end
        object Button11: TButton
          Left = 489
          Top = 4
          Width = 88
          Height = 39
          Action = acBrowseVideos
          TabOrder = 10
        end
        object EdSearch: TEdit
          Left = 10
          Top = 66
          Width = 184
          Height = 21
          TabOrder = 11
          TextHint = 'Find by full name or XYZ% part '
        end
        object Button12: TButton
          Left = 298
          Top = 64
          Width = 89
          Height = 25
          Action = acFindByContent
          TabOrder = 12
          Visible = False
        end
        object Button13: TButton
          Left = 202
          Top = 64
          Width = 89
          Height = 25
          Action = acFindByName
          TabOrder = 13
        end
      end
    end
    object tsMetadata: TTabSheet
      Caption = 'MetaData'
      ImageIndex = 2
      object edCDataName: TEdit
        Left = 24
        Top = 23
        Width = 221
        Height = 21
        TabOrder = 0
        TextHint = 'name of the CData dataset e.g: Files'
      end
      object Button17: TButton
        Left = 264
        Top = 20
        Width = 75
        Height = 25
        Action = acDescribe
        TabOrder = 1
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Free Form Query'
      ImageIndex = 2
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 905
        Height = 101
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel1'
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          905
          101)
        object Label1: TLabel
          Left = 88
          Top = 5
          Width = 193
          Height = 13
          Caption = 'Enter  SQL query for CData GoogleDrive'
        end
        object sbRunQuery: TSpeedButton
          Left = 8
          Top = 24
          Width = 65
          Height = 65
          Caption = 'RUN'
          OnClick = sbRunQueryClick
        end
        object meQuery: TMemo
          Left = 88
          Top = 24
          Width = 634
          Height = 65
          Anchors = [akLeft, akTop, akRight, akBottom]
          Lines.Strings = (
            
              'Select * from Files where Query='#39'('#39#39'root'#39#39' in parents)'#39' and Tras' +
              'hed<>'#39'TRUE'#39' order by Folder desc')
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
    object tsConnection: TTabSheet
      Caption = 'OAuth'
      Enabled = False
      ImageIndex = 3
      TabVisible = False
      object Edit2: TEdit
        Left = 188
        Top = 60
        Width = 405
        Height = 21
        TabOrder = 0
      end
      object Edit1: TEdit
        Left = 188
        Top = 18
        Width = 405
        Height = 21
        TabOrder = 1
      end
      object Button14: TButton
        Left = 32
        Top = 16
        Width = 145
        Height = 25
        Caption = 'Get OAuthTokenLink'
        TabOrder = 2
      end
      object Button15: TButton
        Left = 32
        Top = 58
        Width = 145
        Height = 25
        Caption = 'Set OAuthToken'
        TabOrder = 3
      end
      object Button16: TButton
        Left = 624
        Top = 36
        Width = 165
        Height = 25
        Caption = 'Refresh OAuthToken'
        TabOrder = 4
      end
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 253
    Width = 913
    Height = 325
    Align = alClient
    BevelKind = bkFlat
    Caption = 'Panel5'
    TabOrder = 3
    DesignSize = (
      909
      321)
    object DBGrid2: TDBGrid
      Left = 2
      Top = 34
      Width = 907
      Height = 278
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderStyle = bsNone
      DataSource = dsFiles
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object Panel3: TPanel
      Left = 237
      Top = 0
      Width = 356
      Height = 32
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      object DBNavigator1: TDBNavigator
        Left = 17
        Top = 3
        Width = 240
        Height = 25
        DataSource = dsFiles
        TabOrder = 0
      end
      object btApply: TButton
        Left = 263
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Apply'
        TabOrder = 1
        OnClick = btApplyClick
      end
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'InitiateOAuth=GETANDREFRESH'
      'CacheMetadata=True'
      'CacheQueryResult=True'
      'OAuthSettingsLocation=.\\OAuthSettings.txt'
      'DriverID=CDataGoogleDrive'
      'MonitorBy=Remote')
    Left = 32
    Top = 304
  end
  object FDPhysCDataGoogleDriveDriverLink1: TFDPhysCDataGoogleDriveDriverLink
    DriverID = 'CDataGoogleDrive'
    Left = 88
    Top = 476
  end
  object fqQuery: TFDQuery
    AfterOpen = fqQueryAfterOpen
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    Left = 364
    Top = 296
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 768
    Top = 88
  end
  object dsFiles: TDataSource
    DataSet = fqFiles
    Left = 404
    Top = 488
  end
  object ActionList1: TActionList
    Left = 708
    Top = 60
    object acBrowseFiles: TAction
      Category = 'Browse'
      Caption = 'Browse Files'
      OnExecute = acBrowseFilesExecute
    end
    object acBrowseFolders: TAction
      Category = 'Browse'
      Caption = 'Browse Folders'
      OnExecute = acBrowseFoldersExecute
    end
    object acBrowseVideos: TAction
      Category = 'Browse'
      Caption = 'Browse Videos'
      OnExecute = acBrowseVideosExecute
    end
    object acCreateFolder: TAction
      Caption = 'Create Folder'
      OnExecute = acCreateFolderExecute
    end
    object acFileUpload: TAction
      Caption = 'File Upload'
      OnExecute = acFileUploadExecute
    end
    object acDownloadFile: TAction
      Caption = 'Download file'
      OnExecute = acDownloadFileExecute
    end
    object acDescribe: TAction
      Caption = 'Describe'
      OnExecute = acDescribeExecute
    end
    object acFolderSTree: TAction
      Caption = 'Folders Tree'
      OnExecute = acFolderSTreeExecute
      OnUpdate = acFolderSTreeUpdate
    end
    object acFilePermissions: TAction
      Caption = 'File Permissions'
      OnExecute = acFilePermissionsExecute
      OnUpdate = acFolderSTreeUpdate
    end
    object acBrowseDocs: TAction
      Category = 'Browse'
      Caption = 'Browse Docs'
      OnExecute = acBrowseDocsExecute
    end
    object acBrowseSheets: TAction
      Category = 'Browse'
      Caption = 'Browse Sheets'
      OnExecute = acBrowseSheetsExecute
    end
    object acBrowsePhotos: TAction
      Category = 'Browse'
      Caption = 'Browse Photos'
      OnExecute = acBrowsePhotosExecute
    end
    object acFindByName: TAction
      Caption = 'By Name'
      OnExecute = acFindByNameExecute
    end
    object acFindByContent: TAction
      Caption = 'By Content'
    end
  end
  object fqFiles: TFDQuery
    AfterOpen = fqFilesAfterOpen
    CachedUpdates = True
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvRefreshMode]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.KeyFields = 'Id'
    UpdateObject = FDUpdateSQL1
    SQL.Strings = (
      'select * from Files')
    Left = 300
    Top = 296
  end
  object OpenDialog1: TOpenDialog
    Left = 832
    Top = 20
  end
  object SaveDialog1: TSaveDialog
    Left = 840
    Top = 72
  end
  object fspUpload: TFDStoredProc
    Connection = FDConnection1
    StoredProcName = 'CData.GoogleDrive.UploadFile'
    Left = 116
    Top = 420
    ParamData = <
      item
        Position = 1
        Name = 'Id'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 2
        Name = 'Name'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 3
        Name = 'Description'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 4
        Name = 'Starred'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 5
        Name = 'Trashed'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 6
        Name = 'Viewed'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 7
        Name = 'MIMEType'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 8
        Name = 'Parents'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 9
        Name = 'LocalFile'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 10
        Name = 'FileData'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 11
        Name = 'Encoding'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 12
        Name = 'Id'
        DataType = ftWideString
        ParamType = ptOutput
        Size = 2000
      end
      item
        Position = 13
        Name = 'Success'
        DataType = ftWideString
        ParamType = ptOutput
        Size = 2000
      end>
  end
  object fspDownload: TFDStoredProc
    Connection = FDConnection1
    StoredProcName = 'CData.GoogleDrive.DownloadFile'
    Left = 108
    Top = 304
    ParamData = <
      item
        Position = 1
        Name = 'Id'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 2
        Name = 'FileFormat'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 3
        Name = 'LocalFile'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 4
        Name = 'Encoding'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 5
        Name = 'Overwrite'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 6
        Name = 'FileData'
        DataType = ftWideString
        ParamType = ptOutput
        Size = 2000
      end
      item
        Position = 7
        Name = 'Success'
        DataType = ftWideString
        ParamType = ptOutput
        Size = 2000
      end>
  end
  object fspNewFolder: TFDStoredProc
    Connection = FDConnection1
    StoredProcName = 'CData.GoogleDrive.CreateFolder'
    Left = 112
    Top = 364
    ParamData = <
      item
        Position = 1
        Name = 'Name'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 2
        Name = 'Description'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 3
        Name = 'Starred'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 4
        Name = 'Hidden'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 5
        Name = 'Parents'
        DataType = ftWideString
        ParamType = ptInput
        Size = 2000
      end
      item
        Position = 6
        Name = 'Success'
        DataType = ftWideString
        ParamType = ptOutput
        Size = 2000
      end
      item
        Position = 7
        Name = 'Id'
        DataType = ftWideString
        ParamType = ptOutput
        Size = 2000
      end>
  end
  object fqPermissions: TFDQuery
    AfterOpen = fqPermissionsAfterOpen
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'select * from Permissions where ResourceId = :id')
    Left = 468
    Top = 296
    ParamData = <
      item
        Name = 'ID'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDUpdateSQL1: TFDUpdateSQL
    Connection = FDConnection1
    InsertSQL.Strings = (
      'insert into Files '
      '(Name,Description,MIMEType,Starred) '
      'values'
      '(:NEW_Name,:NEW_Description,:NEW_MIMEType,:NEW_Starred)')
    ModifySQL.Strings = (
      'update Files set '
      'Name=:NEW_Name,Description=:NEW_Description,'
      'MIMEType=:NEW_MIMEType,Starred=:NEW_Starred '
      'where Id = :OLD_Id')
    DeleteSQL.Strings = (
      'delete from Files where Id = :OLD_Id')
    Left = 292
    Top = 392
  end
end
