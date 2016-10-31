unit uProduto;

interface

Type
  TProduto = class
  private
    FEstoqueAtual: Double;
    FdescricaoFiscal: string;
    FPrecoCusto: Double;
    FPrecoVenda: Double;
    FidProduto: integer;
    FNCM: String;
    FAliquota: Double;
    FcodigoBarra: string;
    FST: Integer;
    FUnidade: String;
    FReferencia: String;
    FOrigem: Integer;
    procedure SetAliquota(const Value: Double);
    procedure SetcodigoBarra(const Value: string);
    procedure SetdescricaoFiscal(const Value: string);
    procedure SetEstoqueAtual(const Value: Double);
    procedure SetidProduto(const Value: integer);
    procedure SetNCM(const Value: String);
    procedure SetOrigem(const Value: Integer);
    procedure SetPrecoCusto(const Value: Double);
    procedure SetPrecoVenda(const Value: Double);
    procedure SetReferencia(const Value: String);
    procedure SetST(const Value: Integer);
    procedure SetUnidade(const Value: String);
  published
    property idProduto : integer read FidProduto write SetidProduto;
    property Referencia : String read FReferencia write SetReferencia;
    property codigoBarra : string read FcodigoBarra write SetcodigoBarra;
    property descricaoFiscal : string read FdescricaoFiscal write SetdescricaoFiscal;
    property NCM : String read FNCM write SetNCM;
    property PrecoCusto : Double read FPrecoCusto write SetPrecoCusto;
    property PrecoVenda : Double read FPrecoVenda write SetPrecoVenda;
    property EstoqueAtual : Double read FEstoqueAtual write SetEstoqueAtual;
    property Unidade : String read FUnidade write SetUnidade;
    property Origem : Integer read FOrigem write SetOrigem;
    property ST : Integer read FST write SetST;
    property Aliquota : Double read FAliquota write SetAliquota;
  end;


implementation

{ TProduto }

procedure TProduto.SetAliquota(const Value: Double);
begin
  FAliquota := Value;
end;

procedure TProduto.SetcodigoBarra(const Value: string);
begin
  FcodigoBarra := Value;
end;

procedure TProduto.SetdescricaoFiscal(const Value: string);
begin
  FdescricaoFiscal := Value;
end;

procedure TProduto.SetEstoqueAtual(const Value: Double);
begin
  FEstoqueAtual := Value;
end;

procedure TProduto.SetidProduto(const Value: integer);
begin
  FidProduto := Value;
end;

procedure TProduto.SetNCM(const Value: String);
begin
  FNCM := Value;
end;

procedure TProduto.SetOrigem(const Value: Integer);
begin
  FOrigem := Value;
end;

procedure TProduto.SetPrecoCusto(const Value: Double);
begin
  FPrecoCusto := Value;
end;

procedure TProduto.SetPrecoVenda(const Value: Double);
begin
  FPrecoVenda := Value;
end;

procedure TProduto.SetReferencia(const Value: String);
begin
  FReferencia := Value;
end;

procedure TProduto.SetST(const Value: Integer);
begin
  FST := Value;
end;

procedure TProduto.SetUnidade(const Value: String);
begin
  FUnidade := Value;
end;

end.
