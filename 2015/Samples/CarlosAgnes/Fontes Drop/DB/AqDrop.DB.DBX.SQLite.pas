unit AqDrop.DB.DBX.SQLite;

interface

uses
  System.SysUtils,
  Data.FmtBcd,
  Data.DBXCommon,
  Data.DbxSqlite,
  AqDrop.DB.Adapter,
  AqDrop.DB.DBX;

type
  TAqDBXSQLiteDataConverter = class(TAqDBXDataConverter)
  public
    procedure BCDToParameter(const pParameter: TDBXParameter; const pValue: TBcd); override;
    procedure TimeToParameter(const pParameter: TDBXParameter; const pValue: TTime); override;
    procedure DateToParameter(const pParameter: TDBXParameter; const pValue: TDate); override;
    procedure DateTimeToParameter(const pParameter: TDBXParameter; const pValue: TDateTime); override;

    function DBToString(const pValue: TAqDBXBaseValue): string; override;
    function DBToUInt8(const pValue: TAqDBXBaseValue): Byte; override;
    function DBToInt8(const pValue: TAqDBXBaseValue): ShortInt; override;
    function DBToInt16(const pValue: TAqDBXBaseValue): SmallInt; override;
    function DBToUInt16(const pValue: TAqDBXBaseValue): Word; override;
    function DBToInt32(const pValue: TAqDBXBaseValue): Int32; override;
    function DBToUInt32(const pValue: TAqDBXBaseValue): Cardinal; override;
    function DBToInt64(const pValue: TAqDBXBaseValue): Int64; override;
    function DBToUInt64(const pValue: TAqDBXBaseValue): UInt64; override;
  end;

  TAqDBXSQLiteAdapter = class(TAqDBXAdapter)
  strict protected
    function GetParameterCreationOrder: TAqDBXParameterCreationOrder; override;

    class function GetDefaultSolver: TAqDBSQLSolverClass; override;
    class function GetDefaultConverter: TAqDBXDataConverterClass; override;
  end;

  TAqDBXSQLiteConnection = class(TAqDBXCustomConnection)
  strict private const
    PROPERTY_FAIL_IF_MISSING_NAME = 'FailIfMissing';
  strict protected
    function GetPropertyValueAsString(const pIndex: Int32): string; override;
    procedure SetPropertyValueAsString(const pIndex: Int32; const pValue: string); override;
    function GetPropertyValueAsBoolean(const pIndex: Int32): Boolean;
    procedure SetPropertyValueAsBoolean(const pIndex: Int32; const pValue: Boolean);

    class function GetDefaultAdapter: TAqDBAdapterClass; override;
  public
    constructor Create; override;

    property DataBase: string index $80 read GetPropertyValueAsString write SetPropertyValueAsString;
    property FailIfMissing: Boolean index $81 read GetPropertyValueAsBoolean write SetPropertyValueAsBoolean;
    property DriverUnit: string index $82 read GetPropertyValueAsString write SetPropertyValueAsString;
    property DriverPackageLoader: string index $83 read GetPropertyValueAsString write SetPropertyValueAsString;
    property MetaDataPackageLoader: string index $84 read GetPropertyValueAsString write SetPropertyValueAsString;
  end;


implementation

uses
  System.Classes,
  AqDrop.Core.Exceptions,
  AqDrop.Core.Helpers,
  AqDrop.DB.SQLite;

{ TAqDBXSQLiteAdapter }

class function TAqDBXSQLiteAdapter.GetDefaultConverter: TAqDBXDataConverterClass;
begin
  Result := TAqDBXSQLiteDataConverter;
end;

class function TAqDBXSQLiteAdapter.GetDefaultSolver: TAqDBSQLSolverClass;
begin
  Result := TAqDBSQLiteSQLSolver;
end;

function TAqDBXSQLiteAdapter.GetParameterCreationOrder: TAqDBXParameterCreationOrder;
begin
  Result := TAqDBXParameterCreationOrder.pcoCreateAfterPrepare;
end;

{ TAqDBXSQLiteConnection }

constructor TAqDBXSQLiteConnection.Create;
begin
  inherited;

  Self.DriverName := 'Sqlite';
end;

class function TAqDBXSQLiteConnection.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := TAqDBXSQLiteAdapter;
end;

function TAqDBXSQLiteConnection.GetPropertyValueAsBoolean(const pIndex: Int32): Boolean;
begin
  case pIndex of
    $81:
      Result := Properties[PROPERTY_FAIL_IF_MISSING_NAME].ToBoolean;
  else
    raise EAqInternal.Create('Index not expected in TAqDBXSQLiteConnection.GetPropertyValueAsBoolean.');
  end;
end;

function TAqDBXSQLiteConnection.GetPropertyValueAsString(const pIndex: Int32): string;
begin
  case pIndex of
    $80:
      Result := Properties[TDBXPropertyNames.Database];
    $82:
      Result := Properties[TDBXPropertyNames.DriverUnit];
    $83:
      Result := Properties[TDBXPropertyNames.DriverPackageLoader];
    $84:
      Result := Properties[TDBXPropertyNames.MetaDataPackageLoader];
  else
    Result := inherited;
  end;
end;

procedure TAqDBXSQLiteConnection.SetPropertyValueAsBoolean(const pIndex: Int32; const pValue: Boolean);
begin
  case pIndex of
    $81:
      Properties[PROPERTY_FAIL_IF_MISSING_NAME] := pValue.ToString;
  else
    raise EAqInternal.Create('Index not expected in TAqDBXSQLiteConnection.SetPropertyValueAsBoolean.');
  end;
end;

