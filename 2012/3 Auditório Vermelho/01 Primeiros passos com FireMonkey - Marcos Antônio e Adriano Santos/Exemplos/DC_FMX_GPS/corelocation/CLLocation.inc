{ Parsed from Corelocation.framework CLLocation.h }

{$ifdef TYPES}
{$ifndef CLLOCATION_PAS_T}
{$define CLLOCATION_PAS_T}

{ Types }
type
  CLLocationDegrees = double;
  CLLocationDegreesPtr = ^CLLocationDegrees;
  CLLocationAccuracy = double;
  CLLocationAccuracyPtr = ^CLLocationAccuracy;
  CLLocationSpeed = double;
  CLLocationSpeedPtr = ^CLLocationSpeed;
  CLLocationDirection = double;
  CLLocationDirectionPtr = ^CLLocationDirection;
  CLLocationDistance = double;
  CLLocationDistancePtr = ^CLLocationDistance;

{$endif}
{$endif}

{$ifdef RECORDS}
{$ifndef CLLOCATION_PAS_R}
{$define CLLOCATION_PAS_R}

{ Records }
type
  CLLocationCoordinate2D = record
    latitude: CLLocationDegrees;
    longitude: CLLocationDegrees;
  end;
CLLocationCoordinate2DPtr = ^CLLocationCoordinate2D;


{$endif}
{$endif}

{$ifdef FUNCTIONS}
{$ifndef CLLOCATION_PAS_F}
{$define CLLOCATION_PAS_F}

{$endif}
{$endif}

{$ifdef EXTERNAL_SYMBOLS}
{$ifndef CLLOCATION_PAS_S}
{$define CLLOCATION_PAS_S}

{ External symbols }
var
  kCLDistanceFilterNone: CLLocationDistance; cvar; external;
  kCLLocationAccuracyBestForNavigation: CLLocationAccuracy; cvar; external;
  kCLLocationAccuracyBest: CLLocationAccuracy; cvar; external;
  kCLLocationAccuracyNearestTenMeters: CLLocationAccuracy; cvar; external;
  kCLLocationAccuracyHundredMeters: CLLocationAccuracy; cvar; external;
  kCLLocationAccuracyKilometer: CLLocationAccuracy; cvar; external;
  kCLLocationAccuracyThreeKilometers: CLLocationAccuracy; cvar; external;
  kCLLocationCoordinate2DInvalid: CLLocationCoordinate2D; cvar; external;

{$endif}
{$endif}

{$ifdef FORWARD}
  CLLocation = objcclass;
  CLLocationPointer = ^CLLocation;
  CLLocationPtr = CLLocationPointer;

{$endif}

{$ifdef CLASSES}
{$ifndef CLLOCATION_PAS_C}
{$define CLLOCATION_PAS_C}

{ CLLocation }
  CLLocation = objcclass external (NSObject, NSCopyingProtocol, NSCodingProtocol)
  private
    _internal: id;
    
  public
    function initWithLatitude_longitude(latitude: CLLocationDegrees; longitude: CLLocationDegrees): id; message 'initWithLatitude:longitude:';
    function initWithCoordinate_altitude_horizontalAccuracy_verticalAccuracy_timestamp(coordinate: CLLocationCoordinate2D; altitude: CLLocationDistance; hAccuracy: CLLocationAccuracy; vAccuracy: CLLocationAccuracy; timestamp: NSDate): id; message 'initWithCoordinate:altitude:horizontalAccuracy:verticalAccuracy:timestamp:';
    function initWithCoordinate_altitude_horizontalAccuracy_verticalAccuracy_course_speed_timestamp(coordinate: CLLocationCoordinate2D; altitude: CLLocationDistance; hAccuracy: CLLocationAccuracy; vAccuracy: CLLocationAccuracy; course: CLLocationDirection; speed: CLLocationSpeed; timestamp: NSDate): id; message 'initWithCoordinate:altitude:horizontalAccuracy:verticalAccuracy:course:speed:timestamp:';
    function coordinate: CLLocationCoordinate2D; message 'coordinate';
    function altitude: CLLocationDistance; message 'altitude';
    function horizontalAccuracy: CLLocationAccuracy; message 'horizontalAccuracy';
    function verticalAccuracy: CLLocationAccuracy; message 'verticalAccuracy';
    function course: CLLocationDirection; message 'course';
    function speed: CLLocationSpeed; message 'speed';
    function timestamp: NSDate; message 'timestamp';
    function description: NSString; message 'description';
    function getDistanceFrom(location: CLLocation): CLLocationDistance; message 'getDistanceFrom:'; deprecated 'in __IPHONE_2_0 and later, in  and later';
    function distanceFromLocation(location: CLLocation): CLLocationDistance; message 'distanceFromLocation:';

    { Adopted Protocols }
    function copyWithZone(zone_: NSZonePtr): id;
    procedure encodeWithCoder(aCoder: NSCoder);
    function initWithCoder(aDecoder: NSCoder): id;
  end;

{$endif}
{$endif}
