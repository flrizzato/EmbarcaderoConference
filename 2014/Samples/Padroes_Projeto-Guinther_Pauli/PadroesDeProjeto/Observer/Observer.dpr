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

program Observer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  b: Balanco;
  v: Venda;
begin
  // Concrete Subject
  b := Balanco.Create();
  // Concrete Observer
  v := Venda.Create(b);
  // adicionar os observadores
  b.Attach(v);
  // processo...
  b.Iniciar();
  b.Finalizar(); // comentar essa linha para testar
  // pode vender?
  v.Iniciar();
  Readln;
end.
