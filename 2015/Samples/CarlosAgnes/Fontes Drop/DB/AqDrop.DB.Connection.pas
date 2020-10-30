unit AqDrop.DB.Connection;

interface

uses
  System.Classes,
  System.SyncObjs,
  System.SysUtils,
  AqDrop.Core.Manager,
  AqDrop.Core.Collections.Intf,
  AqDrop.Core.Collections,
  AqDrop.DB.Types,
  AqDrop.DB.SQL,
  AqDrop.DB.Adapter,
  AqDrop.DB.SQL.Intf;

type
  TAqDBConnectionClass = class of TAqDBConnection;

  /// ------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Abstract class for connections with SGBDs.
  ///   PT-BR:
  ///     Classe abstrata base para conexões com SGBDs.
  /// </summary>
  /// ------------------------------------------------------------------------------------------------------------------
  TAqDBConnection = class abstract(TAqManager<TObject>)
  strict private
    FOnwsAdapter: Boolean;

    FTransactionCalls: UInt32;
    FAdapter: TAqDBAdapter;
    FReaders: UInt32;
    FOnFirstReaderOpened: TProc<TAqDBConnection>;
    FOnLastReaderClosed: TProc<TAqDBConnection>;

    procedure CheckConnectionActive;

    function PrepareCommand(const pPreparingFunction: TFunc<TAqID>): TAqID; overload;
    function OpenQuery(const pOpeningFunction: TFunc<IAqDBReader>): IAqDBReader; overload;
    function ExecuteCommand(const pExecutionFunction: TFunc<Int64>): Int64; overload;

    class var FConnections: TAqList<TAqDBConnection>;
  private
    property OnFirstReaderOpened: TProc<TAqDBConnection> read FOnFirstReaderOpened write FOnFirstReaderOpened;
    property OnLastReaderClosed: TProc<TAqDBConnection> read FOnLastReaderClosed write FOnLastReaderClosed;
  strict protected
    procedure DoStartTransaction; virtual; abstract;
    procedure DoCommitTransaction; virtual; abstract;
    procedure DoRollbackTransaction; virtual; abstract;

    function DoPrepareCommand(const pSQL: string;
      const pParametersInitializer: TAqDBParametersHandlerMethod): TAqID; overload; virtual; abstract;
    function DoPrepareCommand(const pSQLCommand: IAqDBSQLCommand;
      const pParametersInitializer: TAqDBParametersHandlerMethod): TAqID; overload; virtual;

    procedure DoUnprepareCommand(const pCommandID: TAqID); virtual; abstract;

    function DoExecuteCommand(const pSQL: string;
      const pParametersHandler: TAqDBParametersHandlerMethod): Int64; overload; virtual; abstract;
    function DoExecuteCommand(const pSQLCommand: IAqDBSQLCommand;
      const pParametersHandler: TAqDBParametersHandlerMethod): Int64; overload; virtual;
    function DoExecuteCommand(const pCommandID: TAqID;
      const pParametersHandler: TAqDBParametersHandlerMethod): Int64; overload; virtual; abstract;

    function DoOpenQuery(const pSQL: string;
      const pParametersHandler: TAqDBParametersHandlerMethod): IAqDBReader; overload; virtual; abstract;
    function DoOpenQuery(const pSQLCommand: IAqDBSQLSelect;
      const pParametersHandler: TAqDBParametersHandlerMethod): IAqDBReader; overload; virtual;
    function DoOpenQuery(const pCommandID: TAqID;
      const pParametersHandler: TAqDBParametersHandlerMethod): IAqDBReader; overload; virtual; abstract;

    function GetActive: Boolean; virtual; abstract;
    procedure SetActive(const pValue: Boolean); virtual;
    function GetInTransaction: Boolean;

    procedure DoConnect; virtual; abstract;
    procedure DoDisconnect; virtual; abstract;

    function CreateAdapter: TAqDBAdapter; virtual;
    class function GetDefaultAdapter: TAqDBAdapterClass; virtual;

    procedure RaiseImpossibleToConnect(const pEBase: Exception);

    property TransactionCalls: UInt32 read FTransactionCalls;
  protected
    procedure SetAdapter(const pAdapter: TAqDBAdapter); overload; virtual;
    procedure SetAdapter(const pAdapter: TAqDBAdapter; const pOwnsAdapter: Boolean); overload; virtual;
    function ExtractAdapter: TAqDBAdapter;
    procedure IncreaseReaderes;
    procedure DecrementReaders;
  public
    class constructor Create;
    class destructor Destroy;

    /// <summary>
    ///   EN-US:
    ///     Class copnstructor.
    ///   PT-BR:
    ///     Construtor da classe.
    /// </summary>
    constructor Create; virtual;
    /// <summary>
    ///   EN-US:
    ///     Class destructor.
    ///   PT-BR:
    ///     Destrutor da classe.
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    ///   EN-US:
    ///     Opens the connection.
    ///   PT-BR:
    ///     Abre a conexão.
    /// </summary>
    procedure Connect; virtual;
    /// <summary>
    ///   EN-US:
    ///     Closes the connection.
    ///   PT-BR:
    ///     Fecha a conexão.
    /// </summary>
    procedure Disconnect; virtual;

    procedure StartTransaction; virtual;
    procedure CommitTransaction; virtual;
    procedure RollbackTransaction; virtual;

    function PrepareCommand(const pSQL: string;
      const pParametersInitializer: TAqDBParametersHandlerMethod = nil): TAqID; overload; virtual;
    function PrepareCommand(const pSQLCommand: IAqDBSQLCommand;
      const pParametersInitializer: TAqDBParametersHandlerMethod = nil): TAqID; overload; virtual;

    procedure UnprepareCommand(const pCommandID: TAqID); virtual;

    /// <summary>
    ///   EN-US:
    ///     Executes a command.
    ///   PT-BR:
    ///     Executa um comando.
    /// </summary>
    /// <param name="pSQL">
    ///   EN-US:
    ///     SQL instruction to be executed.
    ///   PT-BR:
    ///     Instrução SQL a ser executada.
    /// </param>
    /// <param name="pParametersHandler">
    ///   EN-US:
    ///     Anonymous method to handle the parameters values of the command.
    ///   PT-BR:
    ///     Método anônimo para escrita dos valores de entrada dos parâmetros.
    /// </param>
    /// <returns>
    ///   EN-US:
    ///     Returns the affected rows count.
    ///   PT-BR:
    ///     Retorna a quantidade de registros afetados.
    /// </returns>
    function ExecuteCommand(const pSQL: string;
      const pParametersHandler: TAqDBParametersHandlerMethod = nil): Int64; overload; virtual;
    function ExecuteCommand(const pSQLCommand: IAqDBSQLCommand;
      const pParametersHandler: TAqDBParametersHandlerMethod = nil): Int64; overload; virtual;
    function ExecuteCommand(const pCommandID: TAqID;
      const pParametersHandler: TAqDBParametersHandlerMethod = nil): Int64; overload; virtual;

    function OpenQuery(const pSQL: string;
      const pParametersHandler: TAqDBParametersHandlerMethod = nil): IAqDBReader; overload;
    function OpenQuery(const pSQLCommand: IAqDBSQLSelect;
      const pParametersHandler: TAqDBParametersHandlerMethod = nil): IAqDBReader; overload;
    function OpenQuery(const pCommandID: TAqID;
      const pParametersHandler: TAqDBParametersHandlerMethod = nil): IAqDBReader; overload;

    function GetAutoIncrement(const pGenerator: string = ''): Int64; virtual;

    property Adapter: TAqDBAdapter read FAdapter write SetAdapter;
    property Active: Boolean read GetActive write SetActive;
    property InTransaction: Boolean read GetInTransaction;
  end;

  TAqDBPooledConnection<TBaseConnection: TAqDBConnection> = class(TAqDBConnection)
  strict protected type
    TAqDBContext = class
    strict private
      FMasterConnection: TAqDBPooledConnection<TBaseConnection>;
      FLockerThread: TThreadID;
      FConnection: TBaseConnection;
      FPreparedQueries: TAqDictionary<TAqID, TAqID>;
      FCalls: UInt32;
      FLastUsedAt: TDateTime;

      function GetIsLocked: Boolean;
    public
      constructor Create(const pMasterConnections: TAqDBPooledConnection<TBaseConnection>;
        const pBaseConection: TBaseConnection);
      destructor Destroy; override;

      procedure LockConnection;
      procedure ReleaseConnection;

      function GetCommandID(const pMasterCommandID: TAqID): TAqID;

      property Connection: TBaseConnection read FConnection;
      property LockerThread: TThreadID read FLockerThread;
      property Locked: Boolean read GetIsLocked;
      property PreparedQueries: TAqDictionary<TAqID, TAqID> read FPreparedQueries;
      property LastUsedAt: TDateTime read FLastUsedAt;
    end;
  strict private type
    TAqDBFlushContextsThread = class(TThread)
    strict private
      FAutoFlushContextsTime: UInt32;
      FPool: TAqList<TAqDBContext>;

      procedure SetAutoFlushContextsTime(const pValue: UInt32);
    protected
      procedure Execute; override;
    public
      constructor Create(const pPool: TAqList<TAqDBContext>);

      property AutoFlushContextsTime: UInt32 read FAutoFlushContextsTime write SetAutoFlushContextsTime;
    end;

    TAqDBPreparedQuery = class
    strict private
        FSQL: string;
        FParametersInitializer: TAqDBParametersHandlerMethod;
    public
      constructor Create(const pSQL: string; const pParametersInitializer: TAqDBParametersHandlerMethod);

      property SQL: string read FSQL write FSQL;
      property ParametersInitializer: TAqDBParametersHandlerMethod read FParametersInitializer
        write FParametersInitializer;
    end;
  strict private
    FPool: TAqList<TAqDBContext>;
    FConnectionBuilder: TFunc<TBaseConnection>;
    FPreparedQueries: TAqIDDictionary<TAqDBPreparedQuery>;
    FFlushContextsThread: TAqDBFlushContextsThread;

    procedure SolvePoolAndExecute(const pMethod: TProc<TAqDBContext>);
    function GetActiveConnections: Int32;
    function GetAutoFlushContextsTime: UInt32;
    procedure SetAutoFlushContextsTime(const pValue: UInt32);
    procedure FreeFlushContextThread;
  strict protected
    procedure DoStartTransaction; override;
    procedure DoCommitTransaction; override;
    procedure DoRollbackTransaction; override;

    function DoPrepareCommand(const pSQL: string;
      const pParametersInitializer: TAqDBParametersHandlerMethod): TAqID; override;
    function DoPrepareCommand(const pSQLCommand: IAqDBSQLCommand;
      const pParametersInitializer: TAqDBParametersHandlerMethod): TAqID; override;

    procedure DoUnprepareCommand(const pCommandID: TAqID); override;

    function DoExecuteCommand(const pSQL: string;
      const pTratadorParametros: TAqDBParametersHandlerMethod): Int64; override;
    function DoExecuteCommand(const pSQLCommand: IAqDBSQLCommand;
      const pTratadorParametros: TAqDBParametersHandlerMethod): Int64; override;
    function DoExecuteCommand(const pCommandID: TAqID;
      const pTratadorParametros: TAqDBParametersHandlerMethod): Int64; override;

    function DoOpenQuery(const pSQL: string;
      const pTratadorParametros: TAqDBParametersHandlerMethod): IAqDBReader; override;
    function DoOpenQuery(const pSQLCommand: IAqDBSQLSelect;
      const pTratadorParametros: TAqDBParametersHandlerMethod): IAqDBReader; override;
    function DoOpenQuery(const pCommandID: TAqID;
      const pTratadorParametros: TAqDBParametersHandlerMethod): IAqDBReader; override;

    function GetActive: Boolean; override;

    function CreateNewContext: TAqDBContext; virtual;

    procedure DoConnect; override;
    procedure DoDisconnect; override;

    {TODO: hoje reativar}
