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
 * This is only a stub, the real implementation is inside FMX.Platform.IOS. 
 * But since source code is prohibited to distribute I cannot host the fixed unit.
 * ==================================================================================
 * 03/02/2014 (1.0.0)
 *   - Initial implementation.
 * 11/02/2014 (2.0.0)
 *   - Patch free implementation with swizzling.
 * ==================================================================================
*)
unit Cromis.Multitouch.IOS;

interface

uses
  System.SysUtils, System.Types, System.Generics.Collections,

  // Cromis units
  Cromis.Multitouch.Custom,

  FMX.Platform.iOS, FMX.Helpers.iOS, FMX.Forms, FMX.Types,
  Macapi.ObjCRuntime, Macapi.ObjectiveC, iOSapi.Foundation, iOSApi.UIKit;

type
  TTouchEventListener_IOS = class(TTouchEventListener_Custom)
  private
    //loadViewOrig: Pointer;
    //loadViewRepl: Pointer;
    touchesBeganOrig: Pointer;
    touchesBeganRepl: Pointer;
    touchesEndedOrig: Pointer;
    touchesEndedRepl: Pointer;
    touchesMovedOrig: Pointer;
    touchesMovedRepl: Pointer;
    touchesCancelledOrig: Pointer;
    touchesCancelledRepl: Pointer;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

type
  id = Pointer;
  SEL = Pointer;
  Ptouches = ^NSSet;
  PwithEvent = ^UIEvent;

{ TTouchEventListener_Android }

procedure DoNotifyTouchEvent(const touches: NSSet;
                             const withEvent: UIEvent;
                             const EventType: TTouchEventType);
var
  I: Integer;
  Touch: UITouch;
  Event: TTouchEvent;
begin
  // do the event begin notify
  if TouchEventListener <> nil then
  begin
    SetLength(Event.Points, touches.allObjects.count);
    Event.EventType := EventType;

    // notify our global touch handler
    for I := 0 to touches.allObjects.count - 1 do
    begin
      Touch := TUITouch.Wrap(touches.allObjects.objectAtIndex(I));
      Event.Points[I].ID := Integer(touches.allObjects.objectAtIndex(I));
      Event.Points[I].Position.X := Touch.locationInView(Touch.View).x;
      Event.Points[I].Position.Y := Touch.locationInView(Touch.View).y;

      SetLength(Event.Points[I].History, 1);
      Event.Points[I].History[0].X := Touch.previousLocationInView(Touch.View).x;
      Event.Points[I].History[0].Y := Touch.previousLocationInView(Touch.View).y;
    end;

    TouchEventListener.Notify(Event);
  end;
end;

procedure touchesBeganDetour(self: id; _cmd: SEL; touches: Pointer; withEvent: Pointer); cdecl;
begin
  DoNotifyTouchEvent(TNSSet.Wrap(touches), TUIEvent.Wrap(withEvent), teDown);
end;

procedure touchesEndedDetour(self: id; _cmd: SEL; touches: Pointer; withEvent: Pointer); cdecl;
begin
  DoNotifyTouchEvent(TNSSet.Wrap(touches), TUIEvent.Wrap(withEvent), teUp);
end;

procedure touchesMovedDetour(self: id; _cmd: SEL; touches: Pointer; withEvent: Pointer); cdecl;
begin
  DoNotifyTouchEvent(TNSSet.Wrap(touches), TUIEvent.Wrap(withEvent), teMove);
end;

procedure touchesCancelledDetour(self: id; _cmd: SEL; touches: Pointer; withEvent: Pointer); cdecl;
begin
  DoNotifyTouchEvent(TNSSet.Wrap(touches), TUIEvent.Wrap(withEvent), teCanceled);
end;

procedure loadViewDetour(self: id; _cmd: SEL); cdecl;
begin
  UIView(TUIView.Wrap(self)).setMultipleTouchEnabled(True);
end;

constructor TTouchEventListener_IOS.Create;
var
  ViewClass: Pointer;
begin
  inherited;

  // get the UIView class
  ViewClass := objc_getClass('UIView');

  // get the touchesBegan and hook it
  class_addMethod(ViewClass, sel_getUid('touchesBeganDetour:withEvent:'), @touchesBeganDetour, 'v@:@@');
  touchesBeganOrig := class_getInstanceMethod(ViewClass, sel_getUid('touchesBegan:withEvent:'));
  touchesBeganRepl := class_getInstanceMethod(ViewClass, sel_getUid('touchesBeganDetour:withEvent:'));
  method_exchangeImplementations(touchesBeganOrig, touchesBeganRepl);

  class_addMethod(ViewClass, sel_getUid('touchesEndedDetour:withEvent:'), @touchesEndedDetour, 'v@:@@');
  touchesEndedOrig := class_getInstanceMethod(ViewClass, sel_getUid('touchesEnded:withEvent:'));
  touchesEndedRepl := class_getInstanceMethod(ViewClass, sel_getUid('touchesEndedDetour:withEvent:'));
  method_exchangeImplementations(touchesEndedOrig, touchesEndedRepl);

  class_addMethod(ViewClass, sel_getUid('touchesMovedDetour:withEvent:'), @touchesMovedDetour, 'v@:@@');
  touchesMovedOrig := class_getInstanceMethod(ViewClass, sel_getUid('touchesMoved:withEvent:'));
  touchesMovedRepl := class_getInstanceMethod(ViewClass, sel_getUid('touchesMovedDetour:withEvent:'));
  method_exchangeImplementations(touchesMovedOrig, touchesMovedRepl);

  class_addMethod(ViewClass, sel_getUid('touchesCancelledDetour:withEvent:'), @touchesCancelledDetour, 'v@:@@');
  touchesCancelledOrig := class_getInstanceMethod(ViewClass, sel_getUid('touchesCancelled:withEvent:'));
  touchesCancelledRepl := class_getInstanceMethod(ViewClass, sel_getUid('touchesCancelledDetour:withEvent:'));
  method_exchangeImplementations(touchesCancelledOrig, touchesCancelledRepl);

  {
  class_addMethod(ViewClass, sel_getUid('loadViewDetour:'), @loadViewDetour, 'v@:');
  loadViewOrig := class_getInstanceMethod(ViewClass, sel_getUid('loadView:'));
  loadViewRepl := class_getInstanceMethod(ViewClass, sel_getUid('loadViewDetour:'));
  method_exchangeImplementations(loadViewOrig, loadViewRepl);
  }
end;

destructor TTouchEventListener_IOS.Destroy;
begin
  method_exchangeImplementations(touchesCancelledRepl, touchesCancelledOrig);
  method_exchangeImplementations(touchesMovedRepl, touchesMovedOrig);
  method_exchangeImplementations(touchesEndedRepl, touchesEndedOrig);
  method_exchangeImplementations(touchesBeganRepl, touchesBeganOrig);
  //method_exchangeImplementations(loadViewRepl, loadViewOrig);

  inherited;
end;

end.
