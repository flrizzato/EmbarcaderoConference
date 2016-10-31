unit AqDrop.Core.Collections;

interface

uses
  System.SysUtils,
  System.Generics.Defaults,
  System.Generics.Collections,
  System.SyncObjs,
  AqDrop.Core.AnonymousMethods,
  AqDrop.Core.Types,
  AqDrop.Core.Collections.Intf,
  AqDrop.Core.InterfacedObject;

type
  TAqID = NativeUInt;

  ///-------------------------------------------------------------------------------------------------------------------
  /// TAqComparisonResult
  ///-------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Type used to return the comparison result between two items.
  ///   PT-BR:
  ///     Tipo utilizado para retornar o resultado da comparação entre dois itens.
  /// </summary>
  ///-------------------------------------------------------------------------------------------------------------------
  TAqComparisonResult = (acrEqual, acrGreater, acrLess);

  TAqComparerFunction<T> = reference to function(const pValue1, pValue2: T): TAqComparisonResult;

  TAqDictionaryContent = (adcKey, adcValue);
  TAqDictionaryContents = set of TAqDictionaryContent;

  TAqReadList<T> = class(TAqInterfacedObject, IAqReadList<T>)
  strict private
    FList: TList<T>;
    FLocker: TCriticalSection;
    function GetCount: Int32;
    function GetItem(pIndice: Int32): T;
    function GetFirst: T;
    function GetLast: T;

    procedure VerifyLocker;
  public
    constructor Create(const pLista: TList<T>; const pCreateLocker: Boolean = False);
    destructor Destroy; override;

    procedure Lock; virtual;
    procedure Release; virtual;

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

    property Count: Int32 read GetCount;
    property Items[pIndice: Int32]: T read GetItem; default;

    property First: T read GetFirst;
    property Last: T read GetLast;

    function GetEnumerator: TEnumerator<T>;
  end;

  /// ------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Base class for lists of Aquasoft packages.
  ///   PT-BR:
  ///     Classe base para listas nos pacotes Aquasoft.
  ///</summary>
  /// ------------------------------------------------------------------------------------------------------------------
  TAqList<T> = class(TAqReadList<T>, IAqList<T>)
  strict private
    FComparer: IComparer<T>;
    FList: TList<T>;
    FReadList: TAqReadList<T>;
    FFreeObjects: Boolean;

    procedure ListNotifier(Sender: TObject; const Item: T; Action: TCollectionNotification);

    function GetComparer: IComparer<T>;
    procedure SetComparer(pValue: IComparer<T>);
  private
   { Private declarations }
  strict protected
    procedure ExecWithReleaseOff(const pMethod: TProc);

    property FreeObjects: Boolean read FFreeObjects write FFReeObjects;
  public
    /// <summary>
    ///   EN-US:
    ///     Class constructor.
    ///   PT-BR:
    ///     Construtor da classe.
    ///</summary>
    /// <param name="pFreeObjects">
    ///   EN-US:
    ///     Defines if possible objects contained in the list should be automatically released
    ///   PT-BR:
    ///     Define se possíveis objetos contidos na lista devem ser liberados automaticamente.
    ///</param>
    constructor Create(const pFreeObjects: Boolean = False; const pCreateLocker: Boolean = False);
    /// <summary>
    ///   EN-US:
    ///     Class destructor.
    ///   PT-BR:
    ///     Destrutor da classe.
    ///</summary>
    destructor Destroy; override;

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
    procedure Insert(const pIndex: Int32; const pItem: T); virtual;
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
    procedure Delete(const pIndex: Int32); virtual;
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
    procedure Exchange(const pIndex1, pIndex2: Int32); virtual;
    /// <summary>
    ///   EN-US:
    ///     Removes a specific item and add it to another list.
    ///   PT-BR:
    ///     Retira um item específico e o adiciona outra lista.
    /// </summary>
    /// <param name="pIndex">
    ///   EN-US:
    ///     Index of the item in the current list.
    ///   PT-BR:
    ///     Índice do item que deve ser removido da lista corrente.
    /// </param>
    /// <param name="pNewList">
    ///   EN-US:
    ///     List where the item removed will now be added.
    ///   PT-BR:
    ///     Lista onde o item retirado será agora adicionado.
    /// </param>
    procedure ExchangeList(const pIndex: Int32; const pNewList: TAqList<T>); virtual;
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
    function Add(const pItem: T): Int32; virtual;

    function Extract(const pIndex: Int32): T;

    function Copy(const pCreateLocker: Boolean = False): TAqList<T>;

    function GetIReadList: IAqReadList<T>;
    function GetTReadList: TAqReadList<T>;

    procedure Sort; overload;
    procedure Sort(const pComparerFunction: TFunc<T, T, Int32>); overload;
    procedure Sort(pComparer: IComparer<T>); overload;

    property Comparer: IComparer<T> read GetComparer write SetComparer;
  end;

  /// ------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Class that implements the interface IAqResultList<T>.
  ///   PT-BR:
  ///     Classe que implementa a interface IAqResultList<T>.
  /// </summary>
  /// ------------------------------------------------------------------------------------------------------------------
  TAqResultList<T> = class(TAqList<T>, IAqResultList<T>)
  strict private
    function GetOnwsResults: Boolean;
    procedure SetOnwsResults(const pValue: Boolean);
  strict protected
{$IFNDEF AUTOREFCOUNT}
    class function MustCountReferences: Boolean; override;
{$ENDIF}
  public
    function Extract(const pIndex: UInt32 = 0): T;
    procedure ExtractAllTo(const pList: TList<T>);
    function ExtractAll: TList<T>;
  end;


  ///-------------------------------------------------------------------------------------------------------------------
  /// TAqNodeType
  ///-------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Represents the node type in the tree.
  ///   PT-BR:
  ///     Representa o tipo de nodo na árvore.
  /// </summary>
  ///-------------------------------------------------------------------------------------------------------------------

  TAqNodeType = (antRoot, antLeft, antRight);

  ///-------------------------------------------------------------------------------------------------------------------
  /// Class TAqAVLNode
  ///-------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Class used to cread nodes to an AVL Tree.
  ///   PT-BR:
  ///     Classe usada para criar nodos em uma árvore AVL.
  /// </summary>
  ///-------------------------------------------------------------------------------------------------------------------
  TAqAVLNode<T> = class
  strict private
    FFreeObject: Boolean;
    FValue: T;
    FNodeType: TAqNodeType;
    FConnections: array[TAqNodeType] of TAqAVLNode<T>;
    FDepths: array[TAqNodeType] of UInt32;

    function GetBalancing: Int8;
    function GetConnection(pType: TAqNodeType): TAqAVLNode<T>;
    function GetDepth: UInt32;
  private
    procedure RecalculateDepths;
    procedure RecalculateDepth(const pSide: TAqNodeType);
    procedure SetConnection(const pType: TAqNodeType; const pNode: TAqAVLNode<T>);
    procedure SetType(const pType: TAqNodeType);

    function GetEndNode(const pDirection: TAqNodeType): TAqAVLNode<T>;
    function GetSucessorFromSide(pDirection: TAqNodeType; out pSucessor: TAqAVLNode<T>): Boolean;
    function GetSucessor(out pSucessor: TAqAVLNode<T>): Boolean; overload;
  public
    /// <summary>
    ///   EN-US:
    ///     Class constructor.
    ///   PT-BR:
    ///     Construtor da classe.
    /// </summary>
    /// <param name="pValue">
    ///   EN-US:
    ///     Value to be stored in the node.
    ///   PT-BR:
    ///     Valor que o nodo aramazenará.
    /// </param>
    /// <param name="pFreeObjects">
    ///   EN-US:
    ///     Informs if a possible object stored in the node should be automatically released.
    ///   PT-BR:
    ///     Informa se um possível objeto armazenado no nodo deve ser liberado automaticamente.
    /// </param>
    constructor Create(const pValue: T; const pFreeObject: Boolean);

    /// <summary>
    ///   EN-US:
    ///     Class destructor.
    ///   PT-BR:
    ///     Destrutor da classe.
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    ///   EN-US:
    ///     Class function used to reverse the informed direction.
    ///   PT-BR:
    ///     Class function utiliada para retornar a direção inversa à direção passada por parâmetro.
    /// </summary>
    /// <param name="pDirecao">
    ///   EN-US:
    ///     Direction to be reversed.
    ///   PT-BR:
    ///     Direção que deve ser invertida.
    /// </param>
    class function ReverseDirection(const pDirection: TAqNodeType): TAqNodeType;

    /// <summary>
    ///   EN-US:
    ///     Value stores by the node.
    ///   PT-BE:
    ///     Valor armazenado pelo nodo.
    /// </summary>
    property Value: T read FValue;
    /// <summary>
    ///   EN-US:
    ///     Allows the access to the node connections.
    ///   PT-BR:
    ///     Permite acesso às conexões do nodo.
    /// </summary>
    property Connections[pType: TAqNodeType]: TAqAVLNode<T> read GetConnection;
    /// <summary>
    ///   EN-US:
    ///     Root node from the current node.
    ///   PT-BR:
    ///     Nodo pai do nodo selecionado.
    /// </summary>
    property Root: TAqAVLNode<T> index TAqNodeType.antRoot read GetConnection;
    /// <summary>
    ///   EN-US:
    ///     Left child of the node.
    ///   PT-BR:
    ///     Nodo filho à esquerda do nodo selecionado.
    /// </summary>
    property Left: TAqAVLNode<T> index TAqNodeType.antLeft read GetConnection;
    /// <summary>
    ///   EN-US:
    ///     Right child of the node.
    ///   PT-BR:
    ///     Nodo filho à direita do nodo selecionado.
    /// </summary>
    property Right: TAqAVLNode<T> index TAqNodeType.antRight read GetConnection;
    /// <summary>
    ///   EN-US:
    ///     Depth of the node subtree.
    ///   PT-BR:
    ///     Profundidade da sub-árvore do nodo selecionado.
    /// </summary>
    property Depth: UInt32 read GetDepth;
    /// <summary>
    ///   EN-US:
    ///     Current balancing of the tree.
    ///     If the value is positive (+1), means that the subtree is deeper at left.
    ///     If the value is negative (-1), means that the subtree is deeper at right.
    ///     If the value is 0, means that the node is balanced.
    ///   PT-BR:
    ///     Balanceamento atual do nodo.
    ///     Se o valor for positivo (+1), significa que a sub-árvore é mais profunda à esquerda.
    ///     Se o valor for negativo (-1), significa que a sub-árvore é mais profunda à direita.
    ///     Se o valor for 0, significa que o nodo está balanceado.
    /// </summary>
    property Balancing: Int8 read GetBalancing;
    /// <summary>
    ///   EN-US:
    ///     Node Type.
    ///   PT-BR:
    ///     Tipo de nodo.
    /// </summary>
    property NodeType: TAqNodeType read FNodeType;
    /// <summary>
    ///   EN-US:
    ///     Returns the leftmost child of the current node.
    ///   PT-BR:
    ///     Retorna o nodo filho mais à esquerda a partir do nodo corrente.
    /// </summary>
    property LeftmostChild: TAqAVLNode<T> index TAqNodeType.antLeft read GetEndNode;
    /// <summary>
    ///   EN-US:
    ///     Returns the rightmost child of the current node.
    ///   PT-BR:
    ///     Retorna o nodo filho mais à direita a partir do nodo corrente.
    /// </summary>
    property RightmostChild: TAqAVLNode<T> index TAqNodeType.antRight read GetEndNode;
  end;

  ///-------------------------------------------------------------------------------------------------------------------
  /// Classe TAqCustomAVLTree<T>
  ///-------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Tree for storing, indexing and balancing nodes.
  ///   PT-BR:
  ///     Árvore para armazenamento, indexação e balanceamento de nodos.
  /// </summary>
  ///-------------------------------------------------------------------------------------------------------------------
  TAqCustomAVLTree<TKey, TValue> = class
  strict private
    FComparer: TAqComparerFunction<TKey>;
    FFreeObjects: Boolean;
    FRoot: TAqAVLNode<TValue>;
    FLocker: TCriticalSection;

    procedure TraverseTreeInOrder(const pList: TAqResultList<TValue>; const pNode: TAqAVLNode<TValue>);

    procedure RecalculateDepths(const pNode: TAqAVLNode<TValue>);
    procedure Rotate(const pDirection: TAqNodeType; const pNode: TAqAVLNode<TValue>);

    function FindNode(const pKey: TKey; out pNode: TAqAVLNode<TValue>; out pNodeType: TAqNodeType): Boolean;
    function CheckIsEmpty: Boolean;

    procedure VerifyLocker;
  strict protected
    procedure DestroyNode(const pNode: TAqAVLNode<TValue>); virtual;

    function GetKeyFromValue(const pValue: TValue): TKey; virtual; abstract;
    function Compare(const pValue1, pValue2: TKey): TAqComparisonResult; virtual;

    property Root: TAqAVLNode<TValue> read FRoot;
  public
    /// <summary>
    ///   EN-US:
    ///     Class constructor.
    ///   PT-BR:
    ///     Construtor da classe.
    /// </summasy>
    constructor Create; overload;
    /// <summary>
    ///   EN-US:
    ///     Class constructor.
    ///   PT-BR:
    ///     Construtor da classe.
    /// </summasy>
    /// <param name="pFreeObjects">
    ///   EN-US:
    ///     Informs if possible objects stored in the nodes should be automatically released.
    ///   PT-BR:
    ///     Informa se possíveis objetos armazenados nos nodos devem ser liberados automaticamente.
    /// </param>
    /// <param name="pCreateLocker">
    ///   EN-US:
    ///     If true, create an locker (TCriticalSection), allowing the use of Lock and Release methods.
    ///   PT-BR:
    ///     Se verdadeiro, cria um bloqueador (TCriticalSection, permitindo o uso dos métodos Lock e Release.
    /// </param>
    constructor Create(const pFreeObjects: Boolean; const pCreateLocker: Boolean = False); overload;
    /// <summary>
    ///   EN-US:
    ///     Class constructor.
    ///   PT-BR:
    ///     Construtor da classe.
    /// </summasy>
    /// <param name="pComparer">
    ///   EN-US:
    ///     Function that should be used when comparing two items.
    ///   PT-BR:
    ///     Função que deve ser utilizada ao comparar dois itens.
    /// </param>
    /// <param name="pCreateLocker">
    ///   EN-US:
    ///     If true, create an locker (TCriticalSection), allowing the use of Lock and Release methods.
    ///   PT-BR:
    ///     Se verdadeiro, cria um bloqueador (TCriticalSection, permitindo o uso dos métodos Lock e Release.
    /// </param>
    constructor Create(const pComparer: TAqComparerFunction<TKey>; const pCreateLocker: Boolean = False); overload;
    /// <summary>
    ///   EN-US:
    ///     Class constructor.
    ///   PT-BR:
    ///     Construtor da classe.
    /// </summasy>
    /// <param name="pFreeObjects">
    ///   EN-US:
    ///     Informs if possible objects stored in the nodes should be automatically released.
    ///   PT-BR:
    ///     Informa se possíveis objetos armazenados nos nodos devem ser liberados automaticamente.
    /// </param>
    /// <param name="pComparer">
    ///   EN-US:
    ///     Function that should be used when comparing two items.
    ///   PT-BR:
    ///     Função que deve ser utilizada ao comparar dois itens.
    /// </param>
    /// <param name="pCreateLocker">
    ///   EN-US:
    ///     If true, create an locker (TCriticalSection), allowing the use of Lock and Release methods.
    ///   PT-BR:
    ///     Se verdadeiro, cria um bloqueador (TCriticalSection, permitindo o uso dos métodos Lock e Release.
    /// </param>
    constructor Create(const pFreeObjects: Boolean; const pComparer: TAqComparerFunction<TKey>;
      const pCreateLocker: Boolean = False); overload;
    /// <summary>
    ///   EN-US:
    ///     Class destructor.
    ///   PT-BR:
    ///     Destrutor da classe.
    /// </summary>
    destructor Destroy; override;

    procedure Lock;
    procedure Release;

    /// <summary>
    ///   EN-US:
    ///     Clear the tree, deleting all the nodes.
    ///   PT-BR:
    ///     Limpa a árvore, excluindo todos os nodos.
    /// </summary>
    procedure Clear; virtual;

    /// <summary>
    ///   EN-US:
    ///     Tries to add a node to the tree with the informed value.
    ///   PT-BR:
    ///     Tenta adicionar um nodo à arvore com o valor passado por parâmetro.
    ///     Retorna True se o nodo foi adicionado com sucesso.
    ///     Retorna Falso se o valor já existir na árvore.
    /// </summary>
    /// <param name="pValor">
    ///   EN-US:
    ///     Value that must be stored in the node.
    ///   PT-BR:
    ///     Valor que deve ser armazenado pelo novo nodo.
    /// </param>
    /// <returns>
    ///   EN-US:
    ///     If the value is already contained by the tree, the function returns False.
    ///     Otherwise, the value is added to the tree and the function returns True.
    ///   PT-BR:
    ///     Se o valor já está contido na árvore, a função retorna False.
    ///     Caso contrário, o valor é adicionado à árvore e a função retorna True.
    /// </returns>
    function Add(const pValue: TValue): Boolean;
    /// <summary>
    ///   EN-US:
    ///     Tries to find a node with the specified value.
    ///   PT-BR:
    ///     Tenta localizar um nodo com o valor passado por parâmetro.
    /// </summary>
    /// <param name="pKey">
    ///   EN-US:
    ///     Key of the item that should be found in the tree.
    ///   PT-BR:
    ///     Chave do item que deve ser localizado na árvore.
    /// </param>
    /// <param name="pNode">
    ///   EN-US:
    ///     Returns the node that holds the value.
    ///   PT-BR:
    ///     Retorna o nodo que armazena o valor procurado.
    /// </param>
    /// <returns>
    ///   EN-US:
    ///     Returns true if the node was sucessfully found. Otherwise, returns False.
    ///   PT-BR:
    ///     Retorna True se o nodo foi localizado com sucesso. Caso contrário, retorna False.
    /// </returns>
    function Find(const pKey: TKey; out pNode: TAqAVLNode<TValue>): Boolean;
    /// <summary>
    ///   EN-US:
    ///     Tries to delete a node with the specified value.
    ///   PT-BR:
    ///     Tenta deletar um nodo com o valor passado por parâmetro.
    /// </summary>
    /// <param name="pKey">
    ///   EN-US:
    ///     Key of the item that must be found in the tree for lated deletion.
    ///   PT-BR:
    ///     Chave do item que deve ser localizado na árvore para posterior exclusão.
    /// </param>
    /// <returns>
    ///   EN-US:
    ///     Returns True if the node was sucessfully deleted. Otherwise, returns False.
    ///   PT-BR:
    ///     Retorna True se o nodo foi deletado com sucesso com sucesso. Caso contrário, retorna False.
    /// </returns>
    function Delete(const pKey: TKey): Boolean;
    /// <summary>
    ///   EN-US:
    ///     Returns the content of the tree in a list. Traverse order: In-Order.
    ///   PT-BR:
    ///     Retorna o conteúdo da árvore em uma lista. Ordem de pesquisa: In-Ordem.
    /// </summary>
    function GetList: IAqResultList<TValue>;

    /// <summary>
    ///   EN-US:
    ///     Returns True if the tree is empty. Otherwise, returns False.
    ///   PT-BR:
    ///     Retorna True se a árvore estiver vazia. Caso contrário, retorna False.
    /// </summary>
    property Empty: Boolean read CheckIsEmpty;
  end;

  TAqAVLTree<T> = class(TAqCustomAVLTree<T, T>)
  strict protected
    function GetKeyFromValue(const pValue: T): T; override;
  public
    function Find(const pValue: T): Boolean; overload;

    property Root;
  end;

  TAqDictionary<TKey, TValue> = class(TObjectDictionary<TKey, TValue>)
  strict private
    FLocker: TCriticalSection;

    procedure VerifyLocker;
  public
    constructor Create(const pOwnerships: TAqDictionaryContents = []; const pCreateLocker: Boolean = False);
    destructor Destroy; override;

    procedure Lock;
    procedure Release;

    function Add(const pKey: Tkey; const pValue: TValue): Boolean;
  end;

  TAqIDGenerator = class
  strict private
    class var FLocker: TCriticalSection;
    class var FUsedIDs: TAqAVLTree<TAqID>;
  public
    class constructor Create;
    class destructor Destroy;

    class function Generate: TAqID;
    class procedure Release(const pID: TAqID);
  end;

  TAqIDDictionary<TValue> = class(TObjectDictionary<TAqID, TValue>)
  strict private
    procedure ReleaseIDs;
  protected
    procedure KeyNotify(const Key: TAqID; Action: TCollectionNotification); override;
  public
    constructor Create(const pOwnsValues: Boolean);
    destructor Destroy; override;

    function Add(const pValor: TValue): TAqID; reintroduce;
  end;

  TAqListTransporter = class
  public
    class function Transport<TFrom: class; TTo: class, constructor>(
      const pFrom: IAqResultList<TFrom>): TObjectList<TTo>;
  end;

  TAqComparer<T> = class(TComparer<T>)
  strict private
    FComparerFunction: TFunc<T, T, Int32>;
  public
    constructor Create(const pComparerFunction: TFunc<T, T, Int32>);
    function Compare(const Left, Right: T): Int32; override;
  end;


