unit AqDrop.Core.Tokenizer;

interface

uses
  AqDrop.Core.Automaton, AqDrop.Core.Automaton.Text, AqDrop.Core.Collections.Intf, AqDrop.Core.Exceptions;

type
  /// ------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Class for exceptions raised when tokenizing a text.
  ///   PT-BR:
  ///     Classe para Exceções levantadas ao tokenizar um texto.
  /// </summary>
  /// ------------------------------------------------------------------------------------------------------------------
  EAqTokenizer = class(EAqInternal)
  strict private
    FPosition: Int32;
  public
    /// <summary>
    ///   EN-US:
    ///     Class constructor.
    ///   PT-BR:
    ///     Construtor da classe.
    /// </summary>
    /// <param name="pMessage">
    ///   EN-US:
    ///     Exceotion Message.
    ///   PT-BR:
    ///     Mensagem da exceção.
    /// </param>
    /// <param name="pPosition">
    ///   EN-US:
    ///     Text position where the error happened.
    ///   PT-BR:
    ///     Posição do texto onde aconteceu o erro.
    /// </param>
    constructor Create(const pMessage: string; const pPosition: Int32);

    /// <summary>
    ///   EN-US:
    ///     Text position where the error happened.
    ///   PT-BR:
    ///     Posição do texto onde aconteceu o erro.
    /// </summary>
    property Position: Int32 read FPosition;
  end;

  /// ------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Class for representation of Tokens recognized by the Tokenizer.
  ///   PT-BR:
  ///     Classe para representação de Tokens reconhecidos pelo Tokenizer.
  /// </summary>
  /// ------------------------------------------------------------------------------------------------------------------
  TAqToken<TType> = class
  strict private
    FType: TType;
    FText: string;
  public
    /// <summary>
    ///   EN-US:
    ///     Class constructor.
    ///   PT-BR:
    ///     Construtor da classe.
    /// </summary>
    /// <param name="pText">
    ///   EN-US:
    ///     Recognized Token.
    ///   PT-BR:
    ///     Token reconhecido.
    /// </param>
    /// <param name="pType">
    ///   EN-US:
    ///     Token type.
    ///   PT-BR:
    ///     Tipo do Token.
    /// </param>
    constructor Create(const pText: string; const pType: TType);
    /// <summary>
    ///   EN-US:
    ///     Token type.
    ///   PT-BR:
    ///     Tipo do Token.
    /// </summary>
    property &Type: TType read FType;
    /// <summary> Token obtido </summary>
    property Text: string read FText;
  end;

  /// ------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Class able to tokenize a text as defined by its automaton.
  ///   PT-BR:
  ///     Classe capaz de tokenizar um texto, conforme definição do seu autômato.
  /// </summary>
  /// ------------------------------------------------------------------------------------------------------------------
  TAqTokenizer<TIdentifier, TOutput> = class
  public type
    TAqTokenizerAutomaton = TAqTextAutomaton<TIdentifier, TOutput>;
    IAqTokenizerResult = IAqResultList<TAqToken<TOutput>>;
    TAqTokenizerToken = TAqToken<TOutput>;
  strict private
    FAutomaton: TAqTextAutomaton<TIdentifier, TOutput>;
    function FinalizeToken(var pCurrentState: TAqAutomatonState<TIdentifier, Char, TOutput>; var pToken: string;
      var pCurrentPosition: Int32): TAqTokenizerToken;
  strict protected
    property Automaton: TAqTokenizerAutomaton read FAutomaton;
  public
    /// <summary>
    ///   EN-US:
    ///     Class constructor.
    ///   PT-BR:
    ///     Construtor da classe.
    /// </summary>
    constructor Create;
    /// <summary>
    ///   EN-US:
    ///     Class destructor.
    ///   PT-BR:
    ///     Destrutor da classe.
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    ///   EN-US:
    ///     Execute the tokenizer according its automaton definition.
    ///     If the text is recognized, the function returns the tokens list.
    ///     Otherwise, an expcetion of EAqTokenizer is raised.
    ///   PT-BR:
    ///     Executa o tokenizer conforme definição do autômato.
    ///     Se o texto for reconhecido, a função retorna a lista de tokens.
    ///     Caso contrário, uma exceção do tipo EAqTokenizer é disparada.
    /// </summary>
    /// <param name="pTexto">
    ///   EN-US:
    ///     Texto to be tokenized.
    ///   PT-BR:
    ///     Texto que deve ser tokenizado.
    /// </param>
    /// <returns>
    ///   EN-US:
    ///     Returns the obtained list of Tokens.
    ///   PT-BR:
    ///     Retorna a lista de Tokens obtidos.
    /// </returns>
    function Execute(const pText: string): IAqTokenizerResult;
  end;

resourcestring
  StrTextnotRecognized = 'Text not recognized.';

implementation

uses
  AqDrop.Core.Helpers,
  AqDrop.Core.Collections;

{ TAqTokenizer }

constructor TAqTokenizer<TIdentifier, TOutput>.Create;
begin
  FAutomaton := TAqTokenizerAutomaton.Create;
end;

destructor TAqTokenizer<TIdentifier, TOutput>.Destroy;
begin
  FAutomaton.Free;

  inherited;
end;

function TAqTokenizer<TIdentifier, TOutput>.Execute(const pText: string): IAqTokenizerResult;
var
  lI: Int32;
  lCurrentState: TAqAutomatonState<TIdentifier, Char, TOutput>;
  lNewState: TAqAutomatonState<TIdentifier, Char, TOutput>;
  lToken: string;
  lFinal: Int32;
  lResult: TAqResultList<TAqTokenizerToken>;
  lChar: Char;
begin
  lResult := TAqResultList<TAqTokenizerToken>.Create(True);

  try
    lCurrentState := FAutomaton.InitialState;
    lToken := '';

    lFinal := Length(pText);
    lI := 0;
    while lI < lFinal do
    begin
      lChar := pText.Chars[lI];
      if lCurrentState.Transition(lChar, lNewState) then
      begin
        lToken := lToken + lChar;
        lCurrentState := lNewState;
      end else begin
        lResult.Add(FinalizeToken(lCurrentState, lToken, lI));
      end;

      Inc(lI);
    end;

    lResult.Add(FinalizeToken(lCurrentState, lToken, lI));
  except
    lResult.Free;
    raise;
  end;

  Result := lResult;
end;

function TAqTokenizer<TIdentifier, TOutput>.FinalizeToken(
  var pCurrentState: TAqAutomatonState<TIdentifier, Char, TOutput>; var pToken: string;
  var pCurrentPosition: Int32): TAqTokenizerToken;
begin
  if pCurrentState.IsFinal then
  begin
    Result := TAqTokenizerToken.Create(pToken, pCurrentState.Output);
    pToken := '';
    pCurrentState := Automaton.InitialState;
    Dec(pCurrentPosition);
  end else begin
    raise EAqTokenizer.Create(StrTextnotRecognized, pCurrentPosition);
  end;
end;

{ EAqTokenizer }

constructor EAqTokenizer.Create(const pMessage: string; const pPosition: Int32);
begin
  inherited Create(pMessage);

  FPosition := pPosition;
end;

{ TAqToken<TType> }

constructor TAqToken<TType>.Create(const pText: string; const pType: TType);
begin
  FText := pText;
  FType := pType;
end;

end.

