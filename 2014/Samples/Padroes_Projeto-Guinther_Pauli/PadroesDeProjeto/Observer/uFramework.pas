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
  // Observer
  Observador = class abstract
    public procedure Update(); virtual; abstract;
  end;

  // Subject
  Observado = class abstract
    private _observadores: TList<Observador>;
    public procedure Attach(obs: Observador);
    public constructor Create();
    public destructor Destroy(); override;
    public procedure Notity();
  end;

  // Concrete Subject
  Balanco = class (Observado)
    // state é true se balanco está em andamento
    private _state: Boolean;
    public property State: boolean read _state write _state;
    public constructor Create();
    public procedure Iniciar();
    public procedure Finalizar();
  end;

  // Concrete Observer
  Venda = class (Observador)
    private _state: boolean;
    private _balanco: Balanco;
    public procedure Iniciar();
    public procedure Update(); override;
    public constructor Create(b: Balanco);
  end;

implementation

{ Subject }

procedure Observado.Attach(obs: Observador);
begin
  Self._observadores.Add(obs);
end;

constructor Observado.Create();
begin
  Self._observadores := TList<Observador>.Create();
end;

destructor Observado.Destroy();
begin
  Self._observadores.Free();
  inherited;
end;

procedure Observado.Notity();
var
  obs: Observador;
begin
  // broadcast (avisar todos os observadores)
  for obs in _observadores do
    obs.Update();
end;

{ Balanco }

constructor Balanco.Create();
begin
  inherited Create();
  Self._state := false;
end;

procedure Balanco.Finalizar();
begin
  _state := false;
  WriteLn('Balanço finalizado...');
  // notifica os observadores
  Notity();
end;

procedure Balanco.Iniciar();
begin
  _state := true;
  WriteLn('Balanço iniciado...');
  // notifica os observadores
  Notity();
end;

{ Venda }

constructor Venda.Create(b: Balanco);
begin
  self._balanco := b;
end;

procedure Venda.Iniciar();
begin
  // state = true se balanço foi iniciado
  if (not _state) then
    Writeln('Venda iniciada')
  else
    Writeln('Não pode iniciar venda pois balanço está em andamento');
end;

procedure Venda.Update();
begin
  _state := _balanco.State;
end;

end.