resourcestring
  StrCouldNotAddTheItemToTheList = 'Could not add the item to the list.';
  StrCouldNotDeleteTheItemFromTheList = 'Could not delete the item from the list.';
  StrCouldNotInsertTheItemToTheList = 'Could not insert the item to the list.';
  StrCouldNotExchangeTheListItems = 'Could not exchange the list items.';
  StrItWasNotPossibleToGetTheItemFromIndexD = 'It was not possible to get the item from index %d.';
  StrItWasNotPossibleToGetTheFirstItemFromTheList = 'It was not possible to get the first item from the list.';
  StrItWasNotPossibleToGetTheLastItemFromTheList = 'It was not possible to get the last item from the list.';
  StrFailedToTraverseTheAVLTree = 'Failed to traverse the AVL tree.';
  StrFaliedWhenCleaningTheTree = 'Falied when cleaning the tree.';
  StrCouldNotAddTheValueToTheTree = 'Could not add the value to the tree.';
  StrFailedWhenTryingToFindAValueInTheTree = 'Failed when trying to find a value in the tree.';
  StrFailedWhenTryingToDeleteAValueInTheTree = 'Failed when trying to delete a value in the tree.';
  StrThisListDoesntHaveALocker = 'This list doesnt have a locker.';
  StrFailedWhenGeneratingUniqueID = 'Failed when generating unitque ID.';
  StrFunctionNotAvailableInTAqFromToList = 'Function not available in TAqFromToList<TFrom, TTo>.';

