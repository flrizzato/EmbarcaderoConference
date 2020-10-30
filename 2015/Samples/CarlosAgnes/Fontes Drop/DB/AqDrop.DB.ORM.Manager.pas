unit AqDrop.DB.ORM.Manager;

interface

uses
  System.SysUtils,
  AqDrop.Core.InterfacedObject,
  AqDrop.Core.Collections.Intf,
  AqDrop.Core.Collections,
  AqDrop.DB.Types,
  AqDrop.DB.Connection,
  AqDrop.DB.SQL.Intf,
  AqDrop.DB.Adapter;

type
  TAqDBORMManager = class;

  TAqDBORMManagerClient = class
  strict private
    [weak]
    FORMManager: TAqDBORMManager;
  private
    class function CreateNew(const pORMManager: TAqDBORMManager): TAqDBORMManagerClient;
  strict protected
    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;
  public
    constructor Create; virtual;

    property ORMManager: TAqDBORMManager read FORMManager;
  end;

  TAqDBORMManager = class
  strict private
    FConnection: TAqDBConnection;
    FClients: TAqDictionary<string, TAqDBORMManagerClient>;

    procedure FillParametersWithObjectValues(pParameters: IAqDBParameters; const pObject: TObject);

    function GetAdapter: TAqDBAdapter;
    function GetSQLSolver: TAqDBSQLSolver;

    class var FDefault: TAqDBORMManager;
  strict protected
    property Adapter: TAqDBAdapter read GetAdapter;
    property SQLSolver: TAqDBSQLSolver read GetSQLSolver;
  public
    constructor Create(const pConnection: TAqDBConnection);
    destructor Destroy; override;

    function BuildBaseSelect(const pClass: TClass): IAqDBSQLSelect;
    function BuildSelect(const pClass: TClass): IAqDBSQLSelect;

    function BuildBaseInserts(const pClass: TClass): IAqResultList<IAqDBSQLInsert>;
    function BuildInserts(const pClass: TClass): IAqResultList<IAqDBSQLInsert>;

    function BuildBaseUpdates(const pClass: TClass): IAqResultList<IAqDBSQLUpdate>;
    function BuildUpdates(const pClass: TClass): IAqResultList<IAqDBSQLUpdate>;

    function BuildBaseDeletes(const pClass: TClass): IAqResultList<IAqDBSQLDelete>;
    function BuildDeletes(const pClass: TClass): IAqResultList<IAqDBSQLDelete>;

    function CreateFilter: IAqDBSQLComposedCondition;

    function Get<T: class, constructor>(out pResultList: IAqResultList<T>): Boolean; overload;
    function Get<T: class, constructor>(pSelect: IAqDBSQLSelect; out pResultList: IAqResultList<T>): Boolean; overload;
    function Get<T: class, constructor>(const pSelect: string; out pResultList: IAqResultList<T>): Boolean; overload;
    function Get<T: class, constructor>(pFilter: IAqDBSQLComposedCondition;
      out pResultList: IAqResultList<T>): Boolean; overload;
    function Get<T: class, constructor>(const pCustomizationMethod: TProc<IAqDBSQLSelect>;
      out pResultList: IAqResultList<T>): Boolean; overload;
    function Get<T: class, constructor>:IAqResultList<T>; overload;
    function Get<T: class, constructor>(pSelect: IAqDBSQLSelect): IAqResultList<T>; overload;
    function Get<T: class, constructor>(pSelect: string): IAqResultList<T>; overload;
    function Get<T: class, constructor>(pFilter: IAqDBSQLComposedCondition): IAqResultList<T>; overload;
    function Get<T: class, constructor>(
      const pCustomizationMethod: TProc<IAqDBSQLSelect>): IAqResultList<T>; overload;

    function GetByID<T: class, constructor>(const pID: Int64; out pResult: T): Boolean; overload;
    function GetByID<T: class, constructor>(const pID: Int64): T; overload;

    procedure Add(const pObject: TObject; const pFreeObject: Boolean = False); overload;
    procedure Add(const pInserts: IAqReadList<IAqDBSQLInsert>; const pObject: TObject); overload;
    procedure Add(const pInsert: IAqDBSQLInsert; const pObject: TObject); overload;
    procedure Add<T: class>(const pCustomizationMethod: TProc<IAqDBSQLInsert>); overload;

    procedure Update(const pObject: TObject; const pFreeObject: Boolean = False); overload;
    procedure Update(const pUpdates: IAqReadList<IAqDBSQLUpdate>; const pObject: TObject); overload;
    procedure Update(const pUpdate: IAqDBSQLUpdate; const pObject: TObject); overload;
    procedure Update<T: class>(const pCustomizationMethod: TProc<IAqDBSQLUpdate>); overload;


    procedure Delete(const pObject: TObject; const pFreeObject: Boolean = True); overload;
    procedure Delete(const pDeletes: IAqReadList<IAqDBSQLDelete>; const pObject: TObject); overload;
    procedure Delete(const pDelete: IAqDBSQLDelete; const pObject: TObject); overload;
    procedure Delete<T: class>(const pCustomizationMethod: TProc<IAqDBSQLDelete>); overload;

    procedure Post(const pObject: TObject; const pFreeObject: Boolean = False);

    function ExecuteWithObject(const pSQLCommand: string; const pObject: TObject): Int64;

    function GetClient<T: TAqDBORMManagerClient>: T;

    property Connection: TAqDBConnection read FConnection;

    class property Default: TAqDBORMManager read FDefault write FDefault;
  end;


