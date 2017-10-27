unit POO.Model.Log.Email;

interface

uses
  POO.Model.Interfaces, SysUtils;

Type
  TModelLogEmail = class(TInterfacedObject, iLog)
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

{ TModelLogEmail }

constructor TModelLogEmail.Create(Decorator : iLog);
begin
  FDecorator := Decorator;
end;

destructor TModelLogEmail.Destroy;
begin

  inherited;
end;

procedure TModelLogEmail.Gravar(Value, Arq: String);
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

function TModelLogEmail.Salvar(Value : String) : iLog;

begin
  FDecorator.Salvar(Value);
  Gravar(Value, 'LogEmail.txt');
end;

class function TModelLogEmail.New(Decorator : iLog) : iLog;
begin
  Result := Self.Create(Decorator);
end;

end.
