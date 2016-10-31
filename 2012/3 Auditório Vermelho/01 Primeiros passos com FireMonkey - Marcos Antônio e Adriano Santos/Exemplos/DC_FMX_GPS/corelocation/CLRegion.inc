{ Parsed from Corelocation.framework CLRegion.h }

{$ifdef TYPES}
{$ifndef CLREGION_PAS_T}
{$define CLREGION_PAS_T}

{$endif}
{$endif}

{$ifdef RECORDS}
{$ifndef CLREGION_PAS_R}
{$define CLREGION_PAS_R}

{$endif}
{$endif}

{$ifdef FUNCTIONS}
{$ifndef CLREGION_PAS_F}
{$define CLREGION_PAS_F}

{$endif}
{$endif}

{$ifdef EXTERNAL_SYMBOLS}
{$ifndef CLREGION_PAS_S}
{$define CLREGION_PAS_S}

{$endif}
{$endif}

{$ifdef FORWARD}
  CLRegion = objcclass;
  CLRegionPointer = ^CLRegion;
  CLRegionPtr = CLRegionPointer;

{$endif}

{$ifdef CLASSES}
{$ifndef CLREGION_PAS_C}
{$define CLREGION_PAS_C}

{ CLRegion }
  CLRegion = objcclass external (NSObject, NSCopyingProtocol, NSCodingProtocol)
  private
    _internal: id;
    
  public
    function initCircularRegionWithCenter_radius_identifier(center: CLLocationCoordinate2D; radius: CLLocationDistance; identifier: NSString): id; message 'initCircularRegionWithCenter:radius:identifier:';
    function center: CLLocationCoordinate2D; message 'center';
    function radius: CLLocationDistance; message 'radius';
    function identifier: NSString; message 'identifier';
    function containsCoordinate(coordinate: CLLocationCoordinate2D): Boolean; message 'containsCoordinate:';

    { Adopted Protocols }
    function copyWithZone(zone_: NSZonePtr): id;
    procedure encodeWithCoder(aCoder: NSCoder);
    function initWithCoder(aDecoder: NSCoder): id;
  end;

{$endif}
{$endif}
