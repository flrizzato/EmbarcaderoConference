object DMDados: TDMDados
  OldCreateOrder = False
  Height = 265
  Width = 346
  object ConexaoServerDC: TSQLConnection
    ConnectionName = 'DataSnapCONNECTION'
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=17.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'DriverName=DataSnap'
      'HostName=192.168.1.137'
      'port=211'
      'Filters={}')
    Connected = True
    Left = 56
    Top = 16
  end
  object DSProviderConn: TDSProviderConnection
    ServerClassName = 'TServerDelphiConference'
    Connected = True
    SQLConnection = ConexaoServerDC
    Left = 56
    Top = 80
  end
  object cdsclientes: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspClientes'
    RemoteServer = DSProviderConn
    Left = 160
    Top = 16
  end
  object cdsProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspProdutos'
    RemoteServer = DSProviderConn
    Left = 160
    Top = 72
  end
  object cdsPedidos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPedidos'
    RemoteServer = DSProviderConn
    Left = 160
    Top = 136
    object cdsPedidosID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsPedidosNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 15
    end
    object cdsPedidosINCLUSAO: TDateField
      FieldName = 'INCLUSAO'
    end
    object cdsPedidosPREV_ENTREGA: TDateField
      FieldName = 'PREV_ENTREGA'
    end
    object cdsPedidosENTREGA: TSQLTimeStampField
      FieldName = 'ENTREGA'
    end
    object cdsPedidosSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 2
    end
    object cdsPedidosVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
    end
    object cdsPedidosCLIENTE: TIntegerField
      FieldName = 'CLIENTE'
    end
    object cdsPedidossqlItensPedido: TDataSetField
      FieldName = 'sqlItensPedido'
    end
  end
  object cdsItensPedido: TClientDataSet
    Aggregates = <>
    DataSetField = cdsPedidossqlItensPedido
    Params = <>
    Left = 160
    Top = 192
  end
  object dsClientes: TDataSource
    DataSet = cdsclientes
    Left = 240
    Top = 16
  end
  object dsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 240
    Top = 72
  end
  object dsPedidos: TDataSource
    DataSet = cdsPedidos
    Left = 240
    Top = 136
  end
  object dsItensPedido: TDataSource
    DataSet = cdsItensPedido
    Left = 240
    Top = 192
  end
end