//    function GetInTransaction: Boolean; override;

    class function GetDefaultAdapter: TAqDBAdapterClass; override;
  protected
    procedure SetAdapter(const pAdapter: TAqDBAdapter); override;

    property PreparedQueries: TAqIDDictionary<TAqDBPreparedQuery> read FPreparedQueries;
  public
    constructor Create(const pConnectionBuilder: TFunc<TBaseConnection>); reintroduce; virtual;
    destructor Destroy; override;

    procedure StartTransaction; override;
    procedure CommitTransaction; override;
    procedure RollbackTransaction; override;

    property ActiveConnections: Int32 read GetActiveConnections;
    property AutoFlushContextsTime: UInt32 read GetAutoFlushContextsTime write SetAutoFlushContextsTime;
  end;

implementation

uses
  System.DateUtils,
  AqDrop.Core.Exceptions,
  AqDrop.Core.Helpers;

{ TAqDBConnection }

function TAqDBConnection.OpenQuery(const pSQL: string;
  const pParametersHandler: TAqDBParametersHandlerMethod): IAqDBReader;
begin
  Result := OpenQuery(
    function: IAqDBReader
    begin
      Result := DoOpenQuery(pSQL, pParametersHandler);
    end);
end;

procedure TAqDBConnection.CheckConnectionActive;
begin
  if not Active then
  begin
    raise EAqInternal.Create('Connection is not active.');
  end;
