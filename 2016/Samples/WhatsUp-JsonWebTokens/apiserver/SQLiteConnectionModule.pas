unit SQLiteConnectionModule;

interface

uses
  Aurelius.Drivers.Interfaces,
  Aurelius.SQL.SQLite,
  Aurelius.Schema.SQLite,
  Aurelius.Drivers.SQLite,
  System.SysUtils, System.Classes;

type
  TSQLiteConnection = class(TDataModule)
  private
  public
    class function CreateConnection: IDBConnection;
    class function CreateFactory: IDBConnectionFactory;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses 
  Aurelius.Drivers.Base;

{$R *.dfm}

{ TMyConnectionModule }

class function TSQLiteConnection.CreateConnection: IDBConnection;
begin 
  Result := TSQLiteNativeConnectionAdapter.Create(ParamStr(0) + '.db');
//  Result := TSQLiteNativeConnectionAdapter.Create(':memory:');
  (Result as TSQLiteNativeConnectionAdapter).EnableForeignKeys;
end;

class function TSQLiteConnection.CreateFactory: IDBConnectionFactory;
begin
  Result := TDBConnectionFactory.Create(
    function: IDBConnection
    begin
      Result := CreateConnection;
    end
  );
end;



end.
