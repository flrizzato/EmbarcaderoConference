
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Location;

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
  TLocationData = record
    Latitude,
    Longitude,
    Altitude,
    Speed,
    Course,
    HorizontalAccuracy,
    VerticalAccuracy : Double;
  end;

  THeadingData = record
    MagneticHeading,
    TrueHeading,
    HeadingAccuracy : Double;
  end;

  TUpdateLocationEvent = procedure(LocationData : TLocationData) of object;
  TUpdateHeadingEvent = procedure(HeadingData : THeadingData) of object;

type
  TiOSLocation = class(TFmxObject)
  private
    FOnUpdateLocation: TUpdateLocationEvent;
    FEnabled: Boolean;
    FUpdateInterval: Integer;
    FUpdateHeading: Boolean;
    FOnUpdateHeading: TUpdateHeadingEvent;
    FUpdateLocation: Boolean;
    procedure SetEnabled(const Value: Boolean);
    procedure SetUpdateHeading(const Value: Boolean);
    procedure SetUpdateInterval(const Value: Integer);
    procedure SetUpdateLocation(const Value: Boolean);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property OnUpdateLocation: TUpdateLocationEvent read FOnUpdateLocation write FOnUpdateLocation;
    property OnUpdateHeading: TUpdateHeadingEvent read FOnUpdateHeading write FOnUpdateHeading;
    property UpdateInterval: Integer read FUpdateInterval write SetUpdateInterval default 100;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property UpdateLocation: Boolean read FUpdateLocation write SetUpdateLocation default True;
    property UpdateHeading: Boolean read FUpdateHeading write SetUpdateHeading default True;
  end;

var
  GlobalLocation: TiOSLocation;

procedure Register;

implementation

{$IFDEF FPC}
uses
  CoreLocation;
{$ENDIF}

{$IFDEF FPC}
type
  LocDelegate = objcclass(NSObject)
    locationManager : CLLocationManager;
    procedure locationManager_didUpdateToLocation_fromLocation(manager: CLLocationManager; newLocation, oldLocation: CLLocation); message 'locationManager:didUpdateToLocation:fromLocation:';
    procedure locationManager_didUpdateHeading(manager: CLLocationManager; newHeading: CLHeading); message 'locationManager:didUpdateHeading:';
  end;
{$ENDIF}

{$IFDEF FPC}
var
  LocDelegateVar : LocDelegate;
{$ENDIF}

{$IFDEF FPC}
procedure LocDelegate.locationManager_didUpdateToLocation_fromLocation(manager: CLLocationManager; newLocation, oldLocation: CLLocation);
var
  LD : TLocationData;
begin
  LD.Latitude := newLocation.coordinate.latitude;
  LD.Longitude := newLocation.coordinate.longitude;
  LD.Altitude := newLocation.altitude;
  LD.Speed := newLocation.speed;
  LD.Course := newLocation.course;
  LD.HorizontalAccuracy := newLocation.horizontalAccuracy;
  LD.VerticalAccuracy := newLocation.verticalAccuracy;

  if Assigned(GlobalLocation) then
    if Assigned(GlobalLocation.FOnUpdateLocation) then
      GlobalLocation.FOnUpdateLocation(LD);
end;
{$ENDIF}

{$IFDEF FPC}
procedure LocDelegate.locationManager_didUpdateHeading(manager: CLLocationManager; newHeading: CLHeading);
var
  HD : THeadingData;
begin
  HD.MagneticHeading := newHeading.magneticHeading;
  HD.TrueHeading := newHeading.trueHeading;
  HD.HeadingAccuracy := newHeading.headingAccuracy;

  if Assigned(GlobalLocation) then
    if Assigned(GlobalLocation.FOnUpdateHeading) then
      GlobalLocation.FOnUpdateHeading(HD);
end;
{$ENDIF}

constructor TiOSLocation.Create(AOwner: TComponent);
begin
  if Assigned(GlobalLocation) then
    raise Exception.Create('I won''t let you have more than one of these things...');
  inherited;

  {$IFDEF FPC}
	LocDelegateVar := LocDelegate.alloc.init;
  LocDelegateVar.locationManager := CLLocationManager.alloc.init;
  {$ENDIF}

  UpdateInterval := 100;  // Fires SetUpdateInterval
  Enabled := True;        // Fires SetEnabled
  UpdateLocation := True; // Fires SetUpdateLocation
  UpdateHeading := True;  // Fires SetUpdateHeading
  inherited;

  {$IFDEF FPC}
  LocDelegateVar.locationManager.setDesiredAccuracy(kCLLocationAccuracyBestForNavigation);
  {$ENDIF}

  GlobalLocation := Self;
end;

destructor TiOSLocation.Destroy;
begin
  if GlobalLocation = Self then
    GlobalLocation := nil;
  {$IFDEF FPC}
  LocDelegateVar.locationManager.release;
  LocDelegateVar.release;
  {$ENDIF}
  inherited;
end;

procedure TiOSLocation.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  {$IFDEF FPC}
  if FEnabled then
  	LocDelegateVar.locationManager.setDelegate(LocDelegateVar)
  else
  	LocDelegateVar.locationManager.setDelegate(nil);
  {$ENDIF}
end;

procedure TiOSLocation.SetUpdateHeading(const Value: Boolean);
begin
  FUpdateHeading := Value;
  {$IFDEF FPC}
  if FUpdateHeading then
    LocDelegateVar.locationManager.startUpdatingHeading
  else
    LocDelegateVar.locationManager.stopUpdatingHeading;
  {$ENDIF}
end;

procedure TiOSLocation.SetUpdateInterval(const Value: Integer);
begin
  FUpdateInterval := Value;

  // This should be SetDesiredAccuracy and use the enums from CoreLocation
  // Once implemented the call to setDesiredAccuracy should be
  // removed from Create and put in here instead
end;

procedure TiOSLocation.SetUpdateLocation(const Value: Boolean);
begin
  FUpdateLocation := Value;
  {$IFDEF FPC}
  if FUpdateLocation then
    LocDelegateVar.locationManager.startUpdatingLocation
  else
    LocDelegateVar.locationManager.stopUpdatingLocation;
  {$ENDIF}
end;

procedure Register;
begin
  RegisterComponents('iOS', [TiOSLocation]);
end;

end.

