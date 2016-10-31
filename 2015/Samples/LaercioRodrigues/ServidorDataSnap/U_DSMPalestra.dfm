object DSMPalestra: TDSMPalestra
  OldCreateOrder = False
  Height = 109
  Width = 585
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=PALESTRA2015'
      'User_Name=SA'
      'Password=123'
      'Server=PCLAERCIO\SQLEXPRESS'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 32
  end
  object FDQueryTAG: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from tag where numero = :numero')
    Left = 200
    Top = 32
    ParamData = <
      item
        Position = 1
        Name = 'NUMERO'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object ClientDataSetTAG: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'NUMERO'
        ParamType = ptInput
      end>
    ProviderName = 'DataSetProviderTAG'
    Left = 488
    Top = 32
    object ClientDataSetTAGID_TAG: TIntegerField
      FieldName = 'ID_TAG'
      Required = True
    end
    object ClientDataSetTAGNUMERO: TStringField
      FieldName = 'NUMERO'
      Required = True
      Size = 50
    end
  end
  object DataSetProviderTAG: TDataSetProvider
    DataSet = FDQueryTAG
    Left = 344
    Top = 32
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 136
    Top = 8
  end
  object FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink
    Left = 280
    Top = 8
  end
end
