{ ------------------------------------------------------------
SimpleRestRequest - A Simple, fluent interfaced REST client for
Delphi XE and up.

https://github.com/jamiei/SimpleRestClient

Licensed under the BSD-3 Open source license.
--------------------------------------------------------------}
///	<summary>
///	  Contains TRestRequest - The simple, fluent wrapper around Indy's TIdHttp
///	  to make writing RESTful clients easy.
///	</summary>
unit RestRequest;

interface

uses
  SysUtils,
  Classes,

  IdHttp,
  IdAuthentication,
  IdMultipartFormData,
  IdURI,
  IdSSL,
  IdSSLOpenSSL;


  type
    TBeforeRequest = procedure(Sender: TObject; var AHttpClient: TIdHttp) of Object;

    THttpResponse = record

      ///	<summary>
      ///	  The Http Response code returned
      ///	</summary>
      ResponseCode: integer;

      ///	<summary>
      ///	  The Body returned or an exception message.
      ///	</summary>
      ResponseStr: string;
    end;

    TRestRequest = class(TObject)
      private
        FScheme: string;
        FDomain: string;
        FPaths: TStringList;
        FParams: TStringList;
        FFileParams: TStringList;
        FHeaders: TStringList;
        FUsername: string;
        FPassword: string;
        FResponse: THttpResponse;
        FAccept: string;
        FContentType: string;
        FBeforeRequest: TBeforeRequest;
        FSslHandler: TIdSSLIOHandlerSocketOpenSSL;

        procedure doBeforeRequest(AHttpInst: TIdHttp);
        function getHttpClientInstance: TIdHttp;
        function getURLAsStr: string;
        function urlEncode(str: string): string;
        function doPost(aParams: TIdMultiPartFormDataStream): THttpResponse; overload;
        function doPost(aParams: TStringStream): THttpResponse; overload;
        function multipartRequired(aParams, aFileParams: TStringList): boolean;
        function createMultiPartFormDataStreamFromStringList(strings: TStringList; aFileParams: TStringList): TIdMultiPartFormDataStream;
        function createStringStreamFromStringList(strings: TStringList): TStringStream;
        procedure httpAuthorisation(Sender: TObject; Authentication: TIdAuthentication; var Handled: Boolean);
        function createSSLHandlerIfRequired(scheme: string; var httpClient: TIdHttp): boolean;

        function getAccept: string;
        procedure setAccept(const Value: string);
        function getContentType: string;
        procedure setContentType(const Value: string);
        function GetBeforeRequest: TBeforeRequest;
        procedure SetBeforeRequest(const Value: TBeforeRequest);
      public
        constructor Create(aIsSSL: boolean); overload;
        constructor Create; overload;
        destructor Destroy; override;
        function Scheme(aScheme: string): TRestRequest;
        function Domain(aDomain: string): TRestRequest;
        function Path(aPath: string): TRestRequest;
        function Param(aKey: string; aValue: string): TRestRequest;
        function FileParam(aKey: string; aValue: string): TRestRequest;
        function WithHeader(aName: string; aValue: string): TRestRequest;
        function WithCredentials(username, password: string): TRestRequest;

        property Response: THttpResponse read FResponse;
        property FullUrl: string read getURLAsStr;
        property Accept: string read getAccept write setAccept;
        property ContentType: string read getContentType write setContentType;
        property BeforeRequest: TBeforeRequest read GetBeforeRequest write SetBeforeRequest;

        function Get: THttpResponse;
        function Put(aParams: TStringList): THttpResponse;
        function Post(aParams: TStringList): THttpResponse;
        function Delete: THttpResponse;
        function Options: THttpResponse;
    end;

implementation

{ TRestRequest }

constructor TRestRequest.Create(aIsSSL: boolean);
const
  DEFAULT_ACCEPT = 'application/json, application/xml';
  DEFAULT_SCHEME = 'http';
