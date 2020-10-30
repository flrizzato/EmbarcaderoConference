unit uValidador;

interface

type
  TValidador = class
    class function CPF(pCpf: string): boolean;
  end;


implementation

{ TValidador }

class function TValidador.CPF(pCpf: string): boolean;
begin
  Result := Length(pCPF) = 11;
end;

end.
