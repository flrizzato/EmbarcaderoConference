unit AqDrop.DB.Base;

interface

uses
  AqDrop.Core.Collections,
  AqDrop.DB.Connection,
  AqDrop.DB.ORM.Manager,
  AqDrop.DB.SQL.Intf,
  AqDrop.Core.Collections.Intf,
  System.SysUtils,
  AqDrop.DB.ORM.Attributes;

type
  TAqDBObject = class;
  TAqDBObjectClass = class of TAqDBObject;

  TAqDBGenericObjectManager = class abstract(TAqDBORMManagerClient)
  private
    procedure Save(const pDBObject: TAqDBObject);
    function Delete(const pDBObject: TAqDBObject): Boolean;
  strict protected
    function DoNew: TAqDBObject; virtual; abstract;
    function DoGet(const pID: UInt64): TAqDBObject; virtual; abstract;
    procedure DoSave(const pDBObject: TAqDBObject); virtual; abstract;
    function DoDelete(const pDBObject: TAqDBObject): Boolean; virtual; abstract;
  end;

  TAqDBObject = class
  public
    const ID_COLUMN = 'ID';
  strict private
    [weak]
    FManager: TAqDBGenericObjectManager;
  private
    procedure SetManager(const pManager: TAqDBGenericObjectManager);
  strict protected
    function GetID: UInt64; virtual; abstract;

    function GetForeignManager<T: TAqDBGenericObjectManager>: T;

    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;

    procedure ValidateData; virtual;

    property Manager: TAqDBGenericObjectManager read FManager;
  public
    procedure Save;
    procedure Delete;

    property ID: UInt64 read GetID;
  end;

  TAqDBObjectAutoID = class(TAqDBObject)
  strict private
    [AqAutoIncrementColumn(TAqDBObject.ID_COLUMN)]
    FID: UInt64;
  strict protected
    function GetID: UInt64; override;
  end;

  TAqDBObjectRegularID = class(TAqDBObject)
  strict private
    [AqPrimaryKey(TAqDBObject.ID_COLUMN)]
    FID: UInt64;
  strict protected
    function GetID: UInt64; override;
  end;

  TAqDBObjectManager<T: TAqDBObject, constructor> = class(TAqDBGenericObjectManager)
  strict private
    FCache: TAqDictionary<UInt64, T>;
  strict protected
    function DoGet(const pID: UInt64): TAqDBObject; override;
    function DoNew: TAqDBObject; override;
    procedure DoSave(const pDBObject: TAqDBObject); override;
    function DoDelete(const pDBObject: TAqDBObject): Boolean; override;

    procedure AddObject(const pObject: T); virtual;
  public
    constructor Create; override;
    destructor Destroy; override;

    function Get(const pID: Int64): T; overload;
    function Get(const pID: Int64; out pObject: T): Boolean; overload;
    function Get(out pResultList: IAqResultList<T>): Boolean; overload;
    function Get(const pCustomizationMethod: TProc<IAqDBSQLSelect>;
      out pResultList: IAqResultList<T>): Boolean; overload;
    function Get: IAqResultList<T>; overload;
    function Get(const pCustomizationMethod: TProc<IAqDBSQLSelect>): IAqResultList<T>; overload;

    function New: T;
  end;

implementation

uses
  AqDrop.Core.Exceptions,
  AqDrop.DB.SQL,
  AqDrop.DB.Base.Exceptions;

{ TAqDBObject }

procedure TAqDBObject.CommitTransaction;
begin
  FManager.ORMManager.Connection.CommitTransaction;
end;

procedure TAqDBObject.Delete;
begin
  if not FManager.Delete(Self) then
  begin
{$IFNDEF AUTOREFCOUNT}
    Free;
{$ENDIF}
  end;
end;

function TAqDBObject.GetForeignManager<T>: T;
begin
  Result := FManager.ORMManager.GetClient<T>;
end;

procedure TAqDBObject.RollbackTransaction;
begin
  FManager.ORMManager.Connection.RollbackTransaction;
end;

procedure TAqDBObject.Save;
begin
  ValidateData;

  FManager.Save(Self);
end;

procedure TAqDBObject.SetManager(const pManager: TAqDBGenericObjectManager);
begin
  FManager := pManager;
end;

procedure TAqDBObject.StartTransaction;
begin
  FManager.ORMManager.Connection.StartTransaction;
end;

procedure TAqDBObject.ValidateData;
begin
  // virtual method to be overwritten in order to validate the object's data before it being saved.
end;

{ TAqDBObjectManager<T> }

procedure TAqDBObjectManager<T>.AddObject(const pObject: T);
begin
  FCache.Lock;

  try
    if not FCache.ContainsKey(pObject.ID) or (pObject <> FCache.Items[pObject.ID]) then
    begin
      FCache.AddOrSetValue(pObject.ID, pObject);
      pObject.SetManager(Self);
    end;
  finally
    FCache.Release;
  end;