begin
  inherited Create;
  Self.FPaths := TStringList.Create;
  Self.FParams := TStringList.Create;
  Self.FFileParams := TStringList.Create;
  Self.FHeaders := TStringList.Create;
  Self.FAccept := DEFAULT_ACCEPT;
  Self.FScheme := DEFAULT_SCHEME;
end;

constructor TRestRequest.Create;
begin
  Create(false);
end;

function TRestRequest.createMultiPartFormDataStreamFromStringList(strings: TStringList; aFileParams: TStringList): TIdMultiPartFormDataStream;
var
  i: integer;
  key, value: string;
begin
  Result := TIdMultiPartFormDataStream.Create;
  for i := 0 to strings.Count - 1 do
  begin
    key := strings.Names[i];
    value := strings.ValueFromIndex[i];
    Result.AddFormField(key, value);
  end;
  for i := 0 to aFileParams.Count - 1 do
  begin
    key := aFileParams.Names[i];
    value := aFileParams.ValueFromIndex[i];
    Result.AddFile(key, value);
  end;
end;

function TRestRequest.createSSLHandlerIfRequired(scheme: string; var httpClient: TIdHttp): boolean;
begin
  if scheme = 'https' then Self.FSslHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  if Assigned(Self.FSslHandler) then httpClient.IOHandler := FSslHandler;
end;

function TRestRequest.createStringStreamFromStringList(
  strings: TStringList): TStringStream;
var
  i: Integer;
  key, value: string;
  strParam: string;
begin
  Result := TStringStream.Create('');
  for i := 0 to strings.Count - 1 do
  begin
    key := strings.Names[i];
    value := strings.ValueFromIndex[i];
    strParam := urlEncode(key) + '=' + urlEncode(value);
    if not (i = strings.Count - 1) then strParam := strParam + '&';
    Result.WriteString(strParam);
  end;
end;

function TRestRequest.Delete: THttpResponse;
var
  httpClient: TIdHttp;
begin
  httpClient := getHttpClientInstance;
  try
    httpClient.OnAuthorization := Self.httpAuthorisation;
    try
      httpClient.Delete(getURLAsStr);
      Result.ResponseCode := httpClient.ResponseCode;
      Result.ResponseStr := httpClient.ResponseText;
    except
      on E: EIdHTTPProtocolException do
      begin
        Result.ResponseCode := httpClient.ResponseCode;
        Result.ResponseStr := E.Message;
      end;
    end;
  finally
    httpClient.Free;
  end;
end;

destructor TRestRequest.Destroy;
begin
  Self.FPaths.Free;
  Self.FParams.Free;
  Self.FFileParams.Free;
  Self.FHeaders.Free;
  if Assigned(FSslHandler) then FSslHandler.Free;

  inherited;
end;

procedure TRestRequest.doBeforeRequest(AHttpInst: TIdHttp);
begin
  if Assigned(FBeforeRequest) then FBeforeRequest(Self, AHttpInst);
end;

function TRestRequest.Domain(aDomain: string): TRestRequest;
begin
  Self.FDomain := Trim(aDomain);
  Result := Self;
end;

function TRestRequest.doPost(
  aParams: TIdMultiPartFormDataStream): THttpResponse;
var
  httpClient: TIdHttp;
  respStr: string;
begin
  httpClient := getHttpClientInstance;
  try
    httpClient.OnAuthorization := Self.httpAuthorisation;
    try
      httpClient.Request.ContentType := 'multipart/form-data';
      respStr := httpClient.Post(getURLAsStr, aParams);
      Result.ResponseCode := httpClient.ResponseCode;
      Result.ResponseStr := respStr;
    except
      on E: EIdHTTPProtocolException do
      begin
        Result.ResponseCode := httpClient.ResponseCode;
        Result.ResponseStr := '';
      end;
    end;
  finally
    httpClient.Free;
  end;
end;