end;

function TAqDBConnection.OpenQuery(const pCommandID: TAqID;
  const pParametersHandler: TAqDBParametersHandlerMethod): IAqDBReader;
begin
  Result := OpenQuery(
    function: IAqDBReader
    begin
      Result := DoOpenQuery(pCommandID, pParametersHandler);
    end);
end;

function TAqDBConnection.OpenQuery(const pSQLCommand: IAqDBSQLSelect;
  const pParametersHandler: TAqDBParametersHandlerMethod): IAqDBReader;
begin
  Result := OpenQuery(
    function: IAqDBReader
    begin
      Result := DoOpenQuery(pSQLCommand, pParametersHandler);
    end);
end;

function TAqDBConnection.OpenQuery(const pOpeningFunction: TFunc<IAqDBReader>): IAqDBReader;
begin
  try
    CheckConnectionActive;

    Result := pOpeningFunction;
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create('It wasn''t possible to open the query.'));
    end;
  end;
end;

procedure TAqDBConnection.Connect;
begin
  if not Active then
  begin
    SetActive(True);
  end;
end;

procedure TAqDBConnection.StartTransaction;
begin
  try
    CheckConnectionActive;

    if FTransactionCalls = 0 then
    begin
      DoStartTransaction;
    end;

    Inc(FTransactionCalls);
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create('It wasn''t possible to start the transaction.'));
    end;
  end;
