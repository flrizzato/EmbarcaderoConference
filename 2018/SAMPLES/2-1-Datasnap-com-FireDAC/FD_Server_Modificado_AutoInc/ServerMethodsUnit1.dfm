object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 342
  Width = 466
  object SqlClientes: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from Clientes')
    Left = 56
    Top = 96
    object SqlClientesIdCliente: TFDAutoIncField
      FieldName = 'IdCliente'
      Origin = 'IdCliente'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object SqlClientesNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
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
    object SqlTelefonesIdTelefone: TFDAutoIncField
      FieldName = 'IdTelefone'
      Origin = 'IdTelefone'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object SqlTelefonesIdCliente: TIntegerField
      FieldName = 'IdCliente'
      Origin = 'IdCliente'
      Required = True
    end
    object SqlTelefonesNumero: TStringField
      FieldName = 'Numero'
      Origin = 'Numero'
      Required = True
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=EC2018'
      'User_Name=sa'
      'Password=732154Al#'
      'Server=localhost'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 32
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 368
    Top = 40
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 368
    Top = 96
  end
  object ComandosClientes: TFDUpdateSQL
    Connection = FDConnection1
    InsertSQL.Strings = (
      'INSERT INTO EC2018.dbo.Clientes'
      '(Nome)'
      'VALUES (:NEW_Nome);'
      'SELECT SCOPE_IDENTITY() AS IdCliente')
    ModifySQL.Strings = (
      'UPDATE EC2018.dbo.Clientes'
      'SET Nome = :NEW_Nome'
      'WHERE IdCliente = :OLD_IdCliente;'
      'SELECT IdCliente'
      'FROM EC2018.dbo.Clientes'
      'WHERE IdCliente = :NEW_IdCliente')
    DeleteSQL.Strings = (
      'DELETE FROM EC2018.dbo.Clientes'
      'WHERE IdCliente = :OLD_IdCliente')
    FetchRowSQL.Strings = (
      'SELECT SCOPE_IDENTITY() AS IdCliente, Nome'
      'FROM EC2018.dbo.Clientes'
      'WHERE IdCliente = :IdCliente')
    Left = 152
    Top = 96
  end
  object ComandosTelefones: TFDUpdateSQL
    Connection = FDConnection1
    InsertSQL.Strings = (
      'INSERT INTO EC2018.dbo.Telefones'
      '(IdCliente, Numero)'
      'VALUES (:NEW_IdCliente, :NEW_Numero);'
      'SELECT SCOPE_IDENTITY() AS IdTelefone')
    ModifySQL.Strings = (
      'UPDATE EC2018.dbo.Telefones'
      'SET IdCliente = :NEW_IdCliente, Numero = :NEW_Numero'
      'WHERE IdTelefone = :OLD_IdTelefone;'
      'SELECT IdTelefone'
      'FROM EC2018.dbo.Telefones'
      'WHERE IdTelefone = :NEW_IdTelefone')
    DeleteSQL.Strings = (
      'DELETE FROM EC2018.dbo.Telefones'
      'WHERE IdTelefone = :OLD_IdTelefone')
    FetchRowSQL.Strings = (
      'SELECT SCOPE_IDENTITY() AS IdTelefone, IdCliente, Numero'
      'FROM EC2018.dbo.Telefones'
      'WHERE IdTelefone = :IdTelefone')
    Left = 152
    Top = 144
  end
end
