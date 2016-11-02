{*******************************************************************************
*                                                                              *
*  TksCamara - Camara Access Component                                         *
*                                                                              *
*  https://github.com/gmurt/KernowSoftwareFMX                                  *
*                                                                              *
*  Copyright 2015 Graham Murt                                                  *
*                                                                              *
*  email: graham@kernow-software.co.uk                                         *
*                                                                              *
*  Licensed under the Apache License, Version 2.0 (the "License");             *
*  you may not use this file except in compliance with the License.            *
*  You may obtain a copy of the License at                                     *
*                                                                              *
*    http://www.apache.org/licenses/LICENSE-2.0                                *
*                                                                              *
*  Unless required by applicable law or agreed to in writing, software         *
*  distributed under the License is distributed on an "AS IS" BASIS,           *
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    *
*  See the License for the specific language governing permissions and         *
*  limitations under the License.                                              *
*                                                                              *
*******************************************************************************}

unit ksCamara;

interface

{$I ksComponents.inc}

uses Classes, FMX.MediaLibrary, FMX.Media, FMX.Platform, System.Messaging, FMX.Graphics,
  ksTypes;

type
  TksCamaraOnPhotoTaken = procedure(Sender: TObject; ABitmap: TBitmap) of object;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or
    {$IFDEF XE8_OR_NEWER} pidiOSDevice32 or pidiOSDevice64
    {$ELSE} pidiOSDevice {$ENDIF} or pidiOSSimulator or pidAndroid)]
  TksCamara = class(TksComponent)
  private
    FCamaraService: IFMXCameraService;
    FOnPhotoTaken: TksCamaraOnPhotoTaken;
    FEditable: Boolean;
    FSaveToAlbum: Boolean;
    procedure DoDidFinish(Image: TBitmap);
  public
    constructor Create(AOwner: TComponent); override;
    procedure TakePhoto;
  published
    property OnPhotoTaken: TksCamaraOnPhotoTaken read FOnPhotoTaken write FOnPhotoTaken;
    property Editable: Boolean read FEditable write FEditable default True;
    property SaveToAlbum: Boolean read FSaveToAlbum write FSaveToAlbum default True;
  end;

  procedure Register;

implementation

uses Types;

procedure Register;
begin
  RegisterComponents('Kernow Software FMX', [TksCamara]);
end;

{ TksCamara }

constructor TksCamara.Create(AOwner: TComponent);
begin
  inherited;
  TPlatformServices.Current.SupportsPlatformService(IFMXCameraService, FCamaraService);
  FEditable := True;
  FSaveToAlbum := True;
end;

procedure TksCamara.DoDidFinish(Image: TBitmap);
begin
  if Assigned(FOnPhotoTaken) then
    FOnPhotoTaken(Self, Image);
end;

procedure TksCamara.TakePhoto;
var
  AParams: TParamsPhotoQuery;
begin
  AParams.Editable := FEditable;
  // Specifies whether to save a picture to device Photo Library
  AParams.NeedSaveToAlbum := FSaveToAlbum;
  AParams.RequiredResolution := TSize.Create(640, 640);
  AParams.OnDidFinishTaking := DoDidFinish;
  FCamaraService.TakePhoto(nil, AParams);
end;

end.
