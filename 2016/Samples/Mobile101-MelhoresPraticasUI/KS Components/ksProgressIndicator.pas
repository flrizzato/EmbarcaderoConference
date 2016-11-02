{ *******************************************************************************
*                                                                              *
*  TksProgressIndicator                                                          *
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
*  See the License forthe specific language governing permissions and          *
*  limitations under the License.                                              *
*                                                                              *
*******************************************************************************}

unit ksProgressIndicator;

interface

{$I ksComponents.inc}

uses FMX.Controls, Classes, FMX.StdCtrls, FMX.Graphics, FMX.Types, FMX.Objects, ksTypes;


type
  TksProgressIndicator = class;

  TksProgressIndicatorSteps = class(TPersistent)
  private
    [weak]FOwner: TksProgressIndicator;
    FMaxSteps: integer;
    FCurrentStep: integer;
    FSize: integer;
    FVisible: Boolean;
    procedure SetCurrentStep(const Value: integer);
    procedure SetMaxSteps(const Value: integer);
    procedure SetVisible(const Value: Boolean);
    procedure Changed;
    procedure SetSize(const Value: integer);
  public
    constructor Create(AOwner: TksProgressIndicator);
  published
    property MaxSteps: integer read FMaxSteps write SetMaxSteps default 5;
    property CurrentStep: integer read FCurrentStep write SetCurrentStep default 1;
    property Size: integer read FSize write SetSize default 12;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or
    {$IFDEF XE8_OR_NEWER} pidiOSDevice32 or pidiOSDevice64
    {$ELSE} pidiOSDevice {$ENDIF} or pidiOSSimulator or pidAndroid)]
  TksProgressIndicator = class(TksControl)
  private
    FSteps: TksProgressIndicatorSteps;
  protected
    procedure Changed;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Position;
    property Width;
    property Height;
    property Steps: TksProgressIndicatorSteps read FSteps write FSteps;
  end;

  procedure Register;

implementation

uses System.UITypes, Types, SysUtils, System.UIConsts, ksCommon;

procedure Register;
begin
  RegisterComponents('Kernow Software FMX', [TksProgressIndicator]);
end;


{ TksProgressIndicatorSteps }

procedure TksProgressIndicatorSteps.Changed;
begin
  FOwner.Changed;
end;

constructor TksProgressIndicatorSteps.Create(AOwner: TksProgressIndicator);
begin
  inherited Create;
  FOwner := AOwner;
  FMaxSteps := 5;
  FCurrentStep := 1;
  FSize := 12;
  FVisible := True;
end;

procedure TksProgressIndicatorSteps.SetCurrentStep(const Value: integer);
begin
  FCurrentStep := Value;
  Changed;
end;

procedure TksProgressIndicatorSteps.SetMaxSteps(const Value: integer);
begin
  FMaxSteps := Value;
  Changed;

end;

procedure TksProgressIndicatorSteps.SetSize(const Value: integer);
begin
  if FSize <> Value then
  begin
    FSize := Value;
    Changed;
  end;
end;

procedure TksProgressIndicatorSteps.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TksProgressIndicator }

procedure TksProgressIndicator.Changed;
begin
  InvalidateRect(ClipRect);
end;

constructor TksProgressIndicator.Create(AOwner: TComponent);
begin
  inherited;
  FSteps := TksProgressIndicatorSteps.Create(Self);
  Size.Width := 200;
  Size.Height := 40;
end;

destructor TksProgressIndicator.Destroy;
begin
  FreeAndNil(FSteps);
  inherited;
end;


procedure TksProgressIndicator.Paint;
var
  ARect: TRectF;
  ICount: integer;
  AXpos: single;
  ASize: single;
  AColor: TAlphaColor;
  ABmp: TBitmap;
begin
  ABmp := TBitmap.Create;
  ABmp.Resize(Round(Width * (GetScreenScale*2)), Round(Height * (GetScreenScale*2)));
  ASize :=  FSteps.Size * (GetScreenScale*2);

  if FSteps.Visible = False then
    Exit;
  ARect := RectF(0, 0, (FSteps.MaxSteps + (FSteps.MaxSteps-1)) * ASize, ASize);

  OffsetRect(ARect, ((Width * (GetScreenScale*2)) - ARect.Width) / 2, ((Height * (GetScreenScale*2)) - ARect.Height) / 2);
  AXpos := ARect.Left;


  ABmp.Canvas.BeginScene;
  try

    //FBitmap.Canvas.FillRect(ARect, 0, 0, AllCorners, 1);
    for ICount := 0 to FSteps.MaxSteps-1 do
    begin
      AColor := claSilver;
      if (ICount+1) = FSteps.CurrentStep then
        AColor := claDodgerblue;
      ABmp.Canvas.Stroke.Color := AColor;
      ABmp.Canvas.Stroke.Kind := TBrushKind.Solid;
      ABmp.Canvas.Fill.Color := AColor;
      ABmp.Canvas.Fill.Kind := TBrushKind.Solid;


      ABmp.Canvas.FillEllipse(RectF(AXPos, ARect.Top, AXpos+ASize, ARect.Top+ASize), 1);
      ABmp.Canvas.DrawEllipse(RectF(AXPos, ARect.Top, AXpos+ASize, ARect.Top+ASize), 1);
      AXPos := AXPos + (ASize*2);
    end;
  finally
    ABmp.Canvas.EndScene;
  end;
  Canvas.DrawBitmap(ABmp, RectF(0, 0, ABmp.Width, ABmp.Height), ClipRect, 1, False);
end;

end.
