//
// Created by the DataSnap proxy generator.
// 21/10/2012 19:03:26
//

unit UMetodos;

interface

uses Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethodsFiltroClient = class(TDSAdminClient)
  private
    FHoraServidorCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function HoraServidor: string;
  end;

implementation

function TServerMethodsFiltroClient.HoraServidor: string;
begin
  if FHoraServidorCommand = nil then
  begin
    FHoraServidorCommand := FDBXConnection.CreateCommand;
    FHoraServidorCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FHoraServidorCommand.Text := 'TServerMethodsFiltro.HoraServidor';
    FHoraServidorCommand.Prepare;
  end;
  FHoraServidorCommand.ExecuteUpdate;
  Result := FHoraServidorCommand.Parameters[0].Value.GetWideString;
end;


constructor TServerMethodsFiltroClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TServerMethodsFiltroClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TServerMethodsFiltroClient.Destroy;
begin
  FreeAndNil(FHoraServidorCommand);
  inherited;
end;

end.

