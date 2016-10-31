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

program VisitorApp;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  o: ObjectStructure;
  v1: ConcreteVisitor1;
  v2: ConcreteVisitor2;
begin
  // configura estrutura
  o := ObjectStructure.Create();
  o.Attach(ConcreteElementA.Create());
  o.Attach(ConcreteElementB.Create());
  // Criando visitors
  v1 := ConcreteVisitor1.Create();
  v2 := ConcreteVisitor2.Create();
  // estrutura aceitando visitors
  o.Accept(v1);
  o.Accept(v2);
  // wait
  Readln;
end.
