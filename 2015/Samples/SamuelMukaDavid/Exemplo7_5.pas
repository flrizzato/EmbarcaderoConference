unit Exemplo7_5;

interface

uses
  Exemplo7_4, Exemplo7, System.SysUtils;

type
  TFichaAdministrador = class(TAdministrador, IFichaUsuario)
  public
    function GetCodigo: integer;
    function GetNome: String;
    function GetData: TDateTime;
    function GetCargo: string;
  end;


implementation

{ TFichaAdministrador }

function TFichaAdministrador.GetCargo: string;
begin
  result := Setor;
end;

function TFichaAdministrador.GetCodigo: integer;
begin
  result := Codigo;
end;

function TFichaAdministrador.GetData: TDateTime;
begin
  result := now;
end;

function TFichaAdministrador.GetNome: String;
begin
  result := Nome;
end;

end.
