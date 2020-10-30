object IWUserSession: TIWUserSession
  OldCreateOrder = False
  Height = 423
  Width = 732
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Demos Intraweb\Embarcadero Conference 2018\Win32\Deb' +
        'ug\BancoDados\EC2018.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=localhost'
      'Port=3050'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    LoginPrompt = False
    Left = 72
    Top = 136
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 208
    Top = 136
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 360
    Top = 136
  end
  object FDQProdutos: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 10000000
    SQL.Strings = (
      'Select * from Produto'
      'Where COD_PRODUTO = :PRODUTO')
    Left = 72
    Top = 208
    ParamData = <
      item
        Name = 'PRODUTO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object FDQProdutosCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
      Origin = 'COD_PRODUTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQProdutosCOD_FABRICANTE: TIntegerField
      FieldName = 'COD_FABRICANTE'
      Origin = 'COD_FABRICANTE'
    end
    object FDQProdutosCOD_FORNECEDOR: TIntegerField
      FieldName = 'COD_FORNECEDOR'
      Origin = 'COD_FORNECEDOR'
    end
    object FDQProdutosCOD_GRUPO: TIntegerField
      FieldName = 'COD_GRUPO'
      Origin = 'COD_GRUPO'
    end
    object FDQProdutosCOD_NCM: TIntegerField
      FieldName = 'COD_NCM'
      Origin = 'COD_NCM'
    end
    object FDQProdutosPROD_CADASTRO: TDateField
      FieldName = 'PROD_CADASTRO'
      Origin = 'PROD_CADASTRO'
    end
    object FDQProdutosPROD_ATUALIZACAO: TDateField
      FieldName = 'PROD_ATUALIZACAO'
      Origin = 'PROD_ATUALIZACAO'
    end
    object FDQProdutosPROD_DESCRICAO: TStringField
      FieldName = 'PROD_DESCRICAO'
      Origin = 'PROD_DESCRICAO'
      Size = 60
    end
    object FDQProdutosPROD_COD_BARRA: TStringField
      FieldName = 'PROD_COD_BARRA'
      Origin = 'PROD_COD_BARRA'
    end
    object FDQProdutosPROD_REF_FABRICA: TStringField
      FieldName = 'PROD_REF_FABRICA'
      Origin = 'PROD_REF_FABRICA'
      Size = 60
    end
    object FDQProdutosPROD_NCM: TStringField
      FieldName = 'PROD_NCM'
      Origin = 'PROD_NCM'
      Size = 10
    end
    object FDQProdutosPROD_UN: TStringField
      FieldName = 'PROD_UN'
      Origin = 'PROD_UN'
      Size = 10
    end
    object FDQProdutosPROD_PESO_LIQ: TBCDField
      FieldName = 'PROD_PESO_LIQ'
      Origin = 'PROD_PESO_LIQ'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_PESO_BRUTO: TBCDField
      FieldName = 'PROD_PESO_BRUTO'
      Origin = 'PROD_PESO_BRUTO'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_CFOP_ENTRADA: TStringField
      FieldName = 'PROD_CFOP_ENTRADA'
      Origin = 'PROD_CFOP_ENTRADA'
      Size = 4
    end
    object FDQProdutosPROD_ESTOQUE: TBCDField
      FieldName = 'PROD_ESTOQUE'
      Origin = 'PROD_ESTOQUE'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_ALERTA: TBCDField
      FieldName = 'PROD_ALERTA'
      Origin = 'PROD_ALERTA'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_LOCALIZACAO: TStringField
      FieldName = 'PROD_LOCALIZACAO'
      Origin = 'PROD_LOCALIZACAO'
      Size = 9
    end
    object FDQProdutosPROD_ULTIMA_VENDA: TDateField
      FieldName = 'PROD_ULTIMA_VENDA'
      Origin = 'PROD_ULTIMA_VENDA'
    end
    object FDQProdutosPROD_ULTIMA_COMPRA: TDateField
      FieldName = 'PROD_ULTIMA_COMPRA'
      Origin = 'PROD_ULTIMA_COMPRA'
    end
    object FDQProdutosPROD_MARCA: TStringField
      FieldName = 'PROD_MARCA'
      Origin = 'PROD_MARCA'
      Size = 60
    end
    object FDQProdutosPROD_FORNECDOR: TStringField
      FieldName = 'PROD_FORNECDOR'
      Origin = 'PROD_FORNECDOR'
      Size = 60
    end
    object FDQProdutosPROD_GRUPO: TStringField
      FieldName = 'PROD_GRUPO'
      Origin = 'PROD_GRUPO'
      Size = 60
    end
    object FDQProdutosPROD_CUSTO: TBCDField
      FieldName = 'PROD_CUSTO'
      Origin = 'PROD_CUSTO'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_POR_IPI: TBCDField
      FieldName = 'PROD_POR_IPI'
      Origin = 'PROD_POR_IPI'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_POR_FRETE: TBCDField
      FieldName = 'PROD_POR_FRETE'
      Origin = 'PROD_POR_FRETE'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_POR_TRIB: TBCDField
      FieldName = 'PROD_POR_TRIB'
      Origin = 'PROD_POR_TRIB'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_POR_ICMS_DEBITO: TBCDField
      FieldName = 'PROD_POR_ICMS_DEBITO'
      Origin = 'PROD_POR_ICMS_DEBITO'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_POR_ICMS_CREDITO: TBCDField
      FieldName = 'PROD_POR_ICMS_CREDITO'
      Origin = 'PROD_POR_ICMS_CREDITO'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_ICMS_PAGAR: TBCDField
      FieldName = 'PROD_ICMS_PAGAR'
      Origin = 'PROD_ICMS_PAGAR'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_POR_FEDERAL: TBCDField
      FieldName = 'PROD_POR_FEDERAL'
      Origin = 'PROD_POR_FEDERAL'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_POR_CUSTO_FIXO: TBCDField
      FieldName = 'PROD_POR_CUSTO_FIXO'
      Origin = 'PROD_POR_CUSTO_FIXO'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_POR_COMISSAO: TBCDField
      FieldName = 'PROD_POR_COMISSAO'
      Origin = 'PROD_POR_COMISSAO'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_PRECO_FINAL: TBCDField
      FieldName = 'PROD_PRECO_FINAL'
      Origin = 'PROD_PRECO_FINAL'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_MARGEM_LUCRO: TBCDField
      FieldName = 'PROD_MARGEM_LUCRO'
      Origin = 'PROD_MARGEM_LUCRO'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_PRECO_VENDA: TBCDField
      FieldName = 'PROD_PRECO_VENDA'
      Origin = 'PROD_PRECO_VENDA'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_INFO_ADICIONAIS: TStringField
      FieldName = 'PROD_INFO_ADICIONAIS'
      Origin = 'PROD_INFO_ADICIONAIS'
      Size = 255
    end
    object FDQProdutosPROD_IMAGEM: TStringField
      FieldName = 'PROD_IMAGEM'
      Origin = 'PROD_IMAGEM'
      Size = 255
    end
    object FDQProdutosPROD_ORIGEM: TIntegerField
      FieldName = 'PROD_ORIGEM'
      Origin = 'PROD_ORIGEM'
    end
    object FDQProdutosPROD_CSOSN: TIntegerField
      FieldName = 'PROD_CSOSN'
      Origin = 'PROD_CSOSN'
    end
    object FDQProdutosPROD_PIS: TIntegerField
      FieldName = 'PROD_PIS'
      Origin = 'PROD_PIS'
    end
    object FDQProdutosPROD_COFINS: TIntegerField
      FieldName = 'PROD_COFINS'
      Origin = 'PROD_COFINS'
    end
    object FDQProdutosPROD_IPI: TIntegerField
      FieldName = 'PROD_IPI'
      Origin = 'PROD_IPI'
    end
    object FDQProdutosPROD_TOTAL_COMPRADO: TBCDField
      FieldName = 'PROD_TOTAL_COMPRADO'
      Origin = 'PROD_TOTAL_COMPRADO'
      Precision = 18
      Size = 2
    end
    object FDQProdutosCOD_FINALIDADE: TIntegerField
      FieldName = 'COD_FINALIDADE'
      Origin = 'COD_FINALIDADE'
    end
    object FDQProdutosCOD_STATUS: TIntegerField
      FieldName = 'COD_STATUS'
      Origin = 'COD_STATUS'
    end
    object FDQProdutosCOD_LINHA: TIntegerField
      FieldName = 'COD_LINHA'
      Origin = 'COD_LINHA'
    end
    object FDQProdutosCOD_SIMILAR: TStringField
      FieldName = 'COD_SIMILAR'
      Origin = 'COD_SIMILAR'
      Size = 60
    end
    object FDQProdutosPROD_SUBST_POR: TBCDField
      FieldName = 'PROD_SUBST_POR'
      Origin = 'PROD_SUBST_POR'
      Precision = 18
      Size = 2
    end
    object FDQProdutosPROD_PROD_IMPOSTO: TBCDField
      FieldName = 'PROD_PROD_IMPOSTO'
      Origin = 'PROD_PROD_IMPOSTO'
      Precision = 18
      Size = 2
    end
    object FDQProdutosCOD_CFOP: TIntegerField
      FieldName = 'COD_CFOP'
      Origin = 'COD_CFOP'
    end
  end
  object FDQQuery: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 10000000
    Left = 208
    Top = 208
  end
  object FDQProdutos2: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 10000000
    SQL.Strings = (
      'Select * from Produto'
      'Where Prod_Descricao <> '#39#39
      'order by prod_descricao')
    Left = 72
    Top = 272
    object FDQProdutos2COD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
      Origin = 'COD_PRODUTO'
      Required = True
    end
    object FDQProdutos2COD_FABRICANTE: TIntegerField
      FieldName = 'COD_FABRICANTE'
      Origin = 'COD_FABRICANTE'
    end
    object FDQProdutos2COD_FORNECEDOR: TIntegerField
      FieldName = 'COD_FORNECEDOR'
      Origin = 'COD_FORNECEDOR'
    end
    object FDQProdutos2COD_GRUPO: TIntegerField
      FieldName = 'COD_GRUPO'
      Origin = 'COD_GRUPO'
    end
    object FDQProdutos2COD_NCM: TIntegerField
      FieldName = 'COD_NCM'
      Origin = 'COD_NCM'
    end
    object FDQProdutos2PROD_CADASTRO: TDateField
      FieldName = 'PROD_CADASTRO'
      Origin = 'PROD_CADASTRO'
    end
    object FDQProdutos2PROD_ATUALIZACAO: TDateField
      FieldName = 'PROD_ATUALIZACAO'
      Origin = 'PROD_ATUALIZACAO'
    end
    object FDQProdutos2PROD_DESCRICAO: TStringField
      FieldName = 'PROD_DESCRICAO'
      Origin = 'PROD_DESCRICAO'
      Size = 60
    end
    object FDQProdutos2PROD_COD_BARRA: TStringField
      FieldName = 'PROD_COD_BARRA'
      Origin = 'PROD_COD_BARRA'
    end
    object FDQProdutos2PROD_REF_FABRICA: TStringField
      FieldName = 'PROD_REF_FABRICA'
      Origin = 'PROD_REF_FABRICA'
      Size = 60
    end
    object FDQProdutos2PROD_NCM: TStringField
      FieldName = 'PROD_NCM'
      Origin = 'PROD_NCM'
      Size = 10
    end
    object FDQProdutos2PROD_UN: TStringField
      FieldName = 'PROD_UN'
      Origin = 'PROD_UN'
      Size = 10
    end
    object FDQProdutos2PROD_PESO_LIQ: TBCDField
      FieldName = 'PROD_PESO_LIQ'
      Origin = 'PROD_PESO_LIQ'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_PESO_BRUTO: TBCDField
      FieldName = 'PROD_PESO_BRUTO'
      Origin = 'PROD_PESO_BRUTO'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_CFOP_ENTRADA: TStringField
      FieldName = 'PROD_CFOP_ENTRADA'
      Origin = 'PROD_CFOP_ENTRADA'
      Size = 4
    end
    object FDQProdutos2PROD_ESTOQUE: TBCDField
      FieldName = 'PROD_ESTOQUE'
      Origin = 'PROD_ESTOQUE'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_ALERTA: TBCDField
      FieldName = 'PROD_ALERTA'
      Origin = 'PROD_ALERTA'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_LOCALIZACAO: TStringField
      FieldName = 'PROD_LOCALIZACAO'
      Origin = 'PROD_LOCALIZACAO'
      Size = 9
    end
    object FDQProdutos2PROD_ULTIMA_VENDA: TDateField
      FieldName = 'PROD_ULTIMA_VENDA'
      Origin = 'PROD_ULTIMA_VENDA'
    end
    object FDQProdutos2PROD_ULTIMA_COMPRA: TDateField
      FieldName = 'PROD_ULTIMA_COMPRA'
      Origin = 'PROD_ULTIMA_COMPRA'
    end
    object FDQProdutos2PROD_MARCA: TStringField
      FieldName = 'PROD_MARCA'
      Origin = 'PROD_MARCA'
      Size = 60
    end
    object FDQProdutos2PROD_FORNECDOR: TStringField
      FieldName = 'PROD_FORNECDOR'
      Origin = 'PROD_FORNECDOR'
      Size = 60
    end
    object FDQProdutos2PROD_GRUPO: TStringField
      FieldName = 'PROD_GRUPO'
      Origin = 'PROD_GRUPO'
      Size = 60
    end
    object FDQProdutos2PROD_CUSTO: TBCDField
      FieldName = 'PROD_CUSTO'
      Origin = 'PROD_CUSTO'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_POR_IPI: TBCDField
      FieldName = 'PROD_POR_IPI'
      Origin = 'PROD_POR_IPI'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_POR_FRETE: TBCDField
      FieldName = 'PROD_POR_FRETE'
      Origin = 'PROD_POR_FRETE'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_POR_TRIB: TBCDField
      FieldName = 'PROD_POR_TRIB'
      Origin = 'PROD_POR_TRIB'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_POR_ICMS_DEBITO: TBCDField
      FieldName = 'PROD_POR_ICMS_DEBITO'
      Origin = 'PROD_POR_ICMS_DEBITO'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_POR_ICMS_CREDITO: TBCDField
      FieldName = 'PROD_POR_ICMS_CREDITO'
      Origin = 'PROD_POR_ICMS_CREDITO'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_ICMS_PAGAR: TBCDField
      FieldName = 'PROD_ICMS_PAGAR'
      Origin = 'PROD_ICMS_PAGAR'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_POR_FEDERAL: TBCDField
      FieldName = 'PROD_POR_FEDERAL'
      Origin = 'PROD_POR_FEDERAL'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_POR_CUSTO_FIXO: TBCDField
      FieldName = 'PROD_POR_CUSTO_FIXO'
      Origin = 'PROD_POR_CUSTO_FIXO'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_POR_COMISSAO: TBCDField
      FieldName = 'PROD_POR_COMISSAO'
      Origin = 'PROD_POR_COMISSAO'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_PRECO_FINAL: TBCDField
      FieldName = 'PROD_PRECO_FINAL'
      Origin = 'PROD_PRECO_FINAL'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_MARGEM_LUCRO: TBCDField
      FieldName = 'PROD_MARGEM_LUCRO'
      Origin = 'PROD_MARGEM_LUCRO'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_PRECO_VENDA: TBCDField
      FieldName = 'PROD_PRECO_VENDA'
      Origin = 'PROD_PRECO_VENDA'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_INFO_ADICIONAIS: TStringField
      FieldName = 'PROD_INFO_ADICIONAIS'
      Origin = 'PROD_INFO_ADICIONAIS'
      Size = 255
    end
    object FDQProdutos2PROD_IMAGEM: TStringField
      FieldName = 'PROD_IMAGEM'
      Origin = 'PROD_IMAGEM'
      Size = 255
    end
    object FDQProdutos2PROD_ORIGEM: TIntegerField
      FieldName = 'PROD_ORIGEM'
      Origin = 'PROD_ORIGEM'
    end
    object FDQProdutos2PROD_CSOSN: TIntegerField
      FieldName = 'PROD_CSOSN'
      Origin = 'PROD_CSOSN'
    end
    object FDQProdutos2PROD_PIS: TIntegerField
      FieldName = 'PROD_PIS'
      Origin = 'PROD_PIS'
    end
    object FDQProdutos2PROD_COFINS: TIntegerField
      FieldName = 'PROD_COFINS'
      Origin = 'PROD_COFINS'
    end
    object FDQProdutos2PROD_IPI: TIntegerField
      FieldName = 'PROD_IPI'
      Origin = 'PROD_IPI'
    end
    object FDQProdutos2PROD_TOTAL_COMPRADO: TBCDField
      FieldName = 'PROD_TOTAL_COMPRADO'
      Origin = 'PROD_TOTAL_COMPRADO'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2COD_FINALIDADE: TIntegerField
      FieldName = 'COD_FINALIDADE'
      Origin = 'COD_FINALIDADE'
    end
    object FDQProdutos2COD_STATUS: TIntegerField
      FieldName = 'COD_STATUS'
      Origin = 'COD_STATUS'
    end
    object FDQProdutos2COD_LINHA: TIntegerField
      FieldName = 'COD_LINHA'
      Origin = 'COD_LINHA'
    end
    object FDQProdutos2COD_SIMILAR: TStringField
      FieldName = 'COD_SIMILAR'
      Origin = 'COD_SIMILAR'
      Size = 60
    end
    object FDQProdutos2PROD_SUBST_POR: TBCDField
      FieldName = 'PROD_SUBST_POR'
      Origin = 'PROD_SUBST_POR'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2PROD_PROD_IMPOSTO: TBCDField
      FieldName = 'PROD_PROD_IMPOSTO'
      Origin = 'PROD_PROD_IMPOSTO'
      Precision = 18
      Size = 2
    end
    object FDQProdutos2COD_CFOP: TIntegerField
      FieldName = 'COD_CFOP'
      Origin = 'COD_CFOP'
    end
  end
end
