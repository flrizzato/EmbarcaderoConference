unit WinProcessHelpers;

interface

uses
  Classes, Windows, Messages;

procedure ActivateWindow (aWindowClass: TClass);

var
  hMutex: THandle;

implementation

var
 ModuleName: string;
 FoundWnd: THandle;
 MainWindowClass: TClass;

function EnumWndProc(hwnd: THandle;
  Param: Cardinal): Bool; stdcall;
var
  ClassName, WinModuleName: string;
  WinInstance: THandle;
begin
  Result := True;
  SetLength(ClassName, 1024);
  GetClassName(hwnd, PChar(ClassName), Length(ClassName));
  ClassName := PChar(ClassName);
  if ClassName = MainWindowClass.ClassName then
  begin
    // get the module name of the target window
    SetLength(WinModuleName, 1024);
    WinInstance := GetWindowLong(hwnd, GWL_HINSTANCE);
    GetModuleFileName(WinInstance,
      PChar(WinModuleName), Length(WinModuleName));
    WinModuleName := PChar(WinModuleName); // adjust length

    // compare module names
    if WinModuleName = ModuleName then
    begin
      FoundWnd := Hwnd;
      Result := False; // stop enumeration
    end;
  end;
end;

procedure ActivateWindow (aWindowClass: TClass);
var
  cds: CopyDataStruct;
  fFileName: string;
  i: integer;
begin
MainWindowClass := aWindowClass;

  // get the current module name
  SetLength(ModuleName, 1024);
  GetModuleFileName(HInstance,
    PChar(ModuleName), Length(ModuleName));
  ModuleName := PChar(ModuleName); // adjust length

  // find window of previous instance
  EnumWindows(@EnumWndProc, 0);
  if FoundWnd <> 0 then
  begin
    // show the window, eventually
    if not IsWindowVisible(FoundWnd) then
      PostMessage(FoundWnd, wm_User, 0, 0);
    SetForegroundWindow(FoundWnd);

    // grab the file name(s) from the command line parameters
    for i := 1 to ParamCount do
    begin
      fFileName := ParamStr(i);
      // prepare the data to copy
      cds.dwData := 0;
      cds.cbData := (length(fFileName) + 1) * 2;
      cds.lpData := PChar(fFileName);
      // send the data
      SendMessage(FoundWnd, wm_CopyData, 0, Integer(@cds));
    end;
  end;
end;

end.

