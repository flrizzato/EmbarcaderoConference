object ServerDelphiConference: TServerDelphiConference
  OldCreateOrder = False
  Height = 392
  Width = 290
  object sqlConexao: TSQLConnection
    ConnectionName = 'MSSQLConnection'
    DriverName = 'MSSQL9'
    LoginPrompt = False
    Params.Strings = (
      'SchemaOverride=%.dbo'
      'DriverUnit=Data.DBXMsSQL'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXMSSQLDriver180.b' +
        'pl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=18.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXMsSqlMetaDataCommandFactory,DbxMSSQLDr' +
        'iver180.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXMsSqlMetaDataCommandFact' +
        'ory,Borland.Data.DbxMSSQLDriver,Version=18.0.0.0,Culture=neutral' +
        ',PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverMSSQL'
      'LibraryName=dbxmss9.dll'
      'VendorLib=sqlncli.dll'
      'VendorLibWin64=sqlncli.dll'
      'HostName=EDESOFT6237\SQLEXPRESS'
      'Database=dc'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'OSAuthentication=False'
      'PrepareSQL=True'
      '='
      'User_Name=sa'
      'Password=12345678')
    Left = 56
    Top = 16
  end
  object sqlClientes: TSQLDataSet
    SchemaName = 'user'
    CommandText = 'select * from cliente'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqlConexao
    Left = 56
    Top = 72
  end
  object dspClientes: TDataSetProvider
    DataSet = sqlClientes
    Left = 136
    Top = 72
  end
  object sqlProdutos: TSQLDataSet
    SchemaName = 'user'
    CommandText = 'select * from produto'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqlConexao
    Left = 56
    Top = 144
  end
  object dspProdutos: TDataSetProvider
    DataSet = sqlProdutos
    Left = 136
    Top = 144
  end
  object sqlPedidos: TSQLDataSet
    SchemaName = 'user'
    CommandText = 'select * from pedido'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqlConexao
    Left = 56
    Top = 208
  end
  object dspPedidos: TDataSetProvider
    DataSet = sqlPedidos
    Left = 136
    Top = 208
  end
  object sqlItensPedido: TSQLDataSet
    SchemaName = 'dbo'
    CommandText = 'select * from ITENS_PEDIDO WHERE PEDIDO=:ID'
    DataSource = dsRelPedItens
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptInput
      end>
    SQLConnection = sqlConexao
    Left = 56
    Top = 272
  end
  object dsRelPedItens: TDataSource
    DataSet = sqlPedidos
    Left = 136
    Top = 272
  end
  object sqlDinamico: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqlConexao
    Left = 56
    Top = 328
  end
  object dspDinamico: TDataSetProvider
    DataSet = sqlDinamico
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 136
    Top = 328
  end
end
