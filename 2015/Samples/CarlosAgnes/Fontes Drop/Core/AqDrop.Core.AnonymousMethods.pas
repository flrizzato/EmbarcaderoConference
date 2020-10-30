unit AqDrop.Core.AnonymousMethods;

interface

type
  /// ------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Anonymous method equivalent to TNotifyEvent.
  ///   PT-BR:
  ///     Método anônimo equivalente ao TNotifyEvent.
  /// </summary>
  /// ------------------------------------------------------------------------------------------------------------------
  TAqNotifyMethod = reference to procedure(Sender: TObject);

  TAqConversionFunction<TFrom, TTo> = reference to function(const pValue: TFrom): TTo;

implementation

end.
