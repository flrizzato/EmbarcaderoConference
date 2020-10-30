unit uUsuario;

interface

type
  TUsuario = class
  private
    FCodigo: integer;
    FNome: String;
    FData: TDateTime;
    FCargo: string;
  public
    property Codigo: integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Data: TDateTime read FData write FData;
    property Cargo: string read FCargo write FCargo;
  end;

implementation

end.
