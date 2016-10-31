unit AqDrop.DB.ORM.Reader;

interface

{$I '..\Core\AqDrop.Core.Defines.Inc'}

uses
  System.Rtti,
  System.TypInfo,
  System.SyncObjs,
  AqDrop.Core.Types,
  AqDrop.Core.Collections,
  AqDrop.Core.Collections.Intf,
  AqDrop.Core.InterfacedObject,
  AqDrop.DB.SQL,
  AqDrop.DB.ORM.Attributes,
  AqDrop.DB.Types;

type
  TAqDBORMColumn = class
  strict private
    FAttribute: AqColumn;
    function GetAlias: string;
  strict protected
    function GetName: string; virtual; abstract;

    procedure SetValue(const pInstance: TObject; const pValue: TValue); virtual; abstract;
    function GetValue(const pInstance: TObject): TValue; virtual; abstract;
    function GetTypeInfo: PTypeInfo; virtual; abstract;
    function GetType: TAqDataType; virtual; abstract;
  public
    constructor Create(const pAttribute: AqColumn);

    procedure SetObjectValue(const pInstance: TObject; pValue: TValue); overload;
    procedure SetObjectValue(const pInstance: TObject; pValue: IAqDBReadValue); overload;
    procedure SetDBValue(const pInstance: TObject; pValue: IAqDBValue);

    property Attribute: AqColumn read FAttribute;
    property Name: string read GetName;
    property Alias: string read GetAlias;
    property &Type: TAqDataType read GetType;
  end;

  TAqDBORMColumnField = class(TAqDBORMColumn)
  strict private
    FField: TRttiField;

    function ExtractColumnName(const pRttiObject: TRttiNamedObject): string;
  strict protected
    function GetName: string; override;

    procedure SetValue(const pInstance: TObject; const pValue: TValue); override;
    function GetValue(const pInstance: TObject): TValue; override;
    function GetType: TAqDataType; override;
    function GetTypeInfo: PTypeInfo; override;
  public
    constructor Create(const pField: TRttiField; const pAttribute: AqColumn);

    property Field: TRttiField read FField;
  end;

  TAqDBORMColumnProperty = class(TAqDBORMColumn)
  strict private
    FProperty: TRttiProperty;
  strict protected
    function GetName: string; override;

    procedure SetValue(const pInstance: TObject; const pValue: TValue); override;
    function GetValue(const pInstance: TObject): TValue; override;
    function GetType: TAqDataType; override;
    function GetTypeInfo: PTypeInfo; override;
  public
    constructor Create(const pProperty: TRttiProperty; const pAttribute: AqColumn);

    property &Property: TRttiProperty read FProperty;
  end;

  TAqDBORMTable = class
  strict private
    FType: TRttiType;
    FColumns: TAqList<TAqDBORMColumn>;

    function GetColumns: TAqReadList<TAqDBORMColumn>;
  private
    procedure SetType(const pType: TRttiType);
  strict protected
    function GetName: string; virtual; abstract;
    function ExtractTableName(const pType: TRttiType): string;

    property &Type: TRttiType read FType;
  public
    constructor Create(const pType: TRttiType);
    destructor Destroy; override;

    procedure AddColumn(const pField: TRttiField; const pAttribute: AqColumn); overload;
    procedure AddColumn(const pProperty: TRttiProperty; const pAttribute: AqColumn); overload;

    function HasAutoIncrementColumn(out pColumn: TAqDBORMColumn): Boolean;

    property Name: string read GetName;
    property Columns: TAqReadList<TAqDBORMColumn> read GetColumns;
  end;

  TAqDBORMTable<T: AqTable> = class(TAqDBORMTable)
  strict private
    FAttribute: T;
  private
    procedure SetAttribute(const pAttribute: T; const pType: TRttiType);
  strict protected
    function GetName: string; override;
  public
    constructor Create(const pAttribute: T; const pType: TRttiType);

    property Attribute: T read FAttribute;
  end;

  TAqDBORM = class
  strict private
    FMainTable: TAqDBORMTable<AqTable>;
    FSpecializations: TAqList<TAqDBORMTable<AqSpecialization>>;

    function GetInitialized: Boolean;
    function GetActiveTable: TAqDBORMTable<AqTable>;
    function GetHasSpecializations: Boolean;
    function GetSpecializations: TAqReadList<TAqDBORMTable<AqSpecialization>>;

    class var FTableSeparator: string;
  public
    class constructor Create;

    constructor Create;
    destructor Destroy; override;

    procedure AddTable(const pTableInfo: AqTable; const pType: TRttiType);

    function GetTable(const pName: string; out pTable: TAqDBORMTable): Boolean;
    function GetColumn(const pName: string; out pColumn: TAqDBORMColumn): Boolean;
    function GetPrimaryKeys: IAqResultList<TAqDBORMColumn>;

    property Initialized: Boolean read GetInitialized;
    property MainTable: TAqDBORMTable<AqTable> read FMainTable;

    property HasSpecializations: Boolean read GetHasSpecializations;
    property Specializations: TAqReadList<TAqDBORMTable<AqSpecialization>> read GetSpecializations;

    property ActiveTable: TAqDBORMTable<AqTable> read GetActiveTable;

    // se for necessária mais uma configuração, é melhor isolá-las em uma sub-classe.
    class property TableSeparator: string read FTableSeparator;
  end;

  TAqDBORMReader = class
  strict private
    class var FRttiContext: TRttiContext;
    class var FLocker: TCriticalSection;
    class var FTypes: TAqDictionary<string, TRttiType>;
    class var FORMs: TAqDictionary<string, TAqDBORM>;

    class function GetType(const pClass: TClass): TRttiType;
    class function CreateNewORM(const pClass: TClass): TAqDBORM;
  public
    class constructor Create;
    class destructor Destroy;

    class function GetORM(const pClass: TClass; const pUsePool: Boolean = True): TAqDBORM;
  end;

