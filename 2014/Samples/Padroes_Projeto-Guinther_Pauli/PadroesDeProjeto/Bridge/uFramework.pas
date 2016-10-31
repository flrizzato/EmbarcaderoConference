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

  // "Implementor"
  Implementor = class abstract
    public procedure Operation(); virtual; abstract;
  end;

  // "Abstraction"
  Abstraction = class
  private
    procedure setImplementor(const Value: Implementor);
    protected _implementor: Implementor;
    public property Implementor: Implementor write setImplementor;
    public procedure Operation(); virtual;
  end;

  // "RefinedAbstraction"
  RefinedAbstraction = class(Abstraction)
    public procedure Operation(); override;
  end;

  // "ConcreteImplementorA"
  ConcreteImplementorA = class(Implementor)
    public procedure Operation(); override;
  end;

  // "ConcreteImplementorB"
  ConcreteImplementorB = class(Implementor)
    public procedure Operation(); override;
  end;

  // "ConcreteImplementorC"
  ConcreteImplementorC = class(Implementor)
    public procedure Operation(); override;
  end;

implementation

{ Abstraction }

procedure Abstraction.Operation();
begin
  // implementação por delegação
  _implementor.Operation();
end;

procedure Abstraction.setImplementor(const Value: Implementor);
begin
  self._implementor := Value;
end;

{ RefinedAbstraction }

procedure RefinedAbstraction.Operation();
begin
  // implementação por delegação
  self._implementor.Operation();
end;

{ ConcreteImplementorB }

procedure ConcreteImplementorB.Operation();
begin
  Writeln('Operação de Implementador Concreto B chamado');
end;

{ ConcreteImplementorA }

procedure ConcreteImplementorA.Operation();
begin
  Writeln('Operação de Implementador Concreto A chamado');
end;

{ ConcreteImplementorC }

procedure ConcreteImplementorC.Operation;
begin
  Writeln('Operação de Implementador Concreto C chamado');
end;

end.
