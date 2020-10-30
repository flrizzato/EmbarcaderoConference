{ ============================================================================ }
{ DELPHI CONFERENCE 2012 - 23/10/2012                                          }
{ José Mário Silva Guedes - mario.guedes@arrayof.com.br                        }
{                                                                              }
{ Propósito: Concentra os atributos personalizados                             }
{ ============================================================================ }

unit Unt_ClassesAtributos;

interface

type

  /// <summary>
  /// Atributo que caracteriza um CÓDIGO DE LINHA
  /// </summary>
  TCodigoLinhaAttribute = class(TCustomAttribute)
  private
    FCodigoLinha: Smallint;
  public
    constructor Create(ACodigoLinha: Smallint);
    property CodigoLinha: Smallint read FCodigoLinha;
  end;

  /// <summary>
  /// Atributo que determina a ordem de impressão do campo em questão
  /// </summary>
  TOrdemImpressaoAttribute = class(TCustomAttribute)
  private
    FOrdemImpressao: Byte;
  public
    constructor Create(AOrdemImpressao: Byte);
    property OrdemImpressao: Byte read FOrdemImpressao;
  end;

  /// <summary>
  /// Classe base de formatação
  /// </summary>
  TFormatacaoAttribute = class abstract(TCustomAttribute)
  end;

  /// <summary>
  /// Indica que se trata de uma string de tamanho e formatação livre
  /// </summary>
  TStringVariavelAttribute = class(TFormatacaoAttribute)
  private
    FTamanhoMaximo: Byte;
  public
    constructor Create(ATamanhoMaximo: Byte = 255);
    property TamanhoMaximo: Byte read FTamanhoMaximo write FTamanhoMaximo;
  end;

  /// <summary>
  /// Indica que se trata de uma string de tamanho determinado
  /// </summary>
  TStringFixaAttribute = class(TFormatacaoAttribute)
  private
    FTamanho      : Byte;
    FPreenchimento: Char;
  public
    constructor Create(ATamanho: Byte; APreenchimento: string = ' ');
    property Tamanho: Byte read FTamanho;
    property Preenchimento: Char read FPreenchimento;
  end;

  /// <summary>
  /// Indica que se trata de uma data
  /// </summary>
  TDataAttribute = class(TFormatacaoAttribute);

  /// <summary>
  /// Indica que se trata de um valor monetário (R$)
  /// </summary>
  TMonetarioAttribute = class(TFormatacaoAttribute);

implementation

{ TCodigoLinhaAttribute }

constructor TCodigoLinhaAttribute.Create(ACodigoLinha: Smallint);
begin
  Self.FCodigoLinha := ACodigoLinha;
end;

{ TOrdemImpressaoAttribute }

constructor TOrdemImpressaoAttribute.Create(AOrdemImpressao: Byte);
begin
  Self.FOrdemImpressao := AOrdemImpressao;
end;

{ TStringFixaAttribute }

constructor TStringFixaAttribute.Create(ATamanho: Byte; APreenchimento: string);
begin
  Self.FTamanho := ATamanho;
  Self.FPreenchimento := APreenchimento[1];
end;

{ TStringVariavelAttribute }

constructor TStringVariavelAttribute.Create(ATamanhoMaximo: Byte);
begin
  Self.FTamanhoMaximo := ATamanhoMaximo;
end;

end.