implementation

uses
  System.StrUtils,
  System.SysUtils,
  AqDrop.Core.Exceptions,
  AqDrop.Core.Helpers,
  AqDrop.Core.Helpers.TRttiType,
  AqDrop.Core.Helpers.TRttiObject;

{ TAqDBORMReader }

class constructor TAqDBORMReader.Create;
begin
  FRttiContext := TRttiContext.Create;
  FLocker := TCriticalSection.Create;
  FTypes := TAqDictionary<string, TRttiType>.Create;
  FORMs := TAqDictionary<string, TAqDBORM>.Create([TAqDictionaryContent.adcValue]);
end;

class function TAqDBORMReader.CreateNewORM(const pClass: TClass): TAqDBORM;
  procedure ReadClass(pClasse: TClass);
  var
    lClassType: TRttiType;
    lORMOff: AqORMOff;
    lTable: AqTable;
    lField: TRttiField;
    lActiveTable: TAqDBORMTable<AqTable>;
    lColumn: AqColumn;
    lProperty: TRttiProperty;
    lHasMapping: Boolean;
  begin
    if pClasse <> nil then
    begin
      ReadClass(pClasse.ClassParent);

      lClassType := GetType(pClasse);
      if not lClassType.GetAttribute<AqORMOff>(lORMOff) then
      begin
        if lClassType.GetAttribute<AqTable>(lTable) then
        begin
          Result.AddTable(lTable, lClassType);
        end;

        lActiveTable := Result.ActiveTable;

        for lField in lClassType.GetDeclaredFields do
        begin
          if not lField.GetAttribute<AqORMOff>(lORMOff) then
          begin
            lHasMapping := lField.GetAttribute<AqColumn>(lColumn);
            if not lHasMapping then
            begin
              lColumn := nil;
            end;

            if lHasMapping or
              (Result.Initialized and (tmpAutoMapFields in lActiveTable.Attribute.MappingProperties)) then
            begin
              lActiveTable.AddColumn(lField, lColumn);
            end;
          end;
        end;

        for lProperty in lClassType.GetDeclaredProperties do
        begin
          if not lProperty.GetAttribute<AqORMOff>(lORMOff) then
          begin
            lHasMapping := lProperty.GetAttribute<AqColumn>(lColumn);
            if not lHasMapping then
            begin
              lColumn := nil;
            end;

            if lHasMapping or
              (Result.Initialized and (tmpAutoMapProperties in lActiveTable.Attribute.MappingProperties)) then
            begin
              lActiveTable.AddColumn(lProperty, lColumn);
            end;
          end;
        end;
      end;
    end;
  end;
