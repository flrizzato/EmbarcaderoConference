unit Lib.AndroidUtils;
interface
uses
  System.SysUtils,
  FMX.Platform, FMX.Virtualkeyboard, FMX.Types,
  FMX.Helpers.Android, Androidapi.Helpers, Androidapi.JNI.JavaTypes,
  Androidapi.JNI.GraphicsContentViewText;

type
  TKeyboardService = class
  private
    class var FKBService: IFMXVirtualKeyboardService;
    class procedure InitializeService;
  public
    class function IsKeyboardVisible: boolean;
    class procedure ShowKeyboard(AControl: TFMXObject);
    class procedure Hidekeyboard;
  end;

function HasPermission(const Permission: string): Boolean;

implementation

function HasPermission(const Permission: string): Boolean;
begin
  //Permissions listed at http://d.android.com/reference/android/Manifest.permission.html
  Result:=
  {$IF RTLVersion >= 30}
    TAndroidHelper.Context.checkCallingOrSelfPermission
  {$ELSE}
    SharedActivityContext.checkCallingOrSelfPermission
  {$ENDIF}
    (StringToJString(Permission)) =
    TJPackageManager.JavaClass.PERMISSION_GRANTED
end;

{ TKeyboardService }
class procedure TKeyboardService.InitializeService;
begin
  if not assigned(FKBService) then
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FKBService));
end;

class function TKeyboardService.IsKeyboardVisible: boolean;
begin
  InitializeService;
  result:= (TVirtualKeyboardState.Visible in FKBService.VirtualKeyboardState);
end;

class procedure TKeyboardService.Hidekeyboard;
begin
  InitializeService;
  FKBService.HideVirtualKeyboard;
end;

class procedure TKeyboardService.ShowKeyboard(AControl: TFMXObject);
begin
  InitializeService;
  FKBService.ShowVirtualKeyboard(AControl);
end;

end.

