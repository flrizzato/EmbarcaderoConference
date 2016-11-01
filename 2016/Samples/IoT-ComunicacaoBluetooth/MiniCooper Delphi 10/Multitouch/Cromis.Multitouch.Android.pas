(*
 * This software is distributed under BSD license.
 *
 * Copyright (c) 2006-2014 Iztok Kacin, Cromis (iztok.kacin@gmail.com).
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, this
 *   list of conditions and the following disclaimer in the documentation and/or
 *   other materials provided with the distribution.
 * - Neither the name of the Iztok Kacin nor the names of its contributors may be
 *   used to endorse or promote products derived from this software without specific
 *   prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * ==================================================================================
 * Multi touch support for multiple platforms. Without hacks only Android is 
 * supported for now.
 * ==================================================================================
 * 03/02/2014 (1.0.0)
 *   - Initial implementation.
 * 12/03/2014 (1.1.0)
 *   - Use Active touch point record
 *   - Determine which touch point is active for certain type of actions
 * 13/03/2014 (1.1.1)
 *   - Redesigned to use flags instead of active touch point
 * ==================================================================================
*)
unit Cromis.Multitouch.Android;

interface

uses
  System.Types,
  FMX.Platform,

  // Cromis units
  Cromis.Multitouch.Custom,

  // Android specific units
  FMX.Platform.Android, Androidapi.AppGlue, Androidapi.Input, Androidapi.NativeActivity;

type
  TTouchEventListener_Android = class(TTouchEventListener_Custom)
  private
    FAndroidApp: PAndroid_app;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

var
  ScaleFactor: Double;
  OldOnInputEvent: function(App: PAndroid_app; Event: PAInputEvent): Int32; cdecl;

function PixelToPoint(const P: TPointF): TPointF;
begin
  Result := TPointF.Create(P.X / ScaleFactor, P.Y / ScaleFactor);
end;

function HandleAndroidMotionEvent(AEvent: PAInputEvent): Int32; cdecl;
var
  X,Y: Single;
  I,K: Integer;
  Exclude: Boolean;
  PointData: PTouchPoint;
  TouchEvent: TTouchEvent;
  ActionType: Int32;
  EventAction: Int32;
  ActiveIndex: Int32;
begin
  SetLength(TouchEvent.Points, AMotionEvent_getPointerCount(AEvent));
  EventAction := AMotionEvent_getAction(AEvent);
  ActiveIndex := -1;
  Exclude := False;
  Result := 0;

  // get the type of the action that got fired
  ActionType := EventAction and AMOTION_EVENT_ACTION_MASK;

  case ActionType of
    AMOTION_EVENT_ACTION_DOWN: TouchEvent.EventType := teDown;
    AMOTION_EVENT_ACTION_UP: TouchEvent.EventType := teUp;
    AMOTION_EVENT_ACTION_MOVE: TouchEvent.EventType := teMove;
    AMOTION_EVENT_ACTION_POINTER_DOWN: TouchEvent.EventType := teDown;
    AMOTION_EVENT_ACTION_POINTER_UP: TouchEvent.EventType := teUp;
  end;

  if ActionType <> AMOTION_EVENT_ACTION_MOVE then
  begin
    if ActionType in [AMOTION_EVENT_ACTION_POINTER_DOWN, AMOTION_EVENT_ACTION_POINTER_UP] then
    begin
      ActiveIndex := EventAction and AMOTION_EVENT_ACTION_PointerIndex_MASK;
      ActiveIndex := ActiveIndex shr AMOTION_EVENT_ACTION_PointerIndex_SHIFT;
      Exclude := ActionType = AMOTION_EVENT_ACTION_POINTER_UP;
    end
    else if ActionType in [AMOTION_EVENT_ACTION_DOWN, AMOTION_EVENT_ACTION_UP] then
    begin
      if AMotionEvent_getPointerCount(AEvent) = 1 then
      begin
        ActiveIndex := 0;
      end;
    end;
  end;

  for I := 0 to AMotionEvent_getPointerCount(AEvent) - 1 do
  begin
    PointData := @TouchEvent.Points[I];

    X := AMotionEvent_getX(AEvent, I);
    Y := AMotionEvent_getY(AEvent, I);
    PointData.ID := AMotionEvent_getPointerId(AEvent, I);
    PointData.Position := PixelToPoint(TPointF.Create(X, Y));

    if I = ActiveIndex then
    begin
      case ActionType of
        AMOTION_EVENT_ACTION_DOWN: Include(PointData.Flags, pfTouchDown);
        AMOTION_EVENT_ACTION_UP: Include(PointData.Flags, pfTouchUp);
        AMOTION_EVENT_ACTION_MOVE: ;
        AMOTION_EVENT_ACTION_POINTER_DOWN: Include(PointData.Flags, pfTouchDown);
        AMOTION_EVENT_ACTION_POINTER_UP: Include(PointData.Flags, pfTouchUp);
      end;
    end;

    // get possible history points
    SetLength(PointData.History, AMotionEvent_getHistorySize(AEvent));

    for K := Length(PointData.History) - 1 downto 0 do
    begin
      X := AMotionEvent_getHistoricalX(AEvent, I, K);
      Y := AMotionEvent_getHistoricalY(AEvent, I, K);
      PointData.Position := PixelToPoint(TPointF.Create(X, Y));
    end;
  end;

  TouchEventListener.Notify(TouchEvent);
end;

function HandleAndroidInputEvent(var App: TAndroid_app; Event: PAInputEvent): Int32;
var
  EventType: Int64;
begin
  EventType := AInputEvent_getType(Event);
  Result := 0;

  if EventType = AINPUT_EVENT_TYPE_MOTION then
    Result := HandleAndroidMotionEvent(Event);

  if Assigned(OldOnInputEvent) then
    Result := OldOnInputEvent(@App, Event);
end;

{ TTouchEventListener_Android }

constructor TTouchEventListener_Android.Create;
var
  ScreenSvc: IFMXScreenService;
begin
  inherited;

  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, IInterface(ScreenSvc)) then
    ScaleFactor := ScreenSvc.GetScreenScale;

  // get android app instance reference
  FAndroidApp := PANativeActivity(System.DelphiActivity)^.instance;

  if Assigned(FAndroidApp) then
  begin
    OldOnInputEvent := FAndroidApp^.onInputEvent;
    FAndroidApp^.onInputEvent := @HandleAndroidInputEvent;
  end;
end;

destructor TTouchEventListener_Android.Destroy;
begin

  inherited;
end;

end.