end;

procedure TAqDBConnection.CommitTransaction;
begin
  try
    CheckConnectionActive;

    if FTransactionCalls = 0 then
    begin
      raise EAqInternal.Create('There is no transaction to commit.');
    end;

    Dec(FTransactionCalls);

    if FTransactionCalls = 0 then
    begin
      DoCommitTransaction;
    end;
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create('It wasn''t possible to commit the transaction.'));
    end;
  end;
end;

constructor TAqDBConnection.Create;
begin
  inherited;

  SetAdapter(CreateAdapter);

  FConnections.Add(Self);
end;

function TAqDBConnection.CreateAdapter: TAqDBAdapter;
var
  lAdapterClass: TAqDBAdapterClass;
begin
  lAdapterClass := GetDefaultAdapter;

  if Assigned(lAdapterClass) then
  begin
    Result := lAdapterClass.Create;
  end else begin
    Result := nil;
  end;
end;

class constructor TAqDBConnection.Create;
begin
  FConnections := TAqList<TAqDBConnection>.Create
end;

procedure TAqDBConnection.Disconnect;
begin
  if Active then
  begin
    SetActive(False);
  end;
end;

procedure TAqDBConnection.UnprepareCommand(const pCommandID: TAqID);
begin
  DoUnprepareCommand(pCommandID);
end;

procedure TAqDBConnection.DecrementReaders;
begin
  if FReaders > 0 then
  begin
    Dec(FReaders);

    if Assigned(FOnLastReaderClosed) and (FReaders = 0) then
    begin
      FOnLastReaderClosed(Self);
    end;
  end;
end;

destructor TAqDBConnection.Destroy;
var
  lI: Int32;
begin
  if FOnwsAdapter then
  begin
    FAdapter.Free;
  end;

  lI := FConnections.IndexOf(Self);

  if lI >= 0 then
  begin
    FConnections.Delete(lI);
  end;

  inherited;
end;

function TAqDBConnection.ExecuteCommand(const pExecutionFunction: TFunc<Int64>): Int64;
begin
  Result := 0;

  try
    CheckConnectionActive;

    Result := pExecutionFunction;
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create('It wasn''t possible to execute the command.'));
    end;
  end;
end;

function TAqDBConnection.ExecuteCommand(const pSQL: string;
  const pParametersHandler: TAqDBParametersHandlerMethod): Int64;
begin
  Result := ExecuteCommand(
    function: Int64
    begin
      Result := DoExecuteCommand(pSQL, pParametersHandler);
    end);
end;

function TAqDBConnection.GetAutoIncrement(const pGenerator: string): Int64;
var
  lReader: IAqDBReader;
  lQuery: string;
begin
  lQuery := Adapter.SQLSolver.GetAutoIncrementQuery(pGenerator);

  if lQuery.IsEmpty then
  begin
    Result := 0;
  end else begin
    lReader := OpenQuery(lQuery);

    if not lReader.Next then
    begin
      raise EAqInternal.Create('It wasn''t possible to get the generator value.');
    end;

    Result := lReader.Values[0].AsInt64;
  end;
end;

class function TAqDBConnection.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := TAqDBAdapter;
end;

function TAqDBConnection.GetInTransaction: Boolean;
begin
  Result := FTransactionCalls > 0;
end;

procedure TAqDBConnection.IncreaseReaderes;
begin
  if Assigned(FOnFirstReaderOpened) and (FReaders = 0) then
  begin
    FOnFirstReaderOpened(Self);
  end;

  Inc(FReaders);
end;

function TAqDBConnection.PrepareCommand(const pSQLCommand: IAqDBSQLCommand;
  const pParametersInitializer: TAqDBParametersHandlerMethod = nil): TAqID;
begin
  Result := PrepareCommand(
    function: TAqID
    begin
      Result := DoPrepareCommand(pSQLCommand, pParametersInitializer);
    end);
end;

function TAqDBConnection.PrepareCommand(const pPreparingFunction: TFunc<TAqID>): TAqID;
begin
  Result := 0;

  try
    CheckConnectionActive;

    Result := pPreparingFunction;
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create('It wasn''t possible to prepare the command.'));
    end;
  end;
end;

function TAqDBConnection.DoOpenQuery(const pSQLCommand: IAqDBSQLSelect;
  const pParametersHandler: TAqDBParametersHandlerMethod): IAqDBReader;
begin
  Result := DoOpenQuery(FAdapter.SQLSolver.SolveSelect(pSQLCommand), pParametersHandler);
end;

function TAqDBConnection.DoExecuteCommand(const pSQLCommand: IAqDBSQLCommand;
  const pParametersHandler: TAqDBParametersHandlerMethod): Int64;
