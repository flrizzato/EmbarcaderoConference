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

program Bridge;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  ab: Abstraction; // Programção para uma interface
begin
   ab := RefinedAbstraction.Create();
   // Configura implementador e faz chamada de operação
   ab.Implementor := ConcreteImplementorA.Create();
   ab.Operation();
   // Troca implementador e faz chamada de operação
   ab.Implementor := ConcreteImplementorB.Create();
   ab.Operation();
   // Troca implementador e faz chamada de operação
   ab.Implementor := ConcreteImplementorC.Create();
   ab.Operation();
   Readln;
end.
