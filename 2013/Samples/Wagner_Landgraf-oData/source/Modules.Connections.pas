unit Modules.Connections;

interface

uses
  System.SysUtils, System.Classes,
  Aurelius.Drivers.Interfaces,
  Aurelius.Drivers.DBExpress,
  Aurelius.Drivers.SQLite,
  Aurelius.Schema.Firebird,
  Aurelius.Schema.SQLite,
  Aurelius.SQL.Firebird,
  Aurelius.SQL.SQLite;

type
  TConnections = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    FSQLiteConnection: IDBConnection;
    FFirebirdConnection: IDBConnection;
    FRemoteDBConnection: IDBConnection;
    FDefaultConnection: IDBConnection;
  protected
  public
    procedure UpdateDatabase;
    property DefaultConnection: IDBConnection read FDefaultConnection write FDefaultConnection;
    property SQLiteConnection: IDBConnection read FSQLiteConnection;
    property FirebirdConnection: IDBConnection read FFirebirdConnection;
    property RemoteDBConnection: IDBConnection read FRemoteDBConnection;
  end;

var
  Connections: TConnections;

implementation

uses
  IOUtils,
  Modules.FirebirdConnection,
  Aurelius.Drivers.RemoteDB,
  Aurelius.Engine.DatabaseManager,
  XData.XDataset.RemoteDB;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TConnections.DataModuleCreate(Sender: TObject);
var
  RemoteDB: TRemoteDBDatabase;
begin
  // Create SQLite connection
  FSQLiteConnection := TSQLiteNativeConnectionAdapter.Create(
    TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'conf2013.sqlite'));

  // Create Firebird Connection
  FFirebirdConnection := TDBExpressConnectionAdapter.Create(FirebirdConnectionModule.SQLConnection1, false);

  // Create RemoteDB Connection
  RemoteDB := TRemoteDBDatabase.Create(nil);
  RemoteDB.ServerUri := 'http://localhost:2001/tms/db/';
  FRemoteDBConnection := TRemoteDBConnectionAdapter.Create(RemoteDB, true);

  // Set default connection to SQLite
  FDefaultConnection := FSQLiteConnection;
end;

procedure TConnections.UpdateDatabase;
var
  DBManager: TDatabaseManager;
begin
  DBManager := TDatabaseManager.Create(DefaultConnection);
  try
    DBManager.UpdateDatabase;
  finally
    DBManager.Free;
  end;
end;

end.