begin
  Result := DoExecuteCommand(FAdapter.SQLSolver.SolveCommand(pSQLCommand), pParametersHandler);
end;

function TAqDBConnection.DoPrepareCommand(const pSQLCommand: IAqDBSQLCommand;
  const pParametersInitializer: TAqDBParametersHandlerMethod): TAqID;
begin
  Result := DoPrepareCommand(FAdapter.SQLSolver.SolveCommand(pSQLCommand), pParametersInitializer);
end;

procedure TAqDBConnection.RaiseImpossibleToConnect(const pEBase: Exception);
begin
  pEBase.RaiseOuterException(EAqFriendly.Create('It wasn''t possible to stablish a connection to the DB.'));
end;

procedure TAqDBConnection.RollbackTransaction;
begin
  try
    CheckConnectionActive;

    if FTransactionCalls = 0 then
    begin
      raise EAqInternal.Create('There are no transaction to revert.');
    end;

    Dec(FTransactionCalls);

    if FTransactionCalls = 0 then
    begin
      DoRollbackTransaction;
    end;
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create('It wasn''t possible to rollback the transaction.'));
    end;
  end;
end;

function TAqDBConnection.PrepareCommand(const pSQL: string;
  const pParametersInitializer: TAqDBParametersHandlerMethod = nil): TAqID;
begin
  Result := PrepareCommand(
    function: TAqID
    begin
      Result := DoPrepareCommand(pSQL, pParametersInitializer);
    end);
end;

procedure TAqDBConnection.SetAdapter(const pAdapter: TAqDBAdapter);
begin
  SetAdapter(pAdapter, True);
end;

procedure TAqDBConnection.SetActive(const pValue: Boolean);
begin
  inherited;

  if pValue xor Active then
  begin
    if pValue then
    begin
      DoConnect;
    end else begin
      DoDisconnect;
    end;
  end;
end;

procedure TAqDBConnection.SetAdapter(const pAdapter: TAqDBAdapter; const pOwnsAdapter: Boolean);
begin
  if FOnwsAdapter then
  begin
    FAdapter.Free;
  end;

  FAdapter := pAdapter;
  FOnwsAdapter := pOwnsAdapter;
end;

class destructor TAqDBConnection.Destroy;
begin
{$IFNDEF AUTOREFCOUNT}
  while FConnections.Count > 0 do
  begin
    FConnections.Last.Free;
  end;
{$ENDIF}
  FConnections.Free;
end;

function TAqDBConnection.ExecuteCommand(const pCommandID: TAqID;
  const pParametersHandler: TAqDBParametersHandlerMethod): Int64;
begin
  Result := ExecuteCommand(
    function: Int64
    begin
      Result := DoExecuteCommand(pCommandID, pParametersHandler);
    end);
end;

function TAqDBConnection.ExtractAdapter: TAqDBAdapter;
begin
  Result := FAdapter;
  FAdapter := nil;
  FOnwsAdapter := False;
end;

function TAqDBConnection.ExecuteCommand(const pSQLCommand: IAqDBSQLCommand;
  const pParametersHandler: TAqDBParametersHandlerMethod): Int64;
begin
  Result := ExecuteCommand(
    function: Int64
    begin
      Result := DoExecuteCommand(pSQLCommand, pParametersHandler);
    end);
end;


{ TAqDBPooledConnection<TBaseConnection> }

procedure TAqDBPooledConnection<TBaseConnection>.CommitTransaction;
begin
  SolvePoolAndExecute(
    procedure(pContext: TAqDBContext)
    begin
      pContext.Connection.CommitTransaction;
    end);
end;

constructor TAqDBPooledConnection<TBaseConnection>.Create(const pConnectionBuilder: TFunc<TBaseConnection>);
var
  lBaseContext: TAqDBContext;
begin
  FConnectionBuilder := pConnectionBuilder;

  FPreparedQueries := TAqIDDictionary<TAqDBPreparedQuery>.Create(True);
  FPool := TAqList<TAqDBContext>.Create(True, True);

  inherited Create;

  lBaseContext := CreateNewContext;

  if not Assigned(Adapter) then
  begin
    SetAdapter(lBaseContext.Connection.ExtractAdapter);
  end;

  AutoFlushContextsTime := 3 * SecsPerMin;
end;

function TAqDBPooledConnection<TBaseConnection>.CreateNewContext: TAqDBContext;
var
  lConnection: TAqDBConnection;
begin
  FPool.Lock;

  try
    Result := nil;
    try
      lConnection := FConnectionBuilder();
      try
        lConnection.Connect;

        if Assigned(Adapter) then
        begin
          lConnection.SetAdapter(Adapter, False);
        end;
      except
        lConnection.Free;
        raise;
      end;
      Result := TAqDBContext.Create(Self, lConnection);
      FPool.Add(Result);
    except
      Result.Free;
      raise;
    end;
  finally
    FPool.Release;
  end;
