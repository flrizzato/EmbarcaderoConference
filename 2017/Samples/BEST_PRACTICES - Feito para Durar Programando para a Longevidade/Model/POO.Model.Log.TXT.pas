unit POO.Model.Log.TXT;

interface

uses
  POO.Model.Interfaces, SysUtils;

Type
  TModelLogTXT = class(TInterfacedObject, iLog)
    private
      FDecorator : iLog;
    public
      constructor Create(Decorator : iLog);
      destructor Destroy; override;
      class function New(Decorator : iLog) : iLog;
      function Salvar(Value : String) : iLog;
      procedure Gravar(Value, Arq: String);
  end;

implementation

{ TModelLogTXT }

constructor TModelLogTXT.Create(Decorator : iLog);
begin
  FDecorator := Decorator;
end;

destructor TModelLogTXT.Destroy;
begin

  inherited;
end;

procedure TModelLogTXT.Gravar(Value, Arq: String);
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

function TModelLogTXT.Salvar(Value : String) : iLog;
var
  txtFile : TextFile;
begin
  FDecorator.Salvar(Value);
  Gravar(Value, 'LogTXT.txt');
end;

class function TModelLogTXT.New(Decorator : iLog) : iLog;
begin
  Result := Self.Create(Decorator);
end;

end.
