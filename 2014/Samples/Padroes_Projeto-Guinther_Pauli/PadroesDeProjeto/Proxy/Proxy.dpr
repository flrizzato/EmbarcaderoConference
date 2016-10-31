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

program Proxy;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  c: ICalc; // programe para uma interface/abstração
  r: integer;
begin
  c := CalcProxy.Create();
  r := c.Somar(3,5);
  Writeln(IntToStr(r));
  r := c.Multiplicar(5,4);
  Writeln(IntToStr(r));
  r := c.Subtrair(10,3);
  Writeln(IntToStr(r));
  r := c.Dividir(9,3);
  Writeln(IntToStr(r));
  Readln;
 end.
