unit DC2013.Remoto.OlaMundo;

interface

uses
  System.Classes;

type

{$METHODINFO ON}
  TOlaMundo = class(TComponent)
  public
    function OlaMundo: string;
  end;
{$METHODINFO OFF}

function ClassesRemotas: TArray<TPersistentClass>; export;

exports ClassesRemotas;

implementation

uses
  DC2013.OlaMundo.OlaMundo;

function ClassesRemotas: TArray<TPersistentClass>;
begin
  Result := TArray<TPersistentClass>.Create(TOlaMundo);
end;

{ TOlaMundo }

function TOlaMundo.OlaMundo: string;
begin
  Result := DC2013.OlaMundo.OlaMundo.GerarOlaMundo;
end;

end.
