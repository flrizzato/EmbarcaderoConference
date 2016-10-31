unit UsuarioUnit;

interface

type
  TEndereco = class
  private
    FCidade: string;
    FEstado: string;
  public
    property Cidade: string read FCidade write FCidade;
    property Estado: string read FEstado write FEstado;
  end;

  TUsuario = class
  private
    FEmail: string;
    FIdade: Integer;
    FNome: string;
    FEndereco: TEndereco;
  public
    constructor Create;
    destructor Destroy; override;
    property Nome: string read FNome write FNome;
    property Email: string read FEmail write FEmail;
    property Idade: Integer read FIdade write FIdade;
    property Endereco: TEndereco read FEndereco write FEndereco;
  end;

implementation

{ TUsuario }

constructor TUsuario.Create;
begin
  FEndereco := TEndereco.Create;
end;

destructor TUsuario.Destroy;
begin
  FEndereco.Free;
  inherited;
end;

end.
