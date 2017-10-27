//
// Created by the DataSnap proxy generator.
// 9/28/2017 5:59:00 PM
//

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FDoUserLoginCommand: TDSRestCommand;
    FGetSFCasesCommand: TDSRestCommand;
    FGetSFCasesCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function DoUserLogin(fUserName: string; fPassword: string; const ARequestFilter: string = ''): Boolean;
    function GetSFCases(fUserName: string; fPassword: string; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetSFCases_Cache(fUserName: string; fPassword: string; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TServerMethods1_DoUserLogin: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'fUserName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'fPassword'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods1_GetSFCases: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'fUserName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'fPassword'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods1_GetSFCases_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'fUserName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'fPassword'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

implementation

function TServerMethods1Client.DoUserLogin(fUserName: string; fPassword: string; const ARequestFilter: string): Boolean;
begin
  if FDoUserLoginCommand = nil then
  begin
    FDoUserLoginCommand := FConnection.CreateCommand;
    FDoUserLoginCommand.RequestType := 'GET';
    FDoUserLoginCommand.Text := 'TServerMethods1.DoUserLogin';
    FDoUserLoginCommand.Prepare(TServerMethods1_DoUserLogin);
  end;
  FDoUserLoginCommand.Parameters[0].Value.SetWideString(fUserName);
  FDoUserLoginCommand.Parameters[1].Value.SetWideString(fPassword);
  FDoUserLoginCommand.Execute(ARequestFilter);
  Result := FDoUserLoginCommand.Parameters[2].Value.GetBoolean;
end;

function TServerMethods1Client.GetSFCases(fUserName: string; fPassword: string; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetSFCasesCommand = nil then
  begin
    FGetSFCasesCommand := FConnection.CreateCommand;
    FGetSFCasesCommand.RequestType := 'GET';
    FGetSFCasesCommand.Text := 'TServerMethods1.GetSFCases';
    FGetSFCasesCommand.Prepare(TServerMethods1_GetSFCases);
  end;
  FGetSFCasesCommand.Parameters[0].Value.SetWideString(fUserName);
  FGetSFCasesCommand.Parameters[1].Value.SetWideString(fPassword);
  FGetSFCasesCommand.Execute(ARequestFilter);
  if not FGetSFCasesCommand.Parameters[2].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetSFCasesCommand.Parameters[2].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetSFCasesCommand.Parameters[2].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetSFCasesCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods1Client.GetSFCases_Cache(fUserName: string; fPassword: string; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetSFCasesCommand_Cache = nil then
  begin
    FGetSFCasesCommand_Cache := FConnection.CreateCommand;
    FGetSFCasesCommand_Cache.RequestType := 'GET';
    FGetSFCasesCommand_Cache.Text := 'TServerMethods1.GetSFCases';
    FGetSFCasesCommand_Cache.Prepare(TServerMethods1_GetSFCases_Cache);
  end;
  FGetSFCasesCommand_Cache.Parameters[0].Value.SetWideString(fUserName);
  FGetSFCasesCommand_Cache.Parameters[1].Value.SetWideString(fPassword);
  FGetSFCasesCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetSFCasesCommand_Cache.Parameters[2].Value.GetString);
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
  FDoUserLoginCommand.DisposeOf;
  FGetSFCasesCommand.DisposeOf;
  FGetSFCasesCommand_Cache.DisposeOf;
  inherited;
end;

end.

