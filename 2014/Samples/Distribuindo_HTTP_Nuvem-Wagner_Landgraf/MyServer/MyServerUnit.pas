unit MyServerUnit;

interface

uses
  System.SysUtils,
  Sparkle.HttpSys.Server;

procedure StartMyServer;
procedure StopMyServer;

implementation

uses
  Aurelius.Sql.Interbase,
  RemoteDB.Drivers.Base,
  RemoteDB.Drivers.Interfaces,
  RemoteDB.Drivers.FireDac,
  RemoteDB.Server.Module,
  XData.Aurelius.ConnectionPool,
  XData.Server.Module,
  DBDemosModule;

var
  MyServer: THttpSysServer;

procedure StartMyServer;
var
  ConnFactory: IDBConnectionFactory;
begin
  if MyServer <> nil then Exit;
  MyServer := THttpSysServer.Create;

  ConnFactory := TDBConnectionFactory.Create(
    function: IDBConnection
    var
      Module: TdmDBDemos;
    begin
      Module := TdmDBDemos.Create(nil);
      Result := TFireDacConnectionAdapter.Create(Module.FDConnection1, Module);
    end);

  MyServer.AddModule(TRemoteDBModule.Create(
    'http://+:80/tms/dbdemos/data', ConnFactory));

  MyServer.AddModule(TXDataServerModule.Create(
    'http://+:80/tms/dbdemos/rest', TDBConnectionPool.Create(15, ConnFactory)));

  MyServer.Start;
end;

procedure StopMyServer;
begin
  FreeAndNil(MyServer);
end;

initialization
  MyServer := nil;
finalization
  StopMyServer;
end.
