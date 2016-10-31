
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit CoreLocation;

{$mode delphi}
{$modeswitch objectivec1}
{$modeswitch cvar}
{$packrecords c}

interface

{$linkframework CoreLocation}

uses
  ctypes,
  CFBase, MacTypes, 
  iPhoneAll, AnonClassDefinitionsCorelocation;
  
{$define INTERFACE}

//{$include UndefinedTypes.inc}

{$define HEADER}
{$include corelocation/CoreLocation.inc}
{$undef HEADER}

{$define TYPES}
{$include corelocation/CoreLocation.inc}
{$undef TYPES}

{$define RECORDS}
{$include corelocation/CoreLocation.inc}
{$undef RECORDS}

//type
{$define FORWARD}
{$include corelocation/CoreLocation.inc}
{$undef FORWARD}

{$define PROTOCOLS}
{$include corelocation/CoreLocation.inc}
{$undef PROTOCOLS}

{$define CLASSES}
{$include corelocation/CoreLocation.inc}
{$undef CLASSES}
 
{$define FUNCTIONS}
{$include corelocation/CoreLocation.inc}
{$undef FUNCTIONS}

{$define EXTERNAL_SYMBOLS}
{$include corelocation/CoreLocation.inc}
{$undef EXTERNAL_SYMBOLS}

{$define USER_PATCHES}
{$include corelocation/CoreLocation.inc}
{$undef USER_PATCHES}

{$undef INTERFACE}
implementation
{$define IMPLEMENTATION}

{$define USER_PATCHES}
{$include corelocation/CoreLocation.inc}
{$undef USER_PATCHES}

{$undef IMPLEMENTATION}
end.