implementation

uses
{$if CompilerVersion >= 26}
  FireDAC.Stan.Param,
{$endif}
  System.Rtti,
  AqDrop.Core.Types,
  AqDrop.Core.Exceptions,
  AqDrop.DB.ORM.Reader,
  AqDrop.DB.SQL,
  AqDrop.DB.ORM.Attributes;

{ TAqDBORMManager }

constructor TAqDBORMManager.Create(const pConnection: TAqDBConnection);
begin
  FConnection := pConnection;
  FConnection.AddDependent(Self);
  FClients := TAqDictionary<string, TAqDBORMManagerClient>.Create([TAqDictionaryContent.adcValue], True);
end;

function TAqDBORMManager.CreateFilter: IAqDBSQLComposedCondition;
begin
  Result := TAqDBSQLComposedCondition.Create;
end;

procedure TAqDBORMManager.Delete(const pDeletes: IAqReadList<IAqDBSQLDelete>; const pObject: TObject);
var
  lDelete: IAqDBSQLDelete;
begin
  FConnection.StartTransaction;

  try
    for lDelete in pDeletes do
    begin
      Delete(lDelete, pObject);
    end;

    FConnection.CommitTransaction;
  except
    FConnection.RollbackTransaction;
    raise;
  end;
end;

procedure TAqDBORMManager.Delete(const pDelete: IAqDBSQLDelete; const pObject: TObject);
begin
  ExecuteWithObject(SQLSolver.SolveDelete(pDelete), pObject);
end;

procedure TAqDBORMManager.Delete<T>(const pCustomizationMethod: TProc<IAqDBSQLDelete>);
var
  lDeletes: IAqResultList<IAqDBSQLDelete>;
  lDelete: IAqDBSQLDelete;
  lFilter: IAqDBSQLComposedCondition;
begin
  lDeletes := BuildBaseDeletes(T);

  Connection.StartTransaction;

  try
    for lDelete in lDeletes do
    begin
      pCustomizationMethod(lDelete);
      Connection.ExecuteCommand(lDelete);
    end;

    Connection.CommitTransaction;
  except
    on E: Exception do
    begin
      Connection.RollbackTransaction;
      E.RaiseOuterException(EAqInternal.Create('Impossible to execute the custom delete.'));
    end;
  end;
end;

destructor TAqDBORMManager.Destroy;
begin
  FClients.Free;
  FConnection.RemoveDependent(Self);

  inherited;
end;

procedure TAqDBORMManager.Delete(const pObject: TObject; const pFreeObject: Boolean);
begin
  Delete(BuildDeletes(pObject.ClassType), pObject);

{$IFNDEF AUTOREFCOUNT}
  if pFreeObject then
  begin
    pObject.Free;
  end;
{$ENDIF}
end;

procedure TAqDBORMManager.FillParametersWithObjectValues(pParameters: IAqDBParameters; const pObject: TObject);
var
  lI: Int32;
  lColumn: TAqDBORMColumn;
  lORM: TAqDBORM;
begin
  lORM := TAqDBORMReader.GetORM(pObject.ClassType);

  for lI := 0 to pParameters.Count - 1 do
  begin
    if lORM.GetColumn(pParameters[lI].Name, lColumn) then
    begin
      lColumn.SetDBValue(pObject, pParameters[lI]);
    end;
  end;
end;

function TAqDBORMManager.Get<T>(out pResultList: IAqResultList<T>): Boolean;
begin
  Result := Get<T>(BuildSelect(T), pResultList);
end;

function TAqDBORMManager.Get<T>(pSelect: IAqDBSQLSelect; out pResultList: IAqResultList<T>): Boolean;
begin
  Result := Get<T>(SQLSolver.SolveSelect(pSelect), pResultList);
