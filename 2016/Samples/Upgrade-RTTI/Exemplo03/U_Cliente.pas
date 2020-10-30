unit U_Cliente;

interface

uses U_Atributos;

type
   [TNomeTabela('T_Clientes')]
   TCliente = class(TEntidade)
   private
      FCNPJ: String;
      FCodigo: Integer;
      FRazaoSocial: String;
      FValorUltimaVenda: Real;
      FTelefone: String;
      procedure SetCNPJ(const Value: String);
      procedure SetCodigo(const Value: Integer);
      procedure SetRazaoSocial(const Value: String);
      procedure SetTelefone(const Value: String);
      procedure SetValorUltimaVenda(const Value: Real);
   public
      [TNomeCampo('id')]
      property Codigo : Integer read FCodigo write SetCodigo;
      [TNomeCampo('razao_social')]
      property RazaoSocial : String read FRazaoSocial write SetRazaoSocial;
      [TNomeCampo('cnpj')]
      property CNPJ : String read FCNPJ write SetCNPJ;
      [TNomeCampo('telefone')]
      property Telefone : String read FTelefone write SetTelefone;
      [TNomeCampo('ultima_venda')]
      property ValorUltimaVenda : Real read FValorUltimaVenda write SetValorUltimaVenda;

   end;

implementation

{ TCliente }

procedure TCliente.SetCNPJ(const Value: String);
begin
   FCNPJ := Value;
end;

procedure TCliente.SetCodigo(const Value: Integer);
begin
   FCodigo := Value;
end;

procedure TCliente.SetRazaoSocial(const Value: String);
begin
   FRazaoSocial := Value;
end;

procedure TCliente.SetTelefone(const Value: String);
begin
   FTelefone := Value;
end;

procedure TCliente.SetValorUltimaVenda(const Value: Real);
begin
   FValorUltimaVenda := Value;
end;

end.
