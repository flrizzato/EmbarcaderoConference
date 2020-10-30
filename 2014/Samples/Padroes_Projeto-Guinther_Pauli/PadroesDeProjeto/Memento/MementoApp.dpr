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

program MementoApp;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  gp: Pessoa;
  c: Caretaker;
begin
  // cria originator
  gp := Pessoa.Create();
  gp.State := 'Guinther';
 // mostra estado original (criado)
  WriteLn('Estado original: ' + gp.State);
  // cria Caretaker
  c := Caretaker.Create();
  c.Memento := gp.CreateMemento();
  // trocando o estado...
  gp.State := 'Pauli';
  // mostra estado atual
  WriteLn('Estado atual: ' + gp.State);
  // restaurar o estado original
  gp.setMemento(c.Memento);
  // mostra estado atual
  WriteLn('Estado restaurado: ' + gp.State);
  ReadLn;
end.
