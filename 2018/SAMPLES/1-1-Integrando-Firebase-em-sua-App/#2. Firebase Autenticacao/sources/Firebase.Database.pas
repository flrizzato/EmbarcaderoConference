{ *******************************************************************************
  Copyright 2015 Daniele Spinetti

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

unit Firebase.Database;

interface

uses
  Firebase.Interfaces,
  Firebase.Response,
  Firebase.Request,
  System.Net.HttpClient,
  System.Net.URLClient,
  System.Classes,
  System.JSON,
  System.SysUtils,
  System.Generics.Collections;

type

  TFirebaseDatabase = class(TInterfacedObject, IFirebaseDatabase)
  private
    FBaseURI: string;
    FToken: string;
  public
    procedure SetBaseURI(const ABaseURI: string);
    procedure SetToken(const AToken: string);
    function Get(const AParams: array of string;
      AQueryParams: TDictionary<string, string> = nil): IFirebaseResponse;
    function Put(const AParams: array of string; AData: TJSONValue = nil;
      AQueryParams: TDictionary<string, string> = nil;
      ADataOwner: boolean = true): IFirebaseResponse;
    function Post(const AParams: array of string; AData: TJSONValue = nil;
      AQueryParams: TDictionary<string, string> = nil;
      ADataOwner: boolean = true): IFirebaseResponse;
    function Patch(const AParams: array of string; AData: TJSONValue = nil;
      AQueryParams: TDictionary<string, string> = nil;
      ADataOwner: boolean = true): IFirebaseResponse;
    function Delete(const AParams: array of string;
      AQueryParams: TDictionary<string, string> = nil): IFirebaseResponse;
    property BaseURI: string read FBaseURI write SetBaseURI;
    property Token: string read FToken write SetToken;
  end;

implementation

{ TFirebaseDatabase }

procedure TFirebaseDatabase.SetBaseURI(const ABaseURI: string);
begin
  FBaseURI := ABaseURI;
end;

procedure TFirebaseDatabase.SetToken(const AToken: string);
begin
  FToken := AToken;
end;

function TFirebaseDatabase.Get(const AParams: array of string;
  AQueryParams: TDictionary<string, string> = nil): IFirebaseResponse;
var
  ARequest: IFirebaseRequest;
begin
  ARequest := TFirebaseRequest.Create(BaseURI, Token);
  Result := ARequest.SendData(AParams, TFirebaseCommand.fcGet, nil,
    AQueryParams);
end;

function TFirebaseDatabase.Post(const AParams: array of string;
  AData: TJSONValue = nil; AQueryParams: TDictionary<string, string> = nil;
  ADataOwner: boolean = true): IFirebaseResponse;
var
  ARequest: IFirebaseRequest;
begin
  ARequest := TFirebaseRequest.Create(BaseURI, Token);
  Result := ARequest.SendData(AParams, TFirebaseCommand.fcPost, AData,
    AQueryParams, ADataOwner);
end;

function TFirebaseDatabase.Put(const AParams: array of string;
  AData: TJSONValue = nil; AQueryParams: TDictionary<string, string> = nil;
  ADataOwner: boolean = true): IFirebaseResponse;
var
  ARequest: IFirebaseRequest;
begin
  ARequest := TFirebaseRequest.Create(BaseURI, Token);
  Result := ARequest.SendData(AParams, TFirebaseCommand.fcPut, AData,
    AQueryParams, ADataOwner);
end;

function TFirebaseDatabase.Patch(const AParams: array of string;
  AData: TJSONValue = nil; AQueryParams: TDictionary<string, string> = nil;
  ADataOwner: boolean = true): IFirebaseResponse;
var
  ARequest: IFirebaseRequest;
begin
  ARequest := TFirebaseRequest.Create(BaseURI, Token);
  Result := ARequest.SendData(AParams, TFirebaseCommand.fcPatch, AData,
    AQueryParams, ADataOwner);
end;

function TFirebaseDatabase.Delete(const AParams: array of string;
  AQueryParams: TDictionary<string, string> = nil): IFirebaseResponse;
var
  ARequest: IFirebaseRequest;
begin
  ARequest := TFirebaseRequest.Create(BaseURI, Token);
  Result := ARequest.SendData(AParams, TFirebaseCommand.fcRemove, nil,
    AQueryParams);
end;

end.
