unit uHandleUtils;

interface

uses
  Winapi.Windows, System.SysUtils, Vcl.Graphics;

type
  THandleUtils = class
  private
    class function GetPointerWinControl(Wnd: HWND; out ProcessId: Cardinal): Pointer;
  public
    class procedure DestacarHandle(pHandle: THandle); static;
    class function GetNameWinControl(Wnd: HWND): string;
  end;

implementation

class function THandleUtils.GetPointerWinControl(Wnd: HWND; out ProcessId: Cardinal): Pointer;
var
  WindowAtomString: String;
  WindowAtom: ATOM;
  lProcessId: Cardinal;
  lTexto: array [0..255] of Ansichar;
begin
  Result := nil;

  lProcessId := 0;

  if GetWindowThreadProcessId(Wnd, lProcessId) <> 0 then
  begin
    ProcessId := lProcessId;
    WindowAtomString := Format('Delphi%.8X',[ProcessID]);
    WindowAtom := GlobalFindAtom(PChar(WindowAtomString));
    if WindowAtom <> 0 then
    begin
      Result := Pointer(GetProp(Wnd, MakeIntAtom(WindowAtom)));
      GlobalGetAtomNameA(WindowAtom,lTexto,SizeOf(lTexto));
    end;
  end;
end;


class function THandleUtils.GetNameWinControl(Wnd: HWND): string;
var
  lProcessId: Cardinal;
  lObjSelf: Pointer;
  lBuf: Pointer;
  lbytes: NativeUInt;
  ldestProcess: THandle;
  lErro: boolean;
begin
  lObjSelf := GetPointerWinControl(Wnd, lProcessId);
  result := '';

  if lObjSelf <> nil then
  begin
    ldestProcess := OpenProcess(PROCESS_VM_READ, TRUE, lProcessId);
    lErro := ldestProcess = 0;

    try
      GetMem(lBuf, 256);
      try
        lErro := lErro or not ReadProcessMemory(ldestProcess, Pointer(Cardinal(lObjSelf) + 8), lBuf, 4, lbytes);
        lErro := lErro or not ReadProcessMemory(ldestProcess, Pointer(Cardinal(lBuf^)), lBuf, 256, lbytes);

        if not lErro then
        begin
          Result := PChar(lBuf);
        end;
      finally
        FreeMem(lBuf);
      end;
    finally
      CloseHandle(ldestProcess);
    end;
  end;
end;

class procedure  THandleUtils.DestacarHandle(pHandle: THandle);
var
  lRect: TRect;
  lHdc: HDC;
  lPen: HPEN;
begin
  Winapi.Windows.GetClientRect(pHandle,lRect);

  lHdc := GetDC(pHandle);

  lPen := CreatePen(PS_SOLID, 2, ColorToRGB(clRed));
  try
    lPen := SelectObject(lHdc, lPen);
    Winapi.Windows.MoveToEx(lHdc, lRect.Left, lRect.Top, nil);
    Winapi.Windows.LineTo(lHdc, lRect.Right-1, lRect.Top);
    Winapi.Windows.LineTo(lHdc, lRect.Right-1, lRect.Bottom-1);
    Winapi.Windows.LineTo(lHdc, lRect.Left, lRect.Bottom-1);
    Winapi.Windows.LineTo(lHdc, lRect.Left, lRect.Top);
  finally
    DeleteObject(lPen); //delete our pen
  end;
end;

end.
