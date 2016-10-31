object DML: TDML
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 382
  Width = 522
  object FDLocal: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Manoel\Desktop\Delphi Conference 2015\Exemplos' +
        '\Bancos\DCExemplo.s3db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 48
    Top = 8
  end
  object fdQryCliente: TFDQuery
    Connection = FDLocal
    SQL.Strings = (
      'SELECT * FROM TB_CLIENTE')
    Left = 48
    Top = 80
    object fdQryClienteIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
    end
    object fdQryClienteNOME: TWideStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
    object fdQryClienteTELEFONE: TWideStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 10
    end
    object fdQryClienteDT_INCLUSAO: TSQLTimeStampField
      FieldName = 'DT_INCLUSAO'
      Origin = 'DT_INCLUSAO'
    end
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 208
    Top = 8
  end
  object fdQryProduto: TFDQuery
    Connection = FDLocal
    SQL.Strings = (
      'SELECT * FROM TB_PRODUTO')
    Left = 48
    Top = 136
    object fdQryProdutoID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
      Origin = 'ID_PRODUTO'
    end
    object fdQryProdutoNM_PRODUTO: TWideStringField
      FieldName = 'NM_PRODUTO'
      Origin = 'NM_PRODUTO'
      Size = 50
    end
    object fdQryProdutoVL_PRODUTO: TFloatField
      FieldName = 'VL_PRODUTO'
      Origin = 'VL_PRODUTO'
    end
    object fdQryProdutoDT_INCLUSAO: TSQLTimeStampField
      FieldName = 'DT_INCLUSAO'
      Origin = 'DT_INCLUSAO'
    end
  end
  object fdQryPedido: TFDQuery
    Connection = FDLocal
    SQL.Strings = (
      'SELECT * FROM TB_PEDIDO')
    Left = 48
    Top = 192
    object fdQryPedidoID_PEDIDO: TIntegerField
      FieldName = 'ID_PEDIDO'
      Origin = 'ID_PEDIDO'
    end
    object fdQryPedidoID_CLIENTE: TIntegerField
      FieldName = 'ID_CLIENTE'
      Origin = 'ID_CLIENTE'
    end
    object fdQryPedidoDT_PEDIDO: TSQLTimeStampField
      FieldName = 'DT_PEDIDO'
      Origin = 'DT_PEDIDO'
    end
    object fdQryPedidoNR_PEDIDO: TWideStringField
      FieldName = 'NR_PEDIDO'
      Origin = 'NR_PEDIDO'
      Size = 10
    end
    object fdQryPedidoST_PEDIDO: TStringField
      FieldName = 'ST_PEDIDO'
      Origin = 'ST_PEDIDO'
      FixedChar = True
      Size = 1
    end
  end
  object fdQryPedidoItem: TFDQuery
    MasterSource = dsPedido
    MasterFields = 'ID_PEDIDO'
    Connection = FDLocal
    SQL.Strings = (
      'SELECT * FROM TB_PEDIDO_ITEM WHERE ID_PEDIDO=:ID_PEDIDO')
    Left = 48
    Top = 248
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object fdQryPedidoItemID_PEDIDO_ITEM: TIntegerField
      FieldName = 'ID_PEDIDO_ITEM'
      Origin = 'ID_PEDIDO_ITEM'
    end
    object fdQryPedidoItemID_PEDIDO: TIntegerField
      FieldName = 'ID_PEDIDO'
      Origin = 'ID_PEDIDO'
    end
    object fdQryPedidoItemID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
      Origin = 'ID_PRODUTO'
    end
    object fdQryPedidoItemQT_PRODUTO: TIntegerField
      FieldName = 'QT_PRODUTO'
      Origin = 'QT_PRODUTO'
    end
    object fdQryPedidoItemPRODUTO: TStringField
      FieldKind = fkLookup
      FieldName = 'PRODUTO'
      LookupDataSet = fdQryProduto
      LookupKeyFields = 'ID_PRODUTO'
      LookupResultField = 'NM_PRODUTO'
      KeyFields = 'ID_PRODUTO'
      Lookup = True
    end
  end
  object qryDinamico: TFDQuery
    Connection = FDLocal
    UpdateOptions.AssignedValues = [uvRefreshMode, uvAutoCommitUpdates]
    UpdateOptions.RefreshMode = rmAll
    Left = 217
    Top = 64
  end
  object qryDinamico2: TFDQuery
    Connection = FDLocal
    UpdateOptions.AssignedValues = [uvRefreshMode, uvAutoCommitUpdates]
    UpdateOptions.RefreshMode = rmAll
    Left = 217
    Top = 120
  end
  object dsPedido: TDataSource
    DataSet = fdQryPedido
    Left = 136
    Top = 200
  end
end
