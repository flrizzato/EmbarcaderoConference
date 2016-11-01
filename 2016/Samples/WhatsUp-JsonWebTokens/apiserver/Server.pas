unit Server;

interface

uses 
  SQLiteConnectionModule,
  XData.Server.Module,
  System.SysUtils,
  Sparkle.HttpSys.Server,
  Sparkle.HttpServer.Context,
  Sparkle.HttpServer.Module;

procedure StartServer;
procedure StopServer;

implementation

uses
  System.IOUtils,
  Sparkle.Middleware.Jwt,
  Aurelius.Criteria.Linq,
  Aurelius.Drivers.Interfaces,
  XData.Module.Events,
  DatabaseUtils;

var
  SparkleServer: THttpSysServer;

procedure StartServer;
var
  Module: TXDataServerModule;
  Conn: IDBConnection;
begin
  if Assigned(SparkleServer) then
     Exit;

  SparkleServer := THttpSysServer.Create;

  Conn := TSQLiteConnection.CreateConnection;
  DatabaseUtils.UpdateDatabase(Conn);
  Module := TXDataServerModule.Create(
    'http://+:2001/tms/api',
    Conn
  );

  // Accept JSON Web Tokens
  Module.AddMiddleware(TJwtMiddleware.Create('super_secret'));

  // Refuse requests with no authentication info (without JWT)
  Module.AddMiddleware(TAnonymousMiddleware.Create(
    procedure(Context: THttpServerContext; Next: THttpServerProc)
    begin
      if Context.Request.User = nil then
        Context.Response.StatusCode := 401
      else
        Next(Context);
    end

  ));
  SparkleServer.AddModule(Module);

  // Filter list according to authenticated user
  Module.Events.OnEntityList.Subscribe(
    procedure(Args: TEntityListArgs)
    var
      User: IUserIdentity;
      IsAdmin: Boolean;
    begin
      User := Args.Handler.Request.User;
      IsAdmin := (User <> nil) and User.Claims.Exists('admin') and User.Claims['admin'].AsBoolean;

      // Non-admin cannot see Nirvana
      if not IsAdmin and SameText(Args.Criteria.Clazz.ClassName, 'TArtist') then
        Args.Criteria.Add(not Linq['Name'].Contains('Nirvana'));
    end
  );

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
