unit ServerMethodsUnit;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth, System.SyncObjs;

type
{$METHODINFO ON}
  TServerMethods = class(TComponent)
  private
    // class vars - área de memória compartilhada entre as threads
    class var FCriticalSection: TCriticalSection;
    class var FContagemGeral: Int64;
  public
    class constructor Create;
    class destructor Destroy;
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;

    function GetThreadID: Int64;

    function GetContagemGeral: Int64;
  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils;

class constructor TServerMethods.Create;
begin
  FCriticalSection := TCriticalSection.Create;
end;

class destructor TServerMethods.Destroy;
begin
  FCriticalSection.Free;
end;

function TServerMethods.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods.GetContagemGeral: Int64;
begin
  // região crítica garante a correta atualização da variável compartilhada
  // (remove o paralelismo)
  FCriticalSection.Enter;

  try
    Inc(FContagemGeral);
    Result := FContagemGeral;
  finally
    FCriticalSection.Leave;
  end;
end;

function TServerMethods.GetThreadID: Int64;
begin
  // o sleep força uma parada na thread para que uma segunda chamada,
  // durante o sleep, gere a criação de uma nova thread
  Sleep(5000);

  Result := TThread.CurrentThread.ThreadID;
end;

function TServerMethods.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;
end.