implementation

uses
  System.Math,
  AqDrop.Core.Exceptions,
  AqDrop.Core.Helpers.TObject;

{ TAqLista<T> }

function TAqList<T>.Add(const pItem: T): Int32;
begin
  try
    Result := FList.Add(pItem);
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create(StrCouldNotAddTheItemToTheList));
    end;
  end;
end;

constructor TAqList<T>.Create(const pFreeObjects: Boolean; const pCreateLocker: Boolean);
begin
  FList := TList<T>.Create;
  FList.OnNotify := ListNotifier;
  FFreeObjects := pFreeObjects;

  inherited Create(FList, pCreateLocker);
end;

procedure TAqList<T>.Delete(const pIndex: Int32);
begin
  try
    FList.Delete(pIndex);
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create(StrCouldNotDeleteTheItemFromTheList));
    end;
  end;
end;

destructor TAqList<T>.Destroy;
begin
  FReadList.Free;
  FList.Free;

  inherited;
end;

procedure TAqList<T>.ExecWithReleaseOff(const pMethod: TProc);
var
  lFreeObjects: Boolean;
begin
  lFreeObjects := FFreeObjects;

  try
    FFreeObjects := False;

    pMethod;
  finally
    FFreeObjects := lFreeObjects;
  end;
end;

function TAqList<T>.Extract(const pIndex: Int32): T;
var
  lFreeObjects: Boolean;
