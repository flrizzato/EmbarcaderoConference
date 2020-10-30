unit POO.Model.Log;

interface

uses
  POO.Model.Interfaces;

Type
  TModelLog = class(TInterfacedObject, iLog)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iLog;
      function Salvar(Value : String) : iLog;
  end;

implementation

{ TModelLog }

constructor TModelLog.Create;
begin

end;

destructor TModelLog.Destroy;
begin

  inherited;
end;

class function TModelLog.New: iLog;
begin
  Result := Self.Create;
end;

function TModelLog.Salvar(Value: String): iLog;
begin
  Result := Self;
end;

end.
