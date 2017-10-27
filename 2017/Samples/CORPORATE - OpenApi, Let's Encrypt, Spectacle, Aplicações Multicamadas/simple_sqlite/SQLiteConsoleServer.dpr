program SQLiteConsoleServer;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  Aurelius.Drivers.Interfaces,
  Aurelius.Drivers.SQLite,
  Aurelius.Sql.SQLite,
  Aurelius.Schema.SQLite,
  Sparkle.HttpSys.Server,
  XData.Aurelius.ConnectionPool,
  XData.OpenApi.Service,
  XData.Server.Module,
  AureliusEntities in '..\common\AureliusEntities.pas',
  DatabaseUtils in '..\common\DatabaseUtils.pas';

const
  DefaultServerUrl = 'http://localhost:2001/tms/music';

procedure CreateModule(const Url: string; Server: THttpSysServer; Pool: IDBConnectionPool);
var
  Module: TXDataServerModule;
begin
  // Create the XData module
  Module := TXDataServerModule.Create(Url, Pool);

  // Allow access to the API from different domains (less secure but better
  // for testing/development purposes)
  Module.AccessControlAllowOrigin := '*';

  // Add the XData module to the server and start it
  Server.AddModule(Module);
  WriteLn(Format('Module listening at "%s"', [Url]));
end;

procedure StartServer;
var
  Server: THttpSysServer;
  Connection: IDBConnection;
  Pool: IDBConnectionPool;
  I: Integer;
begin
  Server := THttpSysServer.Create;
  try
    // Create a database in memory and create needed tables and columns
    Connection := TSQLiteNativeConnectionAdapter.Create(':memory:');
    UpdateDatabase(Connection);

    // Create a common connection pool for all modules
    Pool := TDBConnectionPool.Create(1,
      function: IDBConnection
      begin
        Result := Connection;
      end);

    // Enable OpenAPI/Swagger support
    RegisterOpenApiService;

    // Create one module for each URL passed in command-line. For example, the following
    // command-line will start a server that listen on both http and https urls
    // SQLiteConsoleServer.exe http://+:80/tms/music https://+:443/tms/music
    if ParamCount > 0 then
      for I := 1 to ParamCount do
        CreateModule(ParamStr(I), Server, Pool)
    else
      // If not command-line parameters are specific, use default URL
      CreateModule(DefaultServerUrl, Server, Pool);


    // Start the server
    Server.Start;
    WriteLn('Server started. Press ENTER to stop.');
    ReadLn;
  finally
    Server.Free;
  end;
end;

begin
  ReportMemoryLeaksOnShutdown := true;
  try
    StartServer;
  except
    on e: exception do
    begin
      WriteLn(e.Message);
      ReadLn;
    end;
  end;
end.

