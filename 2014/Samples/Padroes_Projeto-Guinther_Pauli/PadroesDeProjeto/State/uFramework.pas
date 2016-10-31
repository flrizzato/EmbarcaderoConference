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

  Connection = class; // forward

  // State
  ConnectionState = class abstract
    public procedure Open(context: Connection); virtual; abstract;
    public procedure Close(context: Connection); virtual; abstract;
  end;

  // Concrete State
  ConnectionClosed = class(ConnectionState)
    public procedure Open(context: Connection); override;
    public procedure Close(context: Connection); override;
  end;

  // Concrete State
  ConnectionOpened = class(ConnectionState)
    public procedure Open(context: Connection); override;
    public procedure Close(context: Connection); override;
  end;

  // Context
  Connection = class
    private _state: ConnectionState;
    function getConnectionState: ConnectionState;
    procedure setConnectionState(const Value: ConnectionState);
    public constructor Create(state: ConnectionState);
    public property State: ConnectionState
      read getConnectionState write setConnectionState;
    public procedure Open();
    public procedure Close();
  end;

implementation

{ Connection }

procedure Connection.Close();
begin
  self._state.Close(self);
end;

constructor Connection.Create(state: ConnectionState);
begin
  self._state := state;
end;

function Connection.getConnectionState(): ConnectionState;
begin
  result := Self._state;
end;

procedure Connection.Open();
begin
  self._state.Open(self);
end;

procedure Connection.setConnectionState(
  const Value: ConnectionState);
begin
  self._state := Value;
  WriteLn('State: ' + _state.ClassType.ClassName);
end;

{ ConnectionClosed }

procedure ConnectionClosed.Close(context: Connection);
begin
  context.State := ConnectionClosed.Create();
end;

procedure ConnectionClosed.Open(context: Connection);
begin
  context.State := ConnectionOpened.Create();
end;

{ ConnectionOpened }

procedure ConnectionOpened.Close(context: Connection);
begin
  context.State := ConnectionClosed.Create();
end;

procedure ConnectionOpened.Open(context: Connection);
begin
  context.State := ConnectionOpened.Create();
end;

end.
