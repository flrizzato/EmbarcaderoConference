object DataModule7: TDataModule7
  OldCreateOrder = False
  Height = 412
  Width = 549
  object ExtremedelphiConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=ExtremeDelphi')
    Connected = True
    LoginPrompt = False
    Left = 61
    Top = 24
  end
  object FDQueryMestre: TFDQuery
    Active = True
    Connection = ExtremedelphiConnection
    SQL.Strings = (
      'select * from Vendas')
    Left = 56
    Top = 96
  end
  object FDQueryDetalhe: TFDQuery
    Active = True
    IndexFieldNames = 'IdVenda'
    MasterSource = DtsRelacionamento
    MasterFields = 'Id'
    DetailFields = 'IdVenda'
    Connection = ExtremedelphiConnection
    SQL.Strings = (
      'select * from VendaProdutos where IdVenda = :Id')
    Left = 52
    Top = 196
    ParamData = <
      item
        Name = 'ID'
        DataType = ftAutoInc
        ParamType = ptInput
      end>
  end
  object DtsRelacionamento: TDataSource
    DataSet = FDQueryMestre
    Left = 56
    Top = 144
  end
end
