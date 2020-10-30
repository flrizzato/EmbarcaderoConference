unit uTransactionAspect;

interface

uses
  System.Classes, System.SysUtils, System.Rtti, Aspect4D;

type
  TTransactionAspect = class(TAspect, IAspect)
  private
    FStrings: TStrings;
    function DeveAplicarAspecto(const method: TRttiMethod): boolean;
  public
    constructor Create(const AString: TStrings); reintroduce;
    procedure DoAfter(instance: TObject; method: TRttiMethod;
      const args: System.TArray<System.Rtti.TValue>; var result: TValue);
    procedure DoBefore(instance: TObject; method: TRttiMethod;
      const args: System.TArray<System.Rtti.TValue>; out invoke: boolean; out result: TValue);
    procedure DoException(instance: TObject; method: TRttiMethod;
      const args: System.TArray<System.Rtti.TValue>; out raiseException: boolean;
      theException: Exception; out result: TValue);
    function GetName: string;
  end;

implementation

constructor TTransactionAspect.Create(const AString: TStrings);
begin
  FStrings := AString;
end;

function TTransactionAspect.GetName: string;
begin
  result := QualifiedClassName;
end;

function TTransactionAspect.DeveAplicarAspecto(const method: TRttiMethod): boolean;
begin
  result := method.Name.ToUpper.Equals('POST');
end;

procedure TTransactionAspect.DoAfter(instance: TObject; method: TRttiMethod;
  const args: System.TArray<System.Rtti.TValue>; var result: TValue);
begin
  if DeveAplicarAspecto(method) then
    FStrings.Add('Finalizando transação');
end;

procedure TTransactionAspect.DoBefore(instance: TObject; method: TRttiMethod;
  const args: System.TArray<System.Rtti.TValue>; out invoke: boolean; out result: TValue);
begin
  if DeveAplicarAspecto(method) then
    FStrings.Add('Iniciando transação');
end;

procedure TTransactionAspect.DoException(instance: TObject; method: TRttiMethod;
  const args: System.TArray<System.Rtti.TValue>; out raiseException: boolean;
  theException: Exception; out result: TValue);
begin
  if DeveAplicarAspecto(method) then
    FStrings.Add('Erro durante processamento. Finalizando transação');
end;


end.
