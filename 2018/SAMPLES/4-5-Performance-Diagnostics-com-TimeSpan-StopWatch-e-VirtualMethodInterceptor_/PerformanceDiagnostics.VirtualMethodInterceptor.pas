unit PerformanceDiagnostics.VirtualMethodInterceptor;

interface

uses
  PerformanceDiagnostics.Interfaces, System.Rtti, System.Diagnostics, System.TimeSpan, System.SysUtils;

type
  TMethodProxy = class(TVirtualMethodInterceptor, IMethodProxy)
    strict private
    private
      [Volatile] FRefCount: Integer;
    protected
    public
      class function New(_AObject: TObject): IMethodProxy;
      {Interface Implementation}
      function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
      function _AddRef: Integer; stdcall;
      function _Release: Integer; stdcall;
  end;

  TMethodInterceptor = class(TInterfacedObject, IMethodInterceptor)
  strict private
    FProxy: IMethodProxy;
  private
  protected
  public
    constructor Create(_AObject: TObject; _ABefore: TInterceptBeforeNotify; _AAfter: TInterceptAfterNotify);
    class function New(_AObject: TObject; _ABefore: TInterceptBeforeNotify; _AAfter: TInterceptAfterNotify): IMethodInterceptor;
  end;

implementation

{ TMethodInterceptor }

constructor TMethodInterceptor.Create(_AObject: TObject; _ABefore: TInterceptBeforeNotify; _AAfter: TInterceptAfterNotify);
begin
  FProxy := TMethodProxy.New(_AObject);
  TVirtualMethodInterceptor(FProxy).OnBefore := _ABefore;
  TVirtualMethodInterceptor(FProxy).OnAfter := _AAfter;
  TVirtualMethodInterceptor(FProxy).Proxify(_AObject);
end;

class function TMethodInterceptor.New(_AObject: TObject; _ABefore: TInterceptBeforeNotify; _AAfter: TInterceptAfterNotify): IMethodInterceptor;
begin
  Result := TMethodInterceptor.Create(_AObject, _ABefore, _AAfter);
end;

{ TMethodProxy }

class function TMethodProxy.New(_AObject: TObject): IMethodProxy;
begin
  Result := TMethodProxy.Create(_AObject.ClassType);
end;

function TMethodProxy.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TMethodProxy._AddRef: Integer;
begin
  {$IFNDEF AUTOREFCOUNT}
    Result := AtomicIncrement(FRefCount);
  {$ELSE}
    Result := __ObjAddRef;
  {$ENDIF}
end;

function TMethodProxy._Release: Integer;
begin
  {$IFNDEF AUTOREFCOUNT}
    Result := AtomicDecrement(FRefCount);
    if Result = 0 then
      Destroy;
  {$ELSE}
    Result := __ObjRelease;
  {$ENDIF}
end;

end.
