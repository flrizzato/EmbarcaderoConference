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
  Mediator = class; //forward

  // Colleague (abstract)
  Colega = class abstract
    protected _mediator: Mediator;
    //Construtor
    public constructor Create (mediator: Mediator);
  end;

  // Concrete Colleague
  Suporte = class(Colega)
    public constructor Create(mediator: Mediator);
    public procedure Enviar(mensagem: string);
    public procedure Notificar(mensagem: string);
  end;

  // Concrete Colleague
  Usuario = class(Colega)
  public
    public constructor Create(mediator: Mediator);
    public procedure Enviar(mensagem: string);
    public procedure Notificar(mensagem: string);
  end;

  // Mediator
  Mediator = class abstract
    public procedure Enviar(mensagem: string; colega: Colega); virtual; abstract;
  end;

  // Concrete Mediator
  ConcreteMediator = class(Mediator)
    private _suporte: Suporte;
    private _usuario: Usuario;
    public property Suporte: Suporte write _suporte;
    public property Usuario: Usuario write _usuario;
    public procedure Enviar(mensagem: string; colega: Colega); override;
  end;

implementation

// Concrete Mediator
procedure ConcreteMediator.Enviar(mensagem: string; colega: Colega);
begin
  if colega = _usuario then
    _suporte.Notificar(mensagem)
  else
    _usuario.Notificar(mensagem);
end;

// Abstract Colleague (Colega)
constructor Colega.Create(mediator: Mediator);
begin
  self._mediator := mediator;
end;

// Concrete Colleague (Suporte)
constructor Suporte.Create(mediator: Mediator);
begin
  inherited Create(mediator);
end;

procedure Suporte.Enviar(mensagem: string);
begin
  _mediator.Enviar(mensagem, self);
end;

procedure Suporte.Notificar(mensagem: string);
begin
  WriteLn('Suporte recebeu a mensagem: ' + mensagem);
end;

// Concrete Colleague (Usuario)
constructor Usuario.Create(mediator: Mediator);
begin
  inherited Create(mediator);
end;

procedure Usuario.Enviar(mensagem: string);
begin
  _mediator.Enviar(mensagem, self);
end;

procedure Usuario.Notificar(mensagem: string);
begin
  WriteLn('Usuário recebeu a mensagem: ' + mensagem)
end;

end.

