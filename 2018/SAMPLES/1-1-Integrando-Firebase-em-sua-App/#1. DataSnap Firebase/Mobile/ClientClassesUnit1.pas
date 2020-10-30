//
// Created by the DataSnap proxy generator.
// 24/03/2018 15:21:33
//

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TSrvMetodosClient = class(TDSAdminRestClient)
  private
    FDSServerModuleCreateCommand: TDSRestCommand;
    FDSServerModuleDestroyCommand: TDSRestCommand;
    FGetTicketsCommand: TDSRestCommand;
    FGetTicketsCommand_Cache: TDSRestCommand;
    FSincronizarCommand: TDSRestCommand;
    FPatchTicketCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    procedure DSServerModuleDestroy(Sender: TObject);
    function GetTickets(ATicket: string; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetTickets_Cache(ATicket: string; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function Sincronizar(ATickets: string; const ARequestFilter: string = ''): Boolean;
    function PatchTicket(ATicket: string; const ARequestFilter: string = ''): Boolean;
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TSrvMetodos_DSServerModuleCreate: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TSrvMetodos_DSServerModuleDestroy: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TSrvMetodos_GetTickets: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ATicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TSrvMetodos_GetTickets_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ATicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSrvMetodos_Sincronizar: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ATickets'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TSrvMetodos_PatchTicket: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ATicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

implementation

procedure TSrvMetodosClient.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FConnection.CreateCommand;
    FDSServerModuleCreateCommand.RequestType := 'POST';
    FDSServerModuleCreateCommand.Text := 'TSrvMetodos."DSServerModuleCreate"';
    FDSServerModuleCreateCommand.Prepare(TSrvMetodos_DSServerModuleCreate);
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

procedure TSrvMetodosClient.DSServerModuleDestroy(Sender: TObject);
begin
  if FDSServerModuleDestroyCommand = nil then
  begin
    FDSServerModuleDestroyCommand := FConnection.CreateCommand;
    FDSServerModuleDestroyCommand.RequestType := 'POST';
    FDSServerModuleDestroyCommand.Text := 'TSrvMetodos."DSServerModuleDestroy"';
    FDSServerModuleDestroyCommand.Prepare(TSrvMetodos_DSServerModuleDestroy);
  end;
  if not Assigned(Sender) then
    FDSServerModuleDestroyCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDSServerModuleDestroyCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDSServerModuleDestroyCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDSServerModuleDestroyCommand.Execute;
end;

function TSrvMetodosClient.GetTickets(ATicket: string; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetTicketsCommand = nil then
  begin
    FGetTicketsCommand := FConnection.CreateCommand;
    FGetTicketsCommand.RequestType := 'GET';
    FGetTicketsCommand.Text := 'TSrvMetodos.GetTickets';
    FGetTicketsCommand.Prepare(TSrvMetodos_GetTickets);
  end;
  FGetTicketsCommand.Parameters[0].Value.SetWideString(ATicket);
  FGetTicketsCommand.Execute(ARequestFilter);
  if not FGetTicketsCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetTicketsCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetTicketsCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetTicketsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TSrvMetodosClient.GetTickets_Cache(ATicket: string; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetTicketsCommand_Cache = nil then
  begin
    FGetTicketsCommand_Cache := FConnection.CreateCommand;
    FGetTicketsCommand_Cache.RequestType := 'GET';
    FGetTicketsCommand_Cache.Text := 'TSrvMetodos.GetTickets';
    FGetTicketsCommand_Cache.Prepare(TSrvMetodos_GetTickets_Cache);
  end;
  FGetTicketsCommand_Cache.Parameters[0].Value.SetWideString(ATicket);
  FGetTicketsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetTicketsCommand_Cache.Parameters[1].Value.GetString);
end;

function TSrvMetodosClient.Sincronizar(ATickets: string; const ARequestFilter: string): Boolean;
begin
  if FSincronizarCommand = nil then
  begin
    FSincronizarCommand := FConnection.CreateCommand;
    FSincronizarCommand.RequestType := 'GET';
    FSincronizarCommand.Text := 'TSrvMetodos.Sincronizar';
    FSincronizarCommand.Prepare(TSrvMetodos_Sincronizar);
  end;
  FSincronizarCommand.Parameters[0].Value.SetWideString(ATickets);
  FSincronizarCommand.Execute(ARequestFilter);
  Result := FSincronizarCommand.Parameters[1].Value.GetBoolean;
end;

function TSrvMetodosClient.PatchTicket(ATicket: string; const ARequestFilter: string): Boolean;
begin
  if FPatchTicketCommand = nil then
  begin
    FPatchTicketCommand := FConnection.CreateCommand;
    FPatchTicketCommand.RequestType := 'GET';
    FPatchTicketCommand.Text := 'TSrvMetodos.PatchTicket';
    FPatchTicketCommand.Prepare(TSrvMetodos_PatchTicket);
  end;
  FPatchTicketCommand.Parameters[0].Value.SetWideString(ATicket);
  FPatchTicketCommand.Execute(ARequestFilter);
  Result := FPatchTicketCommand.Parameters[1].Value.GetBoolean;
end;

constructor TSrvMetodosClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TSrvMetodosClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TSrvMetodosClient.Destroy;
begin
  FDSServerModuleCreateCommand.DisposeOf;
  FDSServerModuleDestroyCommand.DisposeOf;
  FGetTicketsCommand.DisposeOf;
  FGetTicketsCommand_Cache.DisposeOf;
  FSincronizarCommand.DisposeOf;
  FPatchTicketCommand.DisposeOf;
  inherited;
end;

end.

