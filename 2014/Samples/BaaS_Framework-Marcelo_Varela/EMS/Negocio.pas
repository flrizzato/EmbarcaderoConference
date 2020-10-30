unit Negocio;

interface

type
  TCliente = class
  private
    FNome: string;
    FCodigo: Integer;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    constructor Create(ACodigo: Integer; ANome: string);
  end;

implementation

{ TCliente }

constructor TCliente.Create(ACodigo: Integer; ANome: string);
begin
  FCodigo := ACodigo;
  FNome := ANome;
end;

end.
