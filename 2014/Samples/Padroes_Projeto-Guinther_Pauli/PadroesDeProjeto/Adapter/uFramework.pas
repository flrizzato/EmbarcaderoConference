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
  // Adaptee
  Adaptado = class
    // interface diferente de request
    public procedure Conectar();
  end;

  // Target
  Alvo = class
    public procedure Conectar(); virtual;
  end;

  // transforma Adaptee num Target...
  // Adapter
  Adaptador = class(Alvo)
    // composição simples
     private _adaptee: Adaptado;
     // delegação simples, repassa chamada ao adaptee
     public procedure Conectar(); override;
     constructor Create();
     destructor Destroy; override;
  end;

implementation

{ Adaptee }

procedure Adaptado.Conectar();
begin
  WriteLn('Método Conectar de Adaptee chamado');
end;

{ Target }

procedure Alvo.Conectar();
begin
   WriteLn('Método Conectar de Target chamado');
end;

{ Adapter }

procedure Adaptador.Conectar();
begin
  _adaptee.Conectar();
end;

constructor Adaptador.Create();
begin
  _adaptee := Adaptado.Create();
end;

destructor Adaptador.Destroy;
begin
  _adaptee.Free;
  inherited;
end;

end.