end;

function TAqDBORMManager.Get<T>(const pSelect: string; out pResultList: IAqResultList<T>): Boolean;
var
  lORM: TAqDBORM;
  lReader: IAqDBReader;
  lList: TAqResultList<T>;
  lObject: T;
  lI: Int32;
  lColumn: TAqDBORMColumn;
begin
  Result := False;
  lList := nil;

  try
    lReader := FConnection.OpenQuery(pSelect);

    while lReader.Next do
    begin
      if not Result then
      begin
        lORM := TAqDBORMReader.GetORM(T);
        Result := True;
        lList := TAqResultList<T>.Create(True);
      end;

      lList.Add(T.Create);
      lObject := lList.Last;

      for lI := 0 to lReader.Count - 1 do
      begin
        if lORM.GetColumn(lReader[lI].Name, lColumn) then
        begin
          lColumn.SetObjectValue(lObject, lReader[lI]);
        end;
      end;
    end;
  except
    lList.Free;
    raise;
  end;

  if Result then
  begin
    pResultList := lList;
  end;
end;

procedure TAqDBORMManager.Add(const pObject: TObject; const pFreeObject: Boolean);
begin
  Add(BuildInserts(pObject.ClassType), pObject);

{$IFNDEF AUTOREFCOUNT}
  if pFreeObject then
  begin
    pObject.Free;
  end;
{$ENDIF}
end;

procedure TAqDBORMManager.Post(const pObject: TObject; const pFreeObject: Boolean = False);
var
  lInserts: IAqResultList<IAqDBSQLInsert>;
  lUpdates: IAqResultList<IAqDBSQLUpdate>;
  lI: Int32;
  lSelect: IAqDBSQLSelect;
  lReader: IAqDBReader;
begin
{$IFNDEF AUTOREFCOUNT}
  try
{$ENDIF}
    lInserts := BuildInserts(pObject.ClassType);
    lUpdates := BuildUpdates(pObject.ClassType);

    if lInserts.Count <> lUpdates.Count then
    begin
      raise EAqInternal.Create('Inserts and Updates of ' + pObject.ClassName + ' has diferent counts.');
    end;

    FConnection.StartTransaction;

    try
      for lI := 0 to lUpdates.Count - 1 do
      begin
        lSelect := TAqDBSQLSelect.Create(lUpdates[lI].Table.Name);
        lSelect.AddColumn(TAqDBSQLIntConstant.Create(1));
        lSelect.Condition := lUpdates[lI].Condition;
        lSelect.Limit := 1;

        lReader := FConnection.OpenQuery(lSelect,
          procedure(pParameters: IAqDBParameters)
          begin
            FillParametersWithObjectValues(pParameters, pObject);
          end);

        if lReader.Next then
        begin
          Update(lUpdates[lI], pObject);
        end else begin
          Add(lInserts[lI], pObject);
        end;
      end;

      FConnection.CommitTransaction;
    except
      FConnection.RollbackTransaction;
      raise;
    end;
{$IFNDEF AUTOREFCOUNT}
  finally
    if pFreeObject then
    begin
      pObject.Free;
    end;
  end;
{$ENDIF}
end;

procedure TAqDBORMManager.Update(const pUpdates: IAqReadList<IAqDBSQLUpdate>; const pObject: TObject);
var
  lUpdate: IAqDBSQLUpdate;
begin
  FConnection.StartTransaction;

  try
    for lUpdate in pUpdates do
    begin
      Update(lUpdate, pObject);
    end;
    FConnection.CommitTransaction;
  except
    FConnection.RollbackTransaction;
    raise;
  end;
end;

procedure TAqDBORMManager.Update(const pUpdate: IAqDBSQLUpdate; const pObject: TObject);
begin
  ExecuteWithObject(SQLSolver.SolveUpdate(pUpdate), pObject);
end;

procedure TAqDBORMManager.Update<T>(const pCustomizationMethod: TProc<IAqDBSQLUpdate>);
var
  lUpdates: IAqResultList<IAqDBSQLUpdate>;
  lUpdate: IAqDBSQLUpdate;
begin
  lUpdates := BuildBaseUpdates(T);

  Connection.StartTransaction;

  try
    for lUpdate in lUpdates do
    begin
      pCustomizationMethod(lUpdate);
      Connection.ExecuteCommand(lUpdate);
    end;
  except
    Connection.RollbackTransaction;
    raise EAqInternal.Create('Impossible to execute the custom update.');
  end;
end;