begin
  Result := TAqDBORM.Create;

  try
    ReadClass(pClass);
  except
    Result.Free;
    raise;
  end;
end;

class destructor TAqDBORMReader.Destroy;
begin
  FORMs.Free;
  FTypes.Free;
  FLocker.Free;
  FRttiContext.Free;
end;

class function TAqDBORMReader.GetORM(const pClass: TClass; const pUsePool: Boolean): TAqDBORM;
begin
  if pUsePool then
  begin
    FLocker.Enter;

    try
      if not FORMs.TryGetValue(pClass.QualifiedClassName, Result) then
      begin
        Result := CreateNewORM(pClass);

        try
          FORMs.Add(pClass.QualifiedClassName, Result);
        except
          Result.Free;
          raise;
        end;
      end;
    finally
      FLocker.Leave;
    end;
  end else begin
    Result := CreateNewORM(pClass);
  end;
end;

class function TAqDBORMReader.GetType(const pClass: TClass): TRttiType;
begin
  FLocker.Enter;

  try
    if not FTypes.TryGetValue(pClass.QualifiedClassName, Result) then
    begin
      Result := FRttiContext.GetType(pClass);

      try
        FTypes.Add(pClass.QualifiedClassName, Result);
      except
        Result.Free;
        raise;
      end;
    end;
  finally
    FLocker.Leave;
  end;
end;

{ TAqDBORM }

procedure TAqDBORM.AddTable(const pTableInfo: AqTable; const pType: TRttiType);
begin
  if not Assigned(FMainTable.Attribute) then
  begin
    FMainTable.SetAttribute(pTableInfo, pType);
  end else begin
    if not (pTableInfo is AqSpecialization) then
    begin
      raise EAqInternal.Create('This ORM already has a main table. All other tables must be specializations.');
    end;

    if not Assigned(FSpecializations) then
    begin
      FSpecializations := TAqList<TAqDBORMTable<AqSpecialization>>.Create(True);
    end;

    FSpecializations.Add(TAqDBORMTable<AqSpecialization>.Create(AqSpecialization(pTableInfo), pType));
  end;
end;

class constructor TAqDBORM.Create;
begin
  FTableSeparator := '.';
end;

constructor TAqDBORM.Create;
begin
  FMainTable := TAqDBORMTable<AqTable>.Create(nil, nil);
end;

destructor TAqDBORM.Destroy;
begin
  FSpecializations.Free;
  FMainTable.Free;

  inherited;
end;

function TAqDBORM.GetColumn(const pName: string; out pColumn: TAqDBORMColumn): Boolean;
var
  lSeparatorPosition: Int32;
  lTableName: string;
  lColumnName: string;
  lITable: Int32;

  function FindColumn(const pColumns: TAqReadList<TAqDBORMColumn>; out pColumn: TAqDBORMColumn): Boolean;
  var
    lIColumn: Int32;
  begin
    Result := False;
    lIColumn := pColumns.Count;

    while not Result and (lIColumn > 0) do
    begin
      Dec(lIColumn);

      Result := string.SameText(lColumnName, pColumns[lIColumn].Name);

      if Result then
      begin
        pColumn := pColumns[lIColumn];
      end;
    end;
  end;
begin
  Result := False;
  lSeparatorPosition := pName.IndexOf(FTableSeparator);

  if lSeparatorPosition >= 0 then
  begin
    lTableName := pName.LeftFromPosition(lSeparatorPosition);
    lColumnName := pName.RightFromPosition(lSeparatorPosition);

    if string.SameText(lTableName, FMainTable.Name) then
    begin
      Result := FindColumn(FMainTable.Columns, pColumn);
    end else if HasSpecializations then
    begin
      lITable := FSpecializations.Count;

      while not Result and (lITable > 0) do
      begin
        Dec(lITable);

        Result := string.SameText(lTableName, FSpecializations[lITable].Attribute.Name);

        if Result then
        begin
          Result := FindColumn(FSpecializations[lITable].Columns, pColumn);
          lITable := 0;
        end;
      end;
    end;
  end else begin
    lColumnName := pName;
    Result := FindColumn(FMainTable.Columns, pColumn);

    if not Result and HasSpecializations then
    begin
      lITable := 0;

      while not Result and (lITable < FSpecializations.Count) do
      begin
        Result := FindColumn(FSpecializations[lITable].Columns, pColumn);
        Inc(lITable);
      end;
    end;
  end;