end;

destructor TAqDBPooledConnection<TBaseConnection>.Destroy;
begin
  FreeFlushContextThread;
  FPool.Free;
  FPreparedQueries.Free;

  inherited;
end;

class function TAqDBPooledConnection<TBaseConnection>.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := nil;
end;

procedure TAqDBPooledConnection<TBaseConnection>.RollbackTransaction;
begin
  SolvePoolAndExecute(
    procedure(pContext: TAqDBContext)
    begin
      pContext.Connection.RollbackTransaction;
    end);
end;

function TAqDBPooledConnection<TBaseConnection>.GetActive: Boolean;
begin
  FPool.Lock;

  try
    Result := FPool.First.Connection.Active;
  finally
    FPool.Release;
  end;
end;

function TAqDBPooledConnection<TBaseConnection>.GetActiveConnections: Int32;
begin
  FPool.Lock;

  try
    Result := FPool.Count;
  finally
    FPool.Release;
  end;
end;

function TAqDBPooledConnection<TBaseConnection>.GetAutoFlushContextsTime: UInt32;
begin
  if Assigned(FFlushContextsThread) then
  begin
    Result := 0;
  end else begin
    Result := FFlushContextsThread.AutoFlushContextsTime;
  end;
end;

//function TAqDBPooledConnection<TBaseConnection>.GetInTransaction: Boolean;
//var
//  lResult: Boolean;
//begin
//  SolvePoolAndExecute(
//    procedure(const pContext: TAqDBContext)
//    begin
//      lResult := pContext.Connection.InTransaction;
//    end);
//end;

function TAqDBPooledConnection<TBaseConnection>.DoOpenQuery(const pSQLCommand: IAqDBSQLSelect;
  const pTratadorParametros: TAqDBParametersHandlerMethod): IAqDBReader;
var
  lResult: IAqDBReader;
begin
  SolvePoolAndExecute(
    procedure(pContext: TAqDBContext)
    begin
      lResult := pContext.Connection.OpenQuery(pSQLCommand, pTratadorParametros);
    end);

  Result := lResult;
end;

function TAqDBPooledConnection<TBaseConnection>.DoOpenQuery(const pCommandID: TAqID;
  const pTratadorParametros: TAqDBParametersHandlerMethod): IAqDBReader;
var
  lResult: IAqDBReader;
begin
  SolvePoolAndExecute(
    procedure(pContext: TAqDBContext)
    begin
      lResult := pContext.Connection.OpenQuery(pContext.GetCommandID(pCommandID), pTratadorParametros);
    end);

  Result := lResult;
end;

function TAqDBPooledConnection<TBaseConnection>.DoOpenQuery(const pSQL: string;
  const pTratadorParametros: TAqDBParametersHandlerMethod): IAqDBReader;
var
  lResult: IAqDBReader;
begin
  SolvePoolAndExecute(
    procedure(pContext: TAqDBContext)
    begin
      lResult := pContext.Connection.OpenQuery(pSQL, pTratadorParametros);
    end);

  Result := lResult;
end;

procedure TAqDBPooledConnection<TBaseConnection>.DoStartTransaction;
begin
  raise EAqInternal.Create('The fisical transaction methods of this class cannot be called.');
end;

procedure TAqDBPooledConnection<TBaseConnection>.DoConnect;
var
  lContext: TAqDBContext;
begin
  FPool.Lock;

  try
    for lContext in FPool do
    begin
      lContext.Connection.Active := True;
    end;
  finally
    FPool.Release;
  end;
end;

procedure TAqDBPooledConnection<TBaseConnection>.DoCommitTransaction;
begin
  raise EAqInternal.Create('The fisical transaction methods of this class cannot be called.');
end;

procedure TAqDBPooledConnection<TBaseConnection>.DoDisconnect;
begin
  FPool.Lock;

  try
    FPool.First.Connection.Active := False;

    while FPool.Count > 1 do
    begin
      FPool.Delete(FPool.Count - 1);
    end;
  finally
    FPool.Release;
  end;
end;

procedure TAqDBPooledConnection<TBaseConnection>.DoUnprepareCommand(const pCommandID: TAqID);
var
  lContext: TAqDBContext;
  lContextCommandID: TAqID;
begin
  FPool.Lock;

  try
    for lContext in FPool do
    begin
      if lContext.PreparedQueries.TryGetValue(pCommandID, lContextCommandID) then
      begin
        lContext.Connection.UnprepareCommand(lContextCommandID);
        lContext.PreparedQueries.Remove(pCommandID);
      end;
    end;

    FPreparedQueries.Remove(pCommandID);
  finally
    FPool.Release;
  end;
end;

procedure TAqDBPooledConnection<TBaseConnection>.FreeFlushContextThread;
begin
  if Assigned(FFlushContextsThread) then
  begin
    FFlushContextsThread.Terminate;
    FFlushContextsThread.WaitFor;
    FreeAndNil(FFlushContextsThread);
  end;