procedure TAqDBORMManager.Update(const pObject: TObject; const pFreeObject: Boolean);
begin
  Update(BuildUpdates(pObject.ClassType), pObject);

{$IFNDEF AUTOREFCOUNT}
  if pFreeObject then
  begin
    pObject.Free;
  end;
{$ENDIF}
end;

procedure TAqDBORMManager.Add(const pInsert: IAqDBSQLInsert; const pObject: TObject);
var
  lORM: TAqDBORM;
  lHasAutoIncrementColumn: Boolean;
  lTable: TAqDBORMTable;
  lAutoIncrementColumn: TAqDBORMColumn;
  lGeneratorName: string;
begin
  lORM := TAqDBORMReader.GetORM(pObject.ClassType);

  lHasAutoIncrementColumn := lORM.GetTable(pInsert.Table.Name, lTable) and
    lTable.HasAutoIncrementColumn(lAutoIncrementColumn);

  FConnection.StartTransaction;

  try
    if lHasAutoIncrementColumn and (Adapter.AutoIncrementType = TAqDBAutoIncrementType.aiGenerator) then
    begin
      if Assigned(lAutoIncrementColumn.Attribute) and (lAutoIncrementColumn.Attribute is AqAutoIncrementColumn) and
        AqAutoIncrementColumn(lAutoIncrementColumn.Attribute).IsGeneratorDefined then
      begin
        lGeneratorName := AqAutoIncrementColumn(lAutoIncrementColumn.Attribute).GeneratorName;
      end else begin
        lGeneratorName := SQLSolver.SolveGeneratorName(lTable.Name);
      end;

      lAutoIncrementColumn.SetObjectValue(pObject, TValue.From<Int64>(FConnection.GetAutoIncrement(lGeneratorName)));
    end;

    ExecuteWithObject(SQLSolver.SolveInsert(pInsert), pObject);

    if lHasAutoIncrementColumn and (Adapter.AutoIncrementType = TAqDBAutoIncrementType.aiAutoIncrement) then
    begin
      lAutoIncrementColumn.SetObjectValue(pObject, TValue.From<Int64>(FConnection.GetAutoIncrement));
    end;

    FConnection.CommitTransaction;
  except
    FConnection.RollbackTransaction;
    raise;
  end;
end;

procedure TAqDBORMManager.Add<T>(const pCustomizationMethod: TProc<IAqDBSQLInsert>);
var
  lInserts: IAqResultList<IAqDBSQLInsert>;
  lInsert: IAqDBSQLInsert;
begin
  lInserts := BuildBaseInserts(T);

  Connection.StartTransaction;

  try
    for lInsert in lInserts do
    begin
      pCustomizationMethod(lInsert);
      Connection.ExecuteCommand(lInsert);
    end;
  except
    Connection.RollbackTransaction;
    raise EAqInternal.Create('Impossible to execute the custom insert.');
  end;
end;

procedure TAqDBORMManager.Add(const pInserts: IAqReadList<IAqDBSQLInsert>; const pObject: TObject);
var
  lInsert: IAqDBSQLInsert;
begin
  FConnection.StartTransaction;

  try
    for lInsert in pInserts do
    begin
      Add(lInsert, pObject);
    end;
    FConnection.CommitTransaction;
  except
    FConnection.RollbackTransaction;
    raise;
  end;
end;

function TAqDBORMManager.BuildBaseDeletes(const pClass: TClass): IAqResultList<IAqDBSQLDelete>;
var
  lORM: TAqDBORM;
  lDeletes: TAqResultList<IAqDBSQLDelete>;
  lSpecialization: TAqDBORMTable<AqSpecialization>;
begin
  lORM := TAqDBORMReader.GetORM(pClass);

  lDeletes := TAqResultList<IAqDBSQLDelete>.Create;

  try
    lDeletes.Add(TAqDBSQLDelete.Create(lORM.MainTable.Name));

    if lORM.HasSpecializations then
    begin
      for lSpecialization in lORM.Specializations do
      begin
        lDeletes.Insert(0, TAqDBSQLDelete.Create(lSpecialization.Name));
      end;
    end;
  except
    lDeletes.Free;
    raise;
  end;

  Result := lDeletes;
end;

function TAqDBORMManager.BuildBaseInserts(const pClass: TClass): IAqResultList<IAqDBSQLInsert>;
var
  lORM: TAqDBORM;
  lInserts: TAqResultList<IAqDBSQLInsert>;
  lSpecialization: TAqDBORMTable<AqSpecialization>;
