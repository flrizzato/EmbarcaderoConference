// 
// Created by the DataSnap proxy generator.
// 19/10/2018 19:05:39
// 

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FGetClientesCommand: TDSRestCommand;
    FGetClientesCommand_Cache: TDSRestCommand;
    FGetTelefonesCommand: TDSRestCommand;
    FGetTelefonesCommand_Cache: TDSRestCommand;
    FGetClientesTelefonesCommand: TDSRestCommand;
    FGetClientesTelefonesCommand_Cache: TDSRestCommand;
    FGravarCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function GetClientes(const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetClientes_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetTelefones(const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetTelefones_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetClientesTelefones(const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetClientesTelefones_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    procedure Gravar(ADeltaList: TFDJSONDeltas);
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TServerMethods1_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_GetClientes: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods1_GetClientes_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_GetTelefones: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods1_GetTelefones_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_GetClientesTelefones: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods1_GetClientesTelefones_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_Gravar: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'ADeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas')
  );

implementation

function TServerMethods1Client.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare(TServerMethods1_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare(TServerMethods1_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.GetClientes(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetClientesCommand = nil then
  begin
    FGetClientesCommand := FConnection.CreateCommand;
    FGetClientesCommand.RequestType := 'GET';
    FGetClientesCommand.Text := 'TServerMethods1.GetClientes';
    FGetClientesCommand.Prepare(TServerMethods1_GetClientes);
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

function TServerMethods1Client.GetClientes_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetClientesCommand_Cache = nil then
  begin
    FGetClientesCommand_Cache := FConnection.CreateCommand;
    FGetClientesCommand_Cache.RequestType := 'GET';
    FGetClientesCommand_Cache.Text := 'TServerMethods1.GetClientes';
    FGetClientesCommand_Cache.Prepare(TServerMethods1_GetClientes_Cache);
  end;
  FGetClientesCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetClientesCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods1Client.GetTelefones(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetTelefonesCommand = nil then
  begin
    FGetTelefonesCommand := FConnection.CreateCommand;
    FGetTelefonesCommand.RequestType := 'GET';
    FGetTelefonesCommand.Text := 'TServerMethods1.GetTelefones';
    FGetTelefonesCommand.Prepare(TServerMethods1_GetTelefones);
  end;
  FGetTelefonesCommand.Execute(ARequestFilter);
  if not FGetTelefonesCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetTelefonesCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetTelefonesCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetTelefonesCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods1Client.GetTelefones_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetTelefonesCommand_Cache = nil then
  begin
    FGetTelefonesCommand_Cache := FConnection.CreateCommand;
    FGetTelefonesCommand_Cache.RequestType := 'GET';
    FGetTelefonesCommand_Cache.Text := 'TServerMethods1.GetTelefones';
    FGetTelefonesCommand_Cache.Prepare(TServerMethods1_GetTelefones_Cache);
  end;
  FGetTelefonesCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetTelefonesCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods1Client.GetClientesTelefones(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetClientesTelefonesCommand = nil then
  begin
    FGetClientesTelefonesCommand := FConnection.CreateCommand;
    FGetClientesTelefonesCommand.RequestType := 'GET';
    FGetClientesTelefonesCommand.Text := 'TServerMethods1.GetClientesTelefones';
    FGetClientesTelefonesCommand.Prepare(TServerMethods1_GetClientesTelefones);
  end;
  FGetClientesTelefonesCommand.Execute(ARequestFilter);
  if not FGetClientesTelefonesCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetClientesTelefonesCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetClientesTelefonesCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetClientesTelefonesCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods1Client.GetClientesTelefones_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetClientesTelefonesCommand_Cache = nil then
  begin
    FGetClientesTelefonesCommand_Cache := FConnection.CreateCommand;
    FGetClientesTelefonesCommand_Cache.RequestType := 'GET';
    FGetClientesTelefonesCommand_Cache.Text := 'TServerMethods1.GetClientesTelefones';
    FGetClientesTelefonesCommand_Cache.Prepare(TServerMethods1_GetClientesTelefones_Cache);
  end;
  FGetClientesTelefonesCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetClientesTelefonesCommand_Cache.Parameters[0].Value.GetString);
end;

procedure TServerMethods1Client.Gravar(ADeltaList: TFDJSONDeltas);
begin
  if FGravarCommand = nil then
  begin
    FGravarCommand := FConnection.CreateCommand;
    FGravarCommand.RequestType := 'POST';
    FGravarCommand.Text := 'TServerMethods1."Gravar"';
    FGravarCommand.Prepare(TServerMethods1_Gravar);
  end;
  if not Assigned(ADeltaList) then
    FGravarCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FGravarCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FGravarCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(ADeltaList), True);
      if FInstanceOwner then
        ADeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FGravarCommand.Execute;
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FGetClientesCommand.DisposeOf;
  FGetClientesCommand_Cache.DisposeOf;
  FGetTelefonesCommand.DisposeOf;
  FGetTelefonesCommand_Cache.DisposeOf;
  FGetClientesTelefonesCommand.DisposeOf;
  FGetClientesTelefonesCommand_Cache.DisposeOf;
  FGravarCommand.DisposeOf;
  inherited;
end;

end.
