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

program CommandApp;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFramework in 'uFramework.pas';

var
  // receiver
  srv: Server;
  // invoker
  form: Formulario;
  // command
  cmd: Command;
begin
  // configura Receiver
  srv := Server.Create();
  // cria comando configurando o receiver
  cmd := ServerCommand.Create(srv);
  // configura o Invoker
  form := Formulario.Create();
  // configurar e executar o comando...
  form.setCommand(cmd);
  form.ClickValidate();
  ReadLn;
end.
