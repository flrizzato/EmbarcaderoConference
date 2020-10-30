//
// Created by the DataSnap proxy generator.
// 21/10/2015 18:03:03
//

unit uCC;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TSMClient = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FGetClientesCommand: TDSRestCommand;
    FGetClientesCommand_Cache: TDSRestCommand;
    FGetProdutosCommand: TDSRestCommand;
    FGetProdutosCommand_Cache: TDSRestCommand;
    FSetPedidosCommand: TDSRestCommand;
    FGetPedidoAndItemCommand: TDSRestCommand;
    FGetPedidoAndItemCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function GetClientes(const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetClientes_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetProdutos(const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetProdutos_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function SetPedidos(ADataset: TFDJSONDataSets; const ARequestFilter: string = ''): Boolean;
    function GetPedidoAndItem(const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetPedidoAndItem_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TSM_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TSM_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TSM_GetClientes: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TSM_GetClientes_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSM_GetProdutos: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TSM_GetProdutos_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSM_SetPedidos: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ADataset'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDataSets'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TSM_GetPedidoAndItem: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TSM_GetPedidoAndItem_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

implementation

function TSMClient.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TSM.EchoString';
    FEchoStringCommand.Prepare(TSM_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TSMClient.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TSM.ReverseString';
    FReverseStringCommand.Prepare(TSM_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TSMClient.GetClientes(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetClientesCommand = nil then
  begin
    FGetClientesCommand := FConnection.CreateCommand;
    FGetClientesCommand.RequestType := 'GET';
    FGetClientesCommand.Text := 'TSM.GetClientes';
    FGetClientesCommand.Prepare(TSM_GetClientes);
  end;
  FGetClientesCommand.Execute(ARequestFilter);
  if not FGetClientesCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetClientesCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetClientesCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetClientesCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TSMClient.GetClientes_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetClientesCommand_Cache = nil then
  begin
    FGetClientesCommand_Cache := FConnection.CreateCommand;
    FGetClientesCommand_Cache.RequestType := 'GET';
    FGetClientesCommand_Cache.Text := 'TSM.GetClientes';
    FGetClientesCommand_Cache.Prepare(TSM_GetClientes_Cache);
  end;
  FGetClientesCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetClientesCommand_Cache.Parameters[0].Value.GetString);
end;

function TSMClient.GetProdutos(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetProdutosCommand = nil then
  begin
    FGetProdutosCommand := FConnection.CreateCommand;
    FGetProdutosCommand.RequestType := 'GET';
    FGetProdutosCommand.Text := 'TSM.GetProdutos';
    FGetProdutosCommand.Prepare(TSM_GetProdutos);
  end;
  FGetProdutosCommand.Execute(ARequestFilter);
  if not FGetProdutosCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetProdutosCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetProdutosCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetProdutosCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TSMClient.GetProdutos_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetProdutosCommand_Cache = nil then
  begin
    FGetProdutosCommand_Cache := FConnection.CreateCommand;
    FGetProdutosCommand_Cache.RequestType := 'GET';
    FGetProdutosCommand_Cache.Text := 'TSM.GetProdutos';
    FGetProdutosCommand_Cache.Prepare(TSM_GetProdutos_Cache);
  end;
  FGetProdutosCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetProdutosCommand_Cache.Parameters[0].Value.GetString);
end;

function TSMClient.SetPedidos(ADataset: TFDJSONDataSets; const ARequestFilter: string): Boolean;
begin
  if FSetPedidosCommand = nil then
  begin
    FSetPedidosCommand := FConnection.CreateCommand;
    FSetPedidosCommand.RequestType := 'POST';
    FSetPedidosCommand.Text := 'TSM."SetPedidos"';
    FSetPedidosCommand.Prepare(TSM_SetPedidos);
  end;
  if not Assigned(ADataset) then
    FSetPedidosCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSetPedidosCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSetPedidosCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(ADataset), True);
      if FInstanceOwner then
        ADataset.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSetPedidosCommand.Execute(ARequestFilter);
  Result := FSetPedidosCommand.Parameters[1].Value.GetBoolean;
end;

function TSMClient.GetPedidoAndItem(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetPedidoAndItemCommand = nil then
  begin
    FGetPedidoAndItemCommand := FConnection.CreateCommand;
    FGetPedidoAndItemCommand.RequestType := 'GET';
    FGetPedidoAndItemCommand.Text := 'TSM.GetPedidoAndItem';
    FGetPedidoAndItemCommand.Prepare(TSM_GetPedidoAndItem);
  end;
  FGetPedidoAndItemCommand.Execute(ARequestFilter);
  if not FGetPedidoAndItemCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetPedidoAndItemCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetPedidoAndItemCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetPedidoAndItemCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TSMClient.GetPedidoAndItem_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetPedidoAndItemCommand_Cache = nil then
  begin
    FGetPedidoAndItemCommand_Cache := FConnection.CreateCommand;
    FGetPedidoAndItemCommand_Cache.RequestType := 'GET';
    FGetPedidoAndItemCommand_Cache.Text := 'TSM.GetPedidoAndItem';
    FGetPedidoAndItemCommand_Cache.Prepare(TSM_GetPedidoAndItem_Cache);
  end;
  FGetPedidoAndItemCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetPedidoAndItemCommand_Cache.Parameters[0].Value.GetString);
end;

constructor TSMClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TSMClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TSMClient.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FGetClientesCommand.DisposeOf;
  FGetClientesCommand_Cache.DisposeOf;
  FGetProdutosCommand.DisposeOf;
  FGetProdutosCommand_Cache.DisposeOf;
  FSetPedidosCommand.DisposeOf;
  FGetPedidoAndItemCommand.DisposeOf;
  FGetPedidoAndItemCommand_Cache.DisposeOf;
  inherited;
end;

end.

