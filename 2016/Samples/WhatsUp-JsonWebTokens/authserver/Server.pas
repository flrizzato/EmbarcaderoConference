unit Server;

interface

uses 
  ConnectionModule, 
  XData.Server.Module,
  System.SysUtils,
  Sparkle.HttpSys.Server,
  Sparkle.HttpServer.Context,
  Sparkle.HttpServer.Module;

procedure StartServer;
procedure StopServer;

implementation

uses
  System.IOUtils;

var
  SparkleServer: THttpSysServer;

procedure StartServer;
var
  Module : TXDataServerModule;
begin
  if Assigned(SparkleServer) then
     Exit;

  SparkleServer := THttpSysServer.Create;

  Module := TXDataServerModule.Create(
    'http://+:2001/tms/auth',
    TSQLiteSQLiteConnection.CreatePool(20)
  );
  SparkleServer.AddModule(Module);

  SparkleServer.Start;
end;

procedure StopServer;
begin
  FreeAndNil(SparkleServer);
end;

initialization
  SparkleServer := nil;
finalization
  StopServer;
end.
