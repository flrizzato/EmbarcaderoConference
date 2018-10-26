{ *******************************************************************************
  Copyright 2015 Daniele Spinetti
  Copyright 2017 Dener Rocha @denernun

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
  ******************************************************************************** }

unit Firebase.Request;

interface

uses
  Firebase.Interfaces,
  Firebase.Response,
  System.JSON,
  System.SysUtils,
  System.Net.URLClient,
  System.Classes,
  System.Net.HttpClient,
  System.Generics.Collections;

type

  TFirebaseRequest = class(TInterfacedObject, IFirebaseRequest)
  protected
    FBaseURI: string;
    FToken: string;
    function EncodeResourceParams(AResourceParams: array of string): string;
    function EncodeQueryParams(AQueryParams
      : TDictionary<string, string>): string;
    function EncodeToken(const AToken: string): string;
  public
    constructor Create(const ABaseURI: string = ''; const AToken: string = '');
    procedure SetBaseURI(const ABaseURI: string);
    procedure SetToken(const AToken: string);
    function SendData(const AResourceParams: array of string;
      const ACommand: TFirebaseCommand; AData: TJSONValue = nil;
      AQueryParams: QueryParams= nil;
      ADataOwner: boolean = true): IFirebaseResponse;
    property BaseURI: string read FBaseURI write SetBaseURI;
    property Token: string read FToken write SetToken;
  end;

implementation

uses
  System.NetConsts, System.NetEncoding, System.StrUtils;

{ TFirebaseRequest }

procedure TFirebaseRequest.SetBaseURI(const ABaseURI: string);
begin
  FBaseURI := ABaseURI;
end;

procedure TFirebaseRequest.SetToken(const AToken: string);
begin
  FToken := AToken;
end;

function TFirebaseRequest.SendData(const AResourceParams: array of string;
  const ACommand: TFirebaseCommand; AData: TJSONValue = nil;
  AQueryParams: TDictionary<string, string> = nil; ADataOwner: boolean = true)
  : IFirebaseResponse;
var
  LClient: THTTPClient;
  LResp: IHTTPResponse;
  LURL: string;
  LSource: TStringStream;
begin
  try
    LClient := THTTPClient.Create;
    LClient.ContentType := 'application/json';
    try
      LSource := nil;
      if AData <> nil then
        LSource := TStringStream.Create(AData.ToJSON);
      try
        LURL := BaseURI + EncodeResourceParams(AResourceParams) +
          EncodeToken(Token) + EncodeQueryParams(AQueryParams);
        case ACommand of
          fcPut:
            LResp := LClient.Put(LURL, LSource);
          fcPost:
            LResp := LClient.Post(LURL, LSource);
          fcPatch:
            LResp := LClient.Patch(LURL, LSource);
          fcGet:
            LResp := LClient.Get(LURL);
          fcRemove:
            LResp := LClient.Delete(LURL);
        end;
        Result := TFirebaseResponse.Create(LResp);
      finally
        if Assigned(LSource) then
          LSource.Free;
      end;
    finally
      LClient.Free;
    end;
  finally
    if ADataOwner then
    begin
      if Assigned(AData) then
        AData.Free;
    end;
  end;
end;

constructor TFirebaseRequest.Create(const ABaseURI, AToken: string);
begin
  inherited Create;
  FBaseURI := ABaseURI;
  FToken := AToken;
end;

function TFirebaseRequest.EncodeQueryParams(AQueryParams
  : TDictionary<string, string>): string;
var
  Param: TPair<string, string>;
begin
  if (not Assigned(AQueryParams)) or not(AQueryParams.Count > 0) then
    exit('');
  Result := ifthen(Token.IsEmpty, '?', '');
  for Param in AQueryParams do
  begin
    if Result <> '?' then
      Result := Result + '&';
    Result := Result + TNetEncoding.URL.URLDecode(Param.Key) + '=' +
      TNetEncoding.URL.URLDecode(Param.Value)
  end;
end;

function TFirebaseRequest.EncodeResourceParams(AResourceParams
  : array of string): string;
var
  i: integer;
begin
  Result := '';
  for i := low(AResourceParams) to high(AResourceParams) do
    Result := Result + '/' + TNetEncoding.URL.Encode(AResourceParams[i]);
end;

function TFirebaseRequest.EncodeToken(const AToken: string): string;
begin
  if Token.IsEmpty then
    Result := ''
  else
    Result := '?auth=' + Token;
end;

end.
