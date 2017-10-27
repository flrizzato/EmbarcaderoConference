unit POO.Model.Log.Factory;

interface

uses
  POO.Model.Interfaces, POO.Model.Log.Email, POO.Model.Log, POO.Model.Log.TXT,
  POO.Model.Log.BD;

Type
  TModelLogFactory = class(TInterfacedObject, iLogFactory)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iLogFactory;
      function Log : iLog;
      function LogTXT(Decorator : iLog) : iLog;
      function LogEmail(Decorator : iLog) : iLog;
      function LogBD(Decorator : iLog) : iLog;
  end;

implementation

{ TModelLogFactory }

constructor TModelLogFactory.Create;
begin

end;

destructor TModelLogFactory.Destroy;
begin

  inherited;
end;

function TModelLogFactory.Log: iLog;
begin
  Result := TModelLog.New;
end;

function TModelLogFactory.LogBD(Decorator: iLog): iLog;
begin
  Result := TModelLogBD.New(Decorator);
end;

function TModelLogFactory.LogEmail(Decorator : iLog) : iLog;
begin
  Result := TModelLogEmail.New(Decorator);
end;

function TModelLogFactory.LogTXT(Decorator : iLog) : iLog;
begin
  Result := TModelLogTXT.New(Decorator);
end;

class function TModelLogFactory.New: iLogFactory;
begin
  Result := Self.Create;
end;

end.
