
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Accelerometer;

{$IFDEF FPC}
{$mode delphi}
{$modeswitch objectivec1}
{$ENDIF}

interface

uses
  SysUtils, Classes, FMX_Types
{$IFDEF FPC}
  , iPhoneAll
{$ENDIF}
  ;

type
  TAccelerateEvent = procedure(x,y,z : Double) of object;

  TiOSAccelerometer = class(TFmxObject)
  private
    FOnAccelerate: TAccelerateEvent;
    FUpdateInterval : Integer;
    FEnabled : Boolean;
    procedure SetEnabled(const Value: Boolean);
    procedure SetUpdateInterval(const Value: Integer);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property OnAccelerate: TAccelerateEvent read FOnAccelerate write FOnAccelerate;
    property UpdateInterval: Integer read FUpdateInterval write SetUpdateInterval default 100;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
  end;

{$IFDEF FPC}
type
  UIAcceleration = objcclass external (NSObject)
  public
    function timestamp: NSTimeInterval; message 'timestamp';
    function x: UIAccelerationValue; message 'x';
    function y: UIAccelerationValue; message 'y';
    function z: UIAccelerationValue; message 'z';
  end;
{$ENDIF}

{$IFDEF FPC}
type
  AccDelegate = objcclass(NSObject)
    procedure accelerometer_didAccelerate(accelerometer: UIAccelerometer; acceleration: UIAcceleration); message 'accelerometer:didAccelerate:';
  end;
{$ENDIF}

{$IFDEF FPC}
var
  AccDelegateVar: AccDelegate;
{$ENDIF}

var
  GlobalAccelerometer: TiOSAccelerometer;

procedure Register;

implementation

{$IFDEF FPC}
procedure AccDelegate.accelerometer_didAccelerate(accelerometer: UIAccelerometer; acceleration: UIAcceleration);
begin
  if Assigned(GlobalAccelerometer) then
    if Assigned(GlobalAccelerometer.FOnAccelerate) then
      GlobalAccelerometer.FOnAccelerate(acceleration.x,acceleration.y,acceleration.z);
end;
{$ENDIF}

constructor TiOSAccelerometer.Create(AOwner: TComponent);
begin
  if Assigned(GlobalAccelerometer) then
    raise Exception.Create('I won''t let you have more than one of these things...');
  inherited;

  {$IFDEF FPC}
  AccDelegateVar := AccDelegate.alloc;
  {$ENDIF}

  UpdateInterval := 100; // Fires SetUpdateInterval
  Enabled := True;       // Fires SetEnabled

  GlobalAccelerometer := Self;
end;

destructor TiOSAccelerometer.Destroy;
begin
  if GlobalAccelerometer = Self then
    GlobalAccelerometer := nil;
  {$IFDEF FPC}
  AccDelegateVar.release;
  {$ENDIF}
  inherited;
end;

procedure TiOSAccelerometer.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  {$IFDEF FPC}
  if FEnabled then
    UIAccelerometer.sharedAccelerometer.setDelegate(AccDelegateVar)
  else
    UIAccelerometer.sharedAccelerometer.setDelegate(nil);
  {$ENDIF}
end;

procedure TiOSAccelerometer.SetUpdateInterval(const Value: Integer);
begin
  FUpdateInterval := Value;
  {$IFDEF FPC}
  UIAccelerometer.sharedAccelerometer.setUpdateInterval(1.0/FUpdateInterval);
  {$ENDIF}
end;

procedure Register;
begin
  RegisterComponents('iOS', [TiOSAccelerometer]);
end;

end.