end;

function TAqDBORM.GetSpecializations: TAqReadList<TAqDBORMTable<AqSpecialization>>;
begin
  Result := FSpecializations.GetTReadList;
end;

function TAqDBORM.GetTable(const pName: string; out pTable: TAqDBORMTable): Boolean;
var
  lI: Int32;
begin
  Result := string.SameText(FMainTable.Name, pName);

  if Result then
  begin
    pTable := FMainTable;
  end else if HasSpecializations then
  begin
    lI := FSpecializations.Count;

    while not Result and (lI > 0) do
    begin
      Dec(lI);

      Result := FSpecializations[lI].Name = pName;

      if Result then
      begin
        pTable := FSpecializations[lI];
      end;
    end;
  end;
end;

function TAqDBORM.GetInitialized: Boolean;
begin
  Result := Assigned(FMainTable.Attribute);
end;

function TAqDBORM.GetPrimaryKeys: IAqResultList<TAqDBORMColumn>;
var
  lResult: TAqResultList<TAqDBORMColumn>;
  lSpecialization: TAqDBORMTable;

  procedure AddPrimaryKeys(const pTable: TAqDBORMTable);
  var
    lColumn: TAqDBORMColumn;
  begin
    for lColumn in pTable.Columns do
    begin
      if Assigned(lColumn.Attribute) and (lColumn.Attribute.PrimaryKey) then
      begin
        lResult.Add(lColumn);
      end;
    end;
  end;
begin
  lResult := TAqResultList<TAqDBORMCOlumn>.Create(False);

  try
    AddPrimaryKeys(FMainTable);

    if HasSpecializations then
    begin
      for lSpecialization in FSpecializations do
      begin
        AddPrimaryKeys(lSpecialization);
      end;
    end;
  except
    lResult.Free;
    raise;
  end;

  Result := lResult;
end;

function TAqDBORM.GetHasSpecializations: Boolean;
begin
  Result := Assigned(FSpecializations);
end;

function TAqDBORM.GetActiveTable: TAqDBORMTable<AqTable>;
begin
  if Assigned(FSpecializations) then
  begin
    Result := TAqDBORMTable<AqTable>(FSpecializations.Last);
  end else begin
    Result := FMainTable;
  end;
end;

{ TAqDBORMColumn }

constructor TAqDBORMColumn.Create(const pAttribute: AqColumn);
begin
  FAttribute := pAttribute;
end;

function TAqDBORMColumn.GetAlias: string;
begin
  if Assigned(FAttribute) and FAttribute.IsAliasDefined then
  begin
    Result := FAttribute.Alias;
  end else begin
    Result := '';
  end;
end;

procedure TAqDBORMColumn.SetDBValue(const pInstance: TObject; pValue: IAqDBValue);
  function IsNullIfZeroActive: Boolean;
  begin
    Result := Assigned(FAttribute) and (TAqDBColumnAttribute.caNullIfZero in FAttribute.Attributes);
  end;

  function IsNullIfEmptyActive: Boolean;
  begin
    Result := Assigned(FAttribute) and (TAqDBColumnAttribute.caNullIfEmpty in FAttribute.Attributes);
  end;

var
  lValue: TValue;
