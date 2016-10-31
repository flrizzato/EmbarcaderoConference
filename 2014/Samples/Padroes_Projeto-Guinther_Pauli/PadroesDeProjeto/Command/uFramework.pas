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
  // Command
  Command = class abstract
    public procedure Execute(); virtual; abstract;
  end;

  // Invoker
  Formulario = class
    private _command: Command;
    public procedure setCommand(command: Command);
    public procedure ClickValidate();
  end;

  // Receiver
  Server = class
    public procedure ValidateUser();
  end;

  // ConcreteCommand
  ServerCommand = class(Command)
     private _server: Server;
     public constructor Create(server: Server);
     public procedure Execute(); override;
  end;

implementation

{ Formulario }

procedure Formulario.ClickValidate();
begin
  Writeln('Formulário - Iniciando validação do usuário');
  _command.Execute();
end;

procedure Formulario.setCommand(command: Command);
begin
  self._command := command;
end;

{ ServerCommand }

constructor ServerCommand.Create(server: Server);
begin
  self._server := server;
end;

procedure ServerCommand.Execute();
begin
  // delegando chamada a receiver
  _server.ValidateUser();
end;

{ Server }

procedure Server.ValidateUser();
begin
  Writeln('Servidor - Validando usuário');
end;

end.