function TRestRequest.doPost(aParams: TStringStream): THttpResponse;
var
  httpClient: TIdHttp;
  respStr: string;
begin
  httpClient := getHttpClientInstance;
  try
    httpClient.OnAuthorization := Self.httpAuthorisation;
    try
      httpClient.Request.ContentType := 'application/x-www-form-urlencoded';
      respStr := httpClient.Post(getURLAsStr, aParams);
      Result.ResponseCode := httpClient.ResponseCode;
      Result.ResponseStr := respStr;
    except
      on E: EIdHTTPProtocolException do
      begin
        Result.ResponseCode := httpClient.ResponseCode;
        Result.ResponseStr := '';
      end;
    end;
  finally
    httpClient.Free;
  end;
end;

function TRestRequest.FileParam(aKey, aValue: string): TRestRequest;
begin
  Self.FFileParams.Add(aKey + '=' + aValue);
  Result := Self;
end;

function TRestRequest.Get: THttpResponse;
var
  httpClient: TIdHttp;
  respStr: string;
begin
  httpClient := getHttpClientInstance;
  try
    httpClient.OnAuthorization := Self.httpAuthorisation;
    try
      respStr := httpClient.Get(getURLAsStr);
      Result.ResponseCode := httpClient.ResponseCode;
      Result.ResponseStr := respStr;
    except
      on E: EIdHTTPProtocolException do
      begin
        Result.ResponseCode := httpClient.ResponseCode;
        Result.ResponseStr := E.Message;
      end;
    end;
  finally
    httpClient.Free;
  end;
end;

function TRestRequest.getAccept: string;
begin
  Result := FAccept;
end;

function TRestRequest.GetBeforeRequest: TBeforeRequest;
begin
  Result := FBeforeRequest;
end;

function TRestRequest.getContentType: string;
begin
  Result := FContentType;
end;

function TRestRequest.getHttpClientInstance: TIdHttp;
begin
  Result := TIdHttp.Create(nil);
  Result.ConnectTimeout := 5000;
  Result.ReadTimeout := 5000;
  Result.OnAuthorization := httpAuthorisation;
  Result.MaxAuthRetries := 0;
  Result.HTTPOptions := [hoInProcessAuth];
  // Create an SSL Handler if we need to.
  createSSLHandlerIfRequired(Self.FScheme, Result);
  doBeforeRequest(Result);
  Result.Request.CustomHeaders.Clear;
  Result.Request.CustomHeaders.AddStrings(Self.FHeaders);
  Result.Request.BasicAuthentication := true;
  Result.Request.Username := Self.FUsername;
  Result.Request.Password := Self.FPassword;
  Result.Request.Accept := FAccept;
  Result.Request.ContentType := FContentType;
end;

function TRestRequest.getURLAsStr: string;
var
  aFullPath: string;
  aFullParams: string;
  i: integer;
begin
  for i := 0 to Self.FPaths.Count - 1 do
  begin
    aFullPath := aFullPath + '/' + Self.FPaths.Strings[i];
  end;
  if Self.FParams.Count > 0 then
  begin
    aFullParams := '?';
    for i := 0 to Self.FParams.Count - 1 do
    begin
      if i > 0 then aFullParams := aFullParams + '&';
      aFullParams := aFullParams + Self.FParams.Names[i] + '=' + Self.FParams.ValueFromIndex[i];
    end;
  end;
  Result := FScheme + '://' + FDomain + aFullPath + aFullParams;
end;

procedure TRestRequest.httpAuthorisation(Sender: TObject;
  Authentication: TIdAuthentication; var Handled: Boolean);
begin
  Authentication.Username := Self.FUsername;
  Authentication.Password := Self.FPassword;
  Handled := true;
end;

function TRestRequest.multipartRequired(aParams,
  aFileParams: TStringList): boolean;
begin
  Result := false;
  if aFileParams.Count > 0 then
  begin
    Result := true;
  end;