begin
  lValue := GetValue(pInstance);

  case GetType of
    TAqDataType.adtBoolean:
      pValue.AsBoolean := lValue.AsBoolean;
    TAqDataType.adtEnumerated:
      pValue.AsInt64 := lValue.AsOrdinal;
    TAqDataType.adtUInt8:
      if (lValue.AsInteger = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtUInt8);
      end else begin
        pValue.AsUInt8 := lValue.AsInteger;
      end;
    TAqDataType.adtInt8:
      if (lValue.AsInteger = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtInt8);
      end else begin
        pValue.AsInt8 := lValue.AsInteger;
      end;
    TAqDataType.adtUInt16:
      if (lValue.AsInteger = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtUInt16);
      end else begin
        pValue.AsUInt16 := lValue.AsInteger;
      end;
    TAqDataType.adtInt16:
      if (lValue.AsInteger = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtInt16);
      end else begin
        pValue.AsInt16 := lValue.AsInteger;
      end;
    TAqDataType.adtUInt32:
{$IF CompilerVersion >= 25}
      if (lValue.AsUInt64 = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtUInt32);
      end else begin
        pValue.AsUInt32 := lValue.AsUInt64;
      end;
{$ELSE}
      if (lValue.AsInt64 = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtInt32);
      end else begin
        pValue.AsUInt32 := lValue.AsInt64;
      end;
{$IFEND}
    TAqDataType.adtInt32:
      if (lValue.AsInteger = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtInt32);
      end else begin
        pValue.AsInt32 :=  lValue.AsInteger;
      end;
    TAqDataType.adtUInt64:
{$IF CompilerVersion >= 25}
      if (lValue.AsUInt64 = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtUInt64);
      end else begin
        pValue.AsUInt64 := lValue.AsUInt64;
      end;
{$ELSE}
      if (lValue.AsInt64 = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtInt32);
      end else begin
        pValue.AsUInt64 := lValue.AsInt64;
      end;
{$IFEND}
    TAqDataType.adtInt64:
      if (lValue.AsInt64 = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtInt64);
      end else begin
        pValue.AsInt64 := lValue.AsInt64;
      end;
    TAqDataType.adtCurrency:
      if (lValue.AsCurrency = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtCurrency);
      end else begin
        pValue.AsCurrency := lValue.AsCurrency;
      end;
    TAqDataType.adtDouble:
      if (lValue.AsExtended = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtDouble);
      end else begin
        pValue.AsDouble := lValue.AsExtended;
      end;
    TAqDataType.adtSingle:
      if (lValue.AsExtended = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtSingle);
      end else begin
        pValue.AsSingle := lValue.AsExtended;
      end;
    TAqDataType.adtDatetime:
      if (lValue.AsExtended = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtDatetime);
      end else begin
        pValue.AsDateTime := lValue.AsExtended;
      end;
    TAqDataType.adtDate:
      if (lValue.AsExtended = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtDate);
      end else begin
        pValue.AsDate := lValue.AsExtended;
      end;
    TAqDataType.adtTime:
      if (lValue.AsExtended = 0) and IsNullIfZeroActive then
      begin
        pValue.SetNull(TAqDataType.adtTime);
      end else begin
        pValue.AsTime := lValue.AsExtended;
      end;
{$IFNDEF AQMOBILE}
    TAqDataType.adtAnsiChar:
      if lValue.AsString.IsEmpty and IsNullIfEmptyActive then
      begin
        pValue.SetNull(TAqDataType.adtAnsiChar);
      end else begin
        pValue.AsAnsiString := AnsiString(lValue.AsString);
      end;
{$ENDIF}
    TAqDataType.adtChar:
      if lValue.AsString.IsEmpty and IsNullIfEmptyActive then
      begin
        pValue.SetNull(TAqDataType.adtChar);
      end else begin
        pValue.AsString := lValue.AsString;
      end;
{$IFNDEF AQMOBILE}
    TAqDataType.adtAnsiString:
      if lValue.AsString.IsEmpty and IsNullIfEmptyActive then
      begin
        pValue.SetNull(TAqDataType.adtAnsiString);
      end else begin
        pValue.AsAnsiString := AnsiString(lValue.AsString);
      end;
{$ENDIF}
    TAqDataType.adtString, TAqDataType.adtWideString:
      if lValue.AsString.IsEmpty and IsNullIfEmptyActive then
      begin
        pValue.SetNull(TAqDataType.adtWideString);
      end else begin
        pValue.AsString := lValue.AsString;
      end;
  else
    raise EAqInternal.Create('Unexpected type when setting value to ' + Self.Name + ' DB Value.');
  end;
