unit Layer.Business;

interface

type
  TCliente = class
  private
    FNome: string;
    FTelefone: string;
    FDataNascimento: TDateTime;
    FOID: string;
  public
    property Nome: string read FNome write FNome;
    property Telefone: string read FTelefone write FTelefone;
    property DataNascimento: TDateTime read FDataNascimento write FDataNascimento;
    function GetOID: string;
    constructor Create(ANome, ATelefone: string; ADataNascimento: TDateTime); overload;
    constructor Create(ANome, ATelefone: string; ADataNascimento: TDateTime; AOID: string); overload;
  end;

implementation

{ TCliente }

constructor TCliente.Create(ANome, ATelefone: string;
  ADataNascimento: TDateTime);
begin
  FNome := ANome;
  FTelefone := ATelefone;
  FDataNascimento := ADataNascimento;
end;

constructor TCliente.Create(ANome, ATelefone: string;
  ADataNascimento: TDateTime; AOID: string);
begin
  Create(ANome, ATelefone, ADataNascimento);
  FOID := AOID;
end;



function TCliente.GetOID: string;
begin
  Result := FOID;
end;

end.
