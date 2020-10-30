object dmCdata: TdmCdata
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 340
  Width = 455
  object fdGDriveCon: TFDConnection
    Params.Strings = (
      'CacheMetadata=True'
      'CacheQueryResult=True'
      'AutoCache=True'
      'InitiateOAuth=GETANDREFRESH'
      'DriverID=CDataGoogleDrive')
    AfterConnect = fdGDriveConAfterConnect
    Left = 64
    Top = 32
  end
  object fqFiles: TFDQuery
    Connection = fdGDriveCon
    SQL.Strings = (
      
        'select Id,Name,MIMEType,ModifiedTime,OwnerName,Folder,Starred,Pa' +
        'rentIds '
      'from Files where :pid in (ParentIds)'
      'and Trashed = '#39'False'#39' order by Folder Desc')
    Left = 56
    Top = 112
    ParamData = <
      item
        Name = 'PID'
        DataType = ftString
        ParamType = ptInput
        Value = '0B8cQ6U8Bn19MSmw3NG5FT3prQVE'
      end>
  end
  object fqTemp: TFDQuery
    Connection = fdGDriveCon
    Left = 108
    Top = 224
  end
  object spCreateFolder: TFDStoredProc
    Connection = fdGDriveCon
    StoredProcName = 'CData.GoogleDrive.CreateFolder'
    Left = 360
    Top = 116
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
  object spUploadFile: TFDStoredProc
    Connection = fdGDriveCon
    StoredProcName = 'CData.GoogleDrive.UploadFile'
    Left = 360
    Top = 172
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
  object spDownloadFile: TFDStoredProc
    Connection = fdGDriveCon
    StoredProcName = 'CData.GoogleDrive.DownloadFile'
    Left = 360
    Top = 236
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
  object fqRead: TFDQuery
    Connection = fdGDriveCon
    SQL.Strings = (
      'select * from Files where Id = :Id')
    Left = 164
    Top = 112
    ParamData = <
      item
        Name = 'ID'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object fqSearch: TFDQuery
    Connection = fdGDriveCon
    Left = 108
    Top = 112
  end
  object fqInsert: TFDQuery
    Connection = fdGDriveCon
    SQL.Strings = (
      'insert into Files '
      '(Name,Description,MIMEType,Starred) '
      'values'
      '(:Name,:Description,:MIME,:Starred)')
    Left = 164
    Top = 164
    ParamData = <
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DESCRIPTION'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MIME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'STARRED'
        DataType = ftBoolean
        ParamType = ptInput
        Value = Null
      end>
  end
  object fqUpdate: TFDQuery
    Connection = fdGDriveCon
    SQL.Strings = (
      'update Files set '
      
        'Name=:Name,Description=:Description,MIMEType=:MIME,Starred=:Star' +
        'red '
      'where Id = :Id')
    Left = 220
    Top = 112
    ParamData = <
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DESCRIPTION'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MIME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'STARRED'
        DataType = ftBoolean
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ID'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object fqDelete: TFDQuery
    Connection = fdGDriveCon
    SQL.Strings = (
      'delete from Files where Id = :fId')
    Left = 220
    Top = 164
    ParamData = <
      item
        Name = 'FID'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object fqPermissions: TFDQuery
    Connection = fdGDriveCon
    SQL.Strings = (
      'select PermissionId,ResourceId,Role,Type,EmailAddress,Domain '
      'from Permissions where ResourceId = :RcId')
    Left = 56
    Top = 168
    ParamData = <
      item
        Name = 'RCID'
        DataType = ftString
        ParamType = ptInput
        Value = '0B8cQ6U8Bn19Mc3dlRGxaVWI1ZjQ'
      end>
  end
end
