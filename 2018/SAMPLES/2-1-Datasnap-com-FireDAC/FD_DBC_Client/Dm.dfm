object Dtm: TDtm
  OldCreateOrder = False
  Height = 384
  Width = 402
  object SQLConnection1: TSQLConnection
    ConnectionName = 'EC2018'
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=DataSnap'
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b')
    Left = 64
    Top = 56
    UniqueId = '{73BDD26D-A216-4744-A890-B1DC76D12533}'
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TServerMethods1'
    SQLConnection = SQLConnection1
    Left = 64
    Top = 112
  end
  object CdsClientes: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    RemoteServer = DSProviderConnection1
    OnNewRecord = CdsClientesNewRecord
    OnReconcileError = CdsClientesReconcileError
    Left = 64
    Top = 168
    object CdsClientesIDCLIENTE: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CdsClientesNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 60
    end
    object CdsClientesSqlTelefones: TDataSetField
      FieldName = 'SqlTelefones'
      Visible = False
    end
  end
  object CdsTelefones: TClientDataSet
    Aggregates = <>
    DataSetField = CdsClientesSqlTelefones
    Params = <>
    OnNewRecord = CdsTelefonesNewRecord
    Left = 64
    Top = 224
    object CdsTelefonesIDTELEFONE: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'IDTELEFONE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CdsTelefonesIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Required = True
    end
    object CdsTelefonesNUMERO: TStringField
      FieldName = 'NUMERO'
      Required = True
    end
  end
end
