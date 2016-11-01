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
 * 11/02/2014 (2.0.0)
 *   - Patch free IOS implementation with swizzling.
 * 16/02/2014 (2.1.0)
 *   - Added support for touched control and relative coordinates
 * 12/03/2014 (2.2.0)
 *   - Added Active touch point so we know which one was it
 * 12/03/2014 (2.2.1)
 *   - Redesigned to use flags instead of active touch point
 * ==================================================================================
*)
unit Cromis.Multitouch.Custom;

interface

uses
  System.SysUtils, System.Types, System.Generics.Collections,

  // FMX units
  FMX.Types, FMX.Forms;

type
  TTouchEventType = (teDown, teMove, teUp, teCanceled);
  TPointFlag = (pfTouchDown, pfTouchUp);
  TPointFlags = set of TPointFlag;

  PTouchPoint = ^TTouchPoint;
  TTouchPoint = record
    ID: Integer;
    Control: TFmxObject;
    Position: TPointF;
    RelPosition: TPointF;
    History: array of TPointF;
    Flags: TPointFlags;
  end;

  TTouchEvent = record
    Points: array of TTouchPoint;
    EventType: TTouchEventType;
  end;

  // declaration of the listener handler procedure
  TListenerHandler = procedure(const Event: TTouchEvent) of Object;
  THandlerWrapper = record
    HandlerID: Integer;
    Handler: TListenerHandler;
  end;

  TTouchEventListener_Custom = class
  private
    FHandlerID: Integer;
    FHandlerList: TList<THandlerWrapper>;
  protected
    property HandlerList: TList<THandlerWrapper> read FHandlerList;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function AddHandler(const Handler: TListenerHandler): Integer;
    procedure RemoveHandler(const ID: Integer);
    procedure Notify(const Event: TTouchEvent);
  end;

  procedure InitializeTouchListener;
  procedure FinalizeTouchListener;

var
  TouchEventListener: TTouchEventListener_Custom = nil;

implementation

{$IFDEF IOS}
uses
  Cromis.Multitouch.IOS;
{$ELSE}
{$IFDEF MACOS}
uses
  //Cromis.Multitouch.Mac,
{$ENDIF MACOS}
{$ENDIF IOS}
{$IFDEF MSWINDOWS}
//uses
  //Cromis.Multitouch.Win,
{$ENDIF}
{$IFDEF ANDROID}
uses
  Cromis.Multitouch.Android;
{$ENDIF}

procedure InitializeTouchListener;
begin
{$IFDEF IOS}
  TouchEventListener := TTouchEventListener_IOS.Create;
{$ELSE}
{$IFDEF MACOS}
  TouchEventListener := TTouchEventListener_Custom.Create;
{$ENDIF MACOS}
{$ENDIF IOS}
{$IFDEF MSWINDOWS}
  TouchEventListener := TTouchEventListener_Custom.Create;
{$ENDIF}
{$IFDEF ANDROID}
  TouchEventListener := TTouchEventListener_Android.Create;
{$ENDIF}
end;


procedure FinalizeTouchListener;
begin
  FreeAndNil(TouchEventListener);
end;

{ TTouchEventListener_Custom }

constructor TTouchEventListener_Custom.Create;
begin
  FHandlerList := TList<THandlerWrapper>.Create;
  FHandlerID := 1;
end;

destructor TTouchEventListener_Custom.Destroy;
begin
  FreeAndNil(FHandlerList);

  inherited;
end;

procedure TTouchEventListener_Custom.Notify(const Event: TTouchEvent);
var
  I: Integer;
  Control: IControl;
begin
  // get controls and coordinated
  if FHandlerList.Count > 0 then
  begin
    if Screen.ActiveForm <> nil then
    begin
      for I := 0 to Length(Event.Points) - 1 do
      begin
        Control := Screen.ActiveForm.ObjectAtPoint(Event.Points[I].Position);

        if Control <> nil then
        begin
          Event.Points[I].Control := Control as TFmxObject;
          Event.Points[I].RelPosition := Control.ScreenToLocal(Event.Points[I].Position);
        end
        else
        begin
          Event.Points[I].Control := Screen.ActiveForm;
          Event.Points[I].RelPosition := Screen.ActiveForm.ScreenToClient(Event.Points[I].Position);
        end;
      end;
    end;
  end;

  // notify all that are registered
  for I := 0 to FHandlerList.Count - 1 do
    FHandlerList[I].Handler(Event);
end;

function TTouchEventListener_Custom.AddHandler(const Handler: TListenerHandler): Integer;
var
  HandlerWrapper: THandlerWrapper;
begin
  HandlerWrapper.HandlerID := FHandlerID;
  HandlerWrapper.Handler := Handler;
  FHandlerList.Add(HandlerWrapper);
  Result := FHandlerID;
  Inc(FHandlerID);
end;

procedure TTouchEventListener_Custom.RemoveHandler(const ID: Integer);
var
  I: Integer;
begin
  for I := 0 to FHandlerList.Count - 1 do
  begin
    if FHandlerList[I].HandlerID = ID then
    begin
      FHandlerList.Delete(I);
      Exit;
    end;
  end;
end;

end.
