unit uEvent;

interface

uses
  System.Classes;

type
  TBrowserEvent = class(TComponent, IDispatch)
  private
    { Private declarations }
    FOnEvent : TNotifyEvent;
    FRefCount : integer;
    function QueryInterface( const IID : TGUID; out Obj) : Integer; stdcall;
    function _AddRef : Integer; stdcall;
    function _Release : Integer; stdcall;
    function Invoke( DispID : Integer; const IID : TGUID; LocaleID : Integer; Flags : Word; var Params; VarResult, ExcepInfo, ArgErr : Pointer) : HResult; stdcall;
  public
    { Public declarations }
    property OnEvent : TNotifyEvent read FOnEvent write FOnEvent;
  end;

implementation


{ TBrowserEvent }

function TBrowserEvent.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TBrowserEvent._AddRef: integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TBrowserEvent._Release: integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
end;

function TBrowserEvent.Invoke(DispID: integer; const IID: TGUID; LocaleID: integer; Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  if Assigned(OnEvent) then
    OnEvent(Self);
  Result := S_OK;
end;

end.
