unit AqDrop.Core.Automaton.Text;

interface

{$I 'AqDrop.Core.Defines.inc'}

uses
  AqDrop.Core.Automaton, AqDrop.Core.Types;

type
  TAqTextAutomaton<TIdentifier, TOutput> = class(TAqAutomaton<TIdentifier, Char, TOutput>)
  strict private type
    TAqInternalAutomaton = TAqAutomaton<TIdentifier, Char, TOutput>;
  strict protected
    function GetDefaultValue: Char; override;
  public
    /// <summary>
    ///   EN-US:
    ///     Allows to add a dictionary containing the values between an interval of an initial and a final char.
    ///   PT-BR:
    ///     Permite adicionar um dicionário contendo os valores existentes entre um caracter inicial e outro
    ///     caracter final.
    /// </summary>
    /// <param name="pDictionaryID">
    ///   EN-US:
    ///     Dictionary ID.
    ///   PT_BR:
    ///     Identificador do dicionário.
    ///</param>
    /// <param name="pInitialValue">
    ///   EN-US:
    ///     Initial value of the interval.
    ///   PT_BR:
    ///     Valor inicial do intervalo.
    ///</param>
    /// <param name="pFinalValue">
    ///   EN-US:
    ///     Final value of the interval.
    ///   PT_BR:
    ///     Valor final do intervalo.
    ///</param>
    /// <returns>
    ///   EN-US:
    ///     Returns the dictionary added to the automaton.
    ///   PT-BR:
    ///     Retorna o dicionário adicionado ao autômato.
    /// </returns>
    function AddDictionary(const pDictionaryID: TIdentifier;
      const pInitialValue, pFinalValue: Char): TAqAutomatonDictionary<TIdentifier, Char>; overload;
    /// <summary>
    ///    EN-US:
    ///      Allows to add a dictionary from a set of chars (AnsiChar).
    ///    PT-BR:
    ///      Permite adicionar um dicionário contendo os valores existentes em um set de caracteres (AnsiChar).
    /// </summary>
    /// <param name="pDictionaryID">
    ///   EN-US:
    ///     Dictionary ID.
    ///   PT_BR:
    ///     Identificador do dicionário.
    ///</param>
    /// <param name="pValues">
    ///   EN-US:
    ///     Char set that will form the dictionary.
    ///   PT_BR:
    ///     Set de caracteres que farão parte do Dicionário.
    ///</param>
    /// <returns>
    ///   EN-US:
    ///     Returns the dictionary added to the automaton.
    ///   PT-BR:
    ///     Retorna o dicionário adicionado ao autômato.
    /// </returns>
{$IFNDEF AQMOBILE}
    function AddDictionary(const pDictionaryID: TIdentifier;
       const pValues: TAqAnsiCharSet): TAqAutomatonDictionary<TIdentifier, Char>; overload;
{$ENDIF}
  end;

resourcestring
  StrInvalidValuesToCreateTheDictionary = 'Invalid values to create the dictionary.';

implementation

uses
  AqDrop.Core.Exceptions;

{ TAqTextAutomaton<TIdentifier, TOutput> }

function TAqTextAutomaton<TIdentifier, TOutput>.AddDictionary(const pDictionaryID: TIdentifier;
  const pInitialValue, pFinalValue: Char): TAqAutomatonDictionary<TIdentifier, Char>;
var
  lValues: TArray<Char>;
  lInitialValue: Int32;
  lFinalValue: Int32;
  lValue: Int32;
begin
  if pInitialValue > pFinalValue then
  begin
    raise EAqInternal.Create(StrInvalidValuesToCreateTheDictionary);
  end;

  lInitialValue := Ord(pInitialValue);
  lFinalValue := Ord(pFinalValue);

  SetLength(lValues, lFinalValue - lInitialValue);
  for lValue := lInitialValue to lFinalValue do
  begin
    lValues[lValue - lInitialValue] := Chr(lValue);
  end;

  Result := AddDictionary(pDictionaryID, lValues);
end;

{$IFNDEF AQMOBILE}
function TAqTextAutomaton<TIdentifier, TOutput>.AddDictionary(const pDictionaryID: TIdentifier;
  const pValues: TAqAnsiCharSet): TAqAutomatonDictionary<TIdentifier, Char>;
var
  lValues: TArray<Char>;
  lValue: AnsiChar;
  lI: Int32;
begin
  lI := 0;
  for lValue in pValues do
  begin
    SetLength(lValues, lI + 1);
    lValues[lI] := Char(lValue);
    Inc(lI);
  end;

  Result := AddDictionary(pDictionaryID, lValues);
end;
{$ENDIF}

function TAqTextAutomaton<TIdentifier, TOutput>.GetDefaultValue: Char;
begin
  Result := #0;
end;

end.

