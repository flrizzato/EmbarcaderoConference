object dmPOS: TdmPOS
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 346
  Width = 215
  object acbrNFe: TACBrNFe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 88
    Top = 32
  end
  object mtblProdutos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 88
    Top = 160
    object mtblProdutosproduto: TIntegerField
      FieldName = 'produto'
    end
    object mtblProdutosdescricao: TStringField
      FieldName = 'descricao'
    end
    object mtblProdutosvalor: TFloatField
      FieldName = 'valor'
    end
  end
  object mtblMesas: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 88
    Top = 216
    object mtblMesasmesa: TIntegerField
      FieldName = 'mesa'
    end
    object mtblMesasstatus: TBooleanField
      FieldName = 'status'
    end
    object mtblMesasvalor: TFloatField
      FieldName = 'valor'
    end
  end
  object mtblVendas: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 88
    Top = 272
    object IntegerField1: TIntegerField
      FieldName = 'mesa'
    end
    object mtblVendasproduto: TIntegerField
      FieldName = 'produto'
    end
    object mtblVendasqtd: TIntegerField
      FieldName = 'qtd'
    end
    object mtblVendasvalorunitario: TFloatField
      FieldName = 'unitario'
    end
  end
end
