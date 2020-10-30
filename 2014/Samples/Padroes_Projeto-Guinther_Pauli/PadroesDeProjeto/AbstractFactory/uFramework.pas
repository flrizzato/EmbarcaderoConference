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

  // Produto Abstrato (Abtract Product)
  DBCommand = class abstract
    public procedure Execute(); virtual; abstract;
  end;

  // Produto Abstrato (Abstract Product)
  DBConnection = class abstract
    public procedure Open(); virtual; abstract;
  end;

  // Fábrica Abstrata (Abstract Factory)
  DBFactory = class abstract
    public function createConnection(): DBConnection; virtual; abstract;
    public function createCommand(): DBCommand; virtual; abstract;
  end;

  // Produto Concreto (Concrete Product)
  OracleCommand = class(DBCommand)
    public procedure Execute(); override;
  end;

  // Produto Concreto (Concret Product)
  OracleConnection = class(DBConnection)
    public procedure Open(); override;
  end;

  // Produto Concreto (Concrete Product)
  SQLCommand = class(DBCommand)
    public procedure Execute(); override;
  end;

  // Produto Concreto (Concret Product)
  SQLConnection = class(DBConnection)
    public procedure Open(); override;
  end;

  // Fábrica Concreta (Concrete Fabric)
  OracleFactory = class(DBFactory)
    public function createConnection(): DBConnection; override;
    public function createCommand(): DBCommand; override;
  end;

  // Fábrica Concreta (Concrete Fabric)
  SQLFactory = class(DBFactory)
    public function createConnection(): DBConnection; override;
    public function createCommand(): DBCommand; override;
  end;

implementation

procedure OracleCommand.Execute();
begin
  WriteLn('Método Execute de OracleCommand foi chamado');
end;

procedure OracleConnection.Open();
begin
  WriteLn('Método Open de OracleConnection foi chamado');
end;

function OracleFactory.createCommand: DBCommand;
begin
  result := OracleCommand.Create();
end;

function OracleFactory.createConnection: DBConnection;
begin
  result := OracleConnection.Create();
end;

procedure SQLCommand.Execute;
begin
  WriteLn('Método Execute de SQLCommand foi chamado');
end;

procedure SQLConnection.Open;
begin
  WriteLn('Método Open de SQLConnection foi chamado');
end;

function SQLFactory.createCommand: DBCommand;
begin
  result := SQLCommand.Create();
end;

function SQLFactory.createConnection: DBConnection;
begin
  result := SQLConnection.Create();
end;

end.
