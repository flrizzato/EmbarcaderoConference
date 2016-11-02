{*******************************************************************************
*                                                                              *
*  TksLoadingIndicator - Loading indicator control                             *
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

unit ksLoadingIndicator;

interface

{$I ksComponents.inc}

uses
  System.SysUtils, System.Classes, ksTypes, FMX.Objects, FMX.StdCtrls,
  FMX.Types;

type
  TksLoadingIndicator = class;

  TksLoadingIndicatorObject = class(TRectangle)
  private
    FLabel: TLabel;
    FArc: TArc;
    FTimer: TTimer;
    function GetText: string;
    procedure SetText(const Value: string);
    procedure DoTimer(Sender: TObject);
    procedure RealignArc;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Text: string read GetText write SetText;
    procedure StartAnimation;
    procedure StopAnimation;
  end;

  TksLoadingIndicatorLabel = class(TPersistent)
  private
    [weak]FOwner: TksLoadingIndicator;
    FText: string;
    FVisible: Boolean;
    procedure SetText(const Value: string);
    procedure SetVisible(const Value: Boolean);
  published
    constructor Create(AOwner: TksLoadingIndicator);
    property Text: string read FText write SetText;
    property Visible: Boolean read FVisible write SetVisible;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or
    {$IFDEF XE8_OR_NEWER} pidiOSDevice32 or pidiOSDevice64
    {$ELSE} pidiOSDevice {$ENDIF} or pidiOSSimulator or pidAndroid)]
  TksLoadingIndicator = class(TksComponent)
  private
    FIndicator: TksLoadingIndicatorObject;
    FLoadingText: TksLoadingIndicatorLabel;
    FModalBackground: TRectangle;
    FVisible: Boolean;
    FShowModal: Boolean;
    FFadeBackground: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowLoading;
    procedure HideLoading;

  published
    property LoadingText: TksLoadingIndicatorLabel read FLoadingText write FLoadingText;
    property IsModal: Boolean read FShowModal write FShowModal default False;
    property FadeBackground: Boolean read FFadeBackground write FFadeBackground default False;
  end;

procedure Register;

implementation


uses FMX.Graphics, FMX.Forms, System.UIConsts;

procedure Register;
begin
  RegisterComponents('Kernow Software FMX', [TksLoadingIndicator]);
end;


{ TksLoadingIndicatorObject }

constructor TksLoadingIndicatorObject.Create(AOwner: TComponent);
begin
  inherited;
  FArc := TArc.Create(Self);
  FArc.Stroke.Color := claLightgray;
  FArc.Stroke.Thickness := 3;
  FArc.Stroke.Kind := TBrushKind.Gradient;
  FArc.Stroke.Gradient.Color := claWhite;
  FArc.Stroke.Gradient.Color1 := claBlack;
  Width := 100;
  Height := 100;
  Align := TAlignLayout.Center;
  Visible := False;
  XRadius := 10;
  YRadius := 10;
  Fill.Color := claBlack;
  HitTest := False;
  Opacity := 1;
  FLabel := TLabel.Create(Self);
  FLabel.StyledSettings := [];
  FLabel.Font.Size := 14;

  FLabel.Height := 30;
  FLabel.Align := TAlignLayout.Bottom;
  FLabel.TextSettings.HorzAlign := TTextAlign.Center;
  FLabel.TextSettings.FontColor := claWhite;
  FTimer := TTimer.Create(nil);
  FTimer.Interval := 25;
  FTimer.OnTimer := DoTimer;
  FTimer.Enabled := True;
  AddObject(FLabel);
  AddObject(FArc);
  Stored := False;
  RealignArc;
end;

destructor TksLoadingIndicatorObject.Destroy;
begin
  FTimer.DisposeOf;
  inherited;
end;

procedure TksLoadingIndicatorObject.DoTimer(Sender: TObject);
begin
  FArc.RotationAngle := FArc.RotationAngle+10;
end;

function TksLoadingIndicatorObject.GetText: string;
begin
  Result := FLabel.Text;
end;

procedure TksLoadingIndicatorObject.RealignArc;
begin
  FArc.Width := 40;
  FArc.Height := 40;
  FArc.StartAngle := 90;
  FArc.EndAngle := 180;
  FArc.Position.X := 30;
  if (FLabel.Visible) and (FLabel.Text <> '') then
    FArc.Position.Y := 15
  else
    FArc.Position.Y := 30;

end;

procedure TksLoadingIndicatorObject.SetText(const Value: string);
begin
  FLabel.Text := Value;
end;

procedure TksLoadingIndicatorObject.StartAnimation;
begin
  FTimer.Enabled := True;
end;

procedure TksLoadingIndicatorObject.StopAnimation;
begin
  FTimer.Enabled := False;
end;

{ TksLoadingIndicator }

constructor TksLoadingIndicator.Create(AOwner: TComponent);
begin
  inherited;
  FIndicator := TksLoadingIndicatorObject.Create(nil);
  FLoadingText := TksLoadingIndicatorLabel.Create(Self);
  FModalBackground := TRectangle.Create(nil);
  FVisible := False;
  FShowModal := False;
  FFadeBackground := False;
end;

destructor TksLoadingIndicator.Destroy;
begin
  if not FVisible then
  begin
    {$IFDEF NEXTGEN}
    FIndicator.DisposeOf;
    FModalBackground.DisposeOf;
    FLoadingText.DisposeOf;
    {$ELSE}
    FIndicator.Free;
    FModalBackground.Free;
    FLoadingText.Free;
    {$ENDIF}
  end;
  inherited;
end;

procedure TksLoadingIndicator.HideLoading;
var
  AOwner: TCustomForm;
begin
  AOwner := (Root.GetObject as TCustomForm);
  FIndicator.StopAnimation;
  AOwner.RemoveObject(FModalBackground);
  AOwner.RemoveObject(FIndicator);
  FVisible := False;
end;

procedure TksLoadingIndicator.ShowLoading;
var
  AOwner: TCustomForm;
begin
  FVisible := True;
  AOwner := (Root.GetObject as TCustomForm);

  FModalBackground.Align := TAlignLayout.Contents;
  FModalBackground.HitTest := FShowModal;
  FModalBackground.Stroke.Kind := TBrushKind.None;
  FModalBackground.Fill.Color := claNull;
  if FFadeBackground then
  begin
    FModalBackground.Fill.Color := claBlack;
    FModalBackground.Opacity := 0.5;
  end;

  AOwner.AddObject(FModalBackground);
  AOwner.AddObject(FIndicator);
  FIndicator.BringToFront;
  FIndicator.FLabel.Visible := FLoadingText.Visible;
  FIndicator.FLabel.Text := FLoadingText.Text;
  FIndicator.RealignArc;
  FIndicator.Visible := True;
  FIndicator.StartAnimation;
end;

{ TksLoadingIndicatorLabel }


constructor TksLoadingIndicatorLabel.Create(AOwner: TksLoadingIndicator);
begin
  inherited Create;
  FOwner := AOwner;
  FText := 'LOADING...';
  FVisible := True;
end;

procedure TksLoadingIndicatorLabel.SetText(const Value: string);
begin
  FText := Value;
end;

procedure TksLoadingIndicatorLabel.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

end.
