object FrmLocalSQL: TFrmLocalSQL
  Left = 0
  Top = 0
  Caption = 'Local SQL'
  ClientHeight = 271
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TDBGrid
    Left = 0
    Top = 0
    Width = 498
    Height = 271
    Align = alClient
    DataSource = ds
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object qryDepartment: TSQLQuery
    Active = True
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from DEPARTMENT')
    SQLConnection = DM.dbxcon
    Left = 72
    Top = 48
  end
  object qryEmployee: TFDQuery
    Active = True
    Connection = DM.con
    SQL.Strings = (
      'select * from EMPLOYEE')
    Left = 160
    Top = 48
  end
  object conLocal: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 72
    Top = 120
  end
  object driver: TFDPhysSQLiteDriverLink
    Left = 248
    Top = 128
  end
  object LocalSQL: TFDLocalSQL
    Connection = conLocal
    Active = True
    DataSets = <
      item
        DataSet = qryDepartment
        Name = 'DEPARTMENT'
      end
      item
        DataSet = qryEmployee
        Name = 'EMPLOYEE'
      end>
    Left = 160
    Top = 120
  end
  object qryLocal: TFDQuery
    Active = True
    LocalSQL = LocalSQL
    Connection = conLocal
    SQL.Strings = (
      'select E.DEPT_NO, E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT '
      'from EMPLOYEE E'
      'inner join DEPARTMENT D'
      'on E.DEPT_NO = D.DEPT_NO'
      'where FIRST_NAME LIKE '#39'%A%'#39
      'order by E.FIRST_NAME')
    Left = 336
    Top = 128
  end
  object ds: TDataSource
    DataSet = qryLocal
    Left = 72
    Top = 200
  end
end
