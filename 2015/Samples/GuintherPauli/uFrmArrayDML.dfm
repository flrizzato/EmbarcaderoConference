object FrmArrayDML: TFrmArrayDML
  Left = 0
  Top = 0
  Caption = 'Array DML'
  ClientHeight = 287
  ClientWidth = 509
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnExecuteArrayDML: TButton
    Left = 24
    Top = 24
    Width = 153
    Height = 25
    Caption = 'Insert usando Array'
    TabOrder = 0
    OnClick = btnExecuteArrayDMLClick
  end
  object grid: TDBGrid
    Left = 0
    Top = 80
    Width = 509
    Height = 207
    Align = alBottom
    DataSource = ds
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object ds: TDataSource
    DataSet = tbl
    Left = 368
    Top = 24
  end
  object tbl: TFDTable
    CachedUpdates = True
    Connection = DM.con
    Left = 232
    Top = 24
  end
  object qry: TFDQuery
    Connection = DM.con
    SQL.Strings = (
      'insert into TESTE_DML2 values (:ID,:TEXTO)')
    Left = 296
    Top = 24
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TEXTO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
end
