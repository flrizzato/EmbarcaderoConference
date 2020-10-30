object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 494
  Width = 450
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\EC 2018\Banco\EC2018.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=localhost'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 32
  end
  object SqlClientes: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from Clientes')
    Left = 56
    Top = 96
    object SqlClientesIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SqlClientesNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 60
    end
  end
  object SqlTelefones: TFDQuery
    MasterSource = DataSource1
    MasterFields = 'IDCLIENTE'
    DetailFields = 'IDCLIENTE'
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'select * from Telefones where IdCliente = :IdCliente')
    Left = 56
    Top = 144
    ParamData = <
      item
        Name = 'IDCLIENTE'
        DataType = ftInteger
        ParamType = ptInput
        Value = 4
      end>
    object SqlTelefonesIDTELEFONE: TIntegerField
      FieldName = 'IDTELEFONE'
      Origin = 'IDTELEFONE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SqlTelefonesIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
      Required = True
    end
    object SqlTelefonesNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Required = True
    end
  end
  object DataSource1: TDataSource
    DataSet = SqlClientes
    Left = 136
    Top = 96
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = SqlClientes
    Options = [poCascadeDeletes, poCascadeUpdates, poAutoRefresh, poPropogateChanges, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    BeforeUpdateRecord = DataSetProvider1BeforeUpdateRecord
    OnGetTableName = DataSetProvider1GetTableName
    Left = 56
    Top = 192
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    OnReconcileError = ClientDataSet1ReconcileError
    Left = 480
    Top = 360
    object ClientDataSet1IDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ClientDataSet1NOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 60
    end
    object ClientDataSet1SqlTelefones: TDataSetField
      FieldName = 'SqlTelefones'
    end
  end
end
