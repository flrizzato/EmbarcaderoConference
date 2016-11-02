{*******************************************************************************
*                                                                              *
*  ksCameraViewer - Real-time Camara Viewer                                    *
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

unit ksCameraViewer;

interface

{$I ksComponents.inc}

uses FMX.Controls, Classes, FMX.Objects, FMX.Media, FMX.Graphics, FMX.Types, ksTypes;

type
  TScanBufferEvent = procedure(Sender: TObject; ABitmap: TBitmap) of object;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or
    {$IFDEF XE8_OR_NEWER} pidiOSDevice32 or pidiOSDevice64
    {$ELSE} pidiOSDevice {$ENDIF} or pidiOSSimulator or pidAndroid)]
  TksCameraViewer = class(TksControl)
  private
    FActive: Boolean;
    FBuffer: TBitmap;
    FViewportBuffer: TBitmap;
    FVideoCamera: TVideoCaptureDevice;
    FOnScanBuffer: TScanBufferEvent;
    procedure DoScanBuffer(Sender: TObject; const ATime: TMediaTime);
    procedure SyncroniseBuffer;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartCapture;
    procedure StopCapture;
  published

    property Align;
    property Height;
    property Size;
    property Position;
    property Visible;
    property Width;
    // events...
    property OnScanBuffer: TScanBufferEvent read FOnScanBuffer write FOnScanBuffer;
  end;

procedure Register;

implementation

uses System.UIConsts, SysUtils, Types, FMX.Forms, FMX.Platform, System.Threading;

procedure Register;
begin
  RegisterComponents('Kernow Software FMX', [TksCameraViewer]);
end;


{ TksCameraViewer }

constructor TksCameraViewer.Create(AOwner: TComponent);
begin
  inherited;
  FActive := False;
  ClipChildren := True;
  FBuffer := TBitmap.Create;
  FViewportBuffer := TBitmap.Create;
end;

destructor TksCameraViewer.Destroy;
begin
  {$IFDEF NEXTGEN}
  FVideoCamera.DisposeOf;
  {$ELSE}
  FVideoCamera.Free;
  {$ENDIF}
  FreeAndNil(FBuffer);
  FreeAndNil(FViewportBuffer);
  inherited;
end;


procedure TksCameraViewer.StartCapture;
begin

  FVideoCamera := TVideoCaptureDevice(TCaptureDeviceManager.Current.GetDefaultDeviceByMediaType(TMediaType.Video));
  FVideoCamera.Quality := TVideoCaptureQuality.MediumQuality;
  {$IFDEF ANDROID}
  FVideoCamera.FocusMode := TFocusMode.ContinuousAutoFocus;
  {$ENDIF}
  if FVideoCamera <> nil then
    FVideoCamera.OnSampleBufferReady := DoScanBuffer;

  FBuffer.Clear(claNull);
  FActive := True;
  if FVideoCamera <> nil then
  begin
    FVideoCamera.StartCapture;
    {$IFDEF ANDROID}
    FVideoCamera.FocusMode := TFocusMode.ContinuousAutoFocus;
    {$ENDIF}
  end;
end;

procedure TksCameraViewer.StopCapture;
begin
  FActive := False;
end;

procedure TksCameraViewer.SyncroniseBuffer;
begin
  if FActive = False then
  begin
    if FVideoCamera <> nil then
    begin
      FVideoCamera.StopCapture;
      {$IFDEF NEXTGEN}
      FreeAndNil(FVideoCamera);
      {$ELSE}
      FVideoCamera.Free;
      {$ENDIF}
    end;
    Exit;
  end
  else
  begin

    FVideoCamera.SampleBufferToBitmap(FBuffer, True);
    if Assigned(FOnScanBuffer) then
      FOnScanBuffer(Self, FBuffer);

    Repaint;
  end;
end;




procedure TksCameraViewer.DoScanBuffer(Sender: TObject; const ATime: TMediaTime);
begin
  TThread.Synchronize(TThread.CurrentThread, SyncroniseBuffer);
end;

procedure TksCameraViewer.Paint;
var
  ABmp: TBitmap;
  r: TRectF;
  AViewBmp: TBitmap;
begin
  inherited;
    if FBuffer.Width = 0 then
      Exit;
  ABmp := TBitmap.Create((Owner as TForm).Width, (Owner as TForm).Height);
  try
    ABmp.Canvas.BeginScene;
    ABmp.Canvas.DrawBitmap(FBuffer, RectF(0, 0, FBuffer.Width, FBuffer.Height), RectF(0, 0, ABmp.Width, ABmp.Height), 1, True);
    ABmp.Canvas.EndScene;
    r := RectF(0, 0, Width, Height);
    AViewBmp := TBitmap.Create(Round(Width), Round(Height));
    try
      OffsetRect(r, (ABmp.Width - r.Width)/2, (ABmp.Height - r.Height)/2);
      AViewBmp.CopyFromBitmap(ABmp, r.Truncate, 0, 0);
      Canvas.DrawBitmap(AViewBmp, RectF(0, 0, AViewBmp.Width, AViewBmp.Height), RectF(0, 0, Width, Height), 1, True);
    finally
      FreeAndNil(AViewBmp);
    end;

  finally
    FreeAndNil(ABmp);
  end;
end;


end.
