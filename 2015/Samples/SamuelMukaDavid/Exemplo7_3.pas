unit Exemplo7_3;

interface

uses
  Exemplo7;

type
  TFichaUsuario = Class(TInterfacedObject, IFichaUsuario)
  private
    FCodigo: integer;
    FNome: string;
    FData: TDateTime;
    FCargo: string;
  protected
    function GetCodigo: integer;
    function GetNome: string;
    function GetData: TDateTime;
    function GetCargo: string;
  public
    property Codigo: Integer read GetCodigo write FCodigo;
    property Nome: string read GetNome write FNome;
    property Data: TDateTime read GetData write FData;
    property Cargo: string read GetCargo write FCargo;
  end;

implementation

{ TFichaUsuario }

function TFichaUsuario.GetCargo: string;
begin
  Result := FCargo;
end;

function TFichaUsuario.GetCodigo: integer;
begin
  Result := FCodigo;
end;

function TFichaUsuario.GetData: TDateTime;
begin
  Result := FData;
end;

function TFichaUsuario.GetNome: string;
begin
  Result := FNome;
end;

end.
