{
Sobre o autor:
Guinther Pauli
Delphi Certified Professional - 3,5,6,7,2005,2006,Delphi Web,Kylix,XE
Microsoft Certified Professional - MCP,MCAD,MCSD.NET,MCTS,MCPD (C#, ASP.NET, Arquitetura)
Colaborador Editorial Revistas .net Magazine e ClubeDelphi
MVP (Most Valuable Professional) - Embarcadero Technologies - US
http://gpauli.com
http://www.facebook.com/guintherpauli
http://www.twitter.com/guintherpauli
http://br.linkedin.com/in/guintherpauli
}

unit uFramework;

interface

type
  // Subject
  ICalc = interface
    function Somar(x,y: integer): integer;
    function Subtrair(x,y: integer): integer;
    function Dividir(x,y: integer): integer;
    function Multiplicar(x,y: integer): integer;
  end;

  // RealSubject
  Calc = class(TInterfacedObject,ICalc)
    public function Somar(x,y: integer): integer;
    public function Subtrair(x,y: integer): integer;
    public function Dividir(x,y: integer): integer;
    public function Multiplicar(x,y: integer): integer;
  end;

  // Proxy
  CalcProxy = class(TInterfacedObject,ICalc)
    private _calc: Calc;
    public function Somar(x,y: integer): integer;
    public function Subtrair(x,y: integer): integer;
    public function Dividir(x,y: integer): integer;
    public function Multiplicar(x,y: integer): integer;
  end;

implementation

{ Calc }

function Calc.Dividir(x, y: integer): integer;
begin
 // considerando apenas inteiros
 result := trunc(x / y);
end;

function Calc.Multiplicar(x, y: integer): integer;
begin
  result := x * y;
end;

function Calc.Somar(x, y: integer): integer;
begin
  result := x + y;
end;

function Calc.Subtrair(x, y: integer): integer;
begin
  result := x - y;
end;

{ CalcProxy }

function CalcProxy.Dividir(x, y: integer): integer;
begin
  // instancia por demanda (lazy)
  if (_calc = nil) then
    _calc := Calc.Create();
  // repassando chamada ao RealSubject
  // Delegação
  result := _calc.Dividir(x, y);
end;

function CalcProxy.Multiplicar(x, y: integer): integer;
begin
  // instancia por demanda (lazy)
  if (_calc = nil) then
    _calc := Calc.Create();
  // repassando chamada ao RealSubject
  // Delegação
  result := _calc.Multiplicar(x, y);
end;

function CalcProxy.Somar(x, y: integer): integer;
begin
  // instancia por demanda (lazy)
  if (_calc = nil) then
    _calc := Calc.Create();
  // repassando chamada ao RealSubject
  // Delegação
  result := _calc.Somar(x, y);
end;

function CalcProxy.Subtrair(x, y: integer): integer;
begin
  // instancia por demanda (lazy)
  if (_calc = nil) then
   _calc := Calc.Create();
  // repassando chamada ao RealSubject
  // Delegação
  result := _calc.Subtrair(x, y);
end;

end.
