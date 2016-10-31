unit uFibonacci;

interface

type
  TFibonacci = class
  public
    class function GetEnesimoNumero(const pN: Word): Cardinal;
  end;

implementation

{ TFibonacci }

class function TFibonacci.GetEnesimoNumero(const pN: Word): Cardinal;
begin
  case pN of
    0:
      Result := 0;
    1:
      Result := 1;
  else
    Result := GetEnesimoNumero(pN - 1) + GetEnesimoNumero(pN - 2);
  end;
end;

end.
