object DSServerClientes: TDSServerClientes
  OldCreateOrder = False
  Height = 449
  Width = 780
  object sqlConnCliente: TSQLConnection
    ConnectionName = 'PROTHEUS_11_SR7'
    DriverName = 'MSSQL'
    KeepConnection = False
    LoginPrompt = False
    Params.Strings = (
      'DriverName=MSSQL'
      'SchemaOverride=%.dbo'
      'DriverUnit=Data.DBXMSSQL'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver240.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=24.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXMsSqlMetaDataCommandFactory,DbxMSSQLDr' +
        'iver240.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXMsSqlMetaDataCommandFact' +
        'ory,Borland.Data.DbxMSSQLDriver,Version=24.0.0.0,Culture=neutral' +
        ',PublicKeyToken=91d62ebb5b0d1b1b'
      'LibraryName=dbxmss.dll'
      'VendorLib=sqlncli10.dll'
      'VendorLibWin64=sqlncli10.dll'
      'HostName=192.168.0.7'
      'Database=Protheus11'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'OSAuthentication=False'
      'PrepareSQL=True'
      'User_Name=sa'
      'Password=distrimed@2015'
      'BlobSize=-1'
      'ErrorResourceFile='
      'OS Authentication=False'
      'Prepare SQL=False')
    Left = 64
    Top = 24
  end
  object FDConnProtheus11_r7: TFDConnection
    Params.Strings = (
      'Database=Protheus11'
      'DriverID=MSSQL'
      'Address=192.168.0.7'
      'User_Name=sa'
      'Password=distrimed@2015')
    LoginPrompt = False
    Left = 454
    Top = 7
  end
  object fdqPedidosCli: TFDQuery
    Connection = FDConnProtheus11_r7
    SQL.Strings = (
      'SELECT top 10 C5_NUM PEDIDO, s.C5_EMISSAO DATA, '
      's.C5_NOTA NOTA, s.C5_OBS OBS'
      'FROM SC5000 s'
      'WHERE s.C5_CLIENTE = :par_CODCLIENTE AND s.D_E_L_E_T_ = '#39#39
      'ORDER BY s.C5_EMISSAO desc, s.C5_HRGRV desc')
    Left = 456
    Top = 64
    ParamData = <
      item
        Name = 'PAR_CODCLIENTE'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 168
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 160
    Top = 72
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 96
    Top = 144
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 240
    Top = 160
  end
  object fdqAutentCliente: TFDQuery
    Connection = FDConnProtheus11_r7
    SQL.Strings = (
      'SELECT s.A1_COD CLIENTE, s.A1_NOME RAZAO, s.A1_NREDUZ FANTASIA, '
      '  s.A1_CONTATO CONTATO, s.A1_MSBLQL BLOQ '
      'FROM SA1000 s WITH(NOLOCK) '
      '  WHERE s.A1_CGC = :parCNPJ AND s.D_E_L_E_T_ ='#39#39)
    Left = 544
    Top = 64
    ParamData = <
      item
        Name = 'PARCNPJ'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object fdqTitulosAB: TFDQuery
    Connection = FDConnProtheus11_r7
    SQL.Strings = (
      'SELECT s.E1_NUM TITULO, s.E1_EMISSAO EMISSAO, '
      's.E1_PEDIDO PEDIDO, s.E1_TIPO TIPO, '
      's.E1_PARCELA PARCELA, s.E1_VENCREA VENCIMENTO, '
      's.E1_VALOR VALOR, s.E1_SALDO SALDO_PAGAR '
      'FROM SE1000 s '
      'WHERE s.E1_CLIENTE = :par_Cliente '
      'AND s.E1_SALDO > 0 AND s.D_E_L_E_T_ = '#39#39
      'order by s.E1_EMISSAO, s.E1_PEDIDO, s.E1_PARCELA,'
      's.E1_VENCREA'
      '')
    Left = 448
    Top = 128
    ParamData = <
      item
        Name = 'PAR_CLIENTE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object fdqTitulosNF: TFDQuery
    Connection = FDConnProtheus11_r7
    SQL.Strings = (
      'SELECT s.E1_NUM TITULO, s.E1_EMISSAO EMISSAO, '
      's.E1_PEDIDO PEDIDO, s.E1_TIPO TIPO, '
      's.E1_PARCELA PARCELA, s.E1_VENCREA VENCIMENTO, '
      's.E1_VALOR VALOR, s.E1_SALDO SALDO_PAGAR '
      'FROM SE1000 s '
      'WHERE s.E1_CLIENTE = :par_Cliente AND '
      's.E1_NUM = :par_Nota AND s.D_E_L_E_T_ = '#39#39
      'order by s.E1_VENCREA, s.E1_PARCELA')
    Left = 544
    Top = 128
    ParamData = <
      item
        Name = 'PAR_CLIENTE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PAR_NOTA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object fdqAtualizaStatusXMLEnvio: TFDQuery
    Connection = FDConnProtheus11_r7
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvRefreshDelete, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.RefreshDelete = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 456
    Top = 200
  end
  object FDCommAtualizaXML: TFDCommand
    Connection = FDConnProtheus11_r7
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    Left = 440
    Top = 304
  end
  object FDUpdateSQL1: TFDUpdateSQL
    Connection = FDConnProtheus11_r7
    Left = 552
    Top = 272
  end
end