end;

function TAqDBPooledConnection<TBaseConnection>.DoExecuteCommand(const pSQLCommand: IAqDBSQLCommand;
  const pTratadorParametros: TAqDBParametersHandlerMethod): Int64;
var
  lResult: Int64;
begin
  SolvePoolAndExecute(
    procedure(pContext: TAqDBContext)
    begin
      lResult := pContext.Connection.ExecuteCommand(pSQLCommand, pTratadorParametros);
    end);

  Result := lResult;
end;

function TAqDBPooledConnection<TBaseConnection>.DoExecuteCommand(const pCommandID: TAqID;
  const pTratadorParametros: TAqDBParametersHandlerMethod): Int64;
var
  lResult: Int64;
begin
  SolvePoolAndExecute(
    procedure(pContext: TAqDBContext)
    begin
      lResult := pContext.Connection.ExecuteCommand(pContext.GetCommandID(pCommandID), pTratadorParametros);
    end);

  Result := lResult;
end;

function TAqDBPooledConnection<TBaseConnection>.DoExecuteCommand(const pSQL: string;
  const pTratadorParametros: TAqDBParametersHandlerMethod): Int64;
var
  lResult: Int64;
begin
  SolvePoolAndExecute(
    procedure(pContext: TAqDBContext)
    begin
      lResult := pContext.Connection.ExecuteCommand(pSQL, pTratadorParametros);
    end);

  Result := lResult;
end;

function TAqDBPooledConnection<TBaseConnection>.DoPrepareCommand(const pSQLCommand: IAqDBSQLCommand;
  const pParametersInitializer: TAqDBParametersHandlerMethod): TAqID;
begin
  Result := DoPrepareCommand(FPool.First.Connection.Adapter.SQLSolver.SolveCommand(pSQLCommand),
    pParametersInitializer);
end;

function TAqDBPooledConnection<TBaseConnection>.DoPrepareCommand(const pSQL: string;
  const pParametersInitializer: TAqDBParametersHandlerMethod): TAqID;
begin
  Result := FPreparedQueries.Add(TAqDBPreparedQuery.Create(pSQL, pParametersInitializer));
end;

procedure TAqDBPooledConnection<TBaseConnection>.DoRollbackTransaction;
begin
  raise EAqInternal.Create('The fisical transaction methods of this class cannot be called.');
end;

procedure TAqDBPooledConnection<TBaseConnection>.SolvePoolAndExecute(const pMethod: TProc<TAqDBContext>);
var
  lI: Int32;
  lLockedContext: TAqDBContext;
  lAvailableContext: TAqDBContext;
  lThreadID: TThreadID;
begin
  FPool.Lock;

  try
    lI := FPool.Count;
    lLockedContext := nil;
    lAvailableContext := nil;
    lThreadID := TThread.CurrentThread.ThreadID;

    while not Assigned(lLockedContext) and (lI > 0) do
    begin
      Dec(lI);
      if FPool[lI].Locked and (FPool[lI].LockerThread = lThreadID) then
      begin
        lLockedContext := FPool[lI];
      end else if not FPool[lI].Locked then
      begin
        lAvailableContext := FPool[lI];
      end;
    end;

    if not Assigned(lLockedContext) then
    begin
      if Assigned(lAvailableContext) then
      begin
        lLockedContext := lAvailableContext;
      end else begin
        lLockedContext := CreateNewContext;
      end;
    end;

    lLockedContext.LockConnection;
  finally
    FPool.Release;
  end;

  try
    pMethod(lLockedContext);
  finally
    lLockedContext.ReleaseConnection;
  end;
end;

procedure TAqDBPooledConnection<TBaseConnection>.StartTransaction;
begin
  SolvePoolAndExecute(
    procedure(pContext: TAqDBContext)
    begin
      pContext.Connection.StartTransaction;
    end);
end;

procedure TAqDBPooledConnection<TBaseConnection>.SetAutoFlushContextsTime(const pValue: UInt32);
begin
  if pValue = 0 then
  begin
    FreeFlushContextThread;
  end else begin
    if not Assigned(FFlushContextsThread) then
    begin
      FFlushContextsThread := TAqDBFlushContextsThread.Create(FPool);
    end;

    FFlushContextsThread.AutoFlushContextsTime := pValue;
  end;
end;

procedure TAqDBPooledConnection<TBaseConnection>.SetAdapter(const pAdapter: TAqDBAdapter);
var
  lContext: TAqDBContext;
begin
  FPool.Lock;
  try
    inherited;

    for lContext in FPool do
    begin
      lContext.Connection.SetAdapter(pAdapter, False);
    end;
  finally
    FPool.Release;
  end;
end;

{ TAqDBPooledConnection<TBaseConnection>.TAqDBContext }

