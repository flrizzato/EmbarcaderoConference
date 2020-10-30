unit lDeviceInfo;
interface
{$IFDEF IOS}
uses
  iOSapi.UIKit, iOSapi.Foundation, Macapi.Helpers;
{$ENDIF}
{$IFDEF ANDROID}
uses
  FMX.Platform.Android,
  Androidapi.JNI.JavaTypes,
  Androidapi.Helpers,
  Androidapi.JNI.Os;
{$ENDIF}

type
  TMobileDeviceInfo = class
  private
    {$IFDEF IOS}
    class var FDevice: UIDevice;
    {$ENDIF}
    class function GetDeviceType: string; static;
    class function GetOSName: string; static;
    class function GetOSVersion: string; static;
    class function GetDeviceID: string; static;
  public
    {$IFDEF IOS}
    class Constructor Create;
    {$ENDIF}
    class property DeviceID: string read GetDeviceID;
    class property DeviceType: string read GetDeviceType;
    class property OSName: string read GetOSName;
    class property OSVersion: string read GetOSVersion;
  end;

implementation

{$IFDEF ANDROID}
function GetCodename(VerString: string): string;
begin
  if VerString = '1.0' then
    Result := 'BASE'
  else if VerString = '1.1' then
    Result := 'BASE_1_1'
  else if VerString = '1.5' then
    Result := 'CUPCAKE'
  else if VerString = '1.6' then
    Result := 'DONUT'
  else if VerString = '2.0' then
    Result := 'ECLAIR'
  else if VerString = '2.0.1' then
    Result := 'ECLAIR_0_1'
  else if VerString = '2.1' then
    Result := 'ECLAIR_MR1'
  else if VerString = '2.2' then
    Result := 'FROYO'
  else if VerString = '2.3' then
    Result := 'GINGERBREAD'
  else if VerString = '2.3.3' then
    Result := 'GINGERBREAD_MR1'
  else if VerString = '3.0' then
    Result := 'HONEYCOMB'
  else if VerString = '3.1' then
    Result := 'HONEYCOMB_MR1'
  else if VerString = '3.2' then
    Result := 'HONEYCOMB_MR2'
  else if VerString = '4.0' then
    Result := 'ICE_CREAM_SANDWICH'
  else if VerString = '4.0.3' then
    Result := 'ICE_CREAM_SANDWICH_MR1'
  else if VerString = '4.1' then
    Result := 'JELLY_BEAN'
  else if VerString = '4.2' then
    Result := 'JELLY_BEAN_MR1'
  else if VerString = '4.3' then
    Result := 'JELLY_BEAN_MR2'
  else if Pos('4.4',VerString) = 1 then
    Result := 'KITKAT'
  else if Pos('5.',VerString) = 1 then
    Result := 'LOLLIPOP'
  else Result := 'UNKNOWN';
end;
{$ENDIF}

{ TMobileDeviceInfo }
{$IFDEF IOS}
class constructor TMobileDeviceInfo.Create;
begin
  FDevice:= TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
end;
{$ENDIF}

class function TMobileDeviceInfo.GetDeviceID: string;
{$IFDEF IOS}
var
  LDevice: UIDevice;
{$ENDIF}
begin
  {$IFDEF IOS}
  Result:= '';
  LDevice:= TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  if Assigned(LDevice) then
    Result:= NSStrToStr(LDevice.identifierForVendor.UUIDString);
  {$ENDIF}
  {$IFDEF ANDROID}
  result:= JStringToString(MainActivity.getDeviceID);
  {$ENDIF}
end;

class function TMobileDeviceInfo.GetDeviceType: string;
begin
  {$IFDEF ANDROID}
  result:= JStringToString(TJBuild.JavaClass.MODEL);
  {$ENDIF}
  {$IFDEF IOS}
  result:= NSStrToStr(FDevice.model);
  {$ENDIF}
end;

class function TMobileDeviceInfo.GetOSName: string;
begin
  {$IFDEF ANDROID}
  result:= 'Android';//GetCodename(JStringToString(TJBuild_VERSION.JavaClass.RELEASE));
  {$ENDIF}
  {$IFDEF IOS}
  result:= 'iOS';//NSStrToStr(FDevice.model);
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  result:= 'Windows';
  {$ENDIF}
end;

class function TMobileDeviceInfo.GetOSVersion: string;
begin
  {$IFDEF ANDROID}
  result:= JStringToString(TJBuild_VERSION.JavaClass.RELEASE);
  {$ENDIF}
  {$IFDEF IOS}
  result:= NSStrToStr(FDevice.systemName);
  {$ENDIF}
end;

end.
