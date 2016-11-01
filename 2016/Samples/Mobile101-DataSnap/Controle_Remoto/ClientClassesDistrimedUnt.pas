//
// Created by the DataSnap proxy generator.
// 25/07/2014 18:52:38
//

unit ClientClassesDistrimedUnt;

interface

uses Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TsvrMetodosClient = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FGetGiroSimplesCommand: TDSRestCommand;
    FGetGiroSimplesCommand_Cache: TDSRestCommand;
    FShowSqlGiroSimplesCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function GetGiroSimples(Grupo: string; DataIni: string; DataFim: string; const ARequestFilter: string = ''): TDBXReader;
    function GetGiroSimples_Cache(Grupo: string; DataIni: string; DataFim: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function ShowSqlGiroSimples(const ARequestFilter: string = ''): string;
  end;

  TDSServerModuleEstoqueClient = class(TDSAdminRestClient)
  private
    FDSServerModuleCreateCommand: TDSRestCommand;
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
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
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
    function GetDadosProdutividade(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetDadosProdutividade_Cache(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetFormulaVitoria(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetFormulaVitoria_Cache(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetVendaLiquida(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetVendaLiquida_Cache(DataIni: string; DataFim: string; out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function AtualizaCargaPE(senha: string; out Mensagem: string; const ARequestFilter: string = ''): Boolean;
    function GetPedidosDuplicados(data: string; out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetPedidosDuplicados_Cache(data: string; out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
    function GetProdDupliCond(out Mensagem: string; const ARequestFilter: string = ''): TDBXReader;
    function GetProdDupliCond_Cache(out Mensagem: string; const ARequestFilter: string = ''): IDSRestCachedDBXReader;
  end;

const
  TsvrMetodos_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TsvrMetodos_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TsvrMetodos_GetGiroSimples: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'Grupo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataIni'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataFim'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDBXReader')
  );

  TsvrMetodos_GetGiroSimples_Cache: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'Grupo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataIni'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'DataFim'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TsvrMetodos_ShowSqlGiroSimples: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TDSServerModuleEstoque_DSServerModuleCreate: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

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

  TDSServerModuleEstoque_AtualizaCargaPE: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'senha'; Direction: 1; DBXType: 26; TypeName: 'string'),
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

implementation

function TsvrMetodosClient.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TsvrMetodos.EchoString';
    FEchoStringCommand.Prepare(TsvrMetodos_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TsvrMetodosClient.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TsvrMetodos.ReverseString';
    FReverseStringCommand.Prepare(TsvrMetodos_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TsvrMetodosClient.GetGiroSimples(Grupo: string; DataIni: string; DataFim: string; const ARequestFilter: string): TDBXReader;
begin
  if FGetGiroSimplesCommand = nil then
  begin
    FGetGiroSimplesCommand := FConnection.CreateCommand;
    FGetGiroSimplesCommand.RequestType := 'GET';
    FGetGiroSimplesCommand.Text := 'TsvrMetodos.GetGiroSimples';
    FGetGiroSimplesCommand.Prepare(TsvrMetodos_GetGiroSimples);
  end;
  FGetGiroSimplesCommand.Parameters[0].Value.SetWideString(Grupo);
  FGetGiroSimplesCommand.Parameters[1].Value.SetWideString(DataIni);
  FGetGiroSimplesCommand.Parameters[2].Value.SetWideString(DataFim);
  FGetGiroSimplesCommand.Execute(ARequestFilter);
  Result := FGetGiroSimplesCommand.Parameters[3].Value.GetDBXReader(FInstanceOwner);
end;

function TsvrMetodosClient.GetGiroSimples_Cache(Grupo: string; DataIni: string; DataFim: string; const ARequestFilter: string): IDSRestCachedDBXReader;
begin
  if FGetGiroSimplesCommand_Cache = nil then
  begin
    FGetGiroSimplesCommand_Cache := FConnection.CreateCommand;
    FGetGiroSimplesCommand_Cache.RequestType := 'GET';
    FGetGiroSimplesCommand_Cache.Text := 'TsvrMetodos.GetGiroSimples';
    FGetGiroSimplesCommand_Cache.Prepare(TsvrMetodos_GetGiroSimples_Cache);
  end;
  FGetGiroSimplesCommand_Cache.Parameters[0].Value.SetWideString(Grupo);
  FGetGiroSimplesCommand_Cache.Parameters[1].Value.SetWideString(DataIni);
  FGetGiroSimplesCommand_Cache.Parameters[2].Value.SetWideString(DataFim);
  FGetGiroSimplesCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedDBXReader.Create(FGetGiroSimplesCommand_Cache.Parameters[3].Value.GetString);
end;

function TsvrMetodosClient.ShowSqlGiroSimples(const ARequestFilter: string): string;
begin
  if FShowSqlGiroSimplesCommand = nil then
  begin
    FShowSqlGiroSimplesCommand := FConnection.CreateCommand;
    FShowSqlGiroSimplesCommand.RequestType := 'GET';
    FShowSqlGiroSimplesCommand.Text := 'TsvrMetodos.ShowSqlGiroSimples';
    FShowSqlGiroSimplesCommand.Prepare(TsvrMetodos_ShowSqlGiroSimples);
  end;
  FShowSqlGiroSimplesCommand.Execute(ARequestFilter);
  Result := FShowSqlGiroSimplesCommand.Parameters[0].Value.GetWideString;
end;

constructor TsvrMetodosClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TsvrMetodosClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TsvrMetodosClient.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FGetGiroSimplesCommand.DisposeOf;
  FGetGiroSimplesCommand_Cache.DisposeOf;
  FShowSqlGiroSimplesCommand.DisposeOf;
  inherited;
end;

procedure TDSServerModuleEstoqueClient.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FConnection.CreateCommand;
    FDSServerModuleCreateCommand.RequestType := 'POST';
    FDSServerModuleCreateCommand.Text := 'TDSServerModuleEstoque."DSServerModuleCreate"';
    FDSServerModuleCreateCommand.Prepare(TDSServerModuleEstoque_DSServerModuleCreate);
  end;
  if not Assigned(Sender) then
    FDSServerModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDSServerModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDSServerModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDSServerModuleCreateCommand.Execute;
end;

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

function TDSServerModuleEstoqueClient.AtualizaCargaPE(senha: string; out Mensagem: string; const ARequestFilter: string): Boolean;
begin
  if FAtualizaCargaPECommand = nil then
  begin
    FAtualizaCargaPECommand := FConnection.CreateCommand;
    FAtualizaCargaPECommand.RequestType := 'GET';
    FAtualizaCargaPECommand.Text := 'TDSServerModuleEstoque.AtualizaCargaPE';
    FAtualizaCargaPECommand.Prepare(TDSServerModuleEstoque_AtualizaCargaPE);
  end;
  FAtualizaCargaPECommand.Parameters[0].Value.SetWideString(senha);
  FAtualizaCargaPECommand.Execute(ARequestFilter);
  Mensagem := FAtualizaCargaPECommand.Parameters[1].Value.GetWideString;
  Result := FAtualizaCargaPECommand.Parameters[2].Value.GetBoolean;
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
  FDSServerModuleCreateCommand.DisposeOf;
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
  inherited;
end;

end.

