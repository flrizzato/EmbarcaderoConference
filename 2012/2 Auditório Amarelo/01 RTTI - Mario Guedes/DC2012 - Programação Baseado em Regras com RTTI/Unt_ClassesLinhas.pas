{ ============================================================================ }
{ DELPHI CONFERENCE 2012 - 23/10/2012                                          }
{ José Mário Silva Guedes - mario.guedes@arrayof.com.br                        }
{                                                                              }
{ Propósito: Concentra as classes descendentes de TLinhaBase.                  }
{            Cada classe representa uma linha do layoute hipotético            }
{ ============================================================================ }

unit Unt_ClassesLinhas;

interface

uses
  Unt_ClasseLinhaBase,
  Unt_ClassesAtributos;

type

{$M+}
  [TCodigoLinhaAttribute(0)]
  TLinha000 = class(TLinhaBase)
  private
    FDataGeracao: TDate;
  published
    [TOrdemImpressaoAttribute(1)]
    [TDataAttribute]
    property DataGeracao: TDate read FDataGeracao write FDataGeracao;
  end;

  [TCodigoLinhaAttribute(1)]
  TLinha001 = class(TLinhaBase)
  private
    FNomeContador: string;
    FCRCContador : string;
  published
    [TOrdemImpressaoAttribute(1)]
    [TStringVariavelAttribute(50)]
    property NomeContador: string read FNomeContador write FNomeContador;
    [TOrdemImpressaoAttribute(2)]
    [TStringFixaAttribute(10)]
    property CRCCOntador: string read FCRCContador write FCRCContador;
  end;

  [TCodigoLinhaAttribute(2)]
  TLinha002 = class(TLinhaBase)
  private
    FNomeEmpresa: string;
    FCNPJ: string;
  published
    [TOrdemImpressaoAttribute(1)]
    [TStringVariavelAttribute(50)]
    property NomeEmpresa: string read FNomeEmpresa write FNomeEmpresa;
    [TOrdemImpressaoAttribute(2)]
    [TStringFixaAttribute(14)]
    property CNPJ: string read FCNPJ write FCNPJ;
  end;

  [TCodigoLinhaAttribute(3)]
  TLinha003 = class(TLinhaBase)
  private
    FDataVenda: TDate;
    FNomeCliente: string;
    FValorCompra: Currency;
  published
    [TOrdemImpressaoAttribute(1)]
    [TDataAttribute]
    property DataVenda: TDate read FDataVenda write FDataVenda;
    [TOrdemImpressaoAttribute(2)]
    [TStringVariavelAttribute]
    property NomeCliente: string read FNomeCliente write FNomeCliente;
    [TOrdemImpressaoAttribute(3)]
    [TMonetarioAttribute]
    property ValorCompra: Currency read FValorCompra write FValorCompra;
  end;

  [TCodigoLinhaAttribute(999)]
  TLinha999 = class(TLinhaBase);
{$M-}

implementation

end.
