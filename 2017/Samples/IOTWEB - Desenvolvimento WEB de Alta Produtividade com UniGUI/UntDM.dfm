object DM: TDM
  OldCreateOrder = False
  Height = 317
  Width = 468
  object fdConn: TFDConnection
    Params.Strings = (
      
        'Database=D:\OneDrive\99-Temp\1 - EC2017\Relat'#243'rios Mobile\Exempl' +
        'o\Database\Relatorios.s3db'
      'OpenMode=ReadWrite'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 40
  end
  object qryClientes: TFDQuery
    Connection = fdConn
    SQL.Strings = (
      'SELECT * FROM CLIENTES')
    Left = 56
    Top = 104
    object qryClientesCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
    end
    object qryClientesapelido: TStringField
      FieldName = 'apelido'
      Origin = 'apelido'
      Size = 30
    end
    object qryClientesrazaosocial: TStringField
      FieldName = 'razaosocial'
      Origin = 'razaosocial'
      Size = 100
    end
    object qryClientesIMPRIMIR: TStringField
      FieldKind = fkCalculated
      FieldName = 'IMPRIMIR'
      OnGetText = qryClientesIMPRIMIRGetText
      Size = 100
      Calculated = True
    end
  end
  object DataSource1: TDataSource
    DataSet = qryClientes
    Left = 56
    Top = 160
  end
end