end;

procedure TAqDBORMColumn.SetObjectValue(const pInstance: TObject; pValue: TValue);
begin
  SetValue(pInstance, pValue);
end;

procedure TAqDBORMColumn.SetObjectValue(const pInstance: TObject; pValue: IAqDBReadValue);
var
  lValue: TValue;
begin
  case GetType of
    TAqDataType.adtBoolean:
      lValue := TValue.From<Boolean>(pValue.AsBoolean);
    TAqDataType.adtEnumerated:
      lValue := TValue.FromOrdinal(GetTypeInfo, pValue.AsInt64);
    TAqDataType.adtUInt8:
      lValue := TValue.From<UInt8>(pValue.AsUInt8);
    TAqDataType.adtInt8:
      lValue := TValue.From<Int8>(pValue.AsInt8);
    TAqDataType.adtUInt16:
      lValue := TValue.From<UInt16>(pValue.AsUInt16);
    TAqDataType.adtInt16:
      lValue := TValue.From<Int16>(pValue.AsInt16);
    TAqDataType.adtUInt32:
      lValue := TValue.From<UInt32>(pValue.AsUInt32);
    TAqDataType.adtInt32:
      lValue := TValue.From<Int32>(pValue.AsInt32);
    TAqDataType.adtUInt64:
      lValue := TValue.From<UInt64>(pValue.AsUInt64);
    TAqDataType.adtInt64:
      lValue := TValue.From<Int64>(pValue.AsInt64);
    TAqDataType.adtCurrency:
      lValue := TValue.From<Currency>(pValue.AsCurrency);
    TAqDataType.adtDouble:
      lValue := TValue.From<Double>(pValue.AsDouble);
    TAqDataType.adtSingle:
      lValue := TValue.From<Single>(pValue.AsSingle);
    TAqDataType.adtDatetime:
      lValue := TValue.From<TDateTime>(pValue.AsDateTime);
    TAqDataType.adtDate:
      lValue := TValue.From<TDate>(pValue.AsDate);
    TAqDataType.adtTime:
      lValue := TValue.From<TTime>(pValue.AsTime);
{$IFNDEF AQMOBILE}
    TAqDataType.adtAnsiChar:
      lValue := TValue.From<AnsiChar>(AnsiChar(pValue.AsString.Chars[0]));
{$ENDIF}
    TAqDataType.adtChar:
      lValue := TValue.From<Char>(pValue.AsString.Chars[0]);
{$IFNDEF AQMOBILE}
    TAqDataType.adtAnsiString:
      lValue := TValue.From<AnsiString>(pValue.AsAnsiString);
{$ENDIF}
    TAqDataType.adtString, TAqDataType.adtWideString:
      lValue := TValue.From<string>(pValue.AsString);
  else
    raise EAqInternal.Create('Unexpected type when setting value to ' + Self.Name + ' object value.');
  end;

  SetValue(pInstance, lValue);
end;

{ TAqDBORMTable }

procedure TAqDBORMTable.AddColumn(const pField: TRttiField; const pAttribute: AqColumn);
begin
  FColumns.Add(TAqDBORMColumnField.Create(pField, pAttribute));
end;

procedure TAqDBORMTable.AddColumn(const pProperty: TRttiProperty; const pAttribute: AqColumn);
begin
  FColumns.Add(TAqDBORMColumnProperty.Create(pProperty, pAttribute));
end;

constructor TAqDBORMTable.Create(const pType: TRttiType);
begin
  FType := pType;
  FColumns := TAqList<TAqDBORMColumn>.Create(True);
end;

destructor TAqDBORMTable.Destroy;
begin
  FColumns.Free;

  inherited;
end;

function TAqDBORMTable.ExtractTableName(const pType: TRttiType): string;
begin
  if (Length(pType.Name) > 1) and StartsStr('T', AnsiUpperCase(pType.Name)) then
  begin
    Result := RightStr(pType.Name, Length(pType.Name) - 1);
  end else begin
    Result := pType.Name;
  end;
end;

