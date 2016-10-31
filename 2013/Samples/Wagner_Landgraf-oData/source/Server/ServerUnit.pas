unit ServerUnit;

interface

uses
  Aurelius.Drivers.Interfaces,
  XData.Http.Server,
  System.SysUtils, System.Classes;

type
  TServerModule = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    function CreateConnectionFactory: IDBConnectionFactory;
  public
    HttpServer: THttpServer;
  end;

implementation

uses
  Modules.FirebirdConnection,
  Aurelius.Drivers.Base,
  Aurelius.Drivers.DBExpress,
  Aurelius.Sql.Firebird,
  Aurelius.Sql.SQLite,
  XData.Aurelius.ConnectionPool,
  XData.Aurelius.EntityServer,
  XData.RemoteDB.Server,
  XData.Http.Url;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

function TServerModule.CreateConnectionFactory: IDBConnectionFactory;
begin
  Result := TDBConnectionFactory.Create(
    function: IDBConnection
    var
      Module: TFirebirdConnectionModule;
    begin
      Module := TFirebirdConnectionModule.Create(nil);
      Result := TDBExpressConnectionAdapter.Create(Module.SQLConnection1, Module);
    end
  );
end;

procedure TServerModule.DataModuleCreate(Sender: TObject);
var
  RemoteDBServer: TRemoteDBServer;
  EntityServer: TAureliusHttpHandler;
  ConnectionFactory: IDBConnectionFactory;
begin
  HttpServer := THttpServer.Create;

  ConnectionFactory := CreateConnectionFactory;

  RemoteDBServer := TRemoteDBServer.Create(
    TUrl.Create('http://localhost:2001/tms/db'),
    ConnectionFactory
  );
  HttpServer.RegisterHandler(RemoteDBServer);

  EntityServer := TAureliusHttpHandler.Create(
    TUrl.Create('http://localhost:2001/tms/entities'),
    TDBConnectionPool.Create(10, ConnectionFactory)
  );
  EntityServer.AccessControlAllowOrigin := '*'; // to allow access from JavaScript
  HttpServer.RegisterHandler(EntityServer);
end;

procedure TServerModule.DataModuleDestroy(Sender: TObject);
begin
  HttpServer.Free;
end;

end.