begin
  lORM := TAqDBORMReader.GetORM(pClass);

  lInserts := TAqResultList<IAqDBSQLInsert>.Create;

  try
    lInserts.Add(TAqDBSQLInsert.Create(lORM.MainTable.Name));

    if lORM.HasSpecializations then
    begin
      for lSpecialization in lORM.Specializations do
      begin
        lInserts.Add(TAqDBSQLInsert.Create(lSpecialization.Name));
      end;
    end;
  except
    lInserts.Free;
    raise;
  end;

  Result := lInserts;
end;

function TAqDBORMManager.BuildBaseSelect(const pClass: TClass): IAqDBSQLSelect;
var
  lSelect: TAqDBSQLSelect;
  lORM: TAqDBORM;
  lSpecialization: TAqDBORMTable<AqSpecialization>;
  lCondition: TAqDBSQLComposedCondition;
  lLink: TAqDBLink;
  lMasterSource: TAqDBSQLSource;
  lDetail: TAqDBSQLSource;

  procedure AddLinkCondition(const pCondition: TAqDBSQLCondition);
  begin
    if not Assigned(lCondition) then
    begin
      lCondition := TAqDBSQLComposedCondition.Create(pCondition);
    end else begin
      lCondition.AddCondition(TAqDBSQLBooleanOperator.boAnd, pCondition);
    end;
  end;
begin
  lSelect := nil;
  try
    lORM := TAqDBORMReader.GetORM(pClass);

    lMasterSource := TAqDBSQLTable.Create(lORM.MainTable.Name);
    lSelect := TAqDBSQLSelect.Create(lMasterSource);

    if lORM.HasSpecializations then
    begin
      for lSpecialization in lORM.Specializations do
      begin
        if lSpecialization.Attribute.Links.Count = 0 then
        begin
          raise EAqInternal.Create('The specialization has no links.');
        end;

        lDetail := TAqDBSQLTable.Create(lSpecialization.Name);
        lCondition := nil;

        for lLink in lSpecialization.Attribute.Links do
        begin
          AddLinkCondition(TAqDBSQLComparisonCondition.Create(
            TAqDBSQLColumn.Create(lLink.MasterKey, lMasterSource),
            TAqDBSQLComparison.cpEqual,
            TAqDBSQLColumn.Create(lLink.ForeignKey, lDetail)));
        end;

        lSelect.AddJoin(TAqDBSQLJoinType.jtInnerJoin, lDetail, lCondition);

        lMasterSource := lDetail;
      end;
    end;
  except
    on E: Exception do
    begin
      lSelect.Free;
      E.RaiseOuterException(EAqInternal.Create('It wasn''t possible to build the select for the ' +
        pClass.QualifiedClassName + ' class.'));
    end;
  end;

  Result := lSelect;
end;

function TAqDBORMManager.BuildBaseUpdates(const pClass: TClass): IAqResultList<IAqDBSQLUpdate>;
var
  lORM: TAqDBORM;
  lUpdates: TAqResultList<IAqDBSQLUpdate>;
  lSpecialization: TAqDBORMTable<AqSpecialization>;
begin
  lORM := TAqDBORMReader.GetORM(pClass);

  lUpdates := TAqResultList<IAqDBSQLUpdate>.Create;

  try
    lUpdates.Add(TAqDBSQLUpdate.Create(lORM.MainTable.Name));

    if lORM.HasSpecializations then
    begin
      for lSpecialization in lORM.Specializations do
      begin
        lUpdates.Add(TAqDBSQLUpdate.Create(lSpecialization.Name));
      end;
    end;
  except
    lUpdates.Free;
    raise;
  end;

  Result := lUpdates;
end;