begin
  lFreeObjects := FFreeObjects;
  FFreeObjects := False;

  try
    Result := FList[pIndex];
    FList.Delete(pIndex);
  finally
    FFreeObjects := lFreeObjects;
  end;
end;

function TAqList<T>.GetComparer: IComparer<T>;
begin
  Result := FComparer;
end;

function TAqList<T>.GetIReadList: IAqReadList<T>;
begin
  Result := GetTReadList;
end;

function TAqList<T>.GetTReadList: TAqReadList<T>;
begin
  if not Assigned(FReadList) then
  begin
    FReadList := TAqReadList<T>.Create(FList);
  end;

  Result := FReadList;
end;

procedure TAqList<T>.Insert(const pIndex: Int32; const pItem: T);
begin
  try
    FList.Insert(pIndex, pItem);
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create(StrCouldNotInsertTheItemToTheList));
    end;
  end;
end;

procedure TAqList<T>.Clear;
begin
  FList.Clear;
end;

function TAqList<T>.Copy(const pCreateLocker: Boolean = False): TAqList<T>;
var
  lItem: T;
begin
  Result := TAqList<T>.Create(False, pCreateLocker);

  try
    for lItem in Self do
    begin
      Result.Add(lItem);
    end;
  except
    Result.Free;
    raise;
  end;
