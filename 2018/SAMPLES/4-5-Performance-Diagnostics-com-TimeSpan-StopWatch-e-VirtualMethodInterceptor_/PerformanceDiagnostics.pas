unit PerformanceDiagnostics;

interface

uses
  PerformanceDiagnostics.Interfaces, System.Rtti, System.Diagnostics, System.TimeSpan, System.SysUtils, System.Generics.Collections, PerformanceDiagnostics.VirtualMethodInterceptor;

type
  TInterceptedList = TObjectDictionary<string,TStopwatch>;

  TPerformanceDiagnostics = class(TInterfacedObject, IPerformanceDiagnostics)
    strict private
      FInterceptor: IMethodInterceptor;
      FInterceptedList: TInterceptedList;
    private
      procedure DoOnBefore(_AInstance: TObject; _AMethod: TRttiMethod; const _AArgs: TArray<TValue>; out _ADoInvoke: Boolean; out _AResult: TValue);
      procedure DoOnAfter(_AInstance: TObject; _AMethod: TRttiMethod; const _AArgs: TArray<TValue>; var _AResult: TValue);
      function GetInterceptedList: TInterceptedList;
    protected
      property List: TInterceptedList read GetInterceptedList;

      function Add(_AMethodName: string): IPerformanceDiagnostics;
      function GetTotalSeconds: Double;
      function GetTotalMiliseconds: Double;

      constructor Create(_AObject: TObject);
    public
      class function New(_AObject: TObject): IPerformanceDiagnostics;
      destructor Destroy; override;
  end;

implementation

{ TPerformanceDiagnostics }

function TPerformanceDiagnostics.Add(_AMethodName: string): IPerformanceDiagnostics;
begin
  List.Add(_AMethodName, Default(TStopwatch));
  Result := Self;
end;

constructor TPerformanceDiagnostics.Create(_AObject: TObject);
begin
  FInterceptor := TMethodInterceptor.New(_AObject, DoOnBefore, DoOnAfter);
end;

destructor TPerformanceDiagnostics.Destroy;
begin
  FInterceptedList.Free;
  inherited;
end;

procedure TPerformanceDiagnostics.DoOnAfter(_AInstance: TObject; _AMethod: TRttiMethod; const _AArgs: TArray<TValue>; var _AResult: TValue);
begin
  if List.ContainsKey(_AMethod.Name) then
    List.Items[_AMethod.Name].Stop;
end;

procedure TPerformanceDiagnostics.DoOnBefore(_AInstance: TObject; _AMethod: TRttiMethod; const _AArgs: TArray<TValue>; out _ADoInvoke: Boolean;
  out _AResult: TValue);
begin
  if List.ContainsKey(_AMethod.Name) then
    List.Items[_AMethod.Name] := TStopwatch.StartNew;
end;

function TPerformanceDiagnostics.GetInterceptedList: TInterceptedList;
begin
  if (not Assigned(FInterceptedList)) then
    FInterceptedList := TInterceptedList.Create();

  Result := FInterceptedList;
end;

function TPerformanceDiagnostics.GetTotalMiliseconds: Double;
var
  ATimeSpan: TTimeSpan;
  AStopWatch: TStopwatch;
begin
  ATimeSpan := TTimeSpan.Zero;
  for AStopWatch in List.Values do
    ATimeSpan := ATimeSpan.Add(AStopWatch.Elapsed);
  Result := ATimeSpan.TotalMilliseconds;
end;

function TPerformanceDiagnostics.GetTotalSeconds: Double;
var
  ATimeSpan: TTimeSpan;
  AStopWatch: TStopwatch;
begin
  ATimeSpan := TTimeSpan.Zero;
  for AStopWatch in List.Values do
    ATimeSpan := ATimeSpan.Add(AStopWatch.Elapsed);
  Result := ATimeSpan.TotalSeconds;
end;

class function TPerformanceDiagnostics.New(_AObject: TObject): IPerformanceDiagnostics;
begin
  Result := TPerformanceDiagnostics.Create(_AObject);
end;

end.
