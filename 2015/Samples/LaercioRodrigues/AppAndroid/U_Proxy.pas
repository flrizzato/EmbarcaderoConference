//
// Created by the DataSnap proxy generator.
// 20/10/2015 13:40:01
//

unit U_Proxy;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminClient)
  private
    FEchoStringCommand: TDBXCommand;
    FReverseStringCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
  end;

  TDSMPalestraClient = class(TDSAdminClient)
  private
    FExisteTAGCommand: TDBXCommand;
    FAbrirPortaCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function ExisteTAG(numero: string): Boolean;
    procedure AbrirPorta(Tag: string);
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
  inherited;
end;

function TDSMPalestraClient.ExisteTAG(numero: string): Boolean;
begin
  if FExisteTAGCommand = nil then
  begin
    FExisteTAGCommand := FDBXConnection.CreateCommand;
    FExisteTAGCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FExisteTAGCommand.Text := 'TDSMPalestra.ExisteTAG';
    FExisteTAGCommand.Prepare;
  end;
  FExisteTAGCommand.Parameters[0].Value.SetWideString(numero);
  FExisteTAGCommand.ExecuteUpdate;
  Result := FExisteTAGCommand.Parameters[1].Value.GetBoolean;
end;

procedure TDSMPalestraClient.AbrirPorta(Tag: string);
begin
  if FAbrirPortaCommand = nil then
  begin
    FAbrirPortaCommand := FDBXConnection.CreateCommand;
    FAbrirPortaCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAbrirPortaCommand.Text := 'TDSMPalestra.AbrirPorta';
    FAbrirPortaCommand.Prepare;
  end;
  FAbrirPortaCommand.Parameters[0].Value.SetWideString(Tag);
  FAbrirPortaCommand.ExecuteUpdate;
end;


constructor TDSMPalestraClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TDSMPalestraClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TDSMPalestraClient.Destroy;
begin
  FExisteTAGCommand.DisposeOf;
  FAbrirPortaCommand.DisposeOf;
  inherited;
end;

end.