end;

procedure TAqList<T>.ListNotifier(Sender: TObject; const Item: T; Action: TCollectionNotification);
begin
  if FFreeObjects and (Action = cnRemoved) then
  begin
    PObject(@Item)^.Free;
  end;
end;

procedure TAqList<T>.SetComparer(pValue: IComparer<T>);
begin
  FComparer := pValue;
end;

procedure TAqList<T>.Sort;
begin
  FList.Sort(FComparer);
end;

procedure TAqList<T>.Sort(const pComparerFunction: TFunc<T, T, Int32>);
var
  lComparer: IComparer<T>;
begin
  lComparer := TAqComparer<T>.Create(pComparerFunction);
  FList.Sort(lComparer);
end;

procedure TAqList<T>.Sort(pComparer: IComparer<T>);
begin
  FList.Sort(pComparer);
end;

procedure TAqList<T>.Exchange(const pIndex1, pIndex2: Int32);
begin
  try
    FList.Exchange(pIndex1, pIndex2);
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create(StrCouldNotExchangeTheListItems));
    end;
  end;
end;

procedure TAqList<T>.ExchangeList(const pIndex: Int32; const pNewList: TAqList<T>);
begin
  pNewList.Add(Items[pIndex]);

  ExecWithReleaseOff(
    procedure
    begin
      Delete(pIndex);
    end);
end;

{ TAqResultList<T> }

function TAqResultList<T>.Extract(const pIndex: UInt32): T;
var
  lResult: T;
begin
  ExecWithReleaseOff(
    procedure
    begin
      lResult := Items[pIndex];
      Delete(pIndex);
    end);
  Result := lResult;
end;

function TAqResultList<T>.ExtractAll: TList<T>;
begin
  Result := TList<T>.Create;

  try
    ExtractAllTo(Result);
  except
     Result.Free;
     raise;
  end;
end;

procedure TAqResultList<T>.ExtractAllTo(const pList: TList<T>);
begin
  FreeObjects := False;

  while Self.Count > 0 do
  begin
    pList.Add(Self.First);
    Self.Delete(0);
  end;
end;

function TAqResultList<T>.GetOnwsResults: Boolean;
begin
  Result := FreeObjects;
end;

{$IFNDEF AUTOREFCOUNT}
class function TAqResultList<T>.MustCountReferences: Boolean;
begin
  Result := True;
end;
{$ENDIF}

procedure TAqResultList<T>.SetOnwsResults(const pValue: Boolean);
begin
  FreeObjects := pValue;
end;

{ TAqReadList<T> }

constructor TAqReadList<T>.Create(const pLista: TList<T>; const pCreateLocker: Boolean = False);
begin
  if pCreateLocker then
  begin
    FLocker := TCriticalSection.Create;
  end;

  FList := pLista;
end;

function TAqReadList<T>.GetEnumerator: TEnumerator<T>;
begin
  Result := TList<T>.TEnumerator.Create(FList);
end;

function TAqReadList<T>.GetItem(pIndice: Int32): T;
begin
  try
    Result := FList[pIndice];
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.CreateFmt(StrItWasNotPossibleToGetTheItemFromIndexD, [pIndice]));
    end;
  end;
end;

function TAqReadList<T>.GetCount: Int32;
begin
  Result := FList.Count;
end;

function TAqReadList<T>.IndexOf(const pValue: T): Int32;
begin
  Result := FList.IndexOf(pValue);
end;

procedure TAqReadList<T>.Lock;
begin
  VerifyLocker;

  FLocker.Enter;
end;

procedure TAqReadList<T>.Release;
begin
  VerifyLocker;

  FLocker.Leave;
end;

procedure TAqReadList<T>.VerifyLocker;
begin
  if not Assigned(FLocker) then
  begin
    raise EAqInternal.Create(StrThisListDoesntHaveALocker);
  end;
end;

destructor TAqReadList<T>.Destroy;
begin
  FLocker.Free;

  inherited;
end;

function TAqReadList<T>.Find(const pMatchFunction: TFunc<T, Boolean>; out pValue: T): Boolean;
var
  lI: Int32;
begin
  Result := False;
  lI := 0;

  while not Result and (lI < Count) do
  begin
    Result := pMatchFunction(Items[lI]);

    if Result then
    begin
      pValue := Items[lI];
    end;

    Inc(lI);
  end;
end;

function TAqReadList<T>.GetFirst: T;
begin
  try
    Result := FList.First;
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create(StrItWasNotPossibleToGetTheFirstItemFromTheList));
    end;
  end;
end;

function TAqReadList<T>.GetLast: T;
begin
  try
    Result := FList.Last;
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create(StrItWasNotPossibleToGetTheLastItemFromTheList));
    end;
  end;
end;

{ TAqAVLNode<T> }

constructor TAqAVLNode<T>.Create(const pValue: T; const pFreeObject: Boolean);
begin
  FFreeObject := pFreeObject;
  FValue := pValue;
end;

destructor TAqAVLNode<T>.Destroy;
begin
  if FFreeObject then
  begin
    PObject(@FValue)^.Free;
  end;

  inherited;
end;

function TAqAVLNode<T>.GetBalancing: Int8;
begin
  Result := FDepths[TAqNodeType.antLeft] - FDepths[TAqNodeType.antRight];
end;

function TAqAVLNode<T>.GetConnection(pType: TAqNodeType): TAqAVLNode<T>;
begin
  Result := FConnections[pType];
end;

function TAqAVLNode<T>.GetEndNode(const pDirection: TAqNodeType): TAqAVLNode<T>;
begin
  Result := Self;

  while Assigned(Result.Connections[pDirection]) do
  begin
    Result := Result.Connections[pDirection];
  end;
end;

function TAqAVLNode<T>.GetDepth: UInt32;
begin
  Result := Max(FDepths[TAqNodeType.antLeft], FDepths[TAqNodeType.antRight]);
