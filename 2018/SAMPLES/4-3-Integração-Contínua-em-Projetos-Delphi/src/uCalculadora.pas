unit uCalculadora;

interface

type
  TCalculadora = class
  public
    function Somar(valor1, valor2: Integer): Integer;
    function Subtrair(valor1, valor2: Integer): Integer;
    function Multiplicar(valor1, valor2: Integer): Integer;
    function Dividir(valor1, valor2: Integer): Extended;
  end;

implementation

function TCalculadora.Somar(valor1, valor2: Integer): Integer;
begin
  result := valor1 + valor2;
end;

function TCalculadora.Subtrair(valor1, valor2: Integer): Integer;
begin
  result := valor1 - valor2;
end;

function TCalculadora.Multiplicar(valor1, valor2: Integer): Integer;
begin
  result := valor1 * valor2;
end;

function TCalculadora.Dividir(valor1, valor2: Integer): Extended;
begin
  if valor2 = 0 then
    result := 0
  else
    result := valor1 / valor2;
end;

end.
