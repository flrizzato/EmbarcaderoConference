library HookDll;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes, Winapi.Windows, Winapi.Messages, Winapi.ShellApi;

{$R *.res}

type
  TStateResult = (srFailed, srOk, srAlready);


const
  HOOK_MSG=WM_USER+100;

var
  Fhook: HHOOK;
  FInstalled: Boolean;
  FHndWinHook: Integer;


function KeyboardProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  if nCode=HC_ACTION then
  begin
    if FHndWinHook <> 0 then
    begin
      PostMessage(FHndWinHook, HOOK_MSG, wParam, lParam);
    end;
  end;
  Result := CallNextHookEx(Fhook, nCode, wParam, lParam);
end;

function InstallHook(pHandle: Integer): integer;
begin
  FHndWinHook := pHandle;
  if FInstalled then
  begin
    Result:= ord(srAlready);
  end else begin
    Fhook:=SetWindowsHookEx(WH_KEYBOARD, @KeyboardProc, HInstance, 0);
    if Fhook <> 0 then
    begin
      Result:= ord(srOk);
      FInstalled:=True;
    end else begin
      Result:= ord(srFailed);
    end;
  end;
end;

function UninstallHook: Integer;
begin
  if FInstalled then
  begin
    Result:=Ord(UnhookWindowsHookEx(Fhook));
    if Result = ord(srOk) then
      FInstalled:=False;
  end else begin
    Result:= ord(srAlready)
  end;
end;

function IsHookInstalled: Boolean;
begin
  Result := FInstalled;
end;

exports
  InstallHook,
  UninstallHook,
  IsHookInstalled;

begin
  FInstalled:=False;
end.


