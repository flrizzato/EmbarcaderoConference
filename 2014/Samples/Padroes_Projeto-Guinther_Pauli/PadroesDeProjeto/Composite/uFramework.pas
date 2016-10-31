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

uses
  Generics.Collections;

type
  // Component
  Component =  class abstract
    protected _name: string;
    public procedure Add(c: Component); virtual; abstract;
    public procedure Remove(c: Component);virtual; abstract;
    public procedure Display(); virtual; abstract;
    constructor Create(name: string); virtual;
  end;

  // Composição
  Formulario = class (Component)
    private _childrens : TList<Component>;
    public procedure Add(c: Component); override;
    public procedure Remove(c: Component); override;
    public procedure Display(); override;
  end;

  // Leaf (folha)
  TextBox = class(Component)
    public procedure Add(c: Component); override;
    public procedure Remove(c: Component); override;
    public procedure Display(); override;
  end;

  // Leaf (folha)
  Button = class(Component)
    public procedure Add(c: Component); override;
    public procedure Remove(c: Component); override;
    public procedure Display(); override;
  end;

  // Leaf (folha)
  &Label = class(Component)
    public procedure Add(c: Component); override;
    public procedure Remove(c: Component); override;
    public procedure Display(); override;
  end;

  // Leaf (folha)
  Panel = class(Component)
    public procedure Add(c: Component); override;
    public procedure Remove(c: Component); override;
    public procedure Display(); override;
  end;


implementation

{ Component }

constructor Component.Create(name: string);
begin
  self._name := name;
end;

{ Formulario }

procedure Formulario.Add(c: Component);
begin
  if _childrens = nil then
     _childrens := TList<Component>.Create();
  _childrens.Add(c);
end;

procedure Formulario.Display();
var
  c: Component;
begin
  for c in _childrens do
     c.Display();
end;

procedure Formulario.Remove(c: Component);
begin
  _childrens.Remove(c);
end;

{ TextBox }

procedure TextBox.Add(c: Component);
begin
  // não adiciona pq não é composição
end;

procedure TextBox.Display();
begin
  WriteLn(_name);
end;

procedure TextBox.Remove(c: Component);
begin
  // não remove pq não é composição
end;

{ Button }

procedure Button.Add(c: Component);
begin
  // não adiciona pq não é composição
end;

procedure Button.Display();
begin
  WriteLn(_name);
end;

procedure Button.Remove(c: Component);
begin
  // não remove pq não é composição
end;

{ Label }

procedure &Label.Add(c: Component);
begin
  // não adiciona pq não é composição
end;

procedure &Label.Display();
begin
  WriteLn(_name);
end;

procedure &Label.Remove(c: Component);
begin
  // não remove pq não é composição
end;

{ Panel }

procedure Panel.Add(c: Component);
begin
  // não adiciona pq não é composição
end;

procedure Panel.Display();
begin
  WriteLn(_name);
end;

procedure Panel.Remove(c: Component);
begin
  // não remove pq não é composição
end;

end.
