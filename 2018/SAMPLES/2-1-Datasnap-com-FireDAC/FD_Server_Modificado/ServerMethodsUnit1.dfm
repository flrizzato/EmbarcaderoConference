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
      'INSERT INTO CLIENTES'
      '(IDCLIENTE, NOME)'
      'VALUES (:NEW_IDCLIENTE, :NEW_NOME)')
    ModifySQL.Strings = (
      'UPDATE CLIENTES'
      'SET IDCLIENTE = :NEW_IDCLIENTE, NOME = :NEW_NOME'
      'WHERE IDCLIENTE = :OLD_IDCLIENTE')
    DeleteSQL.Strings = (
      'DELETE FROM CLIENTES'
      'WHERE IDCLIENTE = :OLD_IDCLIENTE')
    FetchRowSQL.Strings = (
      'SELECT IDCLIENTE, NOME'
      'FROM CLIENTES'
      'WHERE IDCLIENTE = :IDCLIENTE')
    Left = 152
    Top = 96
  end
  object ComandosTelefones: TFDUpdateSQL
    Connection = FDConnection1
    InsertSQL.Strings = (
      'INSERT INTO TELEFONES'
      '(IDTELEFONE, IDCLIENTE, NUMERO)'
      'VALUES (:NEW_IDTELEFONE, :NEW_IDCLIENTE, :NEW_NUMERO)')
    ModifySQL.Strings = (
      'UPDATE TELEFONES'
      
        'SET IDTELEFONE = :NEW_IDTELEFONE, IDCLIENTE = :NEW_IDCLIENTE, NU' +
        'MERO = :NEW_NUMERO'
      'WHERE IDTELEFONE = :OLD_IDTELEFONE')
    DeleteSQL.Strings = (
      'DELETE FROM TELEFONES'
      'WHERE IDTELEFONE = :OLD_IDTELEFONE')
    FetchRowSQL.Strings = (
      'SELECT IDTELEFONE, IDCLIENTE, NUMERO'
      'FROM TELEFONES'
      'WHERE IDTELEFONE = :IDTELEFONE')
    Left = 152
    Top = 144
  end
end
