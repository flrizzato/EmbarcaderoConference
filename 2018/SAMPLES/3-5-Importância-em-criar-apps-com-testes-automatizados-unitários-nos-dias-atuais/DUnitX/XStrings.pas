unit XStrings;

interface

uses
  System.SysUtils;

type
  TXStrings = class
  public
    function SomenteNumeros(AValue: String): String;
//    procedure ExemploMetodoComExcecao;
  end;

implementation

{ TTratamentoStrins }

function TXStrings.SomenteNumeros(AValue: String): String;
var
  I: Integer;
  Erro: String;
begin
  Result := '';
  Erro := 'AAA';

  for I := 1 to Length(AValue) do
  begin
    if AValue[I] in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'] then
    begin
      Result := Result + AValue[I];
    end;
  end;

  Result := Result + Erro;
end;

//procedure TXStrings.ExemploMetodoComExcecao;
//begin
//  raise Exception.Create('Exception de teste!');
//end;

end.
