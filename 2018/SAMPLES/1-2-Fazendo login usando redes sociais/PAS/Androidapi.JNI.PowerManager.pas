unit Androidapi.JNI.PowerManager;

interface

uses
  System.SysUtils,
  Androidapi.JNI,
  Androidapi.JNIBridge,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  FMX.Helpers.Android;

type
  JPowerManager = interface;
  JWakeLock = interface;

 JWakeLockClass = interface(JObjectClass)
  ['{918E171F-CDB8-4464-9507-F49272CE7636}']
  end;

  [JavaSignature('android/os/PowerManager$WakeLock')]
  JWakeLock = interface(JObject)
  ['{D17B1136-FA15-4AEB-85B1-2D490F0FD320}']
    {Methods}
    procedure acquire; cdecl;
    procedure release; cdecl;
    function isHeld: Boolean; cdecl;
  end;
  TJWakeLock = class(TJavaGenericImport<JWakeLockClass, JWakeLock>) end;

  JPowerManagerClass = interface(JObjectClass)
  ['{7D0696A2-ADEA-4158-AE1F-5E720DEDBCF9}']
    {Property methods}
    function _GetFULL_WAKE_LOCK: Integer; cdecl;
    function _GetSCREEN_BRIGHT_WAKE_LOCK: Integer; cdecl;
    function _GetSCREEN_DIM_WAKE_LOCK: Integer; cdecl;
    function _GetPARTIAL_WAKE_LOCK: Integer; cdecl;
    {Properties}
    //Keep screen on bright & keyboard on
    //Deprecated in API level 17 - Jelly Bean MR1
    property FULL_WAKE_LOCK: Integer read _GetFULL_WAKE_LOCK;
    //Keep screen on bright
    //Deprecated in API level 13 - Honeycomb MR2
    property SCREEN_BRIGHT_WAKE_LOCK: Integer read _GetSCREEN_BRIGHT_WAKE_LOCK;
    //Keep screen on dim
    //Deprecated in API level 17 - Jelly Bean MR1
    property SCREEN_DIM_WAKE_LOCK: Integer read _GetSCREEN_DIM_WAKE_LOCK;
    //Keep CPU running, screen & keyboard can go off
    property PARTIAL_WAKE_LOCK: Integer read _GetPARTIAL_WAKE_LOCK;
  end;

  [JavaSignature('android/os/PowerManager')]
  JPowerManager = interface(JObject)
  ['{DEAED658-4353-4D17-B0A3-8179E48BE87F}']
    {Methods}
    function newWakeLock(levelAndFlags: Integer; tag: JString): JWakeLock; cdecl;
  end;
  TJPowerManager = class(TJavaGenericImport<JPowerManagerClass, JPowerManager>) end;

function GetPowerManager: JPowerManager;
function AcquireWakeLock(var AWakeLock: JWakeLock): Boolean;
procedure ReleaseWakeLock(var AWakeLock: JWakeLock);

implementation

uses
  Androidapi.Helpers;

function GetPowerManager: JPowerManager;
var
  PowerServiceNative: JObject;
begin
  PowerServiceNative := SharedActivityContext.getSystemService(
    TJContext.JavaClass.POWER_SERVICE);
  if not Assigned(PowerServiceNative) then
    raise Exception.Create('Could not locate Power Service');
  Result := TJPowerManager.Wrap(
    (PowerServiceNative as ILocalObject).GetObjectID);
  if not Assigned(Result) then
    raise Exception.Create('Could not access Power Manager');
end;

function AcquireWakeLock(var AWakeLock: JWakeLock): Boolean;
var
  PowerManager: JPowerManager;
begin
  Result := Assigned(AWakeLock);
  if not Result then
  begin
    PowerManager := GetPowerManager;
    AWakeLock := PowerManager.newWakeLock(
      TJPowerManager.JavaClass.SCREEN_BRIGHT_WAKE_LOCK,
      StringToJString('Delphi'));
    Result := Assigned(AWakeLock);
  end;
  if Result then
  begin
    if not AWakeLock.IsHeld then
    begin
      AWakeLock.acquire;
      Result := AWakeLock.isHeld
    end;
  end;
end;

procedure ReleaseWakeLock(var AWakeLock: JWakeLock);
begin
  if Assigned(AWakeLock) then
  begin
    AWakeLock.release;
    AWakeLock := nil
  end;
end;

end.
