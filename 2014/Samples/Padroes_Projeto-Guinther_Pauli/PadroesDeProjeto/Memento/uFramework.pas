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
  // Memento
  Memento = class
    private _state: string;
    public constructor Create(state: string);
    property State: string read _state;
  end;

  // Originator
  Pessoa = class
    private _state: string;
    public property State: string read _state write _state;
    public function CreateMemento(): Memento;
    public procedure setMemento(memento: Memento);
  end;

  // Caretaker
  Caretaker = class
    private _memento: Memento;
    public property Memento: Memento read _memento write _memento;
  end;

implementation

// Pessoa
function Pessoa.CreateMemento(): Memento;
begin
  result := Memento.Create(_state);
end;

procedure Pessoa.setMemento(memento: Memento);
begin
  WriteLn('Restaurando o estado...');
  State := memento.State;
end;

constructor Memento.Create(state: string);
begin
  self._state := state;
end;

end.

