{ Parsed from Corelocation.framework CLHeading.h }

{$ifdef TYPES}
{$ifndef CLHEADING_PAS_T}
{$define CLHEADING_PAS_T}

{ Types }
type
  CLHeadingComponentValue = double;
  CLHeadingComponentValuePtr = ^CLHeadingComponentValue;

{$endif}
{$endif}

{$ifdef RECORDS}
{$ifndef CLHEADING_PAS_R}
{$define CLHEADING_PAS_R}

{$endif}
{$endif}

{$ifdef FUNCTIONS}
{$ifndef CLHEADING_PAS_F}
{$define CLHEADING_PAS_F}

{$endif}
{$endif}

{$ifdef EXTERNAL_SYMBOLS}
{$ifndef CLHEADING_PAS_S}
{$define CLHEADING_PAS_S}

{ External symbols }
var
  kCLHeadingFilterNone: CLLocationDegrees; cvar; external;

{$endif}
{$endif}

{$ifdef FORWARD}
  CLHeading = objcclass;
  CLHeadingPointer = ^CLHeading;
  CLHeadingPtr = CLHeadingPointer;

{$endif}

{$ifdef CLASSES}
{$ifndef CLHEADING_PAS_C}
{$define CLHEADING_PAS_C}

{ CLHeading }
  CLHeading = objcclass external (NSObject, NSCopyingProtocol, NSCodingProtocol)
  private
    _internal: id;
    
  public
    function magneticHeading: CLLocationDirection; message 'magneticHeading';
    function trueHeading: CLLocationDirection; message 'trueHeading';
    function headingAccuracy: CLLocationDirection; message 'headingAccuracy';
    function x: CLHeadingComponentValue; message 'x';
    function y: CLHeadingComponentValue; message 'y';
    function z: CLHeadingComponentValue; message 'z';
    function timestamp: NSDate; message 'timestamp';
    function description: NSString; message 'description';

    { Adopted Protocols }
    function copyWithZone(zone_: NSZonePtr): id;
    procedure encodeWithCoder(aCoder: NSCoder);
    function initWithCoder(aDecoder: NSCoder): id;
  end;

{$endif}
{$endif}