function TAqDBORMManager.BuildDeletes(const pClass: TClass): IAqResultList<IAqDBSQLDelete>;
var
  lORM: TAqDBORM;
  lDeletes: TAqResultList<IAqDBSQLDelete>;
  lPKs: TAqList<TAqDBORMColumn>;
  lSpecialization: TAqDBORMTable<AqSpecialization>;
  lFirstCondition: TAqDBSQLComparisonCondition;
  lComposedCondition: TAqDBSQLComposedCondition;

  function CreateCondition(const pColumnName: string): TAqDBSQLComparisonCondition;
  begin
    Result := TAqDBSQLComparisonCondition.Create(TAqDBSQLColumn.Create(pColumnName),
      TAqDBSQLComparison.cpEqual, TAqDBSQLParameter.Create(pColumnName));
  end;

  procedure AddCondition(const pColumnName: string);
  begin
    if not Assigned(lFirstCondition) then
    begin
      lFirstCondition := CreateCondition(pColumnName);
    end else begin
      if not Assigned(lComposedCondition) then
      begin
        lComposedCondition := TAqDBSQLComposedCondition.Create(lFirstCondition);
      end;

      lComposedCondition.AddCondition(TAqDBSQLBooleanOperator.boAnd, CreateCondition(pColumnName));
    end;
  end;

  procedure AddDelete(pTable: TAqDBORMTable<AqTable>);
  var
    lColumn: TAqDBORMColumn;
    lDelete: IAqDBSQLDelete;
  begin
    lFirstCondition := nil;
    lComposedCondition := nil;

    lDelete := TAqDBSQLDelete.Create(pTable.Name);

    if TAqDBTableMappingProperty.tmpInheritPKs in pTable.Attribute.MappingProperties then
    begin
      for lColumn in lPKs do
      begin
        AddCondition(lColumn.Name);
      end;
    end;

    for lColumn in pTable.Columns do
    begin
      if Assigned(lColumn.Attribute) and (lColumn.Attribute.PrimaryKey) then
      begin
        AddCondition(lColumn.Name);
        lPKs.Add(lColumn);
      end;
    end;

    if Assigned(lComposedCondition) then
    begin
      lDelete.Condition := lComposedCondition;
    end else if Assigned(lFirstCondition) then
    begin
      lDelete.Condition := lFirstCondition;
    end;

    lDeletes.Insert(0, lDelete);
  end;
begin
  lORM := TAqDBORMReader.GetORM(pClass);

  lDeletes := TAqResultList<IAqDBSQLDelete>.Create;

  try
    lPKs := TAqList<TAqDBORMColumn>.Create;

    try
      AddDelete(lORM.MainTable);

      if lORM.HasSpecializations then
      begin
        for lSpecialization in lORM.Specializations do
        begin
          AddDelete(TAqDBORMTable<AqTable>(lSpecialization));
        end;
      end;
    finally
      lPKs.Free;
    end;
  except
    lDeletes.Free;
    raise;
  end;

  Result := lDeletes;
end;

function TAqDBORMManager.BuildInserts(const pClass: TClass): IAqResultList<IAqDBSQLInsert>;
var
  lORM: TAqDBORM;
  lInserts: TAqResultList<IAqDBSQLInsert>;
  lSpecialization: TAqDBORMTable<AqSpecialization>;
  lPKs: TAqList<TAqDBORMColumn>;
  lAutoIncrementType: TAqDBAutoIncrementType;

  procedure AddInsert(const pTable: TAqDBORMTable<AqTable>);
  var
    lInsert: IAqDBSQLInsert;
    lColumn: TAqDBORMColumn;
  begin
    lInsert := TAqDBSQLInsert.Create(pTable.Name);

    if TAqDBTableMappingProperty.tmpInheritPKs in pTable.Attribute.MappingProperties then
    begin
      for lColumn in lPKs do
      begin
        lInsert.AddAssignment(TAqDBSQLColumn.Create(lColumn.Name), TAqDBSQLParameter.Create(lColumn.Name));
      end;
    end;

    for lColumn in pTable.Columns do
    begin
      if Assigned(lColumn.Attribute) and (lColumn.Attribute.PrimaryKey) then
      begin
        lPKs.Add(lColumn);
      end;

      if (lAutoIncrementType = TAqDBAutoIncrementType.aiGenerator) or not Assigned(lColumn.Attribute) or not
        lColumn.Attribute.AutoIncrement then
      begin
        lInsert.AddAssignment(TAqDBSQLColumn.Create(lColumn.Name), TAqDBSQLParameter.Create(lColumn.Name));
      end;
    end;

    lInserts.Add(lInsert);
  end;
begin
  lORM := TAqDBORMReader.GetORM(pClass);

  lInserts := TAqResultList<IAqDBSQLInsert>.Create;

  try
    lAutoIncrementType := Adapter.AutoIncrementType;
    lPKs := TAqList<TAqDBORMColumn>.Create;

    try
      AddInsert(lORM.MainTable);

      if lORM.HasSpecializations then
      begin
        for lSpecialization in lORM.Specializations do
        begin
          AddInsert(TAqDBORMTable<AqTable>(lSpecialization));
        end;
      end;
    finally
      lPKs.Free;
    end;
  except
    lInserts.Free;
    raise;
  end;

  Result := lInserts;
end;

function TAqDBORMManager.BuildSelect(const pClass: TClass): IAqDBSQLSelect;
var
  lORM: TAqDBORM;
  lI: Int32;

  procedure AddColumns(const pORMTable: TAqDBORMTable; const pSource: IAqDBSQLSource);
  var
    lColumn: TAqDBORMColumn;
  begin
    for lColumn in pORMTable.Columns do
    begin
      Result.AddColumn(lColumn.Name, lColumn.Alias, pSource);
    end;
  end;
