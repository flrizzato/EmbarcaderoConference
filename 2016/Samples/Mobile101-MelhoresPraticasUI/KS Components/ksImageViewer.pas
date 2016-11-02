{*******************************************************************************
*                                                                              *
*  TksImageViewer - Enhanced image viewer component                            *
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

unit ksImageViewer;

interface

{$I ksComponents.inc}

uses Classes, Types, ksTypes, FMX.InertialMovement, System.UITypes, FMX.Graphics,
  FMX.Layouts, FMX.Types;

type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or
  {$IFDEF XE8_OR_NEWER} pidiOSDevice32 or pidiOSDevice64
  {$ELSE} pidiOSDevice {$ENDIF} or pidiOSSimulator or pidAndroid)]

  TksImageViewer = class(TksControl)
  private
    FAniCalc: TksAniCalc;
    FBitmap: TBitmap;
    FZoom: integer;

    FStartZoom: integer;
    FStartDistance: Integer;
    FOnZoom: TNotifyEvent;
    FMaxXPos: single;
    FMaxYPos: single;
    procedure AniCalcStart(Sender: TObject);
    procedure AniCalcStop(Sender: TObject);
    procedure AniCalcChange(Sender: TObject);

    procedure SetBitmap(const Value: TBitmap);
    procedure UpdateScrollLimits;
    procedure SetZoom(const Value: integer);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      x, y: single); override;
    procedure MouseMove(Shift: TShiftState; x, y: single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      x, y: single); override;
    procedure DoMouseLeave; override;
    procedure Paint; override;
    procedure Resize; override;
    procedure CMGesture(var EventInfo: TGestureEventInfo); override;
  public
    procedure UpdateLabel(ADistance: integer);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MultiTouch(const Touches: TTouches; const Action: TTouchAction);
  published
    property Align;
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property Zoom: integer read FZoom write SetZoom default 100;

    property OnGesture;
    property OnZoom: TNotifyEvent read FOnZoom write FOnZoom;
  end;

  procedure Register;

implementation

uses System.UIConsts, SysUtils, Math, FMX.Controls;


procedure Register;
begin
  RegisterComponents('Kernow Software FMX', [TksImageViewer]);
end;


{ TksImageViewer }

procedure TksImageViewer.AniCalcStart(Sender: TObject);
begin
  if Scene <> nil then
    Scene.ChangeScrollingState(Self, True);
end;

procedure TksImageViewer.AniCalcStop(Sender: TObject);
begin
  if Scene <> nil then
    Scene.ChangeScrollingState(nil, False);
end;

procedure TksImageViewer.CMGesture(var EventInfo: TGestureEventInfo);
{$IFDEF IOS}
var
  APercent: integer;
  ANewZoom: integer;
{$ENDIF}
begin
  inherited;
  {$IFDEF IOS}
  if FStartDistance = 0 then
    APercent := 100
  else
    APercent := Round((EventInfo.Distance / FStartDistance) * 100);

  ANewZoom := Round(FStartZoom * (APercent / 100));
  if Max(FZoom, ANewZoom) - Min(FZoom, ANewZoom) > 10 then
  begin
    FStartZoom := FZoom;
    FStartDistance := 0;
    Exit;
  end;
  Zoom := ANewZoom;
  FStartZoom := Zoom;
  FStartDistance := EventInfo.Distance;
  {$ENDIF}
end;

constructor TksImageViewer.Create(AOwner: TComponent);
begin
  inherited;
  FBitmap := TBitmap.Create;

  FAniCalc := TksAniCalc.Create(nil);
  FAniCalc.OnChanged := AniCalcChange;
  FAniCalc.ViewportPositionF := PointF(0, 0);
  FAniCalc.Animation := True;
  FAniCalc.Averaging := True;
  FAniCalc.Interval := 8;
  FAniCalc.BoundsAnimation := True;
  FAniCalc.TouchTracking := [ttHorizontal, ttVertical];
  FAniCalc.OnChanged := AniCalcChange;
  FAniCalc.OnStart := AniCalcStart;
  FAniCalc.OnStop := AniCalcStop;
  FZoom := 100;
  FMaxXPos := 0;
  FMaxYPos := 0;
  Touch.InteractiveGestures := [TInteractiveGesture.Zoom, TInteractiveGesture.Pan];
end;

destructor TksImageViewer.Destroy;
begin
  FreeAndNil(FBitmap);
  FreeAndNil(FAniCalc);
  inherited;
end;

procedure TksImageViewer.MouseDown(Button: TMouseButton; Shift: TShiftState; x,
  y: single);
begin
  inherited;
  //Form73.ListBox1.Items.Insert(0, 'MouseDown');
  FAniCalc.MouseDown(x, y);