end;

function TAqAVLNode<T>.GetSucessor(out pSucessor: TAqAVLNode<T>): Boolean;
begin
  Result := GetSucessorFromSide(TAqNodeType.antLeft, pSucessor) or GetSucessorFromSide(TAqNodeType.antRight, pSucessor);
end;

function TAqAVLNode<T>.GetSucessorFromSide(pDirection: TAqNodeType; out pSucessor: TAqAVLNode<T>): Boolean;
begin
  Result := Assigned(FConnections[pDirection]);

  if Result then
  begin
    pSucessor := FConnections[pDirection];

    pDirection := ReverseDirection(pDirection);

    pSucessor := pSucessor.GetEndNode(pDirection);
  end;
end;

class function TAqAVLNode<T>.ReverseDirection(const pDirection: TAqNodeType): TAqNodeType;
begin
  case pDirection of
    TAqNodeType.antLeft:
      begin
        Result := TAqNodeType.antRight;
      end;
    TAqNodeType.antRight:
      begin
        Result := TAqNodeType.antLeft;
      end;
  else
    Result := TAqNodeType.antRoot;
  end;
end;

procedure TAqAVLNode<T>.RecalculateDepth(const pSide: TAqNodeType);
begin
  if pSide in [TAqNodeType.antLeft..TAqNodeType.antRight] then
  begin
    if Assigned(FConnections[pSide]) then
    begin
      FDepths[pSide] := FConnections[pSide].Depth + 1;
    end else begin
      FDepths[pSide] := 0;
    end;
  end;
end;

procedure TAqAVLNode<T>.RecalculateDepths;
begin
  RecalculateDepth(TAqNodeType.antLeft);
  RecalculateDepth(TAqNodeType.antRight);
end;

procedure TAqAVLNode<T>.SetConnection(const pType: TAqNodeType; const pNode: TAqAVLNode<T>);
begin
  FConnections[pType] := pNode;

  if Assigned(pNode) and (pType in [TAqNodeType.antLeft..TAqNodeType.antRight]) then
  begin
    pNode.SetConnection(TAqNodeType.antRoot, Self);
    pNode.SetType(pType);
  end else if not Assigned(pNode) and (pType = TAqNodeType.antRoot) then
  begin
    Self.SetType(TAqNodeType.antRoot);
  end;
end;

procedure TAqAVLNode<T>.SetType(const pType: TAqNodeType);
begin
  FNodeType := pType;
end;

{ TAqCustomAVLTree<T> }

function TAqCustomAVLTree<TKey, TValue>.Add(const pValue: TValue): Boolean;
var
  lNode: TAqAVLNode<TValue>;
  lDirection: TAqNodeType;
begin
  Result := not Assigned(FRoot);

  try
    if not Result then
    begin
      Result := not FindNode(GetKeyFromValue(pValue), lNode, lDirection);

      if Result then
      begin
        lNode.SetConnection(lDirection, TAqAVLNode<TValue>.Create(pValue, FFreeObjects));

        RecalculateDepths(lNode);
      end;
    end else
    begin
      FRoot := TAqAVLNode<TValue>.Create(pValue, FFreeObjects);
    end;
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create(StrCouldNotAddTheValueToTheTree));
    end;
  end;
end;

constructor TAqCustomAVLTree<TKey, TValue>.Create(const pFreeObjects: Boolean; const pCreateLocker: Boolean);
begin
  Create(pFreeObjects, nil, pCreateLocker);
end;

constructor TAqCustomAVLTree<TKey, TValue>.Create;
begin
  inherited Create;
end;

constructor TAqCustomAVLTree<TKey, TValue>.Create(const pFreeObjects: Boolean;
  const pComparer: TAqComparerFunction<TKey>; const pCreateLocker: Boolean);
begin
  Create;

  FFreeObjects := pFreeObjects;
  FComparer := pComparer;

  if pCreateLocker then
  begin
    FLocker := TCriticalSection.Create;
  end;
end;

constructor TAqCustomAVLTree<TKey, TValue>.Create(const pComparer: TAqComparerFunction<TKey>;
  const pCreateLocker: Boolean);
begin
  Create(False, pComparer, pCreateLocker);
end;

function TAqCustomAVLTree<TKey, TValue>.Delete(const pKey: TKey): Boolean;
var
  lNode: TAqAVLNode<TValue>;
  lSuccessor: TAqAVLNode<TValue>;
  lNodeToRecalculate: TAqAVLNode<TValue>;
begin
  try
    Result := Find(pKey, lNode);

    if Result then
    begin
      if lNode.GetSucessor(lSuccessor) then
      begin
        if lSuccessor.Root = lNode then
        begin
          lNodeToRecalculate := lSuccessor;
        end else begin
          lSuccessor.Root.SetConnection(lSuccessor.NodeType,
            lSuccessor.Connections[lSuccessor.ReverseDirection(lSuccessor.NodeType)]);
          lNodeToRecalculate := lSuccessor.Root;
        end;

        if Assigned(lNode.Root) then
        begin
          lNode.Root.SetConnection(lNode.NodeType, lSuccessor);
        end else begin
          lSuccessor.SetConnection(TAqNodeType.antRoot, nil);
          FRoot := lSuccessor;
        end;

        if lNode.Left <> lSuccessor then
        begin
          lSuccessor.SetConnection(TAqNodeType.antLeft, lNode.Left);
        end;

        if lNode.Right <> lSuccessor then
        begin
          lSuccessor.SetConnection(TAqNodeType.antRight, lNode.Right);
        end;
      end else begin
        if Assigned(lNode.Root) then
        begin
          lNodeToRecalculate := lNode.Root;
          lNode.Root.SetConnection(lNode.NodeType, nil);
        end else begin
          FRoot := nil;
          lNodeToRecalculate := nil;
        end;
      end;

      if Assigned(lNodeToRecalculate) then
      begin
        RecalculateDepths(lNodeToRecalculate);
      end;

      lNode.SetConnection(TAqNodeType.antRoot, nil);
      lNode.SetConnection(TAqNodeType.antLeft, nil);
      lNode.SetConnection(TAqNodeType.antRight, nil);

      DestroyNode(lNode);
    end;
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create(StrFailedWhenTryingToDeleteAValueInTheTree));
    end;
  end;
end;

destructor TAqCustomAVLTree<TKey, TValue>.Destroy;
begin
  FLocker.Free;
  Clear;

  inherited;
