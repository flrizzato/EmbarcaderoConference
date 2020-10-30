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

program Decorator;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  c: ConcreteComponent;
  d1: ConcreteDecoratorA;
  d2: ConcreteDecoratorB;
  d3: ConcreteDecoratorC;
begin
  // Cria Concrete Components
  c := ConcreteComponent.Create();
  // Cria 3 Decorators
  d1 := ConcreteDecoratorA.Create();
  d2 := ConcreteDecoratorB.Create();
  d3 := ConcreteDecoratorC.Create();
  // Linka decorators
  d1.SetComponent(c);
  d2.SetComponent(c);
  d3.SetComponent(c);
  // chama método decorados que invocam
  // método base de component
  // injetando código em componente sem modificar
  d1.Operation();
  d2.Operation();
  d3.Operation();
  // Wait for user
  Readln;
end.
