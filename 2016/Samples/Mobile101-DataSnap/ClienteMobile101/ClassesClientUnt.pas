// 
// Created by the DataSnap proxy generator.
// 23/10/2016 20:57:39
// 

unit ClassesClientUnt;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TDSServerModuleEstoqueClient = class(TDSAdminRestClient)
  private
    FGetProdutosCommand: TDSRestCommand;
    FGetProdutosCommand_Cache: TDSRestCommand;
    FGetProdutosSuperPromocaoCommand: TDSRestCommand;
    FGetProdutosSuperPromocaoCommand_Cache: TDSRestCommand;
    FGetGiroSimplesCommand: TDSRestCommand;
    FGetGiroSimplesCommand_Cache: TDSRestCommand;
    FGetClientesCommand: TDSRestCommand;
    FGetClientesCommand_Cache: TDSRestCommand;
    FGetVendedoresCommand: TDSRestCommand;
    FGetVendedoresCommand_Cache: TDSRestCommand;
    FCorrigePedidoDuplicadoCommand: TDSRestCommand;
    FGetRomaneioCargaCommand: TDSRestCommand;
    FGetRomaneioCargaCommand_Cache: TDSRestCommand;
    FGetPontuacaoClienteOuroCommand: TDSRestCommand;
    FGetPontuacaoClienteOuroCommand_Cache: TDSRestCommand;
    FGetPontuacaoOuroGMCCommand: TDSRestCommand;
    FGetPontuacaoOuroGMCCommand_Cache: TDSRestCommand;
    FGetDadosProdutividadeCommand: TDSRestCommand;
    FGetDadosProdutividadeCommand_Cache: TDSRestCommand;
    FGetFormulaVitoriaCommand: TDSRestCommand;
    FGetFormulaVitoriaCommand_Cache: TDSRestCommand;
    FGetVendaLiquidaCommand: TDSRestCommand;
    FGetVendaLiquidaCommand_Cache: TDSRestCommand;
    FAtualizaCargaPECommand: TDSRestCommand;
    FGetPedidosDuplicadosCommand: TDSRestCommand;
    FGetPedidosDuplicadosCommand_Cache: TDSRestCommand;
    FGetProdDupliCondCommand: TDSRestCommand;
    FGetProdDupliCondCommand_Cache: TDSRestCommand;
    FGetXMLStatusEnvioCommand: TDSRestCommand;
    FGetXMLStatusEnvioCommand_Cache: TDSRestCommand;
    FAtualizaXMLStatusEnvioCommand: TDSRestCommand;
    FGetPedidosEnderecarCommand: TDSRestCommand;
    FGetPedidosEnderecarCommand_Cache: TDSRestCommand;
    FGetWMSOrdemEntradaDivergenciasCommand: TDSRestCommand;
    FGetWMSOrdemEntradaDivergenciasCommand_Cache: TDSRestCommand;
    FGetWMSOrdemSaidaToERPCommand: TDSRestCommand;
    FGetWMSOrdemSaidaToERPCommand_Cache: TDSRestCommand;
    FGetWMSOrdemSaidaConferirCommand: TDSRestCommand;
    FGetWMSOrdemSaidaConferirCommand_Cache: TDSRestCommand;
    FGetWMSOrdemSaidasRecusadasCommand: TDSRestCommand;
    FGetWMSOrdemSaidasRecusadasCommand_Cache: TDSRestCommand;
    FGetWMSItensOrdemSaidasRecusadasCommand: TDSRestCommand;
    FGetWMSItensOrdemSaidasRecusadasCommand_Cache: TDSRestCommand;
    FZerarSTNFCommand: TDSRestCommand;
    FGetWMSPedidosRetornadosXHoraCommand: TDSRestCommand;
    FGetWMSPedidosRetornadosXHoraCommand_Cache: TDSRestCommand;
    FGetWMSMovtosEstoqueItemCommand: TDSRestCommand;
    FGetWMSMovtosEstoqueItemCommand_Cache: TDSRestCommand;
    FGetWMSExportOSSemSucessoCommand: TDSRestCommand;
    FGetWMSExportOSSemSucessoCommand_Cache: TDSRestCommand;
    FCorrigeWMSEmpenhoNegaMercCommand: TDSRestCommand;
    FGetAFVImportarCommand: TDSRestCommand;
    FGetAFVImportarCommand_Cache: TDSRestCommand;
    FGetDetalhesPedidoAFVCommand: TDSRestCommand;
    FGetDetalhesPedidoAFVCommand_Cache: TDSRestCommand;
    FDeletaItemPedidoAFVCommand: TDSRestCommand;
    FDeletaPedidoAFVCommand: TDSRestCommand;
    FValidaSenhaDelPedCommand: TDSRestCommand;
    FGetProdutoSCondicoesCommand: TDSRestCommand;
    FGetProdutoSCondicoesCommand_Cache: TDSRestCommand;
    FValidaClienteCommand: TDSRestCommand;
    FGetPedidosClienteCommand: TDSRestCommand;
    FGetPedidosClienteCommand_Cache: TDSRestCommand;
    FGetNFClienteCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function GetProdutos(campo: Integer; parametro: string; const ARequestFilter: string = ''): TDBXReader;
    function GetProdutos_Cache(campo: Integer; parametro: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetProdutosSuperPromocao(campo: Integer; parametro: string; const ARequestFilter: string = ''): TDBXReader;
    function GetProdutosSuperPromocao_Cache(campo: Integer; parametro: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetGiroSimples(Grupo: string; DataIni: string; DataFim: string; const ARequestFilter: string = ''): TDBXReader;
    function GetGiroSimples_Cache(Grupo: string; DataIni: string; DataFim: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetClientes(campo: Integer; parametro: string; const ARequestFilter: string = ''): TDBXReader;
    function GetClientes_Cache(campo: Integer; parametro: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetVendedores(campo: Integer; parametro: string; const ARequestFilter: string = ''): TDBXReader;
    function GetVendedores_Cache(campo: Integer; parametro: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function CorrigePedidoDuplicado(NumPedido: string; out Mensagem: string; const ARequestFilter: string = ''): Boolean;
    function GetRomaneioCarga(NumRomaneio: string; out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetRomaneioCarga_Cache(NumRomaneio: string; out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetPontuacaoClienteOuro(CNPJ: string; Senha: string; DataIni: string; DataFim: string; Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetPontuacaoClienteOuro_Cache(CNPJ: string; Senha: string; DataIni: string; DataFim: string; Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetPontuacaoOuroGMC(CNPJ: string; Senha: string; out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetPontuacaoOuroGMC_Cache(CNPJ: string; Senha: string; out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetDadosProdutividade(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetDadosProdutividade_Cache(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetFormulaVitoria(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetFormulaVitoria_Cache(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetVendaLiquida(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetVendaLiquida_Cache(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function AtualizaCargaPE(senha: string; tipocarga: Integer; out Mensagem: string; const ARequestFilter: string = ''): Boolean;
    function GetPedidosDuplicados(data: string; out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetPedidosDuplicados_Cache(data: string; out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetProdDupliCond(out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetProdDupliCond_Cache(out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetXMLStatusEnvio(NF: Integer; out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetXMLStatusEnvio_Cache(NF: Integer; out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function AtualizaXMLStatusEnvio(NF: Integer; email: string; out Mensagem: string; const ARequestFilter: string = ''): Boolean;
    function GetPedidosEnderecar(Rota: string; out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetPedidosEnderecar_Cache(Rota: string; out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetWMSOrdemEntradaDivergencias(out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetWMSOrdemEntradaDivergencias_Cache(out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetWMSOrdemSaidaToERP(out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetWMSOrdemSaidaToERP_Cache(out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetWMSOrdemSaidaConferir(out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetWMSOrdemSaidaConferir_Cache(out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetWMSOrdemSaidasRecusadas(out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetWMSOrdemSaidasRecusadas_Cache(out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetWMSItensOrdemSaidasRecusadas(out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetWMSItensOrdemSaidasRecusadas_Cache(out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function ZerarSTNF(Senha: string; NF: string; out Mensagem: string; const ARequestFilter: string = ''): Boolean;
    function GetWMSPedidosRetornadosXHora(out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetWMSPedidosRetornadosXHora_Cache(out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetWMSMovtosEstoqueItem(out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetWMSMovtosEstoqueItem_Cache(out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetWMSExportOSSemSucesso(out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetWMSExportOSSemSucesso_Cache(out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function CorrigeWMSEmpenhoNegaMerc(NumPedido: string; out Mensagem: string; const ARequestFilter: string = ''): Boolean;
    function GetAFVImportar(out MSG: string; const ARequestFilter: string = ''): TDBXReader;
    function GetAFVImportar_Cache(out MSG: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetDetalhesPedidoAFV(NumAFV: string; out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetDetalhesPedidoAFV_Cache(NumAFV: string; out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function DeletaItemPedidoAFV(NumAFV: string; CodProduto: string; out Mensagem: string; const ARequestFilter: string = ''): Boolean;
    function DeletaPedidoAFV(NumAFV: string; senha: string; out Mensagem: string; const ARequestFilter: string = ''): Boolean;
    function ValidaSenhaDelPed(NumAFV: string; senha: string; out Mensagem: string; const ARequestFilter: string = ''): Boolean;
    function GetProdutoSCondicoes(const ARequestFilter: string = ''): TDBXReader;
    function GetProdutoSCondicoes_Cache(const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function ValidaCliente(CNPJ: string; out Mensagem: string; const ARequestFilter: string = ''): string;
    function GetPedidosCliente(CodCliente: string; dataIni: string; out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetPedidosCliente_Cache(CodCliente: string; dataIni: string; out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetNFCliente(CodigoCliente: string; NF: string; out Mensagem: string; const ARequestFilter: string = ''): Boolean;
  end;

  TDSServerClientesClient = class(TDSAdminRestClient)
  private
    FGetPedidosCommand: TDSRestCommand;
    FGetPedidosCommand_Cache: TDSRestCommand;
    FAutenticaCNPJCommand: TDSRestCommand;
    FAutenticaCNPJCommand_Cache: TDSRestCommand;
    FGetTitulosAbCommand: TDSRestCommand;
    FGetTitulosAbCommand_Cache: TDSRestCommand;
    FGetTitulosNFCommand: TDSRestCommand;
    FGetTitulosNFCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function GetPedidos(CodCliente: string; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetPedidos_Cache(CodCliente: string; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function AutenticaCNPJ(CNPJ: string; const ARequestFilter: string = ''): TFDJSONDataSets;
    function AutenticaCNPJ_Cache(CNPJ: string; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetTitulosAb(CodCliente: string; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetTitulosAb_Cache(CodCliente: string; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetTitulosNF(CodCliente: string; NotaFiscal: string; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetTitulosNF_Cache(CodCliente: string; NotaFiscal: string; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TDSServerModuleEstoque_GetProdutos: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'campo'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'parametro'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetProdutos_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'campo'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'parametro'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetProdutosSuperPromocao: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'campo'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'parametro'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetProdutosSuperPromocao_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'campo'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'parametro'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetGiroSimples: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'Grupo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataIni'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataFim'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetGiroSimples_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'Grupo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataIni'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataFim'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetClientes: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'campo'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'parametro'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetClientes_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'campo'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'parametro'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetVendedores: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'campo'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'parametro'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetVendedores_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'campo'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'parametro'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_CorrigePedidoDuplicado: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'NumPedido'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TDSServerModuleEstoque_GetRomaneioCarga: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'NumRomaneio'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetRomaneioCarga_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'NumRomaneio'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetPontuacaoClienteOuro: array [0..5] of TDSRestParameterMetaData =
  (
    (Name: 'CNPJ'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Senha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataIni'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataFim'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetPontuacaoClienteOuro_Cache: array [0..5] of TDSRestParameterMetaData =
  (
    (Name: 'CNPJ'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Senha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataIni'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataFim'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetPontuacaoOuroGMC: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'CNPJ'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Senha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetPontuacaoOuroGMC_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'CNPJ'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Senha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetDadosProdutividade: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'DataIni'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataFim'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetDadosProdutividade_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'DataIni'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataFim'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetFormulaVitoria: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'DataIni'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataFim'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetFormulaVitoria_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'DataIni'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataFim'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetVendaLiquida: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'DataIni'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataFim'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetVendaLiquida_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'DataIni'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataFim'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_AtualizaCargaPE: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'senha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'tipocarga'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TDSServerModuleEstoque_GetPedidosDuplicados: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'data'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetPedidosDuplicados_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'data'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetProdDupliCond: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetProdDupliCond_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetXMLStatusEnvio: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'NF'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetXMLStatusEnvio_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'NF'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_AtualizaXMLStatusEnvio: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'NF'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'email'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TDSServerModuleEstoque_GetPedidosEnderecar: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'Rota'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetPedidosEnderecar_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'Rota'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetWMSOrdemEntradaDivergencias: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetWMSOrdemEntradaDivergencias_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetWMSOrdemSaidaToERP: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetWMSOrdemSaidaToERP_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetWMSOrdemSaidaConferir: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetWMSOrdemSaidaConferir_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetWMSOrdemSaidasRecusadas: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetWMSOrdemSaidasRecusadas_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetWMSItensOrdemSaidasRecusadas: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetWMSItensOrdemSaidasRecusadas_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_ZerarSTNF: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'Senha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'NF'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TDSServerModuleEstoque_GetWMSPedidosRetornadosXHora: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetWMSPedidosRetornadosXHora_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetWMSMovtosEstoqueItem: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetWMSMovtosEstoqueItem_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetWMSExportOSSemSucesso: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetWMSExportOSSemSucesso_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_CorrigeWMSEmpenhoNegaMerc: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'NumPedido'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TDSServerModuleEstoque_GetAFVImportar: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'MSG'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetAFVImportar_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'MSG'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetDetalhesPedidoAFV: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'NumAFV'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetDetalhesPedidoAFV_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'NumAFV'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_DeletaItemPedidoAFV: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'NumAFV'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'CodProduto'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TDSServerModuleEstoque_DeletaPedidoAFV: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'NumAFV'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'senha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TDSServerModuleEstoque_ValidaSenhaDelPed: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'NumAFV'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'senha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TDSServerModuleEstoque_GetProdutoSCondicoes: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetProdutoSCondicoes_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_ValidaCliente: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'CNPJ'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TDSServerModuleEstoque_GetPedidosCliente: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'CodCliente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'dataIni'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TDSServerModuleEstoque_GetPedidosCliente_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'CodCliente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'dataIni'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerModuleEstoque_GetNFCliente: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'CodigoCliente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'NF'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Mensagem'; Direction: 2; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TDSServerClientes_GetPedidos: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'CodCliente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TDSServerClientes_GetPedidos_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'CodCliente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerClientes_AutenticaCNPJ: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'CNPJ'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TDSServerClientes_AutenticaCNPJ_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'CNPJ'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerClientes_GetTitulosAb: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'CodCliente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TDSServerClientes_GetTitulosAb_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'CodCliente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDSServerClientes_GetTitulosNF: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'CodCliente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'NotaFiscal'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TDSServerClientes_GetTitulosNF_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'CodCliente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'NotaFiscal'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

implementation

function TDSServerModuleEstoqueClient.GetProdutos(campo: Integer; parametro: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetProdutosCommand = nil then
  begin
    FGetProdutosCommand := FConnection.CreateCommand;
    FGetProdutosCommand.RequestType := 'GET';
    FGetProdutosCommand.Text := 'TDSServerModuleEstoque.GetProdutos';
    FGetProdutosCommand.Prepare(TDSServerModuleEstoque_GetProdutos);
  end;
  FGetProdutosCommand.Parameters[0].Value.SetInt32(campo);
  FGetProdutosCommand.Parameters[1].Value.SetWideString(parametro);
  FGetProdutosCommand.Execute(ARequestFilter);
  Result := FGetProdutosCommand.Parameters[2].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetProdutos_Cache(campo: Integer; parametro: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetProdutosCommand_Cache = nil then
  begin
    FGetProdutosCommand_Cache := FConnection.CreateCommand;
    FGetProdutosCommand_Cache.RequestType := 'GET';
    FGetProdutosCommand_Cache.Text := 'TDSServerModuleEstoque.GetProdutos';
    FGetProdutosCommand_Cache.Prepare(TDSServerModuleEstoque_GetProdutos_Cache);
  end;
  FGetProdutosCommand_Cache.Parameters[0].Value.SetInt32(campo);
  FGetProdutosCommand_Cache.Parameters[1].Value.SetWideString(parametro);
  FGetProdutosCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedDBXReader.Create(FGetProdutosCommand_Cache.Parameters[2].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetProdutosSuperPromocao(campo: Integer; parametro: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetProdutosSuperPromocaoCommand = nil then
  begin
    FGetProdutosSuperPromocaoCommand := FConnection.CreateCommand;
    FGetProdutosSuperPromocaoCommand.RequestType := 'GET';
    FGetProdutosSuperPromocaoCommand.Text := 'TDSServerModuleEstoque.GetProdutosSuperPromocao';
    FGetProdutosSuperPromocaoCommand.Prepare(TDSServerModuleEstoque_GetProdutosSuperPromocao);
  end;
  FGetProdutosSuperPromocaoCommand.Parameters[0].Value.SetInt32(campo);
  FGetProdutosSuperPromocaoCommand.Parameters[1].Value.SetWideString(parametro);
  FGetProdutosSuperPromocaoCommand.Execute(ARequestFilter);
  Result := FGetProdutosSuperPromocaoCommand.Parameters[2].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetProdutosSuperPromocao_Cache(campo: Integer; parametro: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetProdutosSuperPromocaoCommand_Cache = nil then
  begin
    FGetProdutosSuperPromocaoCommand_Cache := FConnection.CreateCommand;
    FGetProdutosSuperPromocaoCommand_Cache.RequestType := 'GET';
    FGetProdutosSuperPromocaoCommand_Cache.Text := 'TDSServerModuleEstoque.GetProdutosSuperPromocao';
    FGetProdutosSuperPromocaoCommand_Cache.Prepare(TDSServerModuleEstoque_GetProdutosSuperPromocao_Cache);
  end;
  FGetProdutosSuperPromocaoCommand_Cache.Parameters[0].Value.SetInt32(campo);
  FGetProdutosSuperPromocaoCommand_Cache.Parameters[1].Value.SetWideString(parametro);
  FGetProdutosSuperPromocaoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedDBXReader.Create(FGetProdutosSuperPromocaoCommand_Cache.Parameters[2].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetGiroSimples(Grupo: string; DataIni: string; DataFim: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetGiroSimplesCommand = nil then
  begin
    FGetGiroSimplesCommand := FConnection.CreateCommand;
    FGetGiroSimplesCommand.RequestType := 'GET';
    FGetGiroSimplesCommand.Text := 'TDSServerModuleEstoque.GetGiroSimples';
    FGetGiroSimplesCommand.Prepare(TDSServerModuleEstoque_GetGiroSimples);
  end;
  FGetGiroSimplesCommand.Parameters[0].Value.SetWideString(Grupo);
  FGetGiroSimplesCommand.Parameters[1].Value.SetWideString(DataIni);
  FGetGiroSimplesCommand.Parameters[2].Value.SetWideString(DataFim);
  FGetGiroSimplesCommand.Execute(ARequestFilter);
  Result := FGetGiroSimplesCommand.Parameters[3].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetGiroSimples_Cache(Grupo: string; DataIni: string; DataFim: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetGiroSimplesCommand_Cache = nil then
  begin
    FGetGiroSimplesCommand_Cache := FConnection.CreateCommand;
    FGetGiroSimplesCommand_Cache.RequestType := 'GET';
    FGetGiroSimplesCommand_Cache.Text := 'TDSServerModuleEstoque.GetGiroSimples';
    FGetGiroSimplesCommand_Cache.Prepare(TDSServerModuleEstoque_GetGiroSimples_Cache);
  end;
  FGetGiroSimplesCommand_Cache.Parameters[0].Value.SetWideString(Grupo);
  FGetGiroSimplesCommand_Cache.Parameters[1].Value.SetWideString(DataIni);
  FGetGiroSimplesCommand_Cache.Parameters[2].Value.SetWideString(DataFim);
  FGetGiroSimplesCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedDBXReader.Create(FGetGiroSimplesCommand_Cache.Parameters[3].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetClientes(campo: Integer; parametro: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetClientesCommand = nil then
  begin
    FGetClientesCommand := FConnection.CreateCommand;
    FGetClientesCommand.RequestType := 'GET';
    FGetClientesCommand.Text := 'TDSServerModuleEstoque.GetClientes';
    FGetClientesCommand.Prepare(TDSServerModuleEstoque_GetClientes);
  end;
  FGetClientesCommand.Parameters[0].Value.SetInt32(campo);
  FGetClientesCommand.Parameters[1].Value.SetWideString(parametro);
  FGetClientesCommand.Execute(ARequestFilter);
  Result := FGetClientesCommand.Parameters[2].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetClientes_Cache(campo: Integer; parametro: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetClientesCommand_Cache = nil then
  begin
    FGetClientesCommand_Cache := FConnection.CreateCommand;
    FGetClientesCommand_Cache.RequestType := 'GET';
    FGetClientesCommand_Cache.Text := 'TDSServerModuleEstoque.GetClientes';
    FGetClientesCommand_Cache.Prepare(TDSServerModuleEstoque_GetClientes_Cache);
  end;
  FGetClientesCommand_Cache.Parameters[0].Value.SetInt32(campo);
  FGetClientesCommand_Cache.Parameters[1].Value.SetWideString(parametro);
  FGetClientesCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedDBXReader.Create(FGetClientesCommand_Cache.Parameters[2].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetVendedores(campo: Integer; parametro: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetVendedoresCommand = nil then
  begin
    FGetVendedoresCommand := FConnection.CreateCommand;
    FGetVendedoresCommand.RequestType := 'GET';
    FGetVendedoresCommand.Text := 'TDSServerModuleEstoque.GetVendedores';
    FGetVendedoresCommand.Prepare(TDSServerModuleEstoque_GetVendedores);
  end;
  FGetVendedoresCommand.Parameters[0].Value.SetInt32(campo);
  FGetVendedoresCommand.Parameters[1].Value.SetWideString(parametro);
  FGetVendedoresCommand.Execute(ARequestFilter);
  Result := FGetVendedoresCommand.Parameters[2].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetVendedores_Cache(campo: Integer; parametro: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetVendedoresCommand_Cache = nil then
  begin
    FGetVendedoresCommand_Cache := FConnection.CreateCommand;
    FGetVendedoresCommand_Cache.RequestType := 'GET';
    FGetVendedoresCommand_Cache.Text := 'TDSServerModuleEstoque.GetVendedores';
    FGetVendedoresCommand_Cache.Prepare(TDSServerModuleEstoque_GetVendedores_Cache);
  end;
  FGetVendedoresCommand_Cache.Parameters[0].Value.SetInt32(campo);
  FGetVendedoresCommand_Cache.Parameters[1].Value.SetWideString(parametro);
  FGetVendedoresCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedDBXReader.Create(FGetVendedoresCommand_Cache.Parameters[2].Value.GetString);
end;

function TDSServerModuleEstoqueClient.CorrigePedidoDuplicado(NumPedido: string; out Mensagem: string; const ARequestFilter: string): Boolean;
begin
  if FCorrigePedidoDuplicadoCommand = nil then
  begin
    FCorrigePedidoDuplicadoCommand := FConnection.CreateCommand;
    FCorrigePedidoDuplicadoCommand.RequestType := 'GET';
    FCorrigePedidoDuplicadoCommand.Text := 'TDSServerModuleEstoque.CorrigePedidoDuplicado';
    FCorrigePedidoDuplicadoCommand.Prepare(TDSServerModuleEstoque_CorrigePedidoDuplicado);
  end;
  FCorrigePedidoDuplicadoCommand.Parameters[0].Value.SetWideString(NumPedido);
  FCorrigePedidoDuplicadoCommand.Execute(ARequestFilter);
  Mensagem := FCorrigePedidoDuplicadoCommand.Parameters[1].Value.GetWideString;
  Result := FCorrigePedidoDuplicadoCommand.Parameters[2].Value.GetBoolean;
end;

function TDSServerModuleEstoqueClient.GetRomaneioCarga(NumRomaneio: string; out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetRomaneioCargaCommand = nil then
  begin
    FGetRomaneioCargaCommand := FConnection.CreateCommand;
    FGetRomaneioCargaCommand.RequestType := 'GET';
    FGetRomaneioCargaCommand.Text := 'TDSServerModuleEstoque.GetRomaneioCarga';
    FGetRomaneioCargaCommand.Prepare(TDSServerModuleEstoque_GetRomaneioCarga);
  end;
  FGetRomaneioCargaCommand.Parameters[0].Value.SetWideString(NumRomaneio);
  FGetRomaneioCargaCommand.Execute(ARequestFilter);
  Mensagem := FGetRomaneioCargaCommand.Parameters[1].Value.GetWideString;
  Result := FGetRomaneioCargaCommand.Parameters[2].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetRomaneioCarga_Cache(NumRomaneio: string; out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetRomaneioCargaCommand_Cache = nil then
  begin
    FGetRomaneioCargaCommand_Cache := FConnection.CreateCommand;
    FGetRomaneioCargaCommand_Cache.RequestType := 'GET';
    FGetRomaneioCargaCommand_Cache.Text := 'TDSServerModuleEstoque.GetRomaneioCarga';
    FGetRomaneioCargaCommand_Cache.Prepare(TDSServerModuleEstoque_GetRomaneioCarga_Cache);
  end;
  FGetRomaneioCargaCommand_Cache.Parameters[0].Value.SetWideString(NumRomaneio);
  FGetRomaneioCargaCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetRomaneioCargaCommand_Cache.Parameters[1].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetRomaneioCargaCommand_Cache.Parameters[2].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetPontuacaoClienteOuro(CNPJ: string; Senha: string; DataIni: string; DataFim: string; Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetPontuacaoClienteOuroCommand = nil then
  begin
    FGetPontuacaoClienteOuroCommand := FConnection.CreateCommand;
    FGetPontuacaoClienteOuroCommand.RequestType := 'GET';
    FGetPontuacaoClienteOuroCommand.Text := 'TDSServerModuleEstoque.GetPontuacaoClienteOuro';
    FGetPontuacaoClienteOuroCommand.Prepare(TDSServerModuleEstoque_GetPontuacaoClienteOuro);
  end;
  FGetPontuacaoClienteOuroCommand.Parameters[0].Value.SetWideString(CNPJ);
  FGetPontuacaoClienteOuroCommand.Parameters[1].Value.SetWideString(Senha);
  FGetPontuacaoClienteOuroCommand.Parameters[2].Value.SetWideString(DataIni);
  FGetPontuacaoClienteOuroCommand.Parameters[3].Value.SetWideString(DataFim);
  FGetPontuacaoClienteOuroCommand.Parameters[4].Value.SetWideString(Mensagem);
  FGetPontuacaoClienteOuroCommand.Execute(ARequestFilter);
  Result := FGetPontuacaoClienteOuroCommand.Parameters[5].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetPontuacaoClienteOuro_Cache(CNPJ: string; Senha: string; DataIni: string; DataFim: string; Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetPontuacaoClienteOuroCommand_Cache = nil then
  begin
    FGetPontuacaoClienteOuroCommand_Cache := FConnection.CreateCommand;
    FGetPontuacaoClienteOuroCommand_Cache.RequestType := 'GET';
    FGetPontuacaoClienteOuroCommand_Cache.Text := 'TDSServerModuleEstoque.GetPontuacaoClienteOuro';
    FGetPontuacaoClienteOuroCommand_Cache.Prepare(TDSServerModuleEstoque_GetPontuacaoClienteOuro_Cache);
  end;
  FGetPontuacaoClienteOuroCommand_Cache.Parameters[0].Value.SetWideString(CNPJ);
  FGetPontuacaoClienteOuroCommand_Cache.Parameters[1].Value.SetWideString(Senha);
  FGetPontuacaoClienteOuroCommand_Cache.Parameters[2].Value.SetWideString(DataIni);
  FGetPontuacaoClienteOuroCommand_Cache.Parameters[3].Value.SetWideString(DataFim);
  FGetPontuacaoClienteOuroCommand_Cache.Parameters[4].Value.SetWideString(Mensagem);
  FGetPontuacaoClienteOuroCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedDBXReader.Create(FGetPontuacaoClienteOuroCommand_Cache.Parameters[5].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetPontuacaoOuroGMC(CNPJ: string; Senha: string; out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetPontuacaoOuroGMCCommand = nil then
  begin
    FGetPontuacaoOuroGMCCommand := FConnection.CreateCommand;
    FGetPontuacaoOuroGMCCommand.RequestType := 'GET';
    FGetPontuacaoOuroGMCCommand.Text := 'TDSServerModuleEstoque.GetPontuacaoOuroGMC';
    FGetPontuacaoOuroGMCCommand.Prepare(TDSServerModuleEstoque_GetPontuacaoOuroGMC);
  end;
  FGetPontuacaoOuroGMCCommand.Parameters[0].Value.SetWideString(CNPJ);
  FGetPontuacaoOuroGMCCommand.Parameters[1].Value.SetWideString(Senha);
  FGetPontuacaoOuroGMCCommand.Execute(ARequestFilter);
  Mensagem := FGetPontuacaoOuroGMCCommand.Parameters[2].Value.GetWideString;
  Result := FGetPontuacaoOuroGMCCommand.Parameters[3].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetPontuacaoOuroGMC_Cache(CNPJ: string; Senha: string; out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetPontuacaoOuroGMCCommand_Cache = nil then
  begin
    FGetPontuacaoOuroGMCCommand_Cache := FConnection.CreateCommand;
    FGetPontuacaoOuroGMCCommand_Cache.RequestType := 'GET';
    FGetPontuacaoOuroGMCCommand_Cache.Text := 'TDSServerModuleEstoque.GetPontuacaoOuroGMC';
    FGetPontuacaoOuroGMCCommand_Cache.Prepare(TDSServerModuleEstoque_GetPontuacaoOuroGMC_Cache);
  end;
  FGetPontuacaoOuroGMCCommand_Cache.Parameters[0].Value.SetWideString(CNPJ);
  FGetPontuacaoOuroGMCCommand_Cache.Parameters[1].Value.SetWideString(Senha);
  FGetPontuacaoOuroGMCCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetPontuacaoOuroGMCCommand_Cache.Parameters[2].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetPontuacaoOuroGMCCommand_Cache.Parameters[3].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetDadosProdutividade(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetDadosProdutividadeCommand = nil then
  begin
    FGetDadosProdutividadeCommand := FConnection.CreateCommand;
    FGetDadosProdutividadeCommand.RequestType := 'GET';
    FGetDadosProdutividadeCommand.Text := 'TDSServerModuleEstoque.GetDadosProdutividade';
    FGetDadosProdutividadeCommand.Prepare(TDSServerModuleEstoque_GetDadosProdutividade);
  end;
  FGetDadosProdutividadeCommand.Parameters[0].Value.SetWideString(DataIni);
  FGetDadosProdutividadeCommand.Parameters[1].Value.SetWideString(DataFim);
  FGetDadosProdutividadeCommand.Execute(ARequestFilter);
  Mensagem := FGetDadosProdutividadeCommand.Parameters[2].Value.GetWideString;
  Result := FGetDadosProdutividadeCommand.Parameters[3].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetDadosProdutividade_Cache(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetDadosProdutividadeCommand_Cache = nil then
  begin
    FGetDadosProdutividadeCommand_Cache := FConnection.CreateCommand;
    FGetDadosProdutividadeCommand_Cache.RequestType := 'GET';
    FGetDadosProdutividadeCommand_Cache.Text := 'TDSServerModuleEstoque.GetDadosProdutividade';
    FGetDadosProdutividadeCommand_Cache.Prepare(TDSServerModuleEstoque_GetDadosProdutividade_Cache);
  end;
  FGetDadosProdutividadeCommand_Cache.Parameters[0].Value.SetWideString(DataIni);
  FGetDadosProdutividadeCommand_Cache.Parameters[1].Value.SetWideString(DataFim);
  FGetDadosProdutividadeCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetDadosProdutividadeCommand_Cache.Parameters[2].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetDadosProdutividadeCommand_Cache.Parameters[3].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetFormulaVitoria(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetFormulaVitoriaCommand = nil then
  begin
    FGetFormulaVitoriaCommand := FConnection.CreateCommand;
    FGetFormulaVitoriaCommand.RequestType := 'GET';
    FGetFormulaVitoriaCommand.Text := 'TDSServerModuleEstoque.GetFormulaVitoria';
    FGetFormulaVitoriaCommand.Prepare(TDSServerModuleEstoque_GetFormulaVitoria);
  end;
  FGetFormulaVitoriaCommand.Parameters[0].Value.SetWideString(DataIni);
  FGetFormulaVitoriaCommand.Parameters[1].Value.SetWideString(DataFim);
  FGetFormulaVitoriaCommand.Execute(ARequestFilter);
  Mensagem := FGetFormulaVitoriaCommand.Parameters[2].Value.GetWideString;
  Result := FGetFormulaVitoriaCommand.Parameters[3].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetFormulaVitoria_Cache(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetFormulaVitoriaCommand_Cache = nil then
  begin
    FGetFormulaVitoriaCommand_Cache := FConnection.CreateCommand;
    FGetFormulaVitoriaCommand_Cache.RequestType := 'GET';
    FGetFormulaVitoriaCommand_Cache.Text := 'TDSServerModuleEstoque.GetFormulaVitoria';
    FGetFormulaVitoriaCommand_Cache.Prepare(TDSServerModuleEstoque_GetFormulaVitoria_Cache);
  end;
  FGetFormulaVitoriaCommand_Cache.Parameters[0].Value.SetWideString(DataIni);
  FGetFormulaVitoriaCommand_Cache.Parameters[1].Value.SetWideString(DataFim);
  FGetFormulaVitoriaCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetFormulaVitoriaCommand_Cache.Parameters[2].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetFormulaVitoriaCommand_Cache.Parameters[3].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetVendaLiquida(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetVendaLiquidaCommand = nil then
  begin
    FGetVendaLiquidaCommand := FConnection.CreateCommand;
    FGetVendaLiquidaCommand.RequestType := 'GET';
    FGetVendaLiquidaCommand.Text := 'TDSServerModuleEstoque.GetVendaLiquida';
    FGetVendaLiquidaCommand.Prepare(TDSServerModuleEstoque_GetVendaLiquida);
  end;
  FGetVendaLiquidaCommand.Parameters[0].Value.SetWideString(DataIni);
  FGetVendaLiquidaCommand.Parameters[1].Value.SetWideString(DataFim);
  FGetVendaLiquidaCommand.Execute(ARequestFilter);
  Mensagem := FGetVendaLiquidaCommand.Parameters[2].Value.GetWideString;
  Result := FGetVendaLiquidaCommand.Parameters[3].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetVendaLiquida_Cache(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetVendaLiquidaCommand_Cache = nil then
  begin
    FGetVendaLiquidaCommand_Cache := FConnection.CreateCommand;
    FGetVendaLiquidaCommand_Cache.RequestType := 'GET';
    FGetVendaLiquidaCommand_Cache.Text := 'TDSServerModuleEstoque.GetVendaLiquida';
    FGetVendaLiquidaCommand_Cache.Prepare(TDSServerModuleEstoque_GetVendaLiquida_Cache);
  end;
  FGetVendaLiquidaCommand_Cache.Parameters[0].Value.SetWideString(DataIni);
  FGetVendaLiquidaCommand_Cache.Parameters[1].Value.SetWideString(DataFim);
  FGetVendaLiquidaCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetVendaLiquidaCommand_Cache.Parameters[2].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetVendaLiquidaCommand_Cache.Parameters[3].Value.GetString);
end;

function TDSServerModuleEstoqueClient.AtualizaCargaPE(senha: string; tipocarga: Integer; out Mensagem: string; const ARequestFilter: string): Boolean;
begin
  if FAtualizaCargaPECommand = nil then
  begin
    FAtualizaCargaPECommand := FConnection.CreateCommand;
    FAtualizaCargaPECommand.RequestType := 'GET';
    FAtualizaCargaPECommand.Text := 'TDSServerModuleEstoque.AtualizaCargaPE';
    FAtualizaCargaPECommand.Prepare(TDSServerModuleEstoque_AtualizaCargaPE);
  end;
  FAtualizaCargaPECommand.Parameters[0].Value.SetWideString(senha);
  FAtualizaCargaPECommand.Parameters[1].Value.SetInt32(tipocarga);
  FAtualizaCargaPECommand.Execute(ARequestFilter);
  Mensagem := FAtualizaCargaPECommand.Parameters[2].Value.GetWideString;
  Result := FAtualizaCargaPECommand.Parameters[3].Value.GetBoolean;
end;

function TDSServerModuleEstoqueClient.GetPedidosDuplicados(data: string; out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetPedidosDuplicadosCommand = nil then
  begin
    FGetPedidosDuplicadosCommand := FConnection.CreateCommand;
    FGetPedidosDuplicadosCommand.RequestType := 'GET';
    FGetPedidosDuplicadosCommand.Text := 'TDSServerModuleEstoque.GetPedidosDuplicados';
    FGetPedidosDuplicadosCommand.Prepare(TDSServerModuleEstoque_GetPedidosDuplicados);
  end;
  FGetPedidosDuplicadosCommand.Parameters[0].Value.SetWideString(data);
  FGetPedidosDuplicadosCommand.Execute(ARequestFilter);
  Mensagem := FGetPedidosDuplicadosCommand.Parameters[1].Value.GetWideString;
  Result := FGetPedidosDuplicadosCommand.Parameters[2].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetPedidosDuplicados_Cache(data: string; out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetPedidosDuplicadosCommand_Cache = nil then
  begin
    FGetPedidosDuplicadosCommand_Cache := FConnection.CreateCommand;
    FGetPedidosDuplicadosCommand_Cache.RequestType := 'GET';
    FGetPedidosDuplicadosCommand_Cache.Text := 'TDSServerModuleEstoque.GetPedidosDuplicados';
    FGetPedidosDuplicadosCommand_Cache.Prepare(TDSServerModuleEstoque_GetPedidosDuplicados_Cache);
  end;
  FGetPedidosDuplicadosCommand_Cache.Parameters[0].Value.SetWideString(data);
  FGetPedidosDuplicadosCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetPedidosDuplicadosCommand_Cache.Parameters[1].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetPedidosDuplicadosCommand_Cache.Parameters[2].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetProdDupliCond(out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetProdDupliCondCommand = nil then
  begin
    FGetProdDupliCondCommand := FConnection.CreateCommand;
    FGetProdDupliCondCommand.RequestType := 'GET';
    FGetProdDupliCondCommand.Text := 'TDSServerModuleEstoque.GetProdDupliCond';
    FGetProdDupliCondCommand.Prepare(TDSServerModuleEstoque_GetProdDupliCond);
  end;
  FGetProdDupliCondCommand.Execute(ARequestFilter);
  Mensagem := FGetProdDupliCondCommand.Parameters[0].Value.GetWideString;
  Result := FGetProdDupliCondCommand.Parameters[1].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetProdDupliCond_Cache(out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetProdDupliCondCommand_Cache = nil then
  begin
    FGetProdDupliCondCommand_Cache := FConnection.CreateCommand;
    FGetProdDupliCondCommand_Cache.RequestType := 'GET';
    FGetProdDupliCondCommand_Cache.Text := 'TDSServerModuleEstoque.GetProdDupliCond';
    FGetProdDupliCondCommand_Cache.Prepare(TDSServerModuleEstoque_GetProdDupliCond_Cache);
  end;
  FGetProdDupliCondCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetProdDupliCondCommand_Cache.Parameters[0].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetProdDupliCondCommand_Cache.Parameters[1].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetXMLStatusEnvio(NF: Integer; out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetXMLStatusEnvioCommand = nil then
  begin
    FGetXMLStatusEnvioCommand := FConnection.CreateCommand;
    FGetXMLStatusEnvioCommand.RequestType := 'GET';
    FGetXMLStatusEnvioCommand.Text := 'TDSServerModuleEstoque.GetXMLStatusEnvio';
    FGetXMLStatusEnvioCommand.Prepare(TDSServerModuleEstoque_GetXMLStatusEnvio);
  end;
  FGetXMLStatusEnvioCommand.Parameters[0].Value.SetInt32(NF);
  FGetXMLStatusEnvioCommand.Execute(ARequestFilter);
  Mensagem := FGetXMLStatusEnvioCommand.Parameters[1].Value.GetWideString;
  Result := FGetXMLStatusEnvioCommand.Parameters[2].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetXMLStatusEnvio_Cache(NF: Integer; out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetXMLStatusEnvioCommand_Cache = nil then
  begin
    FGetXMLStatusEnvioCommand_Cache := FConnection.CreateCommand;
    FGetXMLStatusEnvioCommand_Cache.RequestType := 'GET';
    FGetXMLStatusEnvioCommand_Cache.Text := 'TDSServerModuleEstoque.GetXMLStatusEnvio';
    FGetXMLStatusEnvioCommand_Cache.Prepare(TDSServerModuleEstoque_GetXMLStatusEnvio_Cache);
  end;
  FGetXMLStatusEnvioCommand_Cache.Parameters[0].Value.SetInt32(NF);
  FGetXMLStatusEnvioCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetXMLStatusEnvioCommand_Cache.Parameters[1].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetXMLStatusEnvioCommand_Cache.Parameters[2].Value.GetString);
end;

function TDSServerModuleEstoqueClient.AtualizaXMLStatusEnvio(NF: Integer; email: string; out Mensagem: string; const ARequestFilter: string): Boolean;
begin
  if FAtualizaXMLStatusEnvioCommand = nil then
  begin
    FAtualizaXMLStatusEnvioCommand := FConnection.CreateCommand;
    FAtualizaXMLStatusEnvioCommand.RequestType := 'GET';
    FAtualizaXMLStatusEnvioCommand.Text := 'TDSServerModuleEstoque.AtualizaXMLStatusEnvio';
    FAtualizaXMLStatusEnvioCommand.Prepare(TDSServerModuleEstoque_AtualizaXMLStatusEnvio);
  end;
  FAtualizaXMLStatusEnvioCommand.Parameters[0].Value.SetInt32(NF);
  FAtualizaXMLStatusEnvioCommand.Parameters[1].Value.SetWideString(email);
  FAtualizaXMLStatusEnvioCommand.Execute(ARequestFilter);
  Mensagem := FAtualizaXMLStatusEnvioCommand.Parameters[2].Value.GetWideString;
  Result := FAtualizaXMLStatusEnvioCommand.Parameters[3].Value.GetBoolean;
end;

function TDSServerModuleEstoqueClient.GetPedidosEnderecar(Rota: string; out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetPedidosEnderecarCommand = nil then
  begin
    FGetPedidosEnderecarCommand := FConnection.CreateCommand;
    FGetPedidosEnderecarCommand.RequestType := 'GET';
    FGetPedidosEnderecarCommand.Text := 'TDSServerModuleEstoque.GetPedidosEnderecar';
    FGetPedidosEnderecarCommand.Prepare(TDSServerModuleEstoque_GetPedidosEnderecar);
  end;
  FGetPedidosEnderecarCommand.Parameters[0].Value.SetWideString(Rota);
  FGetPedidosEnderecarCommand.Execute(ARequestFilter);
  Mensagem := FGetPedidosEnderecarCommand.Parameters[1].Value.GetWideString;
  Result := FGetPedidosEnderecarCommand.Parameters[2].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetPedidosEnderecar_Cache(Rota: string; out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetPedidosEnderecarCommand_Cache = nil then
  begin
    FGetPedidosEnderecarCommand_Cache := FConnection.CreateCommand;
    FGetPedidosEnderecarCommand_Cache.RequestType := 'GET';
    FGetPedidosEnderecarCommand_Cache.Text := 'TDSServerModuleEstoque.GetPedidosEnderecar';
    FGetPedidosEnderecarCommand_Cache.Prepare(TDSServerModuleEstoque_GetPedidosEnderecar_Cache);
  end;
  FGetPedidosEnderecarCommand_Cache.Parameters[0].Value.SetWideString(Rota);
  FGetPedidosEnderecarCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetPedidosEnderecarCommand_Cache.Parameters[1].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetPedidosEnderecarCommand_Cache.Parameters[2].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetWMSOrdemEntradaDivergencias(out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetWMSOrdemEntradaDivergenciasCommand = nil then
  begin
    FGetWMSOrdemEntradaDivergenciasCommand := FConnection.CreateCommand;
    FGetWMSOrdemEntradaDivergenciasCommand.RequestType := 'GET';
    FGetWMSOrdemEntradaDivergenciasCommand.Text := 'TDSServerModuleEstoque.GetWMSOrdemEntradaDivergencias';
    FGetWMSOrdemEntradaDivergenciasCommand.Prepare(TDSServerModuleEstoque_GetWMSOrdemEntradaDivergencias);
  end;
  FGetWMSOrdemEntradaDivergenciasCommand.Execute(ARequestFilter);
  Mensagem := FGetWMSOrdemEntradaDivergenciasCommand.Parameters[0].Value.GetWideString;
  Result := FGetWMSOrdemEntradaDivergenciasCommand.Parameters[1].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetWMSOrdemEntradaDivergencias_Cache(out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetWMSOrdemEntradaDivergenciasCommand_Cache = nil then
  begin
    FGetWMSOrdemEntradaDivergenciasCommand_Cache := FConnection.CreateCommand;
    FGetWMSOrdemEntradaDivergenciasCommand_Cache.RequestType := 'GET';
    FGetWMSOrdemEntradaDivergenciasCommand_Cache.Text := 'TDSServerModuleEstoque.GetWMSOrdemEntradaDivergencias';
    FGetWMSOrdemEntradaDivergenciasCommand_Cache.Prepare(TDSServerModuleEstoque_GetWMSOrdemEntradaDivergencias_Cache);
  end;
  FGetWMSOrdemEntradaDivergenciasCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetWMSOrdemEntradaDivergenciasCommand_Cache.Parameters[0].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetWMSOrdemEntradaDivergenciasCommand_Cache.Parameters[1].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetWMSOrdemSaidaToERP(out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetWMSOrdemSaidaToERPCommand = nil then
  begin
    FGetWMSOrdemSaidaToERPCommand := FConnection.CreateCommand;
    FGetWMSOrdemSaidaToERPCommand.RequestType := 'GET';
    FGetWMSOrdemSaidaToERPCommand.Text := 'TDSServerModuleEstoque.GetWMSOrdemSaidaToERP';
    FGetWMSOrdemSaidaToERPCommand.Prepare(TDSServerModuleEstoque_GetWMSOrdemSaidaToERP);
  end;
  FGetWMSOrdemSaidaToERPCommand.Execute(ARequestFilter);
  Mensagem := FGetWMSOrdemSaidaToERPCommand.Parameters[0].Value.GetWideString;
  Result := FGetWMSOrdemSaidaToERPCommand.Parameters[1].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetWMSOrdemSaidaToERP_Cache(out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetWMSOrdemSaidaToERPCommand_Cache = nil then
  begin
    FGetWMSOrdemSaidaToERPCommand_Cache := FConnection.CreateCommand;
    FGetWMSOrdemSaidaToERPCommand_Cache.RequestType := 'GET';
    FGetWMSOrdemSaidaToERPCommand_Cache.Text := 'TDSServerModuleEstoque.GetWMSOrdemSaidaToERP';
    FGetWMSOrdemSaidaToERPCommand_Cache.Prepare(TDSServerModuleEstoque_GetWMSOrdemSaidaToERP_Cache);
  end;
  FGetWMSOrdemSaidaToERPCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetWMSOrdemSaidaToERPCommand_Cache.Parameters[0].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetWMSOrdemSaidaToERPCommand_Cache.Parameters[1].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetWMSOrdemSaidaConferir(out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetWMSOrdemSaidaConferirCommand = nil then
  begin
    FGetWMSOrdemSaidaConferirCommand := FConnection.CreateCommand;
    FGetWMSOrdemSaidaConferirCommand.RequestType := 'GET';
    FGetWMSOrdemSaidaConferirCommand.Text := 'TDSServerModuleEstoque.GetWMSOrdemSaidaConferir';
    FGetWMSOrdemSaidaConferirCommand.Prepare(TDSServerModuleEstoque_GetWMSOrdemSaidaConferir);
  end;
  FGetWMSOrdemSaidaConferirCommand.Execute(ARequestFilter);
  Mensagem := FGetWMSOrdemSaidaConferirCommand.Parameters[0].Value.GetWideString;
  Result := FGetWMSOrdemSaidaConferirCommand.Parameters[1].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetWMSOrdemSaidaConferir_Cache(out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetWMSOrdemSaidaConferirCommand_Cache = nil then
  begin
    FGetWMSOrdemSaidaConferirCommand_Cache := FConnection.CreateCommand;
    FGetWMSOrdemSaidaConferirCommand_Cache.RequestType := 'GET';
    FGetWMSOrdemSaidaConferirCommand_Cache.Text := 'TDSServerModuleEstoque.GetWMSOrdemSaidaConferir';
    FGetWMSOrdemSaidaConferirCommand_Cache.Prepare(TDSServerModuleEstoque_GetWMSOrdemSaidaConferir_Cache);
  end;
  FGetWMSOrdemSaidaConferirCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetWMSOrdemSaidaConferirCommand_Cache.Parameters[0].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetWMSOrdemSaidaConferirCommand_Cache.Parameters[1].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetWMSOrdemSaidasRecusadas(out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetWMSOrdemSaidasRecusadasCommand = nil then
  begin
    FGetWMSOrdemSaidasRecusadasCommand := FConnection.CreateCommand;
    FGetWMSOrdemSaidasRecusadasCommand.RequestType := 'GET';
    FGetWMSOrdemSaidasRecusadasCommand.Text := 'TDSServerModuleEstoque.GetWMSOrdemSaidasRecusadas';
    FGetWMSOrdemSaidasRecusadasCommand.Prepare(TDSServerModuleEstoque_GetWMSOrdemSaidasRecusadas);
  end;
  FGetWMSOrdemSaidasRecusadasCommand.Execute(ARequestFilter);
  Mensagem := FGetWMSOrdemSaidasRecusadasCommand.Parameters[0].Value.GetWideString;
  Result := FGetWMSOrdemSaidasRecusadasCommand.Parameters[1].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetWMSOrdemSaidasRecusadas_Cache(out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetWMSOrdemSaidasRecusadasCommand_Cache = nil then
  begin
    FGetWMSOrdemSaidasRecusadasCommand_Cache := FConnection.CreateCommand;
    FGetWMSOrdemSaidasRecusadasCommand_Cache.RequestType := 'GET';
    FGetWMSOrdemSaidasRecusadasCommand_Cache.Text := 'TDSServerModuleEstoque.GetWMSOrdemSaidasRecusadas';
    FGetWMSOrdemSaidasRecusadasCommand_Cache.Prepare(TDSServerModuleEstoque_GetWMSOrdemSaidasRecusadas_Cache);
  end;
  FGetWMSOrdemSaidasRecusadasCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetWMSOrdemSaidasRecusadasCommand_Cache.Parameters[0].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetWMSOrdemSaidasRecusadasCommand_Cache.Parameters[1].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetWMSItensOrdemSaidasRecusadas(out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetWMSItensOrdemSaidasRecusadasCommand = nil then
  begin
    FGetWMSItensOrdemSaidasRecusadasCommand := FConnection.CreateCommand;
    FGetWMSItensOrdemSaidasRecusadasCommand.RequestType := 'GET';
    FGetWMSItensOrdemSaidasRecusadasCommand.Text := 'TDSServerModuleEstoque.GetWMSItensOrdemSaidasRecusadas';
    FGetWMSItensOrdemSaidasRecusadasCommand.Prepare(TDSServerModuleEstoque_GetWMSItensOrdemSaidasRecusadas);
  end;
  FGetWMSItensOrdemSaidasRecusadasCommand.Execute(ARequestFilter);
  Mensagem := FGetWMSItensOrdemSaidasRecusadasCommand.Parameters[0].Value.GetWideString;
  Result := FGetWMSItensOrdemSaidasRecusadasCommand.Parameters[1].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetWMSItensOrdemSaidasRecusadas_Cache(out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetWMSItensOrdemSaidasRecusadasCommand_Cache = nil then
  begin
    FGetWMSItensOrdemSaidasRecusadasCommand_Cache := FConnection.CreateCommand;
    FGetWMSItensOrdemSaidasRecusadasCommand_Cache.RequestType := 'GET';
    FGetWMSItensOrdemSaidasRecusadasCommand_Cache.Text := 'TDSServerModuleEstoque.GetWMSItensOrdemSaidasRecusadas';
    FGetWMSItensOrdemSaidasRecusadasCommand_Cache.Prepare(TDSServerModuleEstoque_GetWMSItensOrdemSaidasRecusadas_Cache);
  end;
  FGetWMSItensOrdemSaidasRecusadasCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetWMSItensOrdemSaidasRecusadasCommand_Cache.Parameters[0].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetWMSItensOrdemSaidasRecusadasCommand_Cache.Parameters[1].Value.GetString);
end;

function TDSServerModuleEstoqueClient.ZerarSTNF(Senha: string; NF: string; out Mensagem: string; const ARequestFilter: string): Boolean;
begin
  if FZerarSTNFCommand = nil then
  begin
    FZerarSTNFCommand := FConnection.CreateCommand;
    FZerarSTNFCommand.RequestType := 'GET';
    FZerarSTNFCommand.Text := 'TDSServerModuleEstoque.ZerarSTNF';
    FZerarSTNFCommand.Prepare(TDSServerModuleEstoque_ZerarSTNF);
  end;
  FZerarSTNFCommand.Parameters[0].Value.SetWideString(Senha);
  FZerarSTNFCommand.Parameters[1].Value.SetWideString(NF);
  FZerarSTNFCommand.Execute(ARequestFilter);
  Mensagem := FZerarSTNFCommand.Parameters[2].Value.GetWideString;
  Result := FZerarSTNFCommand.Parameters[3].Value.GetBoolean;
end;

function TDSServerModuleEstoqueClient.GetWMSPedidosRetornadosXHora(out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetWMSPedidosRetornadosXHoraCommand = nil then
  begin
    FGetWMSPedidosRetornadosXHoraCommand := FConnection.CreateCommand;
    FGetWMSPedidosRetornadosXHoraCommand.RequestType := 'GET';
    FGetWMSPedidosRetornadosXHoraCommand.Text := 'TDSServerModuleEstoque.GetWMSPedidosRetornadosXHora';
    FGetWMSPedidosRetornadosXHoraCommand.Prepare(TDSServerModuleEstoque_GetWMSPedidosRetornadosXHora);
  end;
  FGetWMSPedidosRetornadosXHoraCommand.Execute(ARequestFilter);
  Mensagem := FGetWMSPedidosRetornadosXHoraCommand.Parameters[0].Value.GetWideString;
  Result := FGetWMSPedidosRetornadosXHoraCommand.Parameters[1].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetWMSPedidosRetornadosXHora_Cache(out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetWMSPedidosRetornadosXHoraCommand_Cache = nil then
  begin
    FGetWMSPedidosRetornadosXHoraCommand_Cache := FConnection.CreateCommand;
    FGetWMSPedidosRetornadosXHoraCommand_Cache.RequestType := 'GET';
    FGetWMSPedidosRetornadosXHoraCommand_Cache.Text := 'TDSServerModuleEstoque.GetWMSPedidosRetornadosXHora';
    FGetWMSPedidosRetornadosXHoraCommand_Cache.Prepare(TDSServerModuleEstoque_GetWMSPedidosRetornadosXHora_Cache);
  end;
  FGetWMSPedidosRetornadosXHoraCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetWMSPedidosRetornadosXHoraCommand_Cache.Parameters[0].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetWMSPedidosRetornadosXHoraCommand_Cache.Parameters[1].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetWMSMovtosEstoqueItem(out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetWMSMovtosEstoqueItemCommand = nil then
  begin
    FGetWMSMovtosEstoqueItemCommand := FConnection.CreateCommand;
    FGetWMSMovtosEstoqueItemCommand.RequestType := 'GET';
    FGetWMSMovtosEstoqueItemCommand.Text := 'TDSServerModuleEstoque.GetWMSMovtosEstoqueItem';
    FGetWMSMovtosEstoqueItemCommand.Prepare(TDSServerModuleEstoque_GetWMSMovtosEstoqueItem);
  end;
  FGetWMSMovtosEstoqueItemCommand.Execute(ARequestFilter);
  Mensagem := FGetWMSMovtosEstoqueItemCommand.Parameters[0].Value.GetWideString;
  Result := FGetWMSMovtosEstoqueItemCommand.Parameters[1].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetWMSMovtosEstoqueItem_Cache(out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetWMSMovtosEstoqueItemCommand_Cache = nil then
  begin
    FGetWMSMovtosEstoqueItemCommand_Cache := FConnection.CreateCommand;
    FGetWMSMovtosEstoqueItemCommand_Cache.RequestType := 'GET';
    FGetWMSMovtosEstoqueItemCommand_Cache.Text := 'TDSServerModuleEstoque.GetWMSMovtosEstoqueItem';
    FGetWMSMovtosEstoqueItemCommand_Cache.Prepare(TDSServerModuleEstoque_GetWMSMovtosEstoqueItem_Cache);
  end;
  FGetWMSMovtosEstoqueItemCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetWMSMovtosEstoqueItemCommand_Cache.Parameters[0].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetWMSMovtosEstoqueItemCommand_Cache.Parameters[1].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetWMSExportOSSemSucesso(out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetWMSExportOSSemSucessoCommand = nil then
  begin
    FGetWMSExportOSSemSucessoCommand := FConnection.CreateCommand;
    FGetWMSExportOSSemSucessoCommand.RequestType := 'GET';
    FGetWMSExportOSSemSucessoCommand.Text := 'TDSServerModuleEstoque.GetWMSExportOSSemSucesso';
    FGetWMSExportOSSemSucessoCommand.Prepare(TDSServerModuleEstoque_GetWMSExportOSSemSucesso);
  end;
  FGetWMSExportOSSemSucessoCommand.Execute(ARequestFilter);
  Mensagem := FGetWMSExportOSSemSucessoCommand.Parameters[0].Value.GetWideString;
  Result := FGetWMSExportOSSemSucessoCommand.Parameters[1].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetWMSExportOSSemSucesso_Cache(out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetWMSExportOSSemSucessoCommand_Cache = nil then
  begin
    FGetWMSExportOSSemSucessoCommand_Cache := FConnection.CreateCommand;
    FGetWMSExportOSSemSucessoCommand_Cache.RequestType := 'GET';
    FGetWMSExportOSSemSucessoCommand_Cache.Text := 'TDSServerModuleEstoque.GetWMSExportOSSemSucesso';
    FGetWMSExportOSSemSucessoCommand_Cache.Prepare(TDSServerModuleEstoque_GetWMSExportOSSemSucesso_Cache);
  end;
  FGetWMSExportOSSemSucessoCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetWMSExportOSSemSucessoCommand_Cache.Parameters[0].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetWMSExportOSSemSucessoCommand_Cache.Parameters[1].Value.GetString);
end;

function TDSServerModuleEstoqueClient.CorrigeWMSEmpenhoNegaMerc(NumPedido: string; out Mensagem: string; const ARequestFilter: string): Boolean;
begin
  if FCorrigeWMSEmpenhoNegaMercCommand = nil then
  begin
    FCorrigeWMSEmpenhoNegaMercCommand := FConnection.CreateCommand;
    FCorrigeWMSEmpenhoNegaMercCommand.RequestType := 'GET';
    FCorrigeWMSEmpenhoNegaMercCommand.Text := 'TDSServerModuleEstoque.CorrigeWMSEmpenhoNegaMerc';
    FCorrigeWMSEmpenhoNegaMercCommand.Prepare(TDSServerModuleEstoque_CorrigeWMSEmpenhoNegaMerc);
  end;
  FCorrigeWMSEmpenhoNegaMercCommand.Parameters[0].Value.SetWideString(NumPedido);
  FCorrigeWMSEmpenhoNegaMercCommand.Execute(ARequestFilter);
  Mensagem := FCorrigeWMSEmpenhoNegaMercCommand.Parameters[1].Value.GetWideString;
  Result := FCorrigeWMSEmpenhoNegaMercCommand.Parameters[2].Value.GetBoolean;
end;

function TDSServerModuleEstoqueClient.GetAFVImportar(out MSG: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetAFVImportarCommand = nil then
  begin
    FGetAFVImportarCommand := FConnection.CreateCommand;
    FGetAFVImportarCommand.RequestType := 'GET';
    FGetAFVImportarCommand.Text := 'TDSServerModuleEstoque.GetAFVImportar';
    FGetAFVImportarCommand.Prepare(TDSServerModuleEstoque_GetAFVImportar);
  end;
  FGetAFVImportarCommand.Execute(ARequestFilter);
  MSG := FGetAFVImportarCommand.Parameters[0].Value.GetWideString;
  Result := FGetAFVImportarCommand.Parameters[1].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetAFVImportar_Cache(out MSG: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetAFVImportarCommand_Cache = nil then
  begin
    FGetAFVImportarCommand_Cache := FConnection.CreateCommand;
    FGetAFVImportarCommand_Cache.RequestType := 'GET';
    FGetAFVImportarCommand_Cache.Text := 'TDSServerModuleEstoque.GetAFVImportar';
    FGetAFVImportarCommand_Cache.Prepare(TDSServerModuleEstoque_GetAFVImportar_Cache);
  end;
  FGetAFVImportarCommand_Cache.ExecuteCache(ARequestFilter);
  MSG := FGetAFVImportarCommand_Cache.Parameters[0].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetAFVImportarCommand_Cache.Parameters[1].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetDetalhesPedidoAFV(NumAFV: string; out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetDetalhesPedidoAFVCommand = nil then
  begin
    FGetDetalhesPedidoAFVCommand := FConnection.CreateCommand;
    FGetDetalhesPedidoAFVCommand.RequestType := 'GET';
    FGetDetalhesPedidoAFVCommand.Text := 'TDSServerModuleEstoque.GetDetalhesPedidoAFV';
    FGetDetalhesPedidoAFVCommand.Prepare(TDSServerModuleEstoque_GetDetalhesPedidoAFV);
  end;
  FGetDetalhesPedidoAFVCommand.Parameters[0].Value.SetWideString(NumAFV);
  FGetDetalhesPedidoAFVCommand.Execute(ARequestFilter);
  Mensagem := FGetDetalhesPedidoAFVCommand.Parameters[1].Value.GetWideString;
  Result := FGetDetalhesPedidoAFVCommand.Parameters[2].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetDetalhesPedidoAFV_Cache(NumAFV: string; out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetDetalhesPedidoAFVCommand_Cache = nil then
  begin
    FGetDetalhesPedidoAFVCommand_Cache := FConnection.CreateCommand;
    FGetDetalhesPedidoAFVCommand_Cache.RequestType := 'GET';
    FGetDetalhesPedidoAFVCommand_Cache.Text := 'TDSServerModuleEstoque.GetDetalhesPedidoAFV';
    FGetDetalhesPedidoAFVCommand_Cache.Prepare(TDSServerModuleEstoque_GetDetalhesPedidoAFV_Cache);
  end;
  FGetDetalhesPedidoAFVCommand_Cache.Parameters[0].Value.SetWideString(NumAFV);
  FGetDetalhesPedidoAFVCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetDetalhesPedidoAFVCommand_Cache.Parameters[1].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetDetalhesPedidoAFVCommand_Cache.Parameters[2].Value.GetString);
end;

function TDSServerModuleEstoqueClient.DeletaItemPedidoAFV(NumAFV: string; CodProduto: string; out Mensagem: string; const ARequestFilter: string): Boolean;
begin
  if FDeletaItemPedidoAFVCommand = nil then
  begin
    FDeletaItemPedidoAFVCommand := FConnection.CreateCommand;
    FDeletaItemPedidoAFVCommand.RequestType := 'GET';
    FDeletaItemPedidoAFVCommand.Text := 'TDSServerModuleEstoque.DeletaItemPedidoAFV';
    FDeletaItemPedidoAFVCommand.Prepare(TDSServerModuleEstoque_DeletaItemPedidoAFV);
  end;
  FDeletaItemPedidoAFVCommand.Parameters[0].Value.SetWideString(NumAFV);
  FDeletaItemPedidoAFVCommand.Parameters[1].Value.SetWideString(CodProduto);
  FDeletaItemPedidoAFVCommand.Execute(ARequestFilter);
  Mensagem := FDeletaItemPedidoAFVCommand.Parameters[2].Value.GetWideString;
  Result := FDeletaItemPedidoAFVCommand.Parameters[3].Value.GetBoolean;
end;

function TDSServerModuleEstoqueClient.DeletaPedidoAFV(NumAFV: string; senha: string; out Mensagem: string; const ARequestFilter: string): Boolean;
begin
  if FDeletaPedidoAFVCommand = nil then
  begin
    FDeletaPedidoAFVCommand := FConnection.CreateCommand;
    FDeletaPedidoAFVCommand.RequestType := 'GET';
    FDeletaPedidoAFVCommand.Text := 'TDSServerModuleEstoque.DeletaPedidoAFV';
    FDeletaPedidoAFVCommand.Prepare(TDSServerModuleEstoque_DeletaPedidoAFV);
  end;
  FDeletaPedidoAFVCommand.Parameters[0].Value.SetWideString(NumAFV);
  FDeletaPedidoAFVCommand.Parameters[1].Value.SetWideString(senha);
  FDeletaPedidoAFVCommand.Execute(ARequestFilter);
  Mensagem := FDeletaPedidoAFVCommand.Parameters[2].Value.GetWideString;
  Result := FDeletaPedidoAFVCommand.Parameters[3].Value.GetBoolean;
end;

function TDSServerModuleEstoqueClient.ValidaSenhaDelPed(NumAFV: string; senha: string; out Mensagem: string; const ARequestFilter: string): Boolean;
begin
  if FValidaSenhaDelPedCommand = nil then
  begin
    FValidaSenhaDelPedCommand := FConnection.CreateCommand;
    FValidaSenhaDelPedCommand.RequestType := 'GET';
    FValidaSenhaDelPedCommand.Text := 'TDSServerModuleEstoque.ValidaSenhaDelPed';
    FValidaSenhaDelPedCommand.Prepare(TDSServerModuleEstoque_ValidaSenhaDelPed);
  end;
  FValidaSenhaDelPedCommand.Parameters[0].Value.SetWideString(NumAFV);
  FValidaSenhaDelPedCommand.Parameters[1].Value.SetWideString(senha);
  FValidaSenhaDelPedCommand.Execute(ARequestFilter);
  Mensagem := FValidaSenhaDelPedCommand.Parameters[2].Value.GetWideString;
  Result := FValidaSenhaDelPedCommand.Parameters[3].Value.GetBoolean;
end;

function TDSServerModuleEstoqueClient.GetProdutoSCondicoes(const ARequestFilter: string): TDBXReader;
begin
  if FGetProdutoSCondicoesCommand = nil then
  begin
    FGetProdutoSCondicoesCommand := FConnection.CreateCommand;
    FGetProdutoSCondicoesCommand.RequestType := 'GET';
    FGetProdutoSCondicoesCommand.Text := 'TDSServerModuleEstoque.GetProdutoSCondicoes';
    FGetProdutoSCondicoesCommand.Prepare(TDSServerModuleEstoque_GetProdutoSCondicoes);
  end;
  FGetProdutoSCondicoesCommand.Execute(ARequestFilter);
  Result := FGetProdutoSCondicoesCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetProdutoSCondicoes_Cache(const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetProdutoSCondicoesCommand_Cache = nil then
  begin
    FGetProdutoSCondicoesCommand_Cache := FConnection.CreateCommand;
    FGetProdutoSCondicoesCommand_Cache.RequestType := 'GET';
    FGetProdutoSCondicoesCommand_Cache.Text := 'TDSServerModuleEstoque.GetProdutoSCondicoes';
    FGetProdutoSCondicoesCommand_Cache.Prepare(TDSServerModuleEstoque_GetProdutoSCondicoes_Cache);
  end;
  FGetProdutoSCondicoesCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedDBXReader.Create(FGetProdutoSCondicoesCommand_Cache.Parameters[0].Value.GetString);
end;

function TDSServerModuleEstoqueClient.ValidaCliente(CNPJ: string; out Mensagem: string; const ARequestFilter: string): string;
begin
  if FValidaClienteCommand = nil then
  begin
    FValidaClienteCommand := FConnection.CreateCommand;
    FValidaClienteCommand.RequestType := 'GET';
    FValidaClienteCommand.Text := 'TDSServerModuleEstoque.ValidaCliente';
    FValidaClienteCommand.Prepare(TDSServerModuleEstoque_ValidaCliente);
  end;
  FValidaClienteCommand.Parameters[0].Value.SetWideString(CNPJ);
  FValidaClienteCommand.Execute(ARequestFilter);
  Mensagem := FValidaClienteCommand.Parameters[1].Value.GetWideString;
  Result := FValidaClienteCommand.Parameters[2].Value.GetWideString;
end;

function TDSServerModuleEstoqueClient.GetPedidosCliente(CodCliente: string; dataIni: string; out Mensagem: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetPedidosClienteCommand = nil then
  begin
    FGetPedidosClienteCommand := FConnection.CreateCommand;
    FGetPedidosClienteCommand.RequestType := 'GET';
    FGetPedidosClienteCommand.Text := 'TDSServerModuleEstoque.GetPedidosCliente';
    FGetPedidosClienteCommand.Prepare(TDSServerModuleEstoque_GetPedidosCliente);
  end;
  FGetPedidosClienteCommand.Parameters[0].Value.SetWideString(CodCliente);
  FGetPedidosClienteCommand.Parameters[1].Value.SetWideString(dataIni);
  FGetPedidosClienteCommand.Execute(ARequestFilter);
  Mensagem := FGetPedidosClienteCommand.Parameters[2].Value.GetWideString;
  Result := FGetPedidosClienteCommand.Parameters[3].Value.GetDBXReader(FInstanceOwner);
end;

function TDSServerModuleEstoqueClient.GetPedidosCliente_Cache(CodCliente: string; dataIni: string; out Mensagem: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetPedidosClienteCommand_Cache = nil then
  begin
    FGetPedidosClienteCommand_Cache := FConnection.CreateCommand;
    FGetPedidosClienteCommand_Cache.RequestType := 'GET';
    FGetPedidosClienteCommand_Cache.Text := 'TDSServerModuleEstoque.GetPedidosCliente';
    FGetPedidosClienteCommand_Cache.Prepare(TDSServerModuleEstoque_GetPedidosCliente_Cache);
  end;
  FGetPedidosClienteCommand_Cache.Parameters[0].Value.SetWideString(CodCliente);
  FGetPedidosClienteCommand_Cache.Parameters[1].Value.SetWideString(dataIni);
  FGetPedidosClienteCommand_Cache.ExecuteCache(ARequestFilter);
  Mensagem := FGetPedidosClienteCommand_Cache.Parameters[2].Value.GetWideString;
  Result := TDSRestCachedDBXReader.Create(FGetPedidosClienteCommand_Cache.Parameters[3].Value.GetString);
end;

function TDSServerModuleEstoqueClient.GetNFCliente(CodigoCliente: string; NF: string; out Mensagem: string; const ARequestFilter: string): Boolean;
begin
  if FGetNFClienteCommand = nil then
  begin
    FGetNFClienteCommand := FConnection.CreateCommand;
    FGetNFClienteCommand.RequestType := 'GET';
    FGetNFClienteCommand.Text := 'TDSServerModuleEstoque.GetNFCliente';
    FGetNFClienteCommand.Prepare(TDSServerModuleEstoque_GetNFCliente);
  end;
  FGetNFClienteCommand.Parameters[0].Value.SetWideString(CodigoCliente);
  FGetNFClienteCommand.Parameters[1].Value.SetWideString(NF);
  FGetNFClienteCommand.Execute(ARequestFilter);
  Mensagem := FGetNFClienteCommand.Parameters[2].Value.GetWideString;
  Result := FGetNFClienteCommand.Parameters[3].Value.GetBoolean;
end;

constructor TDSServerModuleEstoqueClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TDSServerModuleEstoqueClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TDSServerModuleEstoqueClient.Destroy;
begin
  FGetProdutosCommand.DisposeOf;
  FGetProdutosCommand_Cache.DisposeOf;
  FGetProdutosSuperPromocaoCommand.DisposeOf;
  FGetProdutosSuperPromocaoCommand_Cache.DisposeOf;
  FGetGiroSimplesCommand.DisposeOf;
  FGetGiroSimplesCommand_Cache.DisposeOf;
  FGetClientesCommand.DisposeOf;
  FGetClientesCommand_Cache.DisposeOf;
  FGetVendedoresCommand.DisposeOf;
  FGetVendedoresCommand_Cache.DisposeOf;
  FCorrigePedidoDuplicadoCommand.DisposeOf;
  FGetRomaneioCargaCommand.DisposeOf;
  FGetRomaneioCargaCommand_Cache.DisposeOf;
  FGetPontuacaoClienteOuroCommand.DisposeOf;
  FGetPontuacaoClienteOuroCommand_Cache.DisposeOf;
  FGetPontuacaoOuroGMCCommand.DisposeOf;
  FGetPontuacaoOuroGMCCommand_Cache.DisposeOf;
  FGetDadosProdutividadeCommand.DisposeOf;
  FGetDadosProdutividadeCommand_Cache.DisposeOf;
  FGetFormulaVitoriaCommand.DisposeOf;
  FGetFormulaVitoriaCommand_Cache.DisposeOf;
  FGetVendaLiquidaCommand.DisposeOf;
  FGetVendaLiquidaCommand_Cache.DisposeOf;
  FAtualizaCargaPECommand.DisposeOf;
  FGetPedidosDuplicadosCommand.DisposeOf;
  FGetPedidosDuplicadosCommand_Cache.DisposeOf;
  FGetProdDupliCondCommand.DisposeOf;
  FGetProdDupliCondCommand_Cache.DisposeOf;
  FGetXMLStatusEnvioCommand.DisposeOf;
  FGetXMLStatusEnvioCommand_Cache.DisposeOf;
  FAtualizaXMLStatusEnvioCommand.DisposeOf;
  FGetPedidosEnderecarCommand.DisposeOf;
  FGetPedidosEnderecarCommand_Cache.DisposeOf;
  FGetWMSOrdemEntradaDivergenciasCommand.DisposeOf;
  FGetWMSOrdemEntradaDivergenciasCommand_Cache.DisposeOf;
  FGetWMSOrdemSaidaToERPCommand.DisposeOf;
  FGetWMSOrdemSaidaToERPCommand_Cache.DisposeOf;
  FGetWMSOrdemSaidaConferirCommand.DisposeOf;
  FGetWMSOrdemSaidaConferirCommand_Cache.DisposeOf;
  FGetWMSOrdemSaidasRecusadasCommand.DisposeOf;
  FGetWMSOrdemSaidasRecusadasCommand_Cache.DisposeOf;
  FGetWMSItensOrdemSaidasRecusadasCommand.DisposeOf;
  FGetWMSItensOrdemSaidasRecusadasCommand_Cache.DisposeOf;
  FZerarSTNFCommand.DisposeOf;
  FGetWMSPedidosRetornadosXHoraCommand.DisposeOf;
  FGetWMSPedidosRetornadosXHoraCommand_Cache.DisposeOf;
  FGetWMSMovtosEstoqueItemCommand.DisposeOf;
  FGetWMSMovtosEstoqueItemCommand_Cache.DisposeOf;
  FGetWMSExportOSSemSucessoCommand.DisposeOf;
  FGetWMSExportOSSemSucessoCommand_Cache.DisposeOf;
  FCorrigeWMSEmpenhoNegaMercCommand.DisposeOf;
  FGetAFVImportarCommand.DisposeOf;
  FGetAFVImportarCommand_Cache.DisposeOf;
  FGetDetalhesPedidoAFVCommand.DisposeOf;
  FGetDetalhesPedidoAFVCommand_Cache.DisposeOf;
  FDeletaItemPedidoAFVCommand.DisposeOf;
  FDeletaPedidoAFVCommand.DisposeOf;
  FValidaSenhaDelPedCommand.DisposeOf;
  FGetProdutoSCondicoesCommand.DisposeOf;
  FGetProdutoSCondicoesCommand_Cache.DisposeOf;
  FValidaClienteCommand.DisposeOf;
  FGetPedidosClienteCommand.DisposeOf;
  FGetPedidosClienteCommand_Cache.DisposeOf;
  FGetNFClienteCommand.DisposeOf;
  inherited;
end;

function TDSServerClientesClient.GetPedidos(CodCliente: string; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetPedidosCommand = nil then
  begin
    FGetPedidosCommand := FConnection.CreateCommand;
    FGetPedidosCommand.RequestType := 'GET';
    FGetPedidosCommand.Text := 'TDSServerClientes.GetPedidos';
    FGetPedidosCommand.Prepare(TDSServerClientes_GetPedidos);
  end;
  FGetPedidosCommand.Parameters[0].Value.SetWideString(CodCliente);
  FGetPedidosCommand.Execute(ARequestFilter);
  if not FGetPedidosCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetPedidosCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetPedidosCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetPedidosCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerClientesClient.GetPedidos_Cache(CodCliente: string; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetPedidosCommand_Cache = nil then
  begin
    FGetPedidosCommand_Cache := FConnection.CreateCommand;
    FGetPedidosCommand_Cache.RequestType := 'GET';
    FGetPedidosCommand_Cache.Text := 'TDSServerClientes.GetPedidos';
    FGetPedidosCommand_Cache.Prepare(TDSServerClientes_GetPedidos_Cache);
  end;
  FGetPedidosCommand_Cache.Parameters[0].Value.SetWideString(CodCliente);
  FGetPedidosCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetPedidosCommand_Cache.Parameters[1].Value.GetString);
end;

function TDSServerClientesClient.AutenticaCNPJ(CNPJ: string; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FAutenticaCNPJCommand = nil then
  begin
    FAutenticaCNPJCommand := FConnection.CreateCommand;
    FAutenticaCNPJCommand.RequestType := 'GET';
    FAutenticaCNPJCommand.Text := 'TDSServerClientes.AutenticaCNPJ';
    FAutenticaCNPJCommand.Prepare(TDSServerClientes_AutenticaCNPJ);
  end;
  FAutenticaCNPJCommand.Parameters[0].Value.SetWideString(CNPJ);
  FAutenticaCNPJCommand.Execute(ARequestFilter);
  if not FAutenticaCNPJCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FAutenticaCNPJCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FAutenticaCNPJCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FAutenticaCNPJCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerClientesClient.AutenticaCNPJ_Cache(CNPJ: string; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FAutenticaCNPJCommand_Cache = nil then
  begin
    FAutenticaCNPJCommand_Cache := FConnection.CreateCommand;
    FAutenticaCNPJCommand_Cache.RequestType := 'GET';
    FAutenticaCNPJCommand_Cache.Text := 'TDSServerClientes.AutenticaCNPJ';
    FAutenticaCNPJCommand_Cache.Prepare(TDSServerClientes_AutenticaCNPJ_Cache);
  end;
  FAutenticaCNPJCommand_Cache.Parameters[0].Value.SetWideString(CNPJ);
  FAutenticaCNPJCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FAutenticaCNPJCommand_Cache.Parameters[1].Value.GetString);
end;

function TDSServerClientesClient.GetTitulosAb(CodCliente: string; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetTitulosAbCommand = nil then
  begin
    FGetTitulosAbCommand := FConnection.CreateCommand;
    FGetTitulosAbCommand.RequestType := 'GET';
    FGetTitulosAbCommand.Text := 'TDSServerClientes.GetTitulosAb';
    FGetTitulosAbCommand.Prepare(TDSServerClientes_GetTitulosAb);
  end;
  FGetTitulosAbCommand.Parameters[0].Value.SetWideString(CodCliente);
  FGetTitulosAbCommand.Execute(ARequestFilter);
  if not FGetTitulosAbCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetTitulosAbCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetTitulosAbCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetTitulosAbCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerClientesClient.GetTitulosAb_Cache(CodCliente: string; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetTitulosAbCommand_Cache = nil then
  begin
    FGetTitulosAbCommand_Cache := FConnection.CreateCommand;
    FGetTitulosAbCommand_Cache.RequestType := 'GET';
    FGetTitulosAbCommand_Cache.Text := 'TDSServerClientes.GetTitulosAb';
    FGetTitulosAbCommand_Cache.Prepare(TDSServerClientes_GetTitulosAb_Cache);
  end;
  FGetTitulosAbCommand_Cache.Parameters[0].Value.SetWideString(CodCliente);
  FGetTitulosAbCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetTitulosAbCommand_Cache.Parameters[1].Value.GetString);
end;

function TDSServerClientesClient.GetTitulosNF(CodCliente: string; NotaFiscal: string; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetTitulosNFCommand = nil then
  begin
    FGetTitulosNFCommand := FConnection.CreateCommand;
    FGetTitulosNFCommand.RequestType := 'GET';
    FGetTitulosNFCommand.Text := 'TDSServerClientes.GetTitulosNF';
    FGetTitulosNFCommand.Prepare(TDSServerClientes_GetTitulosNF);
  end;
  FGetTitulosNFCommand.Parameters[0].Value.SetWideString(CodCliente);
  FGetTitulosNFCommand.Parameters[1].Value.SetWideString(NotaFiscal);
  FGetTitulosNFCommand.Execute(ARequestFilter);
  if not FGetTitulosNFCommand.Parameters[2].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetTitulosNFCommand.Parameters[2].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetTitulosNFCommand.Parameters[2].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetTitulosNFCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerClientesClient.GetTitulosNF_Cache(CodCliente: string; NotaFiscal: string; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetTitulosNFCommand_Cache = nil then
  begin
    FGetTitulosNFCommand_Cache := FConnection.CreateCommand;
    FGetTitulosNFCommand_Cache.RequestType := 'GET';
    FGetTitulosNFCommand_Cache.Text := 'TDSServerClientes.GetTitulosNF';
    FGetTitulosNFCommand_Cache.Prepare(TDSServerClientes_GetTitulosNF_Cache);
  end;
  FGetTitulosNFCommand_Cache.Parameters[0].Value.SetWideString(CodCliente);
  FGetTitulosNFCommand_Cache.Parameters[1].Value.SetWideString(NotaFiscal);
  FGetTitulosNFCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetTitulosNFCommand_Cache.Parameters[2].Value.GetString);
end;

constructor TDSServerClientesClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TDSServerClientesClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TDSServerClientesClient.Destroy;
begin
  FGetPedidosCommand.DisposeOf;
  FGetPedidosCommand_Cache.DisposeOf;
  FAutenticaCNPJCommand.DisposeOf;
  FAutenticaCNPJCommand_Cache.DisposeOf;
  FGetTitulosAbCommand.DisposeOf;
  FGetTitulosAbCommand_Cache.DisposeOf;
  FGetTitulosNFCommand.DisposeOf;
  FGetTitulosNFCommand_Cache.DisposeOf;
  inherited;
end;

end.
