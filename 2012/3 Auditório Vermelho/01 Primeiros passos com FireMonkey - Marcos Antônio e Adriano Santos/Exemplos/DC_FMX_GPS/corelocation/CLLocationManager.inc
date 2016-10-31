{ Parsed from Corelocation.framework CLLocationManager.h }

{$ifdef TYPES}
{$ifndef CLLOCATIONMANAGER_PAS_T}
{$define CLLOCATIONMANAGER_PAS_T}

{ Types }
type
  
  CLDeviceOrientation = culong;
  CLAuthorizationStatus = culong;

{ Constants }

const
  CLDeviceOrientationUnknown = 0;
  CLDeviceOrientationPortrait = 1;
  CLDeviceOrientationPortraitUpsideDown = 2;
  CLDeviceOrientationLandscapeLeft = 3;
  CLDeviceOrientationLandscapeRight = 4;
  CLDeviceOrientationFaceUp = 5;
  CLDeviceOrientationFaceDown = 6;

const
  kCLAuthorizationStatusNotDetermined = 0;
  kCLAuthorizationStatusRestricted = 1;
  kCLAuthorizationStatusDenied = 2;
  kCLAuthorizationStatusAuthorized = 3;

{$endif}
{$endif}

{$ifdef RECORDS}
{$ifndef CLLOCATIONMANAGER_PAS_R}
{$define CLLOCATIONMANAGER_PAS_R}

{$endif}
{$endif}

{$ifdef FUNCTIONS}
{$ifndef CLLOCATIONMANAGER_PAS_F}
{$define CLLOCATIONMANAGER_PAS_F}

{$endif}
{$endif}

{$ifdef EXTERNAL_SYMBOLS}
{$ifndef CLLOCATIONMANAGER_PAS_S}
{$define CLLOCATIONMANAGER_PAS_S}

{$endif}
{$endif}

{$ifdef FORWARD}
  CLLocationManager = objcclass;
  CLLocationManagerPointer = ^CLLocationManager;
  CLLocationManagerPtr = CLLocationManagerPointer;

{$endif}

{$ifdef CLASSES}
{$ifndef CLLOCATIONMANAGER_PAS_C}
{$define CLLOCATIONMANAGER_PAS_C}

{ CLLocationManager }
  CLLocationManager = objcclass external (NSObject)
  private
    _internal: id;
    
  public
    class function locationServicesEnabled: Boolean; message 'locationServicesEnabled';
    class function headingAvailable: Boolean; message 'headingAvailable';
    class function significantLocationChangeMonitoringAvailable: Boolean; message 'significantLocationChangeMonitoringAvailable';
    class function regionMonitoringAvailable: Boolean; message 'regionMonitoringAvailable';
    class function regionMonitoringEnabled: Boolean; message 'regionMonitoringEnabled';
    class function authorizationStatus: CLAuthorizationStatus; message 'authorizationStatus';
    procedure setDelegate (newValue: id); message 'setDelegate:';
    function delegate: id; message 'delegate';
    procedure setPurpose (newValue: NSString); message 'setPurpose:';
    function purpose: NSString; message 'purpose';
    procedure setDistanceFilter (newValue: CLLocationDistance); message 'setDistanceFilter:';
    function distanceFilter: CLLocationDistance; message 'distanceFilter';
    procedure setDesiredAccuracy (newValue: CLLocationAccuracy); message 'setDesiredAccuracy:';
    function desiredAccuracy: CLLocationAccuracy; message 'desiredAccuracy';
    function location: CLLocation; message 'location';
    procedure setHeadingFilter (newValue: CLLocationDegrees); message 'setHeadingFilter:';
    function headingFilter: CLLocationDegrees; message 'headingFilter';
    procedure setHeadingOrientation (newValue: CLDeviceOrientation); message 'setHeadingOrientation:';
    function headingOrientation: CLDeviceOrientation; message 'headingOrientation';
    function heading: CLHeading; message 'heading';
    function maximumRegionMonitoringDistance: CLLocationDistance; message 'maximumRegionMonitoringDistance';
    function monitoredRegions: NSSet; message 'monitoredRegions';
    procedure startUpdatingLocation; message 'startUpdatingLocation';
    procedure stopUpdatingLocation; message 'stopUpdatingLocation';
    procedure startUpdatingHeading; message 'startUpdatingHeading';
    procedure stopUpdatingHeading; message 'stopUpdatingHeading';
    procedure dismissHeadingCalibrationDisplay; message 'dismissHeadingCalibrationDisplay';
    procedure startMonitoringSignificantLocationChanges; message 'startMonitoringSignificantLocationChanges';
    procedure stopMonitoringSignificantLocationChanges; message 'stopMonitoringSignificantLocationChanges';
    procedure startMonitoringForRegion_desiredAccuracy(region: CLRegion; accuracy: CLLocationAccuracy); message 'startMonitoringForRegion:desiredAccuracy:';
    procedure stopMonitoringForRegion(region: CLRegion); message 'stopMonitoringForRegion:';
  end;

{$endif}
{$endif}