function TAqDBORMTable.GetColumns: TAqReadList<TAqDBORMColumn>;
begin
  Result := FColumns.GetTReadList;
end;

function TAqDBORMTable.HasAutoIncrementColumn(out pColumn: TAqDBORMColumn): Boolean;
var
  lI: Int32;
begin
  Result := False;
  lI := 0;
  while not Result and (lI < FColumns.Count) do
  begin
    Result := Assigned(FColumns[lI].Attribute) and FColumns[lI].Attribute.AutoIncrement;

    if Result then
    begin
      pColumn := FColumns[lI];
    end else begin
      Inc(lI);
    end;
  end;
end;

procedure TAqDBORMTable.SetType(const pType: TRttiType);
begin
  FType := pType;
end;

{ TAqDBORMTable<T> }

constructor TAqDBORMTable<T>.Create(const pAttribute: T; const pType: TRttiType);
begin
  inherited Create(pType);

  FAttribute := pAttribute;
end;

function TAqDBORMTable<T>.GetName: string;
begin
  if Assigned(FAttribute) and FAttribute.IsNameDefined then
  begin
    Result := FAttribute.Name;
  end else if Assigned(&Type) then
  begin
    Result := ExtractTableName(&Type);
  end else begin
    raise EAqInternal.Create('Impossible to get the table name.');
  end;
end;

procedure TAqDBORMTable<T>.SetAttribute(const pAttribute: T; const pType: TRttiType);
begin
  SetType(pType);
  FAttribute := pAttribute;
end;

{ TAqDBORMColumnField }

constructor TAqDBORMColumnField.Create(const pField: TRttiField; const pAttribute: AqColumn);
begin
  inherited Create(pAttribute);

  FField := pField;
end;

function TAqDBORMColumnField.ExtractColumnName(const pRttiObject: TRttiNamedObject): string;
begin
  if (Length(pRttiObject.Name) > 1) and StartsStr('F', AnsiUpperCase(pRttiObject.Name)) then
  begin
    Result := RightStr(pRttiObject.Name, Length(pRttiObject.Name) - 1);
  end else begin
    Result := pRttiObject.Name;
  end;
end;

function TAqDBORMColumnField.GetName: string;
begin
  if Assigned(Attribute) and Attribute.IsNameDefined then
  begin
    Result := Attribute.Name;
  end else begin
    Result := ExtractColumnName(FField);
  end;
end;

function TAqDBORMColumnField.GetType: TAqDataType;
begin
  Result := FField.FieldType.GetDataType;
end;

function TAqDBORMColumnField.GetTypeInfo: PTypeInfo;
begin
  Result := FField.FieldType.Handle;
end;

function TAqDBORMColumnField.GetValue(const pInstance: TObject): TValue;
begin
  Result := FField.GetValue(pInstance);
end;

procedure TAqDBORMColumnField.SetValue(const pInstance: TObject; const pValue: TValue);
begin
  FField.SetValue(pInstance, pValue);
end;

{ TAqDBORMColumnProperty }

constructor TAqDBORMColumnProperty.Create(const pProperty: TRttiProperty; const pAttribute: AqColumn);
begin
  inherited Create(pAttribute);

  FProperty := pProperty;
end;

function TAqDBORMColumnProperty.GetName: string;
begin
  if Assigned(Attribute) and Attribute.IsNameDefined then
  begin
    Result := Attribute.Name;
  end else begin
    Result := FProperty.Name;
  end;
end;

function TAqDBORMColumnProperty.GetType: TAqDataType;
begin
  Result := FProperty.PropertyType.GetDataType;
end;

function TAqDBORMColumnProperty.GetTypeInfo: PTypeInfo;
begin
  Result := FProperty.PropertyType.Handle;
end;

function TAqDBORMColumnProperty.GetValue(const pInstance: TObject): TValue;
begin
  Result := FProperty.GetValue(pInstance);
end;

procedure TAqDBORMColumnProperty.SetValue(const pInstance: TObject; const pValue: TValue);
begin
  if not FProperty.IsWritable then
  begin
    raise EAqInternal.Create('Property ' + FProperty.Name + ' is read only.');
  end;

  FProperty.SetValue(pInstance, pValue);
end;

end.
