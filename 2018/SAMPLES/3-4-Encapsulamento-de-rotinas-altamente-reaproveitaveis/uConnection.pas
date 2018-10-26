unit uConnection;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.DB;

type
  TDBConnection = class
  strict private
    class var FDBConnection: TDBConnection;
    constructor CreatePrivate;
  private
    FDConnection: TFDConnection;
    FDQuery: TFDQuery;
  public
    constructor Create;
    class function GetInstance: TDBConnection;
    procedure ExecuteCommand(SQL: String);
    function ExecuteSelect(SQL: String): TDataSet; //interface ou TDataSet
  end;

implementation

uses
  System.SysUtils;

{ TDBConnection }

constructor TDBConnection.Create;
begin
  raise Exception.Create('Para obter uma instância de TDBConnection, use TDBConnection.GetInstace');
end;

constructor TDBConnection.CreatePrivate;
begin
  FDConnection := TFDConnection.Create(nil);
  FDConnection.ConnectionDefName := 'FBRest';

  FDQuery := TFDQuery.Create(nil);
  FDQuery.Connection := FDConnection;
end;

procedure TDBConnection.ExecuteCommand(SQL: String);
begin
  FDQuery.SQL.Clear;
  FDQuery.SQL.Add(sql);
  FDQuery.ExecSQL;
end;

function TDBConnection.ExecuteSelect(SQL: String): TDataSet;
begin
  FDQuery.SQL.Clear;
  FDQuery.Open(SQL);
  Result := FDQuery;
end;

class function TDBConnection.GetInstance: TDBConnection;
begin
  if not assigned(FDBConnection) then
    FDBConnection := TDBConnection.CreatePrivate;
  Result := FDBConnection;
end;

end.