end;

procedure TAqCustomAVLTree<TKey, TValue>.DestroyNode(const pNode: TAqAVLNode<TValue>);
begin
  if Assigned(pNode.Left) then
  begin
    DestroyNode(pNode.Left);
  end;

  if Assigned(pNode.Right) then
  begin
    DestroyNode(pNode.Right);
  end;

{$IFNDEF AUTOREFCOUNT}
  pNode.Free;
{$ENDIF}
end;

function TAqCustomAVLTree<TKey, TValue>.GetList: IAqResultList<TValue>;
var
  lResultList: TAqResultList<TValue>;
begin
  lResultList := TAqResultList<TValue>.Create;

  try
    TraverseTreeInOrder(lResultList, FRoot);
  except
    on E: Exception do
    begin
      lResultList.Free;
      E.RaiseOuterException(EAqInternal.Create(StrFailedToTraverseTheAVLTree));
    end;
  end;

  Result := lResultList;
end;

procedure TAqCustomAVLTree<TKey, TValue>.Lock;
begin
  VerifyLocker;

  FLocker.Enter;
end;

procedure TAqCustomAVLTree<TKey, TValue>.Clear;
begin
  try
    if Assigned(FRoot) then
    begin
      DestroyNode(FRoot);
    end;

    FRoot := nil;
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create(StrFaliedWhenCleaningTheTree));
    end;
  end;
end;

function TAqCustomAVLTree<TKey, TValue>.Find(const pKey: TKey; out pNode: TAqAVLNode<TValue>): Boolean;
var
  lNodeType: TAqNodeType;
begin
  try
    Result := FindNode(pKey, pNode, lNodeType);
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create(StrFailedWhenTryingToFindAValueInTheTree));
    end;
  end;
end;

function TAqCustomAVLTree<TKey, TValue>.FindNode(const pKey: TKey; out pNode: TAqAVLNode<TValue>;
  out pNodeType: TAqNodeType): Boolean;
var
  lNextNode: TAqAVLNode<TValue>;
begin
  lNextNode := FRoot;
  Result := False;

  while Assigned(lNextNode) and not Result do
  begin
    case Compare(GetKeyFromValue(lNextNode.Value), pKey) of
      TAqComparisonResult.acrEqual:
        begin
          Result := True;
          pNodeType := TAqNodeType.antRoot;
        end;
      TAqComparisonResult.acrGreater:
        begin
          pNodeType := TAqNodeType.antRight;
        end;
      TAqComparisonResult.acrLess:
        begin
          pNodeType := TAqNodeType.antLeft;
        end;
    end;

    pNode := lNextNode;

    if not Result then
    begin
      lNextNode := lNextNode.Connections[pNodeType];
    end;
  end;
end;

procedure TAqCustomAVLTree<TKey, TValue>.TraverseTreeInOrder(const pList: TAqResultList<TValue>;
  const pNode: TAqAVLNode<TValue>);
begin
  if Assigned(pNode) then
  begin
    TraverseTreeInOrder(pList, pNode.Left);
    pList.Add(pNode.Value);
    TraverseTreeInOrder(pList, pNode.Right);
  end;
end;

procedure TAqCustomAVLTree<TKey, TValue>.VerifyLocker;
begin
  if not Assigned(FLocker) then
  begin
    raise EAqInternal.Create(StrThisListDoesntHaveALocker);
  end;
end;

procedure TAqCustomAVLTree<TKey, TValue>.RecalculateDepths(const pNode: TAqAVLNode<TValue>);
var
  lBalancing: Int8;
  lLevel1: TAqNodeType;
  lLevel2: TAqNodeType;
  lPivot: TAqAVLNode<TValue>;
begin
  pNode.RecalculateDepths;

  lBalancing := pNode.Balancing;

  if Abs(lBalancing) > 1 then
  begin
    if lBalancing > 0 then
    begin
      lLevel1 := TAqNodeType.antLeft;
    end else begin
      lLevel1 := TAqNodeType.antRight;
    end;

    lBalancing := pNode.Connections[lLevel1].Balancing;

    if lBalancing = 0 then
    begin
      lLevel2 := lLevel1;
    end else if lBalancing > 0 then
    begin
      lLevel2 := TAqNodeType.antLeft;
    end else begin
      lLevel2 := TAqNodeType.antRight;
    end;

    if lLevel1 = lLevel2 then
    begin
      Rotate(TAqAVLNode<TValue>.ReverseDirection(lLevel1), pNode.Connections[lLevel1]);
      RecalculateDepths(pNode);
    end else begin
      lPivot := pNode.Connections[lLevel1].Connections[lLevel2];
      Rotate(lLevel1, lPivot);
      Rotate(lLevel2, lPivot);
      lPivot.Connections[TAqNodeType.antLeft].RecalculateDepths;
      lPivot.Connections[TAqNodeType.antRight].RecalculateDepths;
      RecalculateDepths(lPivot);
    end;
  end else if Assigned(pNode.Root) then
  begin
    RecalculateDepths(pNode.Root);
  end;
end;

procedure TAqCustomAVLTree<TKey, TValue>.Release;
begin
  VerifyLocker;

  FLocker.Leave;
end;

procedure TAqCustomAVLTree<TKey, TValue>.Rotate(const pDirection: TAqNodeType; const pNode: TAqAVLNode<TValue>);
var
  lLevel0: TAqAVLNode<TValue>;
  lLevel1: TAqAVLNode<TValue>;
  lLevel2: TAqAVLNode<TValue>;
  lLevel3: TAqAVLNode<TValue>;
  lReverseDirection: TAqNodeType;
  lType1: TAqNodeType;
begin
  if Assigned(pNode.Root) and (pDirection in [TAqNodeType.antLeft..TAqNodeType.antRight]) then
  begin
    lLevel1 := pNode.Root;
    lLevel0 := lLevel1.Root;
    lLevel2 := pNode;
    lLevel3 := pNode.Connections[pDirection];
    lType1 := lLevel1.NodeType;

    lReverseDirection := TAqAVLNode<TValue>.ReverseDirection(pDirection);

    lLevel2.SetConnection(pDirection, lLevel1);
    lLevel1.SetConnection(lReverseDirection, lLevel3);

    if Assigned(lLevel0) then
    begin
      lLevel0.SetConnection(lType1, lLevel2);
    end else
    begin
      lLevel2.SetConnection(TAqNodeType.antRoot, nil);
      FRoot := lLevel2;
    end;
  end;
