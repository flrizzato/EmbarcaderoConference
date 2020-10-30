//
// Created by the DataSnap proxy generator.
// 12/10/2015 16:16:09
//

unit uMetodosClient;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethodsClient = class(TDSAdminClient)
  private
    FEchoStringCommand: TDBXCommand;
    FReverseStringCommand: TDBXCommand;
    FGerarRelatorioCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GerarRelatorio(AArquivoBase: TFileStream; AXMLData: TMemoryStream; out AArquivoSaida: TStream): Boolean;
  end;

implementation

function TServerMethodsClient.EchoString(Value: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FDBXConnection.CreateCommand;
    FEchoStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FEchoStringCommand.Text := 'TServerMethods.EchoString';
    FEchoStringCommand.Prepare;
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.ExecuteUpdate;
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethodsClient.ReverseString(Value: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FDBXConnection.CreateCommand;
    FReverseStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FReverseStringCommand.Text := 'TServerMethods.ReverseString';
    FReverseStringCommand.Prepare;
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.ExecuteUpdate;
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethodsClient.GerarRelatorio(AArquivoBase: TFileStream; AXMLData: TMemoryStream; out AArquivoSaida: TStream): Boolean;
begin
  if FGerarRelatorioCommand = nil then
  begin
    FGerarRelatorioCommand := FDBXConnection.CreateCommand;
    FGerarRelatorioCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGerarRelatorioCommand.Text := 'TServerMethods.GerarRelatorio';
    FGerarRelatorioCommand.Prepare;
  end;
  FGerarRelatorioCommand.Parameters[0].Value.SetStream(AArquivoBase, FInstanceOwner);
  FGerarRelatorioCommand.Parameters[1].Value.SetStream(AXMLData, FInstanceOwner);
  FGerarRelatorioCommand.ExecuteUpdate;
  AArquivoSaida := FGerarRelatorioCommand.Parameters[2].Value.GetStream(FInstanceOwner);
  Result := FGerarRelatorioCommand.Parameters[3].Value.GetBoolean;
end;


constructor TServerMethodsClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TServerMethodsClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TServerMethodsClient.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FGerarRelatorioCommand.DisposeOf;
  inherited;
end;

end.