end;

constructor TAqDBObjectManager<T>.Create;
begin
  FCache := TAqDictionary<UInt64, T>.Create([TAqDictionaryContent.adcValue], True);
end;

destructor TAqDBObjectManager<T>.Destroy;
begin
  FCache.Free;

  inherited;
end;

function TAqDBObjectManager<T>.DoDelete(const pDBObject: TAqDBObject): Boolean;
var
  lObjectInCache: T;
begin
  FCache.Lock;

  try
    if FCache.TryGetValue(pDBObject.ID, lObjectInCache) and
      (Pointer(pDBObject) = Pointer(lObjectInCache)) then
    begin
      ORMManager.Delete(pDBObject, False);
    end;

    FCache.Remove(pDBObject.ID);
    Result := True; // if someday the object will not be freed by the cache, the result must be set to false
  finally
    FCache.Release;
  end;
end;

function TAqDBObjectManager<T>.DoGet(const pID: UInt64): TAqDBObject;
begin
  Result := Get(pID);
end;

function TAqDBObjectManager<T>.DoNew: TAqDBObject;
begin
  Result := T.Create;
  Result.SetManager(Self);
end;

procedure TAqDBObjectManager<T>.DoSave(const pDBObject: TAqDBObject);
begin
  if not pDBObject.InheritsFrom(T) then
  begin
    raise EAqInternal.Create('Incomptible type when creatin a new Object Manager: ' + pDBObject.QualifiedClassName +
      ' x ' + T.QualifiedClassName);
  end;

  ORMManager.Post(pDBObject);

  AddObject(T(pDBObject));
end;

function TAqDBObjectManager<T>.Get(out pResultList: IAqResultList<T>): Boolean;
begin
  Result := Get(nil, pResultList);
end;

function TAqDBObjectManager<T>.Get: IAqResultList<T>;
begin
  if not Get(Result) then
  begin
    Result := nil;
  end;
end;

function TAqDBObjectManager<T>.Get(const pCustomizationMethod: TProc<IAqDBSQLSelect>): IAqResultList<T>;
begin
  if not Get(pCustomizationMethod, Result) then
  begin
    Result := nil;
  end;
end;

function TAqDBObjectManager<T>.Get(const pID: Int64; out pObject: T): Boolean;
var
  lList: IAqResultList<T>;
begin
  FCache.Lock;

  try
    Result := FCache.TryGetValue(pID, pObject);
  finally
    FCache.Release;
  end;

  if not Result then
  begin
    Result := Get(
      procedure(pSelect: IAqDBSQLSelect)
      begin
        pSelect.CustomizeCondition.AddColumnEqual(TAqDBSQLColumn.Create(T.ID_COLUMN, pSelect.Source), pID);
      end, lList);
    if Result then
    begin
      pObject := lList.First;
    end else begin
      pObject := nil;
    end;
  end;
end;

function TAqDBObjectManager<T>.New: T;
var
  lNew: TAqDBObject;
begin
  Result := nil;

  lNew := DoNew;

  try
    if lNew.InheritsFrom(T) then
    begin
      Result := T(lNew);
    end else begin
      raise EAqInternal.Create('Incomptible type when creatin a new Object Manager: ' + lNew.QualifiedClassName +
        ' x ' + T.QualifiedClassName);
    end;
  except
    lNew.Free;
    raise;
  end;

  Result := T(lNew);
end;

function TAqDBObjectManager<T>.Get(const pCustomizationMethod: TProc<IAqDBSQLSelect>;
  out pResultList: IAqResultList<T>): Boolean;
var
  lObject: T;
begin
  Result := ORMManager.Get<T>(pCustomizationMethod, pResultList);

  if Result then
  begin
    for lObject in pResultList do
    begin
      AddObject(lObject);
    end;

    pResultList.OnwsResults := False;
  end;
end;

function TAqDBObjectManager<T>.Get(const pID: Int64): T;
begin
  if not Get(pID, Result) then
  begin
    Result := nil;
  end;
end;

{ TAqDBObjectAutoID }

function TAqDBObjectAutoID.GetID: UInt64;
begin
  Result := FID;
end;

{ TAqDBObjectRegularID }

function TAqDBObjectRegularID.GetID: UInt64;
begin
  Result := FID;
end;

{ TAqDBGenericObjectManager }

function TAqDBGenericObjectManager.Delete(const pDBObject: TAqDBObject): Boolean;
begin
  Result := DoDelete(pDBObject);
end;

procedure TAqDBGenericObjectManager.Save(const pDBObject: TAqDBObject);
begin
  DoSave(pDBObject);
end;

end.
