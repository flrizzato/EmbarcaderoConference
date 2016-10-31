object FDResource1: TFDResource1
  OldCreateOrder = False
  Height = 282
  Width = 489
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=EC2014'
      'User_Name=sa'
      'Password=sysdba'
      'Server=localhost'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 64
    Top = 72
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 216
    Top = 16
  end
  object qrPessoa: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from Pessoa'
      'order by Nome')
    Left = 64
    Top = 120
    object qrPessoaCodigo: TIntegerField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrPessoaNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 50
    end
  end
  object spPessoaINSERT: TFDStoredProc
    Connection = FDConnection1
    StoredProcName = 'EC2014.dbo.spPessoaINSERT'
    Left = 64
    Top = 168
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        ParamType = ptResult
      end
      item
        Position = 2
        Name = '@Nome'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end>
  end
  object qrPessoaByID: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from Pessoa'
      'where Codigo = :Codigo')
    Left = 64
    Top = 216
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qrPessoaByIDCodigo: TFDAutoIncField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qrPessoaByIDNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 50
    end
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 376
    Top = 16
  end
end
