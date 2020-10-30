unit AqDrop.Core.Collections.Intf;

interface

uses
  System.SysUtils,
  System.Generics.Defaults,
  System.Generics.Collections;

type
  IAqReadList<T> = interface
    /// <returns>
    ///   EN-US:
    ///     Returns the items count of the list.
    ///   PT-BR:
    ///     Retorna a lista de itens da lista.
    /// </returns>
    function GetCount: Int32;
    /// <summary>
    ///   EN-US:
    ///     Allows the access to the items by their indexes.
    ///   PT-BR:
    ///     Permite o acesso aos itens através de seus respectivos índices.
    /// </summary>
    /// <returns>
    ///   EN-US:
    ///     Returns the item of the gived index.
    ///   PT-BR:
    ///     Retorna o item correspondente ao índice informado.
    /// </returns>
    function GetItem(pIndex: Int32): T;

    /// <summary>
    ///   EN-US:
    ///     Finds the index of an item in the list.
    ///   PT-BR:
    ///     Localiza o índice de um item na lista.
    /// </summary>
    /// <param name="pValue">
    ///   EN-US:
    ///     Value that should be found.
    ///   PT-BR:
    ///     Valor que deve ser encontrado.
    /// </param>
    /// <returns>
    ///   EN-US:
    ///     Returns the index fo the searched value. If the value is not found, the function returns -1.
    ///   PT-BR:
    ///     Retorna o índice do valor procurado na lista. Caso o valor não seja encontrado, a função retornará -1.
    /// </returns>
    function IndexOf(const pValue: T): Int32; overload;

    function Find(const pMatchFunction: TFunc<T, Boolean>; out pValue: T): Boolean; overload;

    /// <summary>
    ///   EN-US:
    ///     Function to obtain the first item of the list.
    ///   PT-BR:
    ///     Função para obtenção do primeiro item da lista.
    /// </summary>
    /// <returns>
    ///   EN-US:
    ///     First item of the list.
    ///   PT-BR:
    ///     Primeiro item da lista.
    /// </returns>
    function GetFirst: T;
    /// <summary>
    ///   EN-US:
    ///     Function to obtain the last item of the list.
    ///   PT-BR:
    ///     Função para obtenção do último item da lista.
    /// </summary>
    /// <returns>
    ///   EN-US:
    ///     Last item of the list.
    ///   PT-BR:
    ///     Último item da lista.
    /// </returns>
    function GetLast: T;

    /// <summary>
    ///   EN-US:
    ///     Returns the items count of the list.
    ///   PT-BR:
    ///     Retorna a lista de itens da lista.
    /// </summary>
    property Count: Int32 read GetCount;

    /// <summary>
    ///   EN-US:
    ///     Allows the access to the items by their indexes.
    ///   PT-BR:
    ///     Permite o acesso aos itens através de seus respectivos índices.
    /// </summary>
    property Items[pIndex: Int32]: T read GetItem; default;

    property First: T read GetFirst;
    property Last: T read GetLast;

    function GetEnumerator: TEnumerator<T>;
  end;

  /// ------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Interface for lists returned by methods. Used to automatically release lists by references counting.
  ///   PT-BR:
  ///     Interface para listas retornadas por métodos. Utilizada para liberar listas automaticamente através da
  ///     contagem de referências de interfaces.
  /// </summary>
  /// ------------------------------------------------------------------------------------------------------------------
  IAqResultList<T> = interface(IAqReadList<T>)
    ['{1574A9A4-0650-4E43-AF08-5147A6068E35}']

    function GetOnwsResults: Boolean;
    procedure SetOnwsResults(const pValue: Boolean);

    function Extract(const pIndex: UInt32 = 0): T;
    procedure ExtractAllTo(const pList: TList<T>);
    function ExtractAll: TList<T>;

    function GetComparer: IComparer<T>;
    procedure SetComparer(pValue: IComparer<T>);

    procedure Sort; overload;
    procedure Sort(const pComparerFunction: TFunc<T, T, Int32>); overload;
    procedure Sort(pComparer: IComparer<T>); overload;

    property Comparer: IComparer<T> read GetComparer write SetComparer;
    property OnwsResults: Boolean read GetOnwsResults write SetOnwsResults;
  end;

  IAqList<T> = interface(IAqReadList<T>)
    ['{AE2187BA-592A-4D0B-8C31-5FDEB6025341}']

    /// <summary>
    ///   EN-US:
    ///     Insert a new item to the list, in a specific position.
    ///   PT-BR:
    ///     Insere um novo item, em uma posição específica da lista.
    /// </summary>
    /// <param name="pIndex">
    ///   EN-US:
    ///     Index which the new item must assume.
    ///   PT-BR:
    ///     Posição onde deve ser inserido o novo item.
    /// </param>
    /// <param name="pItem">
    ///   EN-US:
    ///     Item that must be entered.
    ///   PT-BR:
    ///     Item que deve ser inserido.
    /// </param>
    procedure Insert(const pIndex: Int32; const pItem: T);
    /// <summary>
    ///   EN-US:
    ///     Deletes an item from the list.
    ///   PT-BR:
    ///     Exclui um item da lista.
    /// </summary>
    /// <param name="pIndex">
    ///   EN-US:
    ///     Index of the item to be deleted.
    ///   PT-BR:
    ///     Índice do item que deve ser excluído.
    /// </param>
    procedure Delete(const pIndex: Int32);
    /// <summary>
    ///   EN-US:
    ///     Exchange the position of two items in the list.
    ///   PT-BR:
    ///     Troca de posição dois itens da lista.
    /// </summary>
    /// <param name="pIndex1">
    ///   EN-US:
    ///     Index of the first item.
    ///   PT-BR:
    ///     Índice do primeiro item.
    /// </param>
    /// <param name="pIndex2">
    ///   EN-US:
    ///     Index of the second item.
    ///   PT-BR:
    ///     Índice do segundo item.
    /// </param>
    procedure Exchange(const pIndex1, pIndex2: Int32);

    /// <summary>
    ///   EN-US:
    ///     Deletes all items of the list.
    ///   PT-BR:
    ///     Exclui todos os itens da lista.
    /// </summary>
    procedure Clear;

    /// <summary>
    ///   EN-US:
    ///     Adds a new item to the list.
    ///   PT-BR:
    ///     Adiciona um novo item à lista.
    /// </summary>
    /// <param name="pItem">
    ///   EN-US:
    ///     Item that must be added to the list.
    ///   PT-BR:
    ///     Item que deve ser adicionado à lista.
    /// </param>
    /// <returns>
    ///   EN-US:
    ///     Returns the index os the item added to the list.
    ///   PT-BR:
    ///     Retorna o índice do item adicionado à lista.
    /// </returns>
    function Add(const pItem: T): Int32;

    function Extract(const pIndex: Int32): T;

    function GetComparer: IComparer<T>;
    procedure SetComparer(pValue: IComparer<T>);

    procedure Sort; overload;
    procedure Sort(const pComparerFunction: TFunc<T, T, Int32>); overload;
    procedure Sort(pComparer: IComparer<T>); overload;

    property Comparer: IComparer<T> read GetComparer write SetComparer;
  end;

implementation

end.