constructor TAqDBPooledConnection<TBaseConnection>.TAqDBContext.Create(
  const pMasterConnections: TAqDBPooledConnection<TBaseConnection>; const pBaseConection: TBaseConnection);
begin
  FMasterConnection := pMasterConnections;
  FConnection := pBaseConection;
  FPreparedQueries := TAqDictionary<TAqID, TAqID>.Create;
  FConnection.OnFirstReaderOpened :=
    procedure(pConnection: TAqDBConnection)
    begin
      Self.LockConnection;
    end;
  FConnection.OnLastReaderClosed :=
    procedure(pConnection: TAqDBConnection)
    begin
      Self.ReleaseConnection;
    end;
end;

destructor TAqDBPooledConnection<TBaseConnection>.TAqDBContext.Destroy;
begin
  FConnection.Free;
  FPreparedQueries.Free;

  inherited;
end;

function TAqDBPooledConnection<TBaseConnection>.TAqDBContext.GetCommandID(const pMasterCommandID: TAqID): TAqID;
var
  lPreparedQuery: TAqDBPreparedQuery;
begin
  if not FPreparedQueries.TryGetValue(pMasterCommandID, Result) then
  begin
    if not FMasterConnection.PreparedQueries.TryGetValue(pMasterCommandID, lPreparedQuery) then
    begin
      raise EAqInternal.CreateFmt('Command from ID %d not found.', [pMasterCommandID]);
    end;

    Result := FConnection.PrepareCommand(lPreparedQuery.SQL, lPreparedQuery.ParametersInitializer);

    try
      FPreparedQueries.Add(pMasterCommandID, Result);
    except
      FConnection.UnprepareCommand(Result);
      raise;
    end;
  end;
end;

function TAqDBPooledConnection<TBaseConnection>.TAqDBContext.GetIsLocked: Boolean;
begin
  Result := FLockerThread <> 0;
end;

procedure TAqDBPooledConnection<TBaseConnection>.TAqDBContext.ReleaseConnection;
begin
  Self.FMasterConnection.FPool.Lock;

  try
    if FCalls > 0 then
    begin
      Dec(FCalls);
      if not FConnection.InTransaction and (FCalls = 0) then
      begin
        FLockerThread := 0;
        FLastUsedAt := Now;
      end;
    end;
  finally
    Self.FMasterConnection.FPool.Release;
  end;
end;

procedure TAqDBPooledConnection<TBaseConnection>.TAqDBContext.LockConnection;
begin
  Self.FMasterConnection.FPool.Lock;

  try
    if (FLockerThread <> 0) and (FLockerThread <> TThread.CurrentThread.ThreadID) then
    begin
      raise EAqInternal.Create('This context is already locked to another thread.');
    end;

    FLockerThread := TThread.CurrentThread.ThreadID;
    Inc(FCalls);
  finally
    Self.FMasterConnection.FPool.Release;
  end;
end;

{ TAqDBPooledConnection<TBaseConnection>.TAqDBFlushContextsThread }

constructor TAqDBPooledConnection<TBaseConnection>.TAqDBFlushContextsThread.Create(
  const pPool: TAqList<TAqDBContext>);
begin
  inherited Create(False);
  FPool := pPool;
end;

procedure TAqDBPooledConnection<TBaseConnection>.TAqDBFlushContextsThread.Execute;
var
  lNextAttempt: TDateTime;
  lI: Int32;
  lContext: TAqDBContext;
  lDateTimeCut: TDateTime;
begin
  lNextAttempt := 0;

  while not Terminated do
  begin
    if lNextAttempt <= Now then
    begin
      lDateTimeCut := Now.IncSecond(-FAutoFlushContextsTime);
      FPool.Lock;

      try
        lI := 0;

        while not Terminated and (lI < FPool.Count - 1) do
        begin
          lContext := FPool[lI];
          if lContext.Locked or (lContext.LastUsedAt > lDateTimeCut) then
          begin
            Inc(lI);
          end else begin
            FPool.Delete(lI);
          end;
        end;
      finally
        FPool.Release;
      end;

      lNextAttempt := Now.IncSecond((FAutoFlushContextsTime div 4) + 1);
    end;
    Sleep(10);
  end;
end;

procedure TAqDBPooledConnection<TBaseConnection>.TAqDBFlushContextsThread.SetAutoFlushContextsTime(
  const pValue: UInt32);
begin
  FPool.Lock;

  try
    FAutoFlushContextsTime := pValue;
  finally
    FPool.Release;
  end;
end;

{ TAqDBPooledConnection<TBaseConnection>.TAqDBPreparedQuery }

constructor TAqDBPooledConnection<TBaseConnection>.TAqDBPreparedQuery.Create(const pSQL: string;
  const pParametersInitializer: TAqDBParametersHandlerMethod);
begin
  FSQL := pSQL;
  FParametersInitializer := pParametersInitializer;
end;

end.
