object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 474
  Width = 884
  object FDQMenu: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Menu'
      'Order by Item')
    Left = 48
    Top = 56
    object FDQMenuIDMODULO: TIntegerField
      FieldName = 'IDMODULO'
      Origin = 'IDMODULO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQMenuITEM: TWideStringField
      FieldName = 'ITEM'
      Origin = 'ITEM'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 10
    end
    object FDQMenuDESCRICAO: TWideStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 50
    end
    object FDQMenuNIVELMENU: TWideStringField
      FieldName = 'NIVELMENU'
      Origin = 'NIVELMENU'
      Size = 15
    end
    object FDQMenuICONE: TWideStringField
      FieldName = 'ICONE'
      Origin = 'ICONE'
      Size = 50
    end
    object FDQMenuNOMEFORM: TWideStringField
      FieldName = 'NOMEFORM'
      Origin = 'NOMEFORM'
      Size = 50
    end
  end
  object ConexaoBD: TFDConnection
    Params.Strings = (
      
        'Database=C:\Marcelo Giratto - Cursos Online\Fontes das Aulas\Sis' +
        'HelpDesk\Win32\Debug\BancoDados\HELPDESK.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Server=localhost'
      'CharacterSet=UTF8'
      'DriverID=FB')
    ResourceOptions.AssignedValues = [rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    LoginPrompt = False
    BeforeConnect = ConexaoBDBeforeConnect
    Left = 48
    Top = 8
  end
  object FDQQuery: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Clientes')
    Left = 144
    Top = 56
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 144
    Top = 8
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 248
    Top = 8
  end
  object FDQQuery1: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Menu'
      'Order by Item')
    Left = 248
    Top = 56
  end
  object FDQQuery2: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Menu'
      'Order by Item')
    Left = 352
    Top = 56
  end
  object FDQQuery3: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Menu'
      'Order by Item')
    Left = 464
    Top = 56
  end
  object FDQConfiguracoes: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Licenca')
    Left = 48
    Top = 296
    object FDQConfiguracoesIDLICENCA: TIntegerField
      FieldName = 'IDLICENCA'
      Origin = 'IDLICENCA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQConfiguracoesNOMELICENCA: TWideStringField
      FieldName = 'NOMELICENCA'
      Origin = 'NOMELICENCA'
      Size = 50
    end
    object FDQConfiguracoesCNPJ: TWideStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Size = 18
    end
    object FDQConfiguracoesCEP: TWideStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 9
    end
    object FDQConfiguracoesENDERECO: TWideStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 50
    end
    object FDQConfiguracoesNUMERO: TWideStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 10
    end
    object FDQConfiguracoesBAIRRO: TWideStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 30
    end
    object FDQConfiguracoesCIDADE: TWideStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 30
    end
    object FDQConfiguracoesESTADO: TWideStringField
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      Size = 2
    end
    object FDQConfiguracoesTELEFONES: TWideStringField
      FieldName = 'TELEFONES'
      Origin = 'TELEFONES'
      Size = 30
    end
    object FDQConfiguracoesEMAILORIGEM: TWideStringField
      FieldName = 'EMAILORIGEM'
      Origin = 'EMAILORIGEM'
      Size = 100
    end
    object FDQConfiguracoesNOMEORIGEM: TWideStringField
      FieldName = 'NOMEORIGEM'
      Origin = 'NOMEORIGEM'
      Size = 100
    end
    object FDQConfiguracoesSMTP: TWideStringField
      FieldName = 'SMTP'
      Origin = 'SMTP'
      Size = 100
    end
    object FDQConfiguracoesPORTA: TWideStringField
      FieldName = 'PORTA'
      Origin = 'PORTA'
      Size = 5
    end
    object FDQConfiguracoesUSUARIO: TWideStringField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Size = 50
    end
    object FDQConfiguracoesSENHA: TWideStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 50
    end
    object FDQConfiguracoesTLS: TWideStringField
      FieldName = 'TLS'
      Origin = 'TLS'
      Size = 3
    end
    object FDQConfiguracoesSSL: TWideStringField
      FieldName = 'SSL'
      Origin = 'SSL'
      Size = 3
    end
  end
  object FDQClientesCad: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Clientes'
      'Where idCliente = :idCliente')
    Left = 48
    Top = 152
    ParamData = <
      item
        Name = 'IDCLIENTE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQClientesCadIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQClientesCadRAZAOSOCIAL: TWideStringField
      FieldName = 'RAZAOSOCIAL'
      Origin = 'RAZAOSOCIAL'
      Required = True
      Size = 50
    end
    object FDQClientesCadCNPJ: TWideStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Size = 18
    end
    object FDQClientesCadIE: TWideStringField
      FieldName = 'IE'
      Origin = 'IE'
      Size = 15
    end
    object FDQClientesCadCEP: TWideStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 10
    end
    object FDQClientesCadENDERECO: TWideStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 50
    end
    object FDQClientesCadNUMERO: TWideStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 10
    end
    object FDQClientesCadCOMPLEMENTO: TWideStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 30
    end
    object FDQClientesCadBAIRRO: TWideStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 30
    end
    object FDQClientesCadCIDADE: TWideStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 30
    end
    object FDQClientesCadESTADO: TWideStringField
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      Size = 2
    end
    object FDQClientesCadFONEFIXO: TWideStringField
      FieldName = 'FONEFIXO'
      Origin = 'FONEFIXO'
      Size = 15
    end
    object FDQClientesCadFONECELULAR: TWideStringField
      FieldName = 'FONECELULAR'
      Origin = 'FONECELULAR'
      Size = 15
    end
    object FDQClientesCadEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 100
    end
    object FDQClientesCadSENHA: TWideStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 100
    end
    object FDQClientesCadDATAULTIMOACESSO: TSQLTimeStampField
      FieldName = 'DATAULTIMOACESSO'
      Origin = 'DATAULTIMOACESSO'
    end
  end
  object FDQFuncionariosCad: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Funcionarios'
      'Where idFuncionario = :idFuncionario')
    Left = 48
    Top = 104
    ParamData = <
      item
        Name = 'IDFUNCIONARIO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQFuncionariosCadIDFUNCIONARIO: TIntegerField
      FieldName = 'IDFUNCIONARIO'
      Origin = 'IDFUNCIONARIO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQFuncionariosCadNOMEFUNCIONARIO: TWideStringField
      FieldName = 'NOMEFUNCIONARIO'
      Origin = 'NOMEFUNCIONARIO'
      Required = True
      Size = 50
    end
    object FDQFuncionariosCadCPF: TWideStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Size = 18
    end
    object FDQFuncionariosCadRG: TWideStringField
      FieldName = 'RG'
      Origin = 'RG'
      Size = 15
    end
    object FDQFuncionariosCadCEP: TWideStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 10
    end
    object FDQFuncionariosCadENDERECO: TWideStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 50
    end
    object FDQFuncionariosCadNUMERO: TWideStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 10
    end
    object FDQFuncionariosCadCOMPLEMENTO: TWideStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 30
    end
    object FDQFuncionariosCadBAIRRO: TWideStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 30
    end
    object FDQFuncionariosCadCIDADE: TWideStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 30
    end
    object FDQFuncionariosCadESTADO: TWideStringField
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      Size = 2
    end
    object FDQFuncionariosCadFONEFIXO: TWideStringField
      FieldName = 'FONEFIXO'
      Origin = 'FONEFIXO'
      Size = 15
    end
    object FDQFuncionariosCadFONECELULAR: TWideStringField
      FieldName = 'FONECELULAR'
      Origin = 'FONECELULAR'
      Size = 15
    end
    object FDQFuncionariosCadEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 100
    end
    object FDQFuncionariosCadUSUARIO: TWideStringField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Size = 30
    end
    object FDQFuncionariosCadSENHA: TWideStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 100
    end
    object FDQFuncionariosCadDATAULTIMOACESSO: TSQLTimeStampField
      FieldName = 'DATAULTIMOACESSO'
      Origin = 'DATAULTIMOACESSO'
    end
  end
  object FDQProdutosCad: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Produtos'
      'Where idProduto = :idProduto')
    Left = 48
    Top = 200
    ParamData = <
      item
        Name = 'IDPRODUTO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQProdutosCadIDPRODUTO: TIntegerField
      FieldName = 'IDPRODUTO'
      Origin = 'IDPRODUTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQProdutosCadDESCRICAO: TWideStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 50
    end
  end
  object FDQSolicitacoesCad: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Solicitacoes'
      'Where idSolicitacao = :idSolicitacao')
    Left = 48
    Top = 248
    ParamData = <
      item
        Name = 'IDSOLICITACAO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQSolicitacoesCadIDSOLICITACAO: TIntegerField
      FieldName = 'IDSOLICITACAO'
      Origin = 'IDSOLICITACAO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQSolicitacoesCadDESCRICAO: TWideStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 50
    end
  end
  object FDQChamadosCad: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Chamados'
      'Where IDChamado = :IDChamado')
    Left = 48
    Top = 344
    ParamData = <
      item
        Name = 'IDCHAMADO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQChamadosCadIDCHAMADO: TIntegerField
      FieldName = 'IDCHAMADO'
      Origin = 'IDCHAMADO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQChamadosCadIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
      Required = True
    end
    object FDQChamadosCadDATAHORAABERTURA: TSQLTimeStampField
      FieldName = 'DATAHORAABERTURA'
      Origin = 'DATAHORAABERTURA'
      Required = True
    end
    object FDQChamadosCadIDSOLICITACAO: TIntegerField
      FieldName = 'IDSOLICITACAO'
      Origin = 'IDSOLICITACAO'
      Required = True
    end
    object FDQChamadosCadIDPRODUTO: TIntegerField
      FieldName = 'IDPRODUTO'
      Origin = 'IDPRODUTO'
      Required = True
    end
    object FDQChamadosCadNOMESOLICITANTE: TWideStringField
      FieldName = 'NOMESOLICITANTE'
      Origin = 'NOMESOLICITANTE'
      Required = True
      Size = 30
    end
    object FDQChamadosCadDEPTOSOLICITANTE: TWideStringField
      FieldName = 'DEPTOSOLICITANTE'
      Origin = 'DEPTOSOLICITANTE'
      Required = True
      Size = 30
    end
    object FDQChamadosCadDESCRICAOSOLICITACAO: TBlobField
      FieldName = 'DESCRICAOSOLICITACAO'
      Origin = 'DESCRICAOSOLICITACAO'
      Required = True
    end
    object FDQChamadosCadPRIORIDADE: TWideStringField
      FieldName = 'PRIORIDADE'
      Origin = 'PRIORIDADE'
      Required = True
      Size = 10
    end
    object FDQChamadosCadSITUACAO: TWideStringField
      FieldName = 'SITUACAO'
      Origin = 'SITUACAO'
      Size = 10
    end
    object FDQChamadosCadSOLUCAOSOLICITACAO: TBlobField
      FieldName = 'SOLUCAOSOLICITACAO'
      Origin = 'SOLUCAOSOLICITACAO'
    end
    object FDQChamadosCadDATAHORASOLUCAO: TSQLTimeStampField
      FieldName = 'DATAHORASOLUCAO'
      Origin = 'DATAHORASOLUCAO'
    end
    object FDQChamadosCadIDFUNCIONARIOSOLUCAO: TIntegerField
      FieldName = 'IDFUNCIONARIOSOLUCAO'
      Origin = 'IDFUNCIONARIOSOLUCAO'
    end
  end
  object FDQClientes: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Clientes'
      'Order by RazaoSocial')
    Left = 176
    Top = 152
    object FDQClientesIDCLIENTE: TIntegerField
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQClientesRAZAOSOCIAL: TWideStringField
      FieldName = 'RAZAOSOCIAL'
      Origin = 'RAZAOSOCIAL'
      Required = True
      Size = 50
    end
    object FDQClientesCNPJ: TWideStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Size = 18
    end
    object FDQClientesIE: TWideStringField
      FieldName = 'IE'
      Origin = 'IE'
      Size = 15
    end
    object FDQClientesCEP: TWideStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 10
    end
    object FDQClientesENDERECO: TWideStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 50
    end
    object FDQClientesNUMERO: TWideStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 10
    end
    object FDQClientesCOMPLEMENTO: TWideStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 30
    end
    object FDQClientesBAIRRO: TWideStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 30
    end
    object FDQClientesCIDADE: TWideStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 30
    end
    object FDQClientesESTADO: TWideStringField
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      Size = 2
    end
    object FDQClientesFONEFIXO: TWideStringField
      FieldName = 'FONEFIXO'
      Origin = 'FONEFIXO'
      Size = 15
    end
    object FDQClientesFONECELULAR: TWideStringField
      FieldName = 'FONECELULAR'
      Origin = 'FONECELULAR'
      Size = 15
    end
    object FDQClientesEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 100
    end
    object FDQClientesSENHA: TWideStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 100
    end
    object FDQClientesDATAULTIMOACESSO: TSQLTimeStampField
      FieldName = 'DATAULTIMOACESSO'
      Origin = 'DATAULTIMOACESSO'
    end
  end
  object FDQSolicitacoes: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Solicitacoes'
      'Order by IDSolicitacao')
    Left = 176
    Top = 248
    object FDQSolicitacoesIDSOLICITACAO: TIntegerField
      FieldName = 'IDSOLICITACAO'
      Origin = 'IDSOLICITACAO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQSolicitacoesDESCRICAO: TWideStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 50
    end
  end
  object FDQProdutos: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Produtos'
      'Order by idProduto')
    Left = 176
    Top = 200
    object IntegerField1: TIntegerField
      FieldName = 'IDPRODUTO'
      Origin = 'IDPRODUTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object WideStringField1: TWideStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 50
    end
  end
  object FDQEvento: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'Select * from Agenda'
      'Where IDAGENDA = :ID')
    Left = 48
    Top = 392
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object FDQEventoIDAGENDA: TIntegerField
      FieldName = 'IDAGENDA'
      Origin = 'IDAGENDA'
      Required = True
    end
    object FDQEventoIDFUNCIONARIO: TIntegerField
      FieldName = 'IDFUNCIONARIO'
      Origin = 'IDFUNCIONARIO'
      Required = True
    end
    object FDQEventoTITULO: TWideStringField
      FieldName = 'TITULO'
      Origin = 'TITULO'
      Required = True
      Size = 50
    end
    object FDQEventoCOR: TWideStringField
      FieldName = 'COR'
      Origin = 'COR'
      Required = True
      Size = 10
    end
    object FDQEventoINICIO: TSQLTimeStampField
      FieldName = 'INICIO'
      Origin = 'INICIO'
      Required = True
    end
    object FDQEventoFINAL: TSQLTimeStampField
      FieldName = 'FINAL'
      Origin = 'FINAL'
      Required = True
    end
    object FDQEventoDESCRICAO: TWideMemoField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      BlobType = ftWideMemo
    end
  end
end
