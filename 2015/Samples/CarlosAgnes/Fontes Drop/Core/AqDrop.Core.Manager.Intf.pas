unit AqDrop.Core.Manager.Intf;

interface

type
  /// ------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Interface that must be implemented by object manager classes.
  ///   PT-BR:
  ///     Interface que deve ser implementada por classes gerenciadoras.
  /// </summary>
  /// ------------------------------------------------------------------------------------------------------------------
  IAqManager<T: class> = interface
    ['{82232845-E30C-4411-8B73-4234E1898564}']
    procedure _AddDependent(const pDependent: T);
    procedure _RemoveDependent(const pDependent: T);
  end;


implementation

end.
