//
// Created by the DataSnap proxy generator.
// 12/10/2015 19:07:47
//

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FGetImageCommand: TDSRestCommand;
    FGetImageCommand_Cache: TDSRestCommand;
    FGetImagesCommand: TDSRestCommand;
    FGetImagesCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function GetImage(const ARequestFilter: string = ''): TStream;
    function GetImage_Cache(const ARequestFilter: string = ''): IDSRestCachedStream;
    function GetImages(out Img2: TStream; const ARequestFilter: string = ''): TStream;
    function GetImages_Cache(out Img2: IDSRestCachedStream; const ARequestFilter: string = ''): IDSRestCachedStream;
  end;

  TsmCachedDataClient = class(TDSAdminRestClient)
  private
    FCountriesCommand: TDSRestCommand;
    FCountriesCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function Countries(const ARequestFilter: string = ''): TDataSet;
    function Countries_Cache(const ARequestFilter: string = ''): IDSRestCachedDataSet;
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

  TServerMethods1_GetImage: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TServerMethods1_GetImage_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_GetImages: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Img2'; Direction: 2; DBXType: 33; TypeName: 'TStream'),
    (Name: ''; Direction: 4; DBXType: 33; TypeName: 'TStream')
  );

  TServerMethods1_GetImages_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Img2'; Direction: 2; DBXType: 26; TypeName: 'String'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TsmCachedData_Countries: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 23; TypeName: 'TDataSet')
  );

  TsmCachedData_Countries_Cache: array [0..0] of TDSRestParameterMetaData =
  (
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

function TServerMethods1Client.GetImage(const ARequestFilter: string): TStream;
begin
  if FGetImageCommand = nil then
  begin
    FGetImageCommand := FConnection.CreateCommand;
    FGetImageCommand.RequestType := 'GET';
    FGetImageCommand.Text := 'TServerMethods1.GetImage';
    FGetImageCommand.Prepare(TServerMethods1_GetImage);
  end;
  FGetImageCommand.Execute(ARequestFilter);
  Result := FGetImageCommand.Parameters[0].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.GetImage_Cache(const ARequestFilter: string): IDSRestCachedStream;
begin
  if FGetImageCommand_Cache = nil then
  begin
    FGetImageCommand_Cache := FConnection.CreateCommand;
    FGetImageCommand_Cache.RequestType := 'GET';
    FGetImageCommand_Cache.Text := 'TServerMethods1.GetImage';
    FGetImageCommand_Cache.Prepare(TServerMethods1_GetImage_Cache);
  end;
  FGetImageCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedStream.Create(FGetImageCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethods1Client.GetImages(out Img2: TStream; const ARequestFilter: string): TStream;
begin
  if FGetImagesCommand = nil then
  begin
    FGetImagesCommand := FConnection.CreateCommand;
    FGetImagesCommand.RequestType := 'GET';
    FGetImagesCommand.Text := 'TServerMethods1.GetImages';
    FGetImagesCommand.Prepare(TServerMethods1_GetImages);
  end;
  FGetImagesCommand.Execute(ARequestFilter);
  Img2 := FGetImagesCommand.Parameters[0].Value.GetStream(FInstanceOwner);
  Result := FGetImagesCommand.Parameters[1].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.GetImages_Cache(out Img2: IDSRestCachedStream; const ARequestFilter: string): IDSRestCachedStream;
begin
  if FGetImagesCommand_Cache = nil then
  begin
    FGetImagesCommand_Cache := FConnection.CreateCommand;
    FGetImagesCommand_Cache.RequestType := 'GET';
    FGetImagesCommand_Cache.Text := 'TServerMethods1.GetImages';
    FGetImagesCommand_Cache.Prepare(TServerMethods1_GetImages_Cache);
  end;
  FGetImagesCommand_Cache.ExecuteCache(ARequestFilter);
  Img2 := TDSRestCachedStream.Create(FGetImagesCommand_Cache.Parameters[0].Value.GetString);
  Result := TDSRestCachedStream.Create(FGetImagesCommand_Cache.Parameters[1].Value.GetString);
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
  FGetImageCommand.DisposeOf;
  FGetImageCommand_Cache.DisposeOf;
  FGetImagesCommand.DisposeOf;
  FGetImagesCommand_Cache.DisposeOf;
  inherited;
end;

function TsmCachedDataClient.Countries(const ARequestFilter: string): TDataSet;
begin
  if FCountriesCommand = nil then
  begin
    FCountriesCommand := FConnection.CreateCommand;
    FCountriesCommand.RequestType := 'GET';
    FCountriesCommand.Text := 'TsmCachedData.Countries';
    FCountriesCommand.Prepare(TsmCachedData_Countries);
  end;
  FCountriesCommand.Execute(ARequestFilter);
  Result := TCustomSQLDataSet.Create(nil, FCountriesCommand.Parameters[0].Value.GetDBXReader(False), True);
  Result.Open;
  if FInstanceOwner then
    FCountriesCommand.FreeOnExecute(Result);
end;

function TsmCachedDataClient.Countries_Cache(const ARequestFilter: string): IDSRestCachedDataSet;
begin
  if FCountriesCommand_Cache = nil then
  begin
    FCountriesCommand_Cache := FConnection.CreateCommand;
    FCountriesCommand_Cache.RequestType := 'GET';
    FCountriesCommand_Cache.Text := 'TsmCachedData.Countries';
    FCountriesCommand_Cache.Prepare(TsmCachedData_Countries_Cache);
  end;
  FCountriesCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedDataSet.Create(FCountriesCommand_Cache.Parameters[0].Value.GetString);
end;

constructor TsmCachedDataClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TsmCachedDataClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TsmCachedDataClient.Destroy;
begin
  FCountriesCommand.DisposeOf;
  FCountriesCommand_Cache.DisposeOf;
  inherited;
end;

end.

