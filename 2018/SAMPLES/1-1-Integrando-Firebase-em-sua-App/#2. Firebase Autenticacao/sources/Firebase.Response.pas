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
  ********************************************************************************}

unit Firebase.Response;

interface

uses
  Firebase.Interfaces,
  System.SysUtils,
  System.Net.HttpClient;

type

  TFirebaseResponse = class(TInterfacedObject, IFirebaseResponse)
  private
    FHttpResponse: IHTTPResponse;
  public
    constructor Create(AHTTPResponse: IHTTPResponse);
    function ContentAsString(const AEncoding: TEncoding = nil): string;
  end;

implementation

{ TFirebaseResponse }

function TFirebaseResponse.ContentAsString(const AEncoding
  : TEncoding = nil): string;
begin
  Result := FHttpResponse.ContentAsString(AEncoding);
end;

constructor TFirebaseResponse.Create(AHTTPResponse: IHTTPResponse);
begin
  inherited Create;
  FHttpResponse := AHTTPResponse;
end;

end.
