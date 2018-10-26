object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 342
  Width = 452
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
    MasterFields = 'IDCLIENTE'
    DetailFields = 'IDCLIENTE'
    Connection = FDConnection1
    SQL.Strings = (
      'select * from Telefones')
    Left = 56
    Top = 144
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
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\EC 2018\Banco\EC2018.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=localhost'
      'DriverID=IB')
    Left = 56
    Top = 32
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 248
    Top = 40
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 248
    Top = 96
  end
end