begin
  Result := BuildBaseSelect(pClass);
  lORM := TAqDBORMReader.GetORM(pClass);

  AddColumns(lORM.MainTable, Result.Source);

  if lORM.HasSpecializations then
  begin
    for lI := 0 to lORM.Specializations.Count - 1 do
    begin
      AddColumns(lORM.Specializations[lI], Result.Joins[lI].Source);
    end;
  end;
end;

function TAqDBORMManager.BuildUpdates(const pClass: TClass): IAqResultList<IAqDBSQLUpdate>;
var
  lORM: TAqDBORM;
  lUpdates: TAqResultList<IAqDBSQLUpdate>;
  lPKs: TAqList<TAqDBORMColumn>;
  lSpecialization: TAqDBORMTable<AqSpecialization>;
  lFirstCondition: TAqDBSQLComparisonCondition;
  lComposedCondition: TAqDBSQLComposedCondition;

  function CreateCondition(const pColumnName: string): TAqDBSQLComparisonCondition;
  begin
    Result := TAqDBSQLComparisonCondition.Create(TAqDBSQLColumn.Create(pColumnName),
      TAqDBSQLComparison.cpEqual, TAqDBSQLParameter.Create(pColumnName));
  end;

  procedure AddCondition(const pColumnName: string);
  begin
    if not Assigned(lFirstCondition) then
    begin
      lFirstCondition := CreateCondition(pColumnName);
    end else begin
      if not Assigned(lComposedCondition) then
      begin
        lComposedCondition := TAqDBSQLComposedCondition.Create(lFirstCondition);
      end;

      lComposedCondition.AddCondition(TAqDBSQLBooleanOperator.boAnd, CreateCondition(pColumnName));
    end;
  end;

  procedure AddUpdate(pTable: TAqDBORMTable<AqTable>);
  var
    lColumn: TAqDBORMColumn;
    lUpdate: IAqDBSQLUpdate;
  begin
    lFirstCondition := nil;
    lComposedCondition := nil;

    lUpdate := TAqDBSQLUpdate.Create(pTable.Name);

    if TAqDBTableMappingProperty.tmpInheritPKs in pTable.Attribute.MappingProperties then
    begin
      for lColumn in lPKs do
      begin
        AddCondition(lColumn.Name);
      end;
    end;

    for lColumn in pTable.Columns do
    begin
      if Assigned(lColumn.Attribute) and (lColumn.Attribute.PrimaryKey) then
      begin
        AddCondition(lColumn.Name);
        lPKs.Add(lColumn);
      end else begin
        lUpdate.AddAssignment(TAqDBSQLColumn.Create(lColumn.Name), TAqDBSQLParameter.Create(lColumn.Name));
      end;
    end;

    if Assigned(lComposedCondition) then
    begin
      lUpdate.Condition := lComposedCondition;
    end else if Assigned(lFirstCondition) then
    begin
      lUpdate.Condition := lFirstCondition;
    end;

    lUpdates.Add(lUpdate);
  end;
begin
  lORM := TAqDBORMReader.GetORM(pClass);

  lUpdates := TAqResultList<IAqDBSQLUpdate>.Create;

  try
    lPKs := TAqList<TAqDBORMColumn>.Create;

    try
      AddUpdate(lORM.MainTable);

      if lORM.HasSpecializations then
      begin
        for lSpecialization in lORM.Specializations do
        begin
          AddUpdate(TAqDBORMTable<AqTable>(lSpecialization));
        end;
      end;
    finally
      lPKs.Free;
    end;
  except
    lUpdates.Free;
    raise;
  end;

  Result := lUpdates;
end;

function TAqDBORMManager.ExecuteWithObject(const pSQLCommand: string; const pObject: TObject): Int64;
begin
  if Assigned(pObject) then
  begin
    Result := FConnection.ExecuteCommand(pSQLCommand,
      procedure(pParameters: IAqDBParameters)
      begin
        FillParametersWithObjectValues(pParameters, pObject);
      end);
  end else begin
    Result := FConnection.ExecuteCommand(pSQLCommand);
  end;
end;

function TAqDBORMManager.Get<T>(pSelect: IAqDBSQLSelect): IAqResultList<T>;
begin
  if not Get<T>(pSelect, Result) then
  begin
    Result := nil;
  end;
end;

