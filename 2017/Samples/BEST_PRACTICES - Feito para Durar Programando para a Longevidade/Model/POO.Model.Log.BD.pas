unit POO.Model.Log.BD;

interface

uses
  POO.Model.Interfaces, SysUtils;

Type
  TModelLogBD = class(TInterfacedObject, iLog)
    private
      FDecorator : iLog;
    public
      constructor Create(Decorator : iLog);
      destructor Destroy; override;
      class function New(Decorator : iLog) : iLog;
      function Salvar(Value : String) : iLog;
      procedure Gravar(Value, Arq : String);
  end;

implementation

{ TModelLogBD }

constructor TModelLogBD.Create(Decorator : iLog);
begin
  FDecorator := Decorator;
end;

destructor TModelLogBD.Destroy;
begin

  inherited;
end;

procedure TModelLogBD.Gravar(Value, Arq: String);
var
  txtFile : TextFile;
begin
  AssignFile(txtFile, Arq);
  if FileExists(Arq) then
    Append(txtFile)
  else
    Rewrite(txtFile);
  Writeln(txtFile, Value);
  CloseFile(txtFile);
end;

function TModelLogBD.Salvar(Value : String) : iLog;

begin
  FDecorator.Salvar(Value);
  Gravar(Value, 'LogBD.txt');
end;

class function TModelLogBD.New(Decorator : iLog) : iLog;
begin
  Result := Self.Create(Decorator);
end;

end.
