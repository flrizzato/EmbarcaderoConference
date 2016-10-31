unit AqDrop.Core.Observable;

{$I 'AqDrop.Core.FullRTTIForMethods.inc'}

interface

uses
  System.Rtti,
  System.Classes,
  System.SysUtils,
  AqDrop.Core.Attributes,
  AQDrop.Core.Observer.Intf,
  AqDrop.Core.Observer,
  AqDrop.Core.Collections;

type
  AqNotifyObserversTag = class(TAqAttribute);

  TAqObservable = class
  strict private
    FObserversChannel: TAqObserversChannel;
    FUpdating: Boolean;

    class var FInterceptors: TAqDictionary<string, TVirtualMethodInterceptor>;
    class function GetInterceptor: TVirtualMethodInterceptor;
  strict protected
    procedure SetAndNotify<T>(var FDestiny: T; const pValue: T);
    procedure Notify; virtual;
  public
    class destructor Destroy;

    constructor Create;
    destructor Destroy; override;

    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;

    function RegisterObserver(const pObserverEvent: TNotifyEvent): TAqID; overload;
    function RegisterObserver(const pObserverMethod: TProc<TObject>): TAqID; overload;
    function RegisterObserver(pObserver: IAqObserver): TAqID; overload;
    procedure UnregisterObserver(const pObserverID: Int32);
  end;

implementation

uses
  AqDrop.Core.Collections.Intf, AqDrop.Core.Helpers.TRttiObject;

{ TAqObservable }

function TAqObservable.RegisterObserver(const pObserverEvent: TNotifyEvent): TAqID;
begin
  Result := FObserversChannel.RegisterObserver(TAqObserverByEvent.Create(pObserverEvent));
end;

function TAqObservable.RegisterObserver(const pObserverMethod: TProc<TObject>): TAqID;
begin
  Result := FObserversChannel.RegisterObserver(TAqObserverByMethod.Create(pObserverMethod));
end;

procedure TAqObservable.BeginUpdate;
begin
  FUpdating := True;
end;

constructor TAqObservable.Create;
begin
  inherited;

  FObserversChannel := TAqObserversChannel.Create;

  GetInterceptor.Proxify(Self);
end;

procedure TAqObservable.UnregisterObserver(const pObserverID: Int32);
begin
  FObserversChannel.UnregisterObserver(pObserverID);
end;

class destructor TAqObservable.Destroy;
begin
  FInterceptors.Free;
end;

destructor TAqObservable.Destroy;
begin
  GetInterceptor.Unproxify(Self);
  FObserversChannel.Free;

  inherited;
end;

procedure TAqObservable.EndUpdate;
begin
  if FUpdating then
  begin
    FUpdating := False;
    Notify;
  end;
end;

class function TAqObservable.GetInterceptor: TVirtualMethodInterceptor;
begin
  if not Assigned(FInterceptors) then
  begin
    FInterceptors := TAqDictionary<string, TVirtualMethodInterceptor>.Create([TAqDictionaryContent.adcValue]);
  end;

  if not FInterceptors.TryGetValue(Self.QualifiedClassName, Result) then
  begin
    Result := TVirtualMethodInterceptor.Create(Self);

    try
      Result.OnAfter :=
        procedure(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>; var Result: TValue)
        var
          lAttribute: AqNotifyObserversTag;
        begin
          if Method.GetAttribute<AqNotifyObserversTag>(lAttribute) then
          begin
            (Instance as Self).Notify;
          end;
        end;

      FInterceptors.Add(Self.QualifiedClassName, Result);
    except
      Result.Free;
      raise;
    end;
  end;
end;

procedure TAqObservable.Notify;
begin
  if not FUpdating then
  begin
    FObserversChannel.Notify(Self);
  end;
end;

procedure TAqObservable.SetAndNotify<T>(var FDestiny: T; const pValue: T);
begin
  FDestiny := pValue;
  Notify;
end;

function TAqObservable.RegisterObserver(pObserver: IAqObserver): TAqID;
begin
  Result := FObserversChannel.RegisterObserver(pObserver);
end;

end.
