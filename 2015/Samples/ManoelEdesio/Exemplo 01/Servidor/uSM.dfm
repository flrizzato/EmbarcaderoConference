object SM: TSM
  OldCreateOrder = False
  Height = 380
  Width = 487
  object qryClientes: TFDQuery
    Connection = FDConn
    FetchOptions.AssignedValues = [evMode, evUnidirectional]
    FetchOptions.Mode = fmAll
    UpdateOptions.UpdateTableName = 'DC.dbo.TB_CLIENTE'
    SQL.Strings = (
      'SELECT * FROM TB_CLIENTE')
    Left = 183
    Top = 88
    object qryClientesIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
      Required = True
    end
    object qryClientesNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
    object qryClientesTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 10
    end
  end
  object FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink
    Left = 48
    Top = 24
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 48
    Top = 72
  end
  object FDStanStorageJSONLink: TFDStanStorageJSONLink
    Left = 48
    Top = 120
  end
  object FDStanStorageBinLink: TFDStanStorageBinLink
    Left = 48
    Top = 168
  end
  object FDConn: TFDConnection
    Params.Strings = (
      'Database=DC'
      'Server=CPRO28908\SQLEXPRESS'
      'OSAuthent=Yes'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 184
    Top = 24
  end
  object qryProdutos: TFDQuery
    Connection = FDConn
    FetchOptions.AssignedValues = [evMode, evUnidirectional]
    FetchOptions.Mode = fmAll
    UpdateOptions.UpdateTableName = 'DC.dbo.TB_CLIENTE'
    SQL.Strings = (
      'SELECT * FROM TB_PRODUTO')
    Left = 183
    Top = 152
    object qryProdutosID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
    end
    object qryProdutosNM_PRODUTO: TStringField
      FieldName = 'NM_PRODUTO'
      Size = 50
    end
    object qryProdutosVL_PRODUTO: TFloatField
      FieldName = 'VL_PRODUTO'
    end
    object qryProdutosDT_INCLUSAO: TBytesField
      FieldName = 'DT_INCLUSAO'
      ReadOnly = True
      Size = 8
    end
  end
  object tblPedido: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 336
    Top = 40
  end
  object tblPedidoItem: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 336
    Top = 104
  end
  object qryPedido: TFDQuery
    Connection = FDConn
    Left = 184
    Top = 216
  end
  object qryPedidoItem: TFDQuery
    Connection = FDConn
    Left = 184
    Top = 280
  end
  object stGeraId: TFDStoredProc
    Connection = FDConn
    StoredProcName = 'DC.dbo.PROC_GERA_ID'
    Left = 336
    Top = 176
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        ParamType = ptResult
      end
      item
        Position = 2
        Name = '@DS_TABELA'
        DataType = ftString
        ParamType = ptInput
        Size = 100
      end
      item
        Position = 3
        Name = '@DS_CAMPO'
        DataType = ftString
        ParamType = ptInput
        Size = 100
      end
      item
        Position = 4
        Name = '@ID_NEW'
        DataType = ftInteger
        ParamType = ptInputOutput
      end>
  end
  object qrySelectPedido: TFDQuery
    Connection = FDConn
    SQL.Strings = (
      'SELECT * FROM TB_PEDIDO')
    Left = 48
    Top = 224
  end
  object qrySelectPedidoItem: TFDQuery
    Connection = FDConn
    SQL.Strings = (
      'SELECT * FROM TB_PEDIDO_ITEM')
    Left = 48
    Top = 288
  end
end