procedure TAqDBXSQLiteConnection.SetPropertyValueAsString(const pIndex: Int32; const pValue: string);
begin
  case pIndex of
    $80:
      Properties[TDBXPropertyNames.Database] := pValue;
    $82:
      Properties[TDBXPropertyNames.DriverUnit] := pValue;
    $83:
      Properties[TDBXPropertyNames.DriverPackageLoader] := pValue;
    $84:
      Properties[TDBXPropertyNames.MetaDataPackageLoader] := pValue;
  else
    inherited;
  end;
end;

{ TAqDBXSQLiteDataConverter }

procedure TAqDBXSQLiteDataConverter.BCDToParameter(const pParameter: TDBXParameter; const pValue: TBcd);
begin
  pParameter.DataType := TDBXDataTypes.DoubleType;
  pParameter.Value.AsDouble := pValue.ToDouble;
end;

procedure TAqDBXSQLiteDataConverter.DateTimeToParameter(const pParameter: TDBXParameter; const pValue: TDateTime);
begin
  pParameter.DataType := TDBXDataTypes.DoubleType;
  pParameter.Value.AsDouble := pValue;
end;

procedure TAqDBXSQLiteDataConverter.DateToParameter(const pParameter: TDBXParameter; const pValue: TDate);
begin
  DateTimeToParameter(pParameter, pValue);
end;

function TAqDBXSQLiteDataConverter.DBToInt16(const pValue: TAqDBXBaseValue): SmallInt;
begin
  if not pValue.DBXValue.IsNull and (pValue.DBXValue.ValueType.DataType = TDBXDataTypes.BlobType) then
  begin
    Result := DBToString(pValue).ToInt16;
  end else begin
    Result := inherited;
  end;
end;

function TAqDBXSQLiteDataConverter.DBToInt32(const pValue: TAqDBXBaseValue): Int32;
begin
  if not pValue.DBXValue.IsNull and (pValue.DBXValue.ValueType.DataType = TDBXDataTypes.BlobType) then
  begin
    Result := DBToString(pValue).ToInt32;
  end else begin
    Result := inherited;
  end;
end;

function TAqDBXSQLiteDataConverter.DBToInt64(const pValue: TAqDBXBaseValue): Int64;
begin
  if not pValue.DBXValue.IsNull and (pValue.DBXValue.ValueType.DataType = TDBXDataTypes.BlobType) then
  begin
    Result := DBToString(pValue).ToInt64;
  end else begin
    Result := inherited;
  end;
end;

function TAqDBXSQLiteDataConverter.DBToInt8(const pValue: TAqDBXBaseValue): ShortInt;
begin
  if not pValue.DBXValue.IsNull and (pValue.DBXValue.ValueType.DataType = TDBXDataTypes.BlobType) then
  begin
    Result := DBToString(pValue).ToUInt8;
  end else begin
    Result := inherited;
  end;
end;

function TAqDBXSQLiteDataConverter.DBToString(const pValue: TAqDBXBaseValue): string;
var
  lBufferSize: Int64;
  lIsNull: LongBool;
  lBuffer: TArray<Byte>;
begin
  if not pValue.DBXValue.IsNull and (pValue.DBXValue.ValueType.DataType = TDBXDataTypes.BlobType) then
  begin
    if pValue.DBXValue.ValueType.SubType in [TDBXDataTypes.TableType, TDBXDataTypes.WideMemoSubType] then
    begin
      pValue.Values.ByteReader.GetByteLength(pValue.Index, lBufferSize, lIsNull);
      SetString(Result, nil, lBufferSize div SizeOf(Char));
      lBuffer := TArray<Byte>(Pointer(Result));
      pValue.Values.ByteReader.GetBytes(pValue.Index, 0, lBuffer, 0, lBufferSize, lIsNull);
    end else begin
      raise EAqInternal.Create('Unexpected type when reading a BLOB field in TAqDBXSQLiteDataConverter.DBToString.');
    end;
  end else begin
    Result := inherited;
  end;
end;

function TAqDBXSQLiteDataConverter.DBToUInt16(const pValue: TAqDBXBaseValue): Word;
begin
  if not pValue.DBXValue.IsNull and (pValue.DBXValue.ValueType.DataType = TDBXDataTypes.BlobType) then
  begin
    Result := DBToString(pValue).ToUInt16;
  end else begin
    Result := inherited;
  end;
end;

function TAqDBXSQLiteDataConverter.DBToUInt32(const pValue: TAqDBXBaseValue): Cardinal;
begin
  if not pValue.DBXValue.IsNull and (pValue.DBXValue.ValueType.DataType = TDBXDataTypes.BlobType) then
  begin
    Result := DBToString(pValue).ToUInt32;
  end else begin
    Result := inherited;
  end;
end;

function TAqDBXSQLiteDataConverter.DBToUInt64(const pValue: TAqDBXBaseValue): UInt64;
begin
  if not pValue.DBXValue.IsNull and (pValue.DBXValue.ValueType.DataType = TDBXDataTypes.BlobType) then
  begin
    Result := DBToString(pValue).ToUInt64;
  end else begin
    Result := inherited;
  end;
end;

function TAqDBXSQLiteDataConverter.DBToUInt8(const pValue: TAqDBXBaseValue): Byte;
begin
  if not pValue.DBXValue.IsNull and (pValue.DBXValue.ValueType.DataType = TDBXDataTypes.BlobType) then
  begin
    Result := DBToString(pValue).ToInt8;
  end else begin
    Result := inherited;
  end;
end;

procedure TAqDBXSQLiteDataConverter.TimeToParameter(const pParameter: TDBXParameter; const pValue: TTime);
begin
  DateTimeToParameter(pParameter, pValue);
end;

end.