function TAqDBORMManager.Get<T>: IAqResultList<T>;
begin
  if not Get<T>(Result) then
  begin
    Result := nil;
  end;
end;

function TAqDBORMManager.Get<T>(pFilter: IAqDBSQLComposedCondition; out pResultList: IAqResultList<T>): Boolean;
var
  lSelect: IAqDBSQLSelect;
begin
  lSelect := BuildSelect(T);
  lSelect.CustomizeCondition(pFilter);
  Result := Get<T>(lSelect, pResultList);
end;

function TAqDBORMManager.Get<T>(pSelect: string): IAqResultList<T>;
begin
  if not Get<T>(pSelect, Result) then
  begin
    Result := nil;
  end;
end;

function TAqDBORMManager.Get<T>(pFilter: IAqDBSQLComposedCondition): IAqResultList<T>;
begin
  if not Get<T>(pFilter, Result) then
  begin
    Result := nil;
  end;
end;

function TAqDBORMManager.GetByID<T>(const pID: Int64): T;
begin
  if not GetByID<T>(pID, Result) then
  begin
    Result := nil;
  end;
end;

function TAqDBORMManager.GetClient<T>: T;
var
  lClient: TAqDBORMManagerClient;
begin
  FClients.Lock;

  try
    if not FClients.TryGetValue(T.QualifiedClassName, lClient) then
    begin
      lClient := T.CreateNew(Self);
      FClients.Add(T.QualifiedClassName, lClient);
    end;

    Result := T(lClient);
  finally
    FClients.Release;
  end;
end;

function TAqDBORMManager.GetSQLSolver: TAqDBSQLSolver;
begin
  Result := nil;

  try
    Result := Adapter.SQLSolver;

    if not Assigned(Result) then
    begin
      raise EAqInternal.Create('The manager''s adapter has no SQL solver.');
    end;
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create('It wasn''t possible to obtain the SQL solver.'));
    end;
  end;
end;

function TAqDBORMManager.GetByID<T>(const pID: Int64; out pResult: T): Boolean;
var
  lPKs: IAqResultList<TAqDBORMColumn>;
  lResultList: IAqResultList<T>;
begin
  lPKs := TAqDBORMReader.GetORM(T).GetPrimaryKeys;

  if (lPKs.Count <> 1) or not (lPKs.First.&Type in adtIntTypes) then
  begin
    raise EAqInternal.Create('The class ' + T.QualifiedClassName + ' doesn''t observe the Unique Key rule.');
  end;

  Result := Get<T>(CreateFilter.AddColumnEqual(lPKs.First.Name, pID), lResultList);
  if Result then
  begin
    pResult := lResultList.Extract;
  end;
end;

function TAqDBORMManager.Get<T>(const pCustomizationMethod: TProc<IAqDBSQLSelect>;
  out pResultList: IAqResultList<T>): Boolean;
var
  lSelect: IAqDBSQLSelect;
begin
  lSelect := BuildSelect(T);

  if Assigned(pCustomizationMethod) then
  begin
    pCustomizationMethod(lSelect);
  end;

  Result := Get<T>(lSelect, pResultList);
end;

function TAqDBORMManager.Get<T>(const pCustomizationMethod: TProc<IAqDBSQLSelect>): IAqResultList<T>;
begin
  if not Get<T>(pCustomizationMethod, Result) then
  begin
    Result := nil;
  end;
end;

function TAqDBORMManager.GetAdapter: TAqDBAdapter;
begin
  Result := nil;

  try
    if not Assigned(FConnection) then
    begin
      raise EAqInternal.Create('The ORM manager has no connection associated.');
    end;

    Result := FConnection.Adapter;

    if not Assigned(Result) then
    begin
      raise EAqInternal.Create('The manager''s connection has no adapter.');
    end;
  except
    on E: Exception do
    begin
      E.RaiseOuterException(EAqInternal.Create('It wasn''t possible to get the Adapter.'));
    end;
  end;
end;

{ TAqDBORMManagerClient }

procedure TAqDBORMManagerClient.CommitTransaction;
begin
  FORMManager.Connection.CommitTransaction;
end;

constructor TAqDBORMManagerClient.Create;
begin

end;

class function TAqDBORMManagerClient.CreateNew(const pORMManager: TAqDBORMManager): TAqDBORMManagerClient;
begin
  Result := Self.Create;
  Result.FORMManager := pORMManager;
end;

procedure TAqDBORMManagerClient.RollbackTransaction;
begin
  FORMManager.Connection.RollbackTransaction;
end;

procedure TAqDBORMManagerClient.StartTransaction;
begin
  FORMManager.Connection.StartTransaction;
end;

end.