end;

function TRestRequest.Options: THttpResponse;
var
  httpClient: TIdHttp;
  respStr: string;
begin
  httpClient := getHttpClientInstance;
  try
    httpClient.OnAuthorization := Self.httpAuthorisation;
    try
      httpClient.Options(Self.FullUrl);
      Result.ResponseCode := httpClient.ResponseCode;
      Result.ResponseStr := httpClient.ResponseText;
    except
      on E: EIdHTTPProtocolException do
      begin
        Result.ResponseCode := httpClient.ResponseCode;
        Result.ResponseStr := E.Message;
      end;
    end;
  finally
    httpClient.Free;
  end;
end;

function TRestRequest.Param(aKey, aValue: string): TRestRequest;
begin
  Self.FParams.Add(aKey + '=' + aValue);
  Result := Self;
end;

function TRestRequest.Path(aPath: string): TRestRequest;
begin
  Self.FPaths.Append(aPath);
  Result := Self;
end;

function TRestRequest.Post(aParams: TStringList): THttpResponse;
var
  aParamStream: TStringStream;
  aParamMulti: TIdMultiPartFormDataStream;
begin
  if not Self.multipartRequired(aParams, FFileParams) then
  begin
    aParamStream := Self.createStringStreamFromStringList(aParams);
    try
      Result := doPost(aParamStream);
    finally
      aParamStream.Free;
    end;
  end
  else
  begin
    aParamMulti := Self.createMultiPartFormDataStreamFromStringList(aParams, FFileParams);
    try
      Result := doPost(aParamMulti);
    finally
      aParamMulti.Free;
    end;
  end;
end;

function TRestRequest.Put(aParams: TStringList): THttpResponse;
var
  httpClient: TIdHttp;
  params: TStringStream;
  respStr: string;
begin
  httpClient := getHttpClientInstance;
  try
    httpClient.OnAuthorization := Self.httpAuthorisation;
    try
      params := createStringStreamFromStringList(aParams);
      httpClient.Request.ContentType := 'application/x-www-form-urlencoded';
      try
        respStr := httpClient.Put(getURLAsStr, params);
      finally
        params.Free;
      end;
      Result.ResponseCode := httpClient.ResponseCode;
      Result.ResponseStr := respStr;
    except
      on E: EIdHTTPProtocolException do
      begin
        Result.ResponseCode := httpClient.ResponseCode;
        Result.ResponseStr := '';
      end;
    end;
  finally
    httpClient.Free;
  end;
end;

procedure TRestRequest.setAccept(const Value: string);
begin
  FAccept := value;
end;

procedure TRestRequest.SetBeforeRequest(const Value: TBeforeRequest);
begin
  FBeforeRequest := value;
end;

procedure TRestRequest.setContentType(const Value: string);
begin
  FContentType := Value;
end;

function TRestRequest.Scheme(aScheme: string): TRestRequest;
begin
  Self.FScheme := Trim(aScheme);
  Result := Self;
end;

function TRestRequest.urlEncode(str: string): string;
var
  i: Integer;
const
  UnsafeChars = ['*', '#', '%', '<', '>', ' ','[',']'];  {do not localize}
begin
  Result := '';    {Do not Localize}
  for i := 1 to Length(str) do
  begin
    if (str[i] in UnsafeChars) or (not (ord(str[i])in [33..128])) then
    begin {do not localize}
      Result := Result + '%' + IntToHex(Ord(str[i]), 2);  {do not localize}
    end
    else
    begin
      Result := Result + str[i];
    end;
  end;
end;

function TRestRequest.WithCredentials(username, password: string): TRestRequest;
begin
  Self.FUsername := username;
  Self.FPassword := password;
  Result := Self;
end;

function TRestRequest.WithHeader(aName, aValue: string): TRestRequest;
begin
  Self.FHeaders.Add(aName + ':' + aValue);
  Result := Self;
end;

end.
