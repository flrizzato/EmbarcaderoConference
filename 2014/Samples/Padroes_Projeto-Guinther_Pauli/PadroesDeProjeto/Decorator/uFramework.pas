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
   // "Component"
  Component = class abstract
    public procedure Operation(); virtual; abstract;
  end;

  // "ConcreteComponent"
  ConcreteComponent = class (Component)
    public procedure Operation(); override;
    // + métodos
  end;

  // "Decorator"
  Decorator = class (Component)
    protected _component: Component;
    public procedure SetComponent(aComponent: Component);
    // método adicional você normalmente adicionaria
    // diretamente no concrete componente
    public procedure Operation(); override;
  end;

  // "ConcreteDecoratorA"
  ConcreteDecoratorA = class(Decorator)
    private addedState: string;
    public procedure Operation(); override;
  end;

  // "ConcreteDecoratorB"
  ConcreteDecoratorB = class(Decorator)
    private addedState: string;
    public procedure Operation(); override;
  end;

   // "ConcreteDecoratorC"
  ConcreteDecoratorC = class(Decorator)
    private addedState: string;
    public procedure Operation(); override;
  end;


implementation


{ ConcreteComponent }

procedure ConcreteComponent.Operation();
begin
  WriteLn('ConcreteComponent.Operation');
end;

{ Decorator }

procedure Decorator.Operation();
begin
  if (_component <> nil) then
    _component.Operation();
  // operação concreta...
  // + operação decorada, adicionada dinamicamente
end;

procedure Decorator.SetComponent(aComponent: Component);
begin
  self._component := aComponent;
end;

{ ConcreteDecoratorA }

procedure ConcreteDecoratorA.Operation();
begin
  inherited Operation();
  addedState := 'New State';
  WriteLn('ConcreteDecoratorA.Operation');
end;

{ ConcreteDecoratorB }

procedure ConcreteDecoratorB.Operation();
begin
  inherited Operation();
  addedState := 'New State';
  WriteLn('ConcreteDecoratorB.Operation');
end;

{ ConcreteDecoratorC }

procedure ConcreteDecoratorC.Operation();
begin
  inherited Operation();
  addedState := 'New State';
  WriteLn('ConcreteDecoratorC.Operation');
end;

end.