end;

procedure TksImageViewer.DoMouseLeave;
begin
  inherited;
  if (FAniCalc <> nil) then
    FAniCalc.MouseLeave;

  FStartDistance := 0;
  FStartZoom := 0;
  //updatelabel(EventInfo.Distance);
  //updatelabel();
end;

procedure TksImageViewer.MouseMove(Shift: TShiftState; x, y: single);
begin
  inherited;
  FAniCalc.MouseMove(x, y);
end;

procedure TksImageViewer.MouseUp(Button: TMouseButton; Shift: TShiftState; x,
  y: single);
begin
  inherited;
  FAniCalc.MouseUp(x, y);
  //Form73.ListBox1.Items.Insert(0, 'MouseUp');
  FStartZoom := 0;
  FStartDistance := 0;
  UpdateScrollLimits;
end;

procedure TksImageViewer.MultiTouch(const Touches: TTouches;
  const Action: TTouchAction);
begin
  // still working this out.
end;

procedure TksImageViewer.Paint;
var
  ASourceRect: TRectF;
  ADestRect: TRectF;
  ASaveState: TCanvasSaveState;
begin
  inherited;
  if (csDesigning in ComponentState) then
    DrawDesignBorder(claDimgray, claDimgray);
  ASaveState := Canvas.SaveState;
  try
    Canvas.IntersectClipRect(ClipRect);
    Canvas.Clear(claBlack);
    ASourceRect := RectF(0, 0, FBitmap.Width, FBitmap.Height);

    ADestRect := ASourceRect;
    ADestRect.Width := (FBitmap.Width/100)*FZoom;
    ADestRect.Height := (FBitmap.Height/100)*FZoom;

    //{$IFDEF ANDROID}
    ADestRect := ClipRect;
    //{$ENDIF}

    OffsetRect(ADestRect, 0-FAniCalc.ViewportPosition.X, 0-FAniCalc.ViewportPosition.Y);

    if ADestRect.Width < Width then
      OffsetRect(ADestRect, (Width - ADestRect.Width) /2, 0);

    if ADestRect.Height < Height then
      OffsetRect(ADestRect, 0, (Height - ADestRect.Height) /2);

    Canvas.DrawBitmap(FBitmap,
                      ASourceRect,
                      ADestRect,
                      1,
                      True);

  finally
    Canvas.RestoreState(ASaveState);
  end;
end;

procedure TksImageViewer.Resize;
begin
  inherited;
  UpdateScrollLimits;
end;

procedure TksImageViewer.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
  UpdateScrollLimits;
end;

procedure TksImageViewer.SetZoom(const Value: integer);
var
  xpercent, ypercent: single;
begin
  if (Value > 10) and (Value < 200) then
  begin
    if FZoom <> Value then
    begin
      FZoom := Value;
   FAniCalc.UpdatePosImmediately;
   FAniCalc.MouseLeave;

    if FMaxXPos = 0 then
      XPercent := 0
    else
      xpercent := (FAniCalc.ViewportPositionF.X / FMaxXPos) * 100;
    if FMaxYPos = 0 then
      ypercent := 0
    else
      ypercent := (FAniCalc.ViewportPositionF.Y / FMaxYPos) * 100;

    UpdateScrollLimits;

    FAniCalc.ViewportPositionF := PointF((FMaxXPos / 100) * xpercent,
                                         (FMaxYPos / 100) * ypercent);

    InvalidateRect(ClipRect);
      if Assigned(FOnZoom) then
        FOnZoom(Self);
    end;
  end;
end;

procedure TksImageViewer.AniCalcChange(Sender: TObject);
begin
  InvalidateRect(ClipRect);
end;


procedure TksImageViewer.UpdateLabel(ADistance: integer);
begin

end;

procedure TksImageViewer.UpdateScrollLimits;
var
  Targets: array of TAniCalculations.TTarget;
  w, h: single;
begin

  if FAniCalc <> nil then
  begin
    //w := (FBitmap.Width / 100) * FZoom;
    //h := (FBitmap.Height / 100) * FZoom;
    //w := w - Width;
    //h := h - Height;

    w := 0;
    h := 0;

    SetLength(Targets, 2);
    Targets[0].TargetType := TAniCalculations.TTargetType.Min;
    Targets[0].Point := TPointD.Create(0, 0);

    Targets[1].TargetType := TAniCalculations.TTargetType.Max;
    Targets[1].Point := TPointD.Create(Max(0,w), Max(0, h));
    FAniCalc.SetTargets(Targets);

    FMaxXPos := Targets[1].Point.X;
    FMaxYPos := Targets[1].Point.Y;


  end;
end;

end.
