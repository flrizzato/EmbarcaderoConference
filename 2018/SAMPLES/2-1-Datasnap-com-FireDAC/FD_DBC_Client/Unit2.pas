//
// Created by the DataSnap proxy generator.
// 20/10/2018 16:45:41
// 

unit Unit2;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminClient)
  private
    FDataSetProvider1GetTableNameCommand: TDBXCommand;
    FEchoStringCommand: TDBXCommand;
    FReverseStringCommand: TDBXCommand;
    FGetClientesCommand: TDBXCommand;
    FGetClientesJSONCommand: TDBXCommand;
    FGravarCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DataSetProvider1GetTableName(Sender: TObject; DataSet: TDataSet; var TableName: string);
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetClientes: string;
    function GetClientesJSON: TJSONArray;
    procedure Gravar(Value: string);
  end;

implementation

procedure TServerMethods1Client.DataSetProvider1GetTableName(Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
  if FDataSetProvider1GetTableNameCommand = nil then
  begin
    FDataSetProvider1GetTableNameCommand := FDBXConnection.CreateCommand;
    FDataSetProvider1GetTableNameCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDataSetProvider1GetTableNameCommand.Text := 'TServerMethods1.DataSetProvider1GetTableName';
    FDataSetProvider1GetTableNameCommand.Prepare;
  end;
  if not Assigned(Sender) then
    FDataSetProvider1GetTableNameCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDataSetProvider1GetTableNameCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataSetProvider1GetTableNameCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FDataSetProvider1GetTableNameCommand.Parameters[1].Value.SetDBXReader(TDBXDataSetReader.Create(DataSet, FInstanceOwner), True);
  FDataSetProvider1GetTableNameCommand.Parameters[2].Value.SetWideString(TableName);
  FDataSetProvider1GetTableNameCommand.ExecuteUpdate;
  TableName := FDataSetProvider1GetTableNameCommand.Parameters[2].Value.GetWideString;
end;

function TServerMethods1Client.EchoString(Value: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FDBXConnection.CreateCommand;
    FEchoStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare;
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.ExecuteUpdate;
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FDBXConnection.CreateCommand;
    FReverseStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare;
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.ExecuteUpdate;
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.GetClientes: string;
begin
  if FGetClientesCommand = nil then
  begin
    FGetClientesCommand := FDBXConnection.CreateCommand;
    FGetClientesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetClientesCommand.Text := 'TServerMethods1.GetClientes';
    FGetClientesCommand.Prepare;
  end;
  FGetClientesCommand.ExecuteUpdate;
  Result := FGetClientesCommand.Parameters[0].Value.GetWideString;
end;

function TServerMethods1Client.GetClientesJSON: TJSONArray;
begin
  if FGetClientesJSONCommand = nil then
  begin
    FGetClientesJSONCommand := FDBXConnection.CreateCommand;
    FGetClientesJSONCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetClientesJSONCommand.Text := 'TServerMethods1.GetClientesJSON';
    FGetClientesJSONCommand.Prepare;
  end;
  FGetClientesJSONCommand.ExecuteUpdate;
  Result := TJSONArray(FGetClientesJSONCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

procedure TServerMethods1Client.Gravar(Value: string);
begin
  if FGravarCommand = nil then
  begin
    FGravarCommand := FDBXConnection.CreateCommand;
    FGravarCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGravarCommand.Text := 'TServerMethods1.Gravar';
    FGravarCommand.Prepare;
  end;
  FGravarCommand.Parameters[0].Value.SetWideString(Value);
  FGravarCommand.ExecuteUpdate;
end;

constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FDataSetProvider1GetTableNameCommand.DisposeOf;
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FGetClientesCommand.DisposeOf;
  FGetClientesJSONCommand.DisposeOf;
  FGravarCommand.DisposeOf;
  inherited;
end;

end.
