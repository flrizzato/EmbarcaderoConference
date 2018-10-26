object DMLocalSQL: TDMLocalSQL
  OldCreateOrder = False
  Height = 323
  Width = 774
  object ConnectionFirebird: TFDConnection
    Params.Strings = (
      
        'Database=C:\ECON2018\7-3-FireDAC-Recursos-que-voc'#234'-n'#227'o-conhecia\' +
        '00 - DB\ECON2018.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 88
    Top = 32
  end
  object ConnectionPostgreSQL: TFDConnection
    Params.Strings = (
      'Database=econ2018'
      'User_Name=postgres'
      'Password=postgres'
      'Server=localhost'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 88
    Top = 112
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\10\bin\libpq.dll'
    Left = 696
    Top = 112
  end
  object Clientes: TFDQuery
    Active = True
    LocalSQL = LocalSQL
    Connection = ConnectionFirebird
    SQL.Strings = (
      'SELECT'
      '    *'
      'FROM'
      '    CLIENTES')
    Left = 192
    Top = 32
    object ClientesID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ClientesNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 100
    end
  end
  object Produtos: TFDQuery
    Active = True
    LocalSQL = LocalSQL
    Connection = ConnectionFirebird
    SQL.Strings = (
      'SELECT'
      '    *'
      'FROM'
      '    PRODUTOS')
    Left = 320
    Top = 32
    object ProdutosID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ProdutosNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 100
    end
    object ProdutosVALOR: TBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Required = True
      Precision = 18
      Size = 2
    end
  end
  object Vendas: TFDQuery
    Active = True
    LocalSQL = LocalSQL
    Connection = ConnectionPostgreSQL
    SQL.Strings = (
      'SELECT'
      '    *'
      'FROM'
      '    VENDAS')
    Left = 192
    Top = 112
  end
  object LocalSQL: TFDLocalSQL
    Connection = ConnectionLocal
    Active = True
    DataSets = <>
    Left = 88
    Top = 264
  end
  object VendasFull: TFDQuery
    Connection = ConnectionLocal
    SQL.Strings = (
      'SELECT'
      '    v.id venda,'
      '    c.id id_cliente,'
      '    c.nome cliente,'
      '    p.id id_produto,'
      '    p.nome produto'
      'FROM'
      '  Vendas v'
      'JOIN Clientes c ON c.id = v.id_cliente'
      'JOIN Produtos p ON p.id = v.id_produto')
    Left = 192
    Top = 192
    object VendasFullvenda: TIntegerField
      FieldName = 'venda'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object VendasFullid_cliente: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'id_cliente'
      Origin = 'ID'
      ProviderFlags = []
      ReadOnly = True
    end
    object VendasFullcliente: TStringField
      AutoGenerateValue = arDefault
      DisplayWidth = 50
      FieldName = 'cliente'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object VendasFullid_produto: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'id_produto'
      Origin = 'ID'
      ProviderFlags = []
      ReadOnly = True
    end
    object VendasFullproduto: TStringField
      AutoGenerateValue = arDefault
      DisplayWidth = 50
      FieldName = 'produto'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
  end
  object ConnectionLocal: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 88
    Top = 192
  end
end
