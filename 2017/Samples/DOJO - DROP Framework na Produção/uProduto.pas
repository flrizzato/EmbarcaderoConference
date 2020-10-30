unit uProduto;

interface

uses AqDrop.DB.Base, AqDrop.DB.ORM.Attributes;

type
  [AqTable]
  TProduto = class(TAqDBObjectAutoID)
  private
    FNome: string;
    FValor: Currency;
  public
    property Nome: string read FNome write FNome;
    property Valor: Currency read FValor write FValor;
  end;

  TProdutos = class(TAqDBObjectManager<TProduto>);

implementation

end.
