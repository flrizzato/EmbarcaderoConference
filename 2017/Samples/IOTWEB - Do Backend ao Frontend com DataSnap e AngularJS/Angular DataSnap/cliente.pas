unit cliente;

interface

type
  TCliente = class
  private
    FEmail: String;
    FNome: String;
    procedure SetEmail(const Value: String);
    procedure SetNome(const Value: String);
  published
    property Nome: String read FNome write SetNome;
    property Email: String read FEmail write SetEmail;
  end;

implementation

{ TCliente }

procedure TCliente.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TCliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.
