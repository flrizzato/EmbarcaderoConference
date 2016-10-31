{ ============================================================================ }
{ DELPHI CONFERENCE 2012 - 23/10/2012                                          }
{ José Mário Silva Guedes - mario.guedes@arrayof.com.br                        }
{                                                                              }
{ Propósito: Oferecer classes de exeção para a correta identificação dos       }
{            possíveis erros                                                   }
{ ============================================================================ }

unit Unt_ClasseException;

interface

uses
  System.SysUtils,
  System.TypInfo;

type

  /// <summary>
  /// Caracteriza um erro de tipo de propriedade não previsto
  /// </summary>
  EGerarLinhaTipoNaoPrevisto = class(Exception)
  public
    constructor Create(ATipo: string);
  end;

implementation

{ EGerarLinhaTipoNaoPrevisto }

constructor EGerarLinhaTipoNaoPrevisto.Create(ATipo: string);
begin
  inherited Create(Format('Tipo de Propriedade não previsto: [%s]', [ATipo]));
end;

end.
