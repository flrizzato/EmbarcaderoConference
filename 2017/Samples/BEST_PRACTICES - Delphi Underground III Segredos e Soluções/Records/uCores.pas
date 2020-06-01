unit uCores;

interface

type
  TCor = record
  public
    class operator Implicit(pValor: string): TCor;
    class operator Implicit(pValor: Cardinal): TCor;
    class operator Add(pCor1, pCor2: TCor): TCor;

    case Integer of
      0:
        (
          Cor: Cardinal;
        );
      1:
        (
          B: Byte;
          G: Byte;
          R: Byte;
          A: Byte;
        );
  end;

implementation


{ TCor }

class operator TCor.Implicit(pValor: string): TCor;
begin
  if pValor = 'verde' then
  begin
    Result.R := 0;
    Result.B := 0;
    Result.A := $FF;
    Result.G := $FF;
  end;
end;

class operator TCor.Add(pCor1, pCor2: TCor): TCor;
begin
  Result.B := Integer(pCor1.B + pCor2.B) div 2;
  Result.G := Integer(pCor1.G + pCor2.G) div 2;
  Result.R := Integer(pCor1.R + pCor2.R) div 2;
  Result.A := Integer(pCor1.A + pCor2.A) div 2;
end;

class operator TCor.Implicit(pValor: Cardinal): TCor;
begin
  Result.Cor := pValor;
end;

end.
