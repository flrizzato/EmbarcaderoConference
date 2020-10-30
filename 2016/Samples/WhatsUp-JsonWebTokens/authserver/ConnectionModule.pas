unit ConnectionModule;

interface

uses
  Aurelius.Drivers.Interfaces,
  Aurelius.SQL.SQLite,
  Aurelius.Schema.SQLite,
  Aurelius.Drivers.SQLite,
  System.SysUtils, System.Classes;

type
  TSQLiteSQLiteConnection = class(TDataModule)
  private
  public
    class function CreateConnection: IDBConnection;
    class function CreateFactory: IDBConnectionFactory;
     
    class function CreatePool(APoolSize: Integer): IDBConnectionPool;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses  
  XData.Aurelius.ConnectionPool,
  Aurelius.Drivers.Base;

{$R *.dfm}

{ TMyConnectionModule }

class function TSQLiteSQLiteConnection.CreateConnection: IDBConnection;
begin 
  Result := TSQLiteNativeConnectionAdapter.Create(':memory:');
end;

class function TSQLiteSQLiteConnection.CreateFactory: IDBConnectionFactory;
begin
  Result := TDBConnectionFactory.Create(
    function: IDBConnection
    begin
      Result := CreateConnection;
    end
  );
end;

class function TSQLiteSQLiteConnection.CreatePool(APoolSize: Integer): IDBConnectionPool;
var
  Factory: IDBConnectionFactory;
begin
  Factory := CreateFactory;
  Result := TDBConnectionPool.Create(APoolSize, Factory);
end;

end.
