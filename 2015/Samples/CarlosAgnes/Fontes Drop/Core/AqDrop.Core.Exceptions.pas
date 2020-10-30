unit AqDrop.Core.Exceptions;

interface

uses
  System.SysUtils;

type
  /// ------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Base class for exceptions raised in Aquasoft packages.
  ///   PT-BR:
  ///     Classe base para as exceções levantadas por pacotes da Aquasoft.
  /// </summary>
  /// ------------------------------------------------------------------------------------------------------------------
  EAqException = class(Exception);

  /// ------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Exception raised to notify internal erros of the framework (technical or not friendly messages).
  ///   PT-BR:
  ///     Exceção disparada para notificar erros internos do framework (mensagens técnicas ou não amigáveis).
  /// </summary>
  /// ------------------------------------------------------------------------------------------------------------------
  EAqInternal = class(EAqException);

  /// ------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Exception raised to notify errors that can be externalized (friendly messages).
  ///   PT-BR:
  ///     Exceção disparada para notificar erros que podem ser externados (mensagens amigáveis).
  /// </summary>
  /// ------------------------------------------------------------------------------------------------------------------
  EAqFriendly = class(EAqException);

implementation

end.