end;

function TAqCustomAVLTree<TKey, TValue>.CheckIsEmpty: Boolean;
begin
  Result := not Assigned(FRoot);
end;

function TAqCustomAVLTree<TKey, TValue>.Compare(const pValue1, pValue2: TKey): TAqComparisonResult;
begin
  if not Assigned(FComparer) then
  begin
    FComparer :=
      function(const pValue1, pValue2: TKey): TAqComparisonResult
      var
        lComparacaoBinaria: Int32;
      begin
        lComparacaoBinaria := BinaryCompare(Pointer(@pValue1), Pointer(@pValue2), SizeOf(TKey));

        if lComparacaoBinaria = 0 then
        begin
          Result := TAqComparisonResult.acrEqual;
        end else if lComparacaoBinaria < 0 then
        begin
          Result := TAqComparisonResult.acrGreater;
        end else begin
          Result := TAqComparisonResult.acrLess;
        end;
      end;
  end;

  Result := FComparer(pValue1, pValue2);
end;

{ TAqAVLTree<T> }

function TAqAVLTree<T>.GetKeyFromValue(const pValue: T): T;
begin
  Result := pValue;
end;

function TAqAVLTree<T>.Find(const pValue: T): Boolean;
var
  lNode: TAqAVLNode<T>;
begin
  Result := Find(pValue, lNode);
end;

{ TAqIDGenerator }

class constructor TAqIDGenerator.Create;
begin
  FLocker := TCriticalSection.Create;
  FUsedIDs := TAqAVLTree<TAqID>.Create;
end;

class destructor TAqIDGenerator.Destroy;
begin
  FUsedIDs.Free;
  FLocker.Free;
end;

class function TAqIDGenerator.Generate: TAqID;
var
  lGeneretadID: Boolean;
  lAttempts: UInt16;
  lI: UInt8;
begin
  FLocker.Enter;

  try
    lAttempts := 1000;

    repeat
      Result := 0;
      for lI := 1 to SizeOf(Result) do
      begin
        Result := (Result shl 8) + UInt8(Random(High(UInt8) + 1));
      end;

      lGeneretadID := not FUsedIDs.Find(Result);

      if not lGeneretadID then
      begin
        Dec(lAttempts);
      end;
    until (lGeneretadID and (Result <> 0)) or (lAttempts = 0);

    if not lGeneretadID then
    begin
      // válvula de escape
      Result := 1;

      while (Result < High(TAqID)) and FUsedIDs.Find(Result) do
      begin
        Inc(Result);
      end;
    end;

    if not FUsedIDs.Add(Result) then
    begin
      raise EAqInternal.Create(StrFailedWhenGeneratingUniqueID);
    end;
  finally
    FLocker.Leave;
  end;
end;

class procedure TAqIDGenerator.Release(const pID: TAqID);
begin
  FLocker.Enter;

  try
    FUsedIDs.Delete(pID);
  finally
    FLocker.Leave;
  end;
end;

{ TAqIDDictionary<TValue> }

function TAqIDDictionary<TValue>.Add(const pValor: TValue): TAqID;
begin
  Result := TAqIDGenerator.Generate;

  try
    inherited Add(Result, pValor);
  except
    TAqIDGenerator.Release(Result);
    raise;
  end;
end;

constructor TAqIDDictionary<TValue>.Create(const pOwnsValues: Boolean);
begin
  if pOwnsValues then
  begin
    inherited Create([doOwnsValues]);
  end else begin
    inherited Create;
  end;
end;

destructor TAqIDDictionary<TValue>.Destroy;
begin
  ReleaseIDs;

  inherited;
end;

procedure TAqIDDictionary<TValue>.KeyNotify(const Key: TAqID; Action: TCollectionNotification);
begin
  inherited;

  if Action = cnRemoved then
  begin
    TAqIDGenerator.Release(Key);
  end;
end;

procedure TAqIDDictionary<TValue>.ReleaseIDs;
var
  lID: TAqID;
begin
  for lID in Keys do
  begin
    TAqIDGenerator.Release(lID);
  end;
end;

{ TAqDictionary<TKey, TValue> }

function TAqDictionary<TKey, TValue>.Add(const pKey: Tkey; const pValue: TValue): Boolean;
begin
  Result := not ContainsKey(pKey);

  if Result then
  begin
    inherited Add(pKey, pValue);
  end;
end;

constructor TAqDictionary<TKey, TValue>.Create(const pOwnerships: TAqDictionaryContents; const pCreateLocker: Boolean);
var
  lSet: TDictionaryOwnerships;
begin
  lSet := [];

  if adcKey in pOwnerships then
  begin
    Include(lSet, doOwnsKeys);
  end;

  if adcValue in pOwnerships then
  begin
    Include(lSet, doOwnsValues);
  end;

  inherited Create(lSet);

  if pCreateLocker then
  begin
    FLocker := TCriticalSection.Create;
  end;
end;

destructor TAqDictionary<TKey, TValue>.Destroy;
begin
  FLocker.Free;

  inherited;
end;

procedure TAqDictionary<TKey, TValue>.Lock;
begin
  VerifyLocker;

  FLocker.Enter;
end;

procedure TAqDictionary<TKey, TValue>.Release;
begin
  VerifyLocker;

  FLocker.Leave;
end;

procedure TAqDictionary<TKey, TValue>.VerifyLocker;
begin
  if not Assigned(FLocker) then
  begin
    raise EAqInternal.Create(StrThisListDoesntHaveALocker);
  end;
end;

{ TAqListTransporter }

class function TAqListTransporter.Transport<TFrom, TTo>(const pFrom: IAqResultList<TFrom>): TObjectList<TTo>;
var
  lObject: TFrom;
begin
  Result := TObjectList<TTo>.Create;

  try
    for lObject in pFrom do
    begin
      Result.Add(TObject(lObject).CloneTo<TTo>);
    end;
  except
    Result.Free;
    raise;
  end;
end;

{ TAqComparer<T> }

function TAqComparer<T>.Compare(const Left, Right: T): Int32;
begin
  Result := FComparerFunction(Left, Right);
end;

constructor TAqComparer<T>.Create(const pComparerFunction: TFunc<T, T, Int32>);
begin
  FComparerFunction := pComparerFunction;
end;

end.
