object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 150
  Width = 215
  object FDQuery1: TFDQuery
    Connection = ServerContainer1.FDConnection1
    SQL.Strings = (
      'select * from cliente')
    Left = 88
    Top = 40
  end
end
