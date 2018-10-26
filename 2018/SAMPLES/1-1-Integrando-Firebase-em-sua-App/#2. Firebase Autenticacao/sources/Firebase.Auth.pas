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
  ********************************************************************************}

unit Firebase.Auth;

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

const
  GOOGLE_REFRESH_AUTH_URL = 'https://securetoken.googleapis.com/v1/token';
  GOOGLE_CUSTOM_AUTH_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyCustomToken';
  GOOGLE_GET_USER_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/getAccountInfo';
  GOOGLE_IDENTITY_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyAssertion';
  GOOGLE_SIGNUP_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser';
  GOOGLE_PASSWORD_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword';
  GOOGLE_GET_CONFIRMATION_CODE_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/getOobConfirmationCode';
  GOOGLE_SET_ACCOUNT_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/setAccountInfo';
  GOOGLE_CREATE_AUTH_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/createAuthUri';

type

  TFirebaseAuth = class(TInterfacedObject, IFirebaseAuth)
  private
    FApiKey: string;
  public
    procedure SetApiKey(const AValue: string);
    function CreateUserWithEmailAndPassword(AEmail, APassword: string): IFirebaseResponse;
    function SignInWithEmailAndPassword(AEmail: string; APassword: string): IFirebaseResponse;
    function SendResetPassword(AEmail:string):IFirebaseResponse;
    property ApiKey: string read FApiKey write SetApiKey;
  end;

implementation

{ TFirebaseAuth }






function TFirebaseAuth.CreateUserWithEmailAndPassword(AEmail, APassword: string): IFirebaseResponse;
var
  AData: TJSONObject;
  AParams: TDictionary<string, string>;
  ARequest: TFirebaseRequest;
begin

  AData := TJSONObject.Create;
  AData.AddPair(TJSONPair.Create('email',AEmail));
  AData.AddPair(TJSONPair.Create('password',APassword));
  AData.AddPair(TJSONPair.Create('returnSecureToken','true'));

  ARequest := TFirebaseRequest.Create;
  ARequest.SetBaseURI(GOOGLE_SIGNUP_URL);
  AParams := TDictionary<string, string>.Create;
  try
    AParams.Add('key',ApiKey);
    Result := ARequest.SendData([], fcPost, AData, AParams);
  finally
    AParams.Free;
    ARequest.Free;
  end;

end;

function TFirebaseAuth.SendResetPassword(AEmail: string): IFirebaseResponse;
var
  AData: TJSONObject;
  AParams: TDictionary<string, string>;
  ARequest: TFirebaseRequest;
begin

  AData := TJSONObject.Create;
  AData.AddPair(TJSONPair.Create('email',AEmail));
  AData.AddPair(TJSONPair.Create('requestType','PASSWORD_RESET'));

  ARequest := TFirebaseRequest.Create;
  ARequest.SetBaseURI(GOOGLE_GET_CONFIRMATION_CODE_URL);
  AParams := TDictionary<string, string>.Create;
  try
    AParams.Add('key',ApiKey);
    Result := ARequest.SendData([], fcPost, AData, AParams);
  finally
    AParams.Free;
    ARequest.Free;
  end;

end;

procedure TFirebaseAuth.SetApiKey(const AValue: string);
begin
  FApiKey := AValue;
end;



function TFirebaseAuth.SignInWithEmailAndPassword(AEmail,
  APassword: string): IFirebaseResponse;
var
  AData: TJSONObject;
  AParams: TDictionary<string, string>;
  ARequest: TFirebaseRequest;
begin

  AData := TJSONObject.Create;
  AData.AddPair(TJSONPair.Create('email',AEmail));
  AData.AddPair(TJSONPair.Create('password',APassword));
  AData.AddPair(TJSONPair.Create('returnSecureToken','true'));

  ARequest := TFirebaseRequest.Create;
  ARequest.SetBaseURI(GOOGLE_PASSWORD_URL);
  AParams := TDictionary<string, string>.Create;
  try
    AParams.Add('key',ApiKey);
    Result := ARequest.SendData([], fcPost, AData, AParams);

  finally
    AParams.Free;
    ARequest.Free;
  end;

end;

end.

//function CreateUserWithEmailAndPassword(AEmail: string; APassword: string; ASendVerificationEmail: Boolean = false): IFirebaseResponse; overload;
//function CreateUserWithEmailAndPassword(AEmail: string; APassword: string; ADisplayName: string = ''; ASendVerificationEmail: Boolean = false): IFirebaseResponse; overload;
//
//function TFirebaseAuth.CreateUserWithEmailAndPassword(AEmail, APassword: string;
//  ASendVerificationEmail: Boolean): IFirebaseResponse;
//begin
//  Result := CreateUserWithEmailAndPassword(AEmail, APassword, '', ASendVerificationEmail);
//end;
//
//function TFirebaseAuth.CreateUserWithEmailAndPassword(AEmail, APassword,
//  ADisplayName: string; ASendVerificationEmail: Boolean): IFirebaseResponse;
//var
//  Content: string;
//begin
//  //JSON '{{\"email\":\"{email}\",\"password\":\"{password}\",\"returnSecureToken\":true}}';
//  Content := '';
//end;

//function CreateUserWithEmailAndPassword(AEmail: string; APassword: string; ASendVerificationEmail: Boolean = false): IFirebaseResponse; overload;
//function CreateUserWithEmailAndPassword(AEmail: string; APassword: string; ADisplayName: string = ''; ASendVerificationEmail: Boolean = false): IFirebaseResponse; overload;

