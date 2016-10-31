{ Parsed from Corelocation.framework CLError.h }

{$ifdef TYPES}
{$ifndef CLERROR_PAS_T}
{$define CLERROR_PAS_T}

{ Types }
type
  
  CLError = culong;

{ Constants }

const
  kCLErrorLocationUnknown = 0;
  kCLErrorDenied = 1;
  kCLErrorNetwork = 2;
  kCLErrorHeadingFailure = 3;
  kCLErrorRegionMonitoringDenied = 4;
  kCLErrorRegionMonitoringFailure = 5;
  kCLErrorRegionMonitoringSetupDelayed = 6;

{$endif}
{$endif}

{$ifdef RECORDS}
{$ifndef CLERROR_PAS_R}
{$define CLERROR_PAS_R}

{$endif}
{$endif}

{$ifdef FUNCTIONS}
{$ifndef CLERROR_PAS_F}
{$define CLERROR_PAS_F}

{$endif}
{$endif}

{$ifdef EXTERNAL_SYMBOLS}
{$ifndef CLERROR_PAS_S}
{$define CLERROR_PAS_S}

{$endif}
{$endif}
