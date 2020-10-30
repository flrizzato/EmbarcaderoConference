unit uEmpresa;

interface

Type
  TEmpresa = class
  private
    FCNPJ: String;
    FEmail: String;
    FBairro: String;
    FIM: String;
    FUF: String;
    FCEP: String;
    FNumero: String;
    FIE: String;
    FMunicipio: String;
    FRazaoSocial: String;
    FCodigoUF: Integer;
    FComplemento: String;
    FCodigoMunicipio: Integer;
    FEndereco: String;
    FTelefone: String;
    FNomeFantasia: String;
    procedure SetBairro(const Value: String);
    procedure SetCEP(const Value: String);
    procedure SetCNPJ(const Value: String);
    procedure SetCodigoMunicipio(const Value: Integer);
    procedure SetCodigoUF(const Value: Integer);
    procedure SetComplemento(const Value: String);
    procedure SetEmail(const Value: String);
    procedure SetEndereco(const Value: String);
    procedure SetIE(const Value: String);
    procedure SetIM(const Value: String);
    procedure SetMunicipio(const Value: String);
    procedure SetNomeFantasia(const Value: String);
    procedure SetNumero(const Value: String);
    procedure SetRazaoSocial(const Value: String);
    procedure SetTelefone(const Value: String);
    procedure SetUF(const Value: String);
  published
    property RazaoSocial  : String read FRazaoSocial write SetRazaoSocial;
    property NomeFantasia : String read FNomeFantasia write SetNomeFantasia;
    property CNPJ : String read FCNPJ write SetCNPJ;
    property IE : String read FIE write SetIE;
    property IM : String read FIM write SetIM;
    property Endereco : String read FEndereco write SetEndereco;
    property Numero : String read FNumero write SetNumero;
    property Bairro : String read FBairro write SetBairro;
    property CEP : String read FCEP write SetCEP;
    property Complemento : String read FComplemento write SetComplemento;
    property UF : String read FUF write SetUF;
    property CodigoUF : Integer read FCodigoUF write SetCodigoUF;
    property Municipio : String read FMunicipio write SetMunicipio;
    property CodigoMunicipio : Integer read FCodigoMunicipio write SetCodigoMunicipio;
    property Email : String read FEmail write SetEmail;
    property Telefone : String read FTelefone write SetTelefone;
  end;

implementation

{ TEmpresa }

procedure TEmpresa.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TEmpresa.SetCEP(const Value: String);
begin
  FCEP := Value;
end;

procedure TEmpresa.SetCNPJ(const Value: String);
begin
  FCNPJ := Value;
end;

procedure TEmpresa.SetCodigoMunicipio(const Value: Integer);
begin
  FCodigoMunicipio := Value;
end;

procedure TEmpresa.SetCodigoUF(const Value: Integer);
begin
  FCodigoUF := Value;
end;

procedure TEmpresa.SetComplemento(const Value: String);
begin
  FComplemento := Value;
end;

procedure TEmpresa.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TEmpresa.SetEndereco(const Value: String);
begin
  FEndereco := Value;
end;

procedure TEmpresa.SetIE(const Value: String);
begin
  FIE := Value;
end;

procedure TEmpresa.SetIM(const Value: String);
begin
  FIM := Value;
end;

procedure TEmpresa.SetMunicipio(const Value: String);
begin
  FMunicipio := Value;
end;

procedure TEmpresa.SetNomeFantasia(const Value: String);
begin
  FNomeFantasia := Value;
end;

procedure TEmpresa.SetNumero(const Value: String);
begin
  FNumero := Value;
end;

procedure TEmpresa.SetRazaoSocial(const Value: String);
begin
  FRazaoSocial := Value;
end;

procedure TEmpresa.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

procedure TEmpresa.SetUF(const Value: String);
begin
  FUF := Value;
end;

end.
