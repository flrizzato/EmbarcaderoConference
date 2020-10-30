{ Parsed from Corelocation.framework CLLocationManagerDelegate.h }

{$ifdef TYPES}
{$ifndef CLLOCATIONMANAGERDELEGATE_PAS_T}
{$define CLLOCATIONMANAGERDELEGATE_PAS_T}

{$endif}
{$endif}

{$ifdef RECORDS}
{$ifndef CLLOCATIONMANAGERDELEGATE_PAS_R}
{$define CLLOCATIONMANAGERDELEGATE_PAS_R}

{$endif}
{$endif}

{$ifdef FUNCTIONS}
{$ifndef CLLOCATIONMANAGERDELEGATE_PAS_F}
{$define CLLOCATIONMANAGERDELEGATE_PAS_F}

{$endif}
{$endif}

{$ifdef EXTERNAL_SYMBOLS}
{$ifndef CLLOCATIONMANAGERDELEGATE_PAS_S}
{$define CLLOCATIONMANAGERDELEGATE_PAS_S}

{$endif}
{$endif}

{$ifdef FORWARD}
  CLLocationManagerDelegateProtocol = objcprotocol;

{$endif}
{$ifdef PROTOCOLS}
{$ifndef CLLOCATIONMANAGERDELEGATE_PAS_P}
{$define CLLOCATIONMANAGERDELEGATE_PAS_P}
  
{ CLLocationManagerDelegate Protocol }
  CLLocationManagerDelegateProtocol = objcprotocol external name 'CLLocationManagerDelegate'
  optional
    function locationManagerShouldDisplayHeadingCalibration(manager: CLLocationManager): Boolean; message 'locationManagerShouldDisplayHeadingCalibration:';
    procedure locationManager_didChangeAuthorizationStatus(manager: CLLocationManager; status: CLAuthorizationStatus); message 'locationManager:didChangeAuthorizationStatus:';
  end;
{$endif}
{$endif}
