//
// Created by the DataSnap proxy generator.
// 12/10/2015 13:16:18
//

unit uProxy;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminClient)
  private
    FEchoStringCommand: TDBXCommand;
    FReverseStringCommand: TDBXCommand;
    FGenerateReportCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GenerateReport(aStart: Integer; anEnd: Integer; aCallback: TDBXCallback; var FSize: Integer): TStream;
  end;

implementation

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

function TServerMethods1Client.GenerateReport(aStart: Integer; anEnd: Integer; aCallback: TDBXCallback; var FSize: Integer): TStream;
begin
  if FGenerateReportCommand = nil then
  begin
    FGenerateReportCommand := FDBXConnection.CreateCommand;
    FGenerateReportCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGenerateReportCommand.Text := 'TServerMethods1.GenerateReport';
    FGenerateReportCommand.Prepare;
  end;
  FGenerateReportCommand.Parameters[0].Value.SetInt32(aStart);
  FGenerateReportCommand.Parameters[1].Value.SetInt32(anEnd);
  FGenerateReportCommand.Parameters[2].Value.SetCallbackValue(aCallback);
  FGenerateReportCommand.Parameters[3].Value.SetInt32(FSize);
  FGenerateReportCommand.ExecuteUpdate;
  FSize := FGenerateReportCommand.Parameters[3].Value.GetInt32;
  Result := FGenerateReportCommand.Parameters[4].Value.GetStream(FInstanceOwner);
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
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FGenerateReportCommand.DisposeOf;
  inherited;
end;

end.

