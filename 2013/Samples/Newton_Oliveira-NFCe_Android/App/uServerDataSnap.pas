// 
// Created by the DataSnap proxy generator.
// 29/10/2013 20:26:29
// 

unit uServerDataSnap;

interface

uses Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, uNota, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminClient)
  private
    FEchoStringCommand: TDBXCommand;
    FReverseStringCommand: TDBXCommand;
    FEnviarNotaCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function EnviarNota(pNotaFiscal: TNotaFiscal): string;
  end;

implementation

function TServerMethods1Client.EchoString(Value: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FDBXConnection.CreateCommand;
    FEchoStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare;
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.ExecuteUpdate;
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FDBXConnection.CreateCommand;
    FReverseStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare;
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.ExecuteUpdate;
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.EnviarNota(pNotaFiscal: TNotaFiscal): string;
begin
  if FEnviarNotaCommand = nil then
  begin
    FEnviarNotaCommand := FDBXConnection.CreateCommand;
    FEnviarNotaCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FEnviarNotaCommand.Text := 'TServerMethods1.EnviarNota';
    FEnviarNotaCommand.Prepare;
  end;
  if not Assigned(pNotaFiscal) then
    FEnviarNotaCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FEnviarNotaCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FEnviarNotaCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(pNotaFiscal), True);
      if FInstanceOwner then
        pNotaFiscal.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FEnviarNotaCommand.ExecuteUpdate;
  Result := FEnviarNotaCommand.Parameters[1].Value.GetWideString;
end;


constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TServerMethods1Client.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FEnviarNotaCommand.DisposeOf;
  inherited;
end;

end.
