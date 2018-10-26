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

unit Firebase.Interfaces;

interface

uses
  System.JSON,
  System.SysUtils,
  System.Generics.Collections;

type

  TFirebaseCommand = (fcPut, fcPatch, fcPost, fcGet, fcRemove);
  QueryParams =TDictionary < string, string >;

  IFirebaseResponse = interface(IInterface)
    ['{28CE1C37-DE9E-47C2-8764-2FB073B93FB8}']
    function ContentAsString(const AEncoding: TEncoding = nil): string;
  end;

  IFirebaseRequest = interface(IInterface)
    ['{3B265C49-747A-4EFF-AC76-138A39F1C34B}']
    procedure SetBaseURI(const ABaseURI: string);
    procedure SetToken(const AToken: string);
    function SendData(const AResourceParams: array of string;
      const ACommand: TFirebaseCommand; AData: TJSONValue = nil;
      AQueryParams: QueryParams= nil;
      ADataOwner: boolean = true): IFirebaseResponse;
  end;

  IFirebaseDatabase = interface(IInterface)
    ['{43135DC9-C04F-42A3-AB5B-3E15AE207322}']
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
  end;

  IFirebaseAuth = interface(IInterface)
    ['{74CEDE48-B2BD-4CB4-BD5F-34A60BEDF8C3}']
    procedure SetApiKey(const AValue: string);
    function SignInWithEmailAndPassword(AEmail: string; APassword: string): IFirebaseResponse;
    function CreateUserWithEmailAndPassword(AEmail, APassword: string): IFirebaseResponse;
    function SendResetPassword(AEmail:string):IFirebaseResponse;
  end;

implementation

end.
