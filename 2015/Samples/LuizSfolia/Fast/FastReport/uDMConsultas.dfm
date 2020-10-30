object DMConsultas: TDMConsultas
  OldCreateOrder = False
  Height = 432
  Width = 445
  object qryEmployee: TFDQuery
    Connection = DMConexao.FDConnection
    SQL.Strings = (
      'select * from "EMPLOYEE" D order by JOB_COUNTRY')
    Left = 88
    Top = 40
  end
  object dspEmployee: TDataSetProvider
    DataSet = qryEmployee
    Left = 88
    Top = 96
  end
  object cdsEmployee: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspEmployee'
    Left = 88
    Top = 152
  end
end
