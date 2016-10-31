unit uFuncoes;

interface

function ValidaCPF(pCPF : string): boolean;


implementation

function ValidaCPF(pCPF : string): boolean;
begin
  Result := Length(pCPF) = 11;
end;


end.
