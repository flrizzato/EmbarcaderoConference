//
// Created by the DataSnap proxy generator.
// 02/09/2016 15:21:16
//

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FDownloadFileCommand: TDSRestCommand;
    FDownloadFileCommand_Cache: TDSRestCommand;
    FGerarPDFCommand: TDSRestCommand;
    FGerarPDFCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function DownloadFile(AArquivo: string; out Size: Int64; const ARequestFilter: string = ''): TStream;
    function DownloadFile_Cache(AArquivo: string; out Size: Int64; const ARequestFilter: string = ''): IDSRestCachedStream;
    function GerarPDF(out Size: Int64; const ARequestFilter: string = ''): TStream;
    function GerarPDF_Cache(out Size: Int64; const ARequestFilter: string = ''): IDSRestCachedStream;
  end;

const
  TServerMethods1_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_DownloadFile: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'AArquivo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Size'; Direction: 2; DBXType: 18; TypeName: 'Int64'),
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TServerMethods1_DownloadFile_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'AArquivo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Size'; Direction: 2; DBXType: 18; TypeName: 'Int64'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_GerarPDF: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Size'; Direction: 2; DBXType: 18; TypeName: 'Int64'),
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TServerMethods1_GerarPDF_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Size'; Direction: 2; DBXType: 18; TypeName: 'Int64'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

implementation

function TServerMethods1Client.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare(TServerMethods1_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare(TServerMethods1_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.DownloadFile(AArquivo: string; out Size: Int64; const ARequestFilter: string): TStream;
begin
  if FDownloadFileCommand = nil then
  begin
    FDownloadFileCommand := FConnection.CreateCommand;
    FDownloadFileCommand.RequestType := 'GET';
    FDownloadFileCommand.Text := 'TServerMethods1.DownloadFile';
    FDownloadFileCommand.Prepare(TServerMethods1_DownloadFile);
  end;
  FDownloadFileCommand.Parameters[0].Value.SetWideString(AArquivo);
  FDownloadFileCommand.Execute(ARequestFilter);
  Size := FDownloadFileCommand.Parameters[1].Value.GetInt64;
  Result := FDownloadFileCommand.Parameters[2].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.DownloadFile_Cache(AArquivo: string; out Size: Int64; const ARequestFilter: string): IDSRestCachedStream;
begin
  if FDownloadFileCommand_Cache = nil then
  begin
    FDownloadFileCommand_Cache := FConnection.CreateCommand;
    FDownloadFileCommand_Cache.RequestType := 'GET';
    FDownloadFileCommand_Cache.Text := 'TServerMethods1.DownloadFile';
    FDownloadFileCommand_Cache.Prepare(TServerMethods1_DownloadFile_Cache);
  end;
  FDownloadFileCommand_Cache.Parameters[0].Value.SetWideString(AArquivo);
  FDownloadFileCommand_Cache.ExecuteCache(ARequestFilter);
  Size := FDownloadFileCommand_Cache.Parameters[1].Value.GetInt64;
  Result := TDSRestCachedStream.Create(FDownloadFileCommand_Cache.Parameters[2].Value.GetString);
end;

function TServerMethods1Client.GerarPDF(out Size: Int64; const ARequestFilter: string): TStream;
begin
  if FGerarPDFCommand = nil then
  begin
    FGerarPDFCommand := FConnection.CreateCommand;
    FGerarPDFCommand.RequestType := 'GET';
    FGerarPDFCommand.Text := 'TServerMethods1.GerarPDF';
    FGerarPDFCommand.Prepare(TServerMethods1_GerarPDF);
  end;
  FGerarPDFCommand.Execute(ARequestFilter);
  Size := FGerarPDFCommand.Parameters[0].Value.GetInt64;
  Result := FGerarPDFCommand.Parameters[1].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.GerarPDF_Cache(out Size: Int64; const ARequestFilter: string): IDSRestCachedStream;
begin
  if FGerarPDFCommand_Cache = nil then
  begin
    FGerarPDFCommand_Cache := FConnection.CreateCommand;
    FGerarPDFCommand_Cache.RequestType := 'GET';
    FGerarPDFCommand_Cache.Text := 'TServerMethods1.GerarPDF';
    FGerarPDFCommand_Cache.Prepare(TServerMethods1_GerarPDF_Cache);
  end;
  FGerarPDFCommand_Cache.ExecuteCache(ARequestFilter);
  Size := FGerarPDFCommand_Cache.Parameters[0].Value.GetInt64;
  Result := TDSRestCachedStream.Create(FGerarPDFCommand_Cache.Parameters[1].Value.GetString);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FDownloadFileCommand.DisposeOf;
  FDownloadFileCommand_Cache.DisposeOf;
  FGerarPDFCommand.DisposeOf;
  FGerarPDFCommand_Cache.DisposeOf;
  inherited;
end;

end.

