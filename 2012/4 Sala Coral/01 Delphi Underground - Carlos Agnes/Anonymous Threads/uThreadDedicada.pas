unit uThreadDedicada;

interface

uses
  System.Classes;

type
  TThreadFibonacciDedicada = class(TThread)
  strict private
    FN: Word;
  protected
    procedure Execute; override;
  public
    constructor Create(const pN: Word);
  end;

implementation

uses
  uFibonacci;

constructor TThreadFibonacciDedicada.Create(const pN: Word);
begin
  inherited Create(False);
  Assert(pN >= 2);
  FN := pN;
end;

procedure TThreadFibonacciDedicada.Execute;
begin
  inherited;
  ReturnValue := TFibonacci.GetEnesimoNumero(FN - 1) +
    TFibonacci.GetEnesimoNumero(FN - 2);
end;

end.
