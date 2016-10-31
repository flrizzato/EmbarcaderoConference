unit AqDrop.DB.FD;

{$I '..\Core\AqDrop.Core.Defines.Inc'}

interface

uses
  System.Classes,
  Data.SqlTimSt,
  Data.FmtBcd,
  Data.DB,
{$if CompilerVersion >= 26}
  FireDAC.Stan.Param,
{$endif}
  AqDrop.Core.Types,
  AqDrop.Core.InterfacedObject,
  AqDrop.Core.Collections,
  AqDrop.DB.Types,
  AqDrop.DB.Adapter,
  AqDrop.DB.Connection,
  AqDrop.DB.FD.TypeMapping;

const
  TAqFDDataTypeMapping: array[TAqDataType] of TFieldType = (
    TFieldType.ftUnknown,           // adtUnknown
    TFieldType.ftBoolean,           // adtBoolean
    TFieldType.ftInteger,           // adtEnumerated
    TFieldType.ftByte,              // adtUInt8
    TFieldType.ftShortint,          // adtInt8
    TFieldType.ftWord,              // adtUInt16
    TFieldType.ftSmallint,          // adtInt16
    TFieldType.ftLongWord,          // adtUInt32
    TFieldType.ftInteger,           // adtInt32
    TFieldType.ftLargeint,          // adtUInt64
    TFieldType.ftLargeint,          // adtInt64
    TFieldType.ftCurrency,          // adtCurrency
    TFieldType.ftFloat,             // adtDouble
    TFieldType.ftSingle,            // adtSingle
    TFieldType.ftDateTime,          // adtDatetime
    TFieldType.ftDate,              // adtDate
    TFieldType.ftTime,              // adtTime
    TFieldType.ftString,            // adtAnsiChar
    TFieldType.ftWideString,        // adtChar
    TFieldType.ftString,            // adtAnsiString
    TFieldType.ftWideString,        // adtString
    TFieldType.ftWideString,        // adtWideString
    TFieldType.ftUnknown,           // adtSet
    TFieldType.ftUnknown,           // adtClass
    TFieldType.ftUnknown,           // adtMethod
    TFieldType.ftVariant,           // adtVariant
    TFieldType.ftUnknown,           // adtRecord
    TFieldType.ftUnknown);          // adtInterface

type
  TAqFDDataConverter = class
  public
    function ParamToString(const pParameter: TAqFDMappedParam): string; virtual;
{$IFNDEF AQMOBILE}
    function ParamToAnsiString(const pParameter: TAqFDMappedParam): AnsiString; virtual;
{$ENDIF}
    function ParamToBoolean(const pParameter: TAqFDMappedParam): Boolean; virtual;
    function ParamToBCD(const pParameter: TAqFDMappedParam): TBcd; virtual;
    function ParamToDate(const pParameter: TAqFDMappedParam): TDate; virtual;
    function ParamToTime(const pParameter: TAqFDMappedParam): TTime; virtual;
    function ParamToDateTime(const pParameter: TAqFDMappedParam): TDateTime; virtual;
    function ParamToUInt8(const pParameter: TAqFDMappedParam): UInt8; virtual;
    function ParamToInt8(const pParameter: TAqFDMappedParam): Int8; virtual;
    function ParamToUInt16(const pParameter: TAqFDMappedParam): UInt16; virtual;
    function ParamToInt16(const pParameter: TAqFDMappedParam): Int16; virtual;
    function ParamToUInt32(const pParameter: TAqFDMappedParam): UInt32; virtual;
    function ParamToInt32(const pParameter: TAqFDMappedParam): Int32; virtual;
    function ParamToUInt64(const pParameter: TAqFDMappedParam): UInt64; virtual;
    function ParamToInt64(const pParameter: TAqFDMappedParam): Int64; virtual;
    function ParamToSingle(const pParameter: TAqFDMappedParam): Single; virtual;
    function ParamToDouble(const pParameter: TAqFDMappedParam): Double; virtual;
    function ParamToCurrency(const pParameter: TAqFDMappedParam): Currency; virtual;

    function FieldToString(const pField: TField): string; virtual;
{$IFNDEF AQMOBILE}
    function FieldToAnsiString(const pField: TField): AnsiString; virtual;
{$ENDIF}
    function FieldToBoolean(const pField: TField): Boolean; virtual;
    function FieldToBCD(const pField: TField): TBcd; virtual;
    function FieldToDate(const pField: TField): TDate; virtual;
    function FieldToTime(const pField: TField): TTime; virtual;
    function FieldToDateTime(const pField: TField): TDateTime; virtual;
    function FieldToUInt8(const pField: TField): UInt8; virtual;
    function FieldToInt8(const pField: TField): Int8; virtual;
    function FieldToUInt16(const pField: TField): UInt16; virtual;
    function FieldToInt16(const pField: TField): Int16; virtual;
    function FieldToUInt32(const pField: TField): UInt32; virtual;
    function FieldToInt32(const pField: TField): Int32; virtual;
    function FieldToUInt64(const pField: TField): UInt64; virtual;
    function FieldToInt64(const pField: TField): Int64; virtual;
    function FieldToSingle(const pField: TField): Single; virtual;
    function FieldToDouble(const pField: TField): Double; virtual;
    function FieldToCurrency(const pField: TField): Currency; virtual;

    procedure StringToParam(const pParameter: TAqFDMappedParam; const pValue: string); virtual;
{$IFNDEF AQMOBILE}
    procedure AnsiStringToParam(const pParameter: TAqFDMappedParam; const pValue: AnsiString); virtual;
{$ENDIF}
    procedure BooleanToParam(const pParameter: TAqFDMappedParam; const pValue: Boolean); virtual;
    procedure BCDToParam(const pParameter: TAqFDMappedParam; const pValue: TBcd); virtual;
    procedure DateToParam(const pParameter: TAqFDMappedParam; const pValue: TDate); virtual;
    procedure TimeToParam(const pParameter: TAqFDMappedParam; const pValue: TTime); virtual;
    procedure DateTimeToParam(const pParameter: TAqFDMappedParam; const pValue: TDateTime); virtual;
    procedure UInt8ToParam(const pParameter: TAqFDMappedParam; const pValue: UInt8); virtual;
    procedure Int8ToParam(const pParameter: TAqFDMappedParam; const pValue: Int8); virtual;
    procedure UInt16ToParam(const pParameter: TAqFDMappedParam; const pValue: UInt16); virtual;
    procedure Int16ToParam(const pParameter: TAqFDMappedParam; const pValue: Int16); virtual;
    procedure UInt32ToParam(const pParameter: TAqFDMappedParam; const pValue: UInt32); virtual;
    procedure Int32ToParam(const pParameter: TAqFDMappedParam; const pValue: Int32); virtual;
    procedure UInt64ToParam(const pParameter: TAqFDMappedParam; const pValue: UInt64); virtual;
    procedure Int64ToParam(const pParameter: TAqFDMappedParam; const pValue: Int64); virtual;
    procedure SingleToParam(const pParameter: TAqFDMappedParam; const pValue: Single); virtual;
    procedure DoubleToParam(const pParameter: TAqFDMappedParam; const pValue: Double); virtual;
    procedure CurrencyToParam(const pParameter: TAqFDMappedParam; const pValue: Currency); virtual;
  end;

  TAqFDDataConverterClass = class of TAqFDDataConverter;

  TAqFDAdapter = class(TAqDBAdapter)
  strict private
    FFDDataConverter: TAqFDDataConverter;

    procedure SetFDDataConverter(const pDataConverter: TAqFDDataConverter);
  strict protected
    function CreateDataConverter: TAqFDDataConverter; virtual;
    class function GetDefaultDataConverter: TAqFDDataConverterClass; virtual;
  public
    constructor Create; override;
    destructor Destroy; override;

    property FDDataConverter: TAqFDDataConverter read FFDDataConverter write SetFDDataConverter;
  end;

  TAqFDObject = class(TAqInterfacedObject)
  strict protected
    class function MustCountReferences: Boolean; override;
  end;

  TAqFDParameter = class;
  TAqFDParameters = class;
  TAqFDCustomConnection = class;

  TAqFDParameter = class(TAqFDObject, IAqDBValue)
  strict private
    FParameters: TAqFDParameters;
    FParameter: TAqFDMappedParam;
  public
    constructor Create(const pParameters: TAqFDParameters; const pParameter: TAqFDMappedParam);

    function GetName: string;
    procedure SetName(const pName: string);

    function GetIsNull: Boolean;

    procedure SetDataType(const pDataType: TAqDataType);

    function GetAsString: string;
{$IFNDEF AQMOBILE}
    function GetAsAnsiString: AnsiString;
{$ENDIF}
    function GetAsBoolean: Boolean;
    function GetAsTimeStamp: TSQLTimeStamp;
    function GetAsTimeStampOffset: TSQLTimeStampOffset;
    function GetAsBCD: TBcd;
    function GetAsDate: TDate;
    function GetAsTime: TTime;
    function GetAsDateTime: TDateTime;
    function GetAsUInt8: UInt8;
    function GetAsInt8: Int8;
    function GetAsUInt16: UInt16;
    function GetAsInt16: Int16;
    function GetAsUInt32: UInt32;
    function GetAsInt32: Int32;
    function GetAsUInt64: UInt64;
    function GetAsInt64: Int64;
    function GetAsSingle: Single;
    function GetAsDouble: Double;
    function GetAsCurrency: Currency;

    procedure SetAsString(const pValue: string);
{$IFNDEF AQMOBILE}
    procedure SetAsAnsiString(const pValue: AnsiString);
{$ENDIF}
    procedure SetAsBoolean(const pValue: Boolean);
    procedure SetAsTimeStamp(const pValue: TSQLTimeStamp);
    procedure SetAsTimeStampOffset(const pValue: TSQLTimeStampOffset);
    procedure SetAsBCD(const pValue: TBcd);
    procedure SetAsDate(const pValue: TDate);
    procedure SetAsTime(const pValue: TTime);
    procedure SetAsDateTime(const pValue: TDateTime);
    procedure SetAsUInt8(const pValue: UInt8);
    procedure SetAsInt8(const pValue: Int8);
    procedure SetAsUInt16(const pValue: UInt16);
    procedure SetAsInt16(const pValue: Int16);
    procedure SetAsUInt32(const pValue: UInt32);
    procedure SetAsInt32(const pValue: Int32);
    procedure SetAsUInt64(const pValue: UInt64);
    procedure SetAsInt64(const pValue: Int64);
    procedure SetAsSingle(const pValue: Single);
    procedure SetAsDouble(const pValue: Double);
    procedure SetAsCurrency(const pValue: Currency);

    procedure SetNull(const pDataType: TAqDataType = TAqDataType.adtUnknown);
  end;

  TAqFDParameters = class(TAqFDObject, IAqDBParameters)
  strict private
    FConnection: TAqFDCustomConnection;
    FQuery: TAqFDMappedQuery;
  public
    constructor Create(const pConnection: TAqFDCustomConnection; const pQuery: TAqFDMappedQuery);

    function GetValueByIndex(pIndex: Int32): IAqDBValue;
    function GetValueByName(pName: string): IAqDBValue;
    function GetCount: Int32;

    property Connection: TAqFDCustomConnection read FConnection;
  end;

  TAqFDField = class;
  TAqFDReader = class;

  TAqFDField = class(TAqFDObject, IAqDBReadValue)
  strict private
    FReader: TAqFDReader;
    FField: TField;
  public
    constructor Create(const pReader: TAqFDReader; const pField: TField);

    function GetName: string;
    procedure SetName(const pName: string);

    function GetIsNull: Boolean;

    function GetAsString: string;
{$IFNDEF AQMOBILE}
    function GetAsAnsiString: AnsiString;
{$ENDIF}
    function GetAsBoolean: Boolean;
    function GetAsTimeStamp: TSQLTimeStamp;
    function GetAsTimeStampOffset: TSQLTimeStampOffset;
    function GetAsBCD: TBcd;
    function GetAsDate: TDate;
    function GetAsTime: TTime;
    function GetAsDateTime: TDateTime;
    function GetAsUInt8: UInt8;
    function GetAsInt8: Int8;
    function GetAsUInt16: UInt16;
    function GetAsInt16: Int16;
    function GetAsUInt32: UInt32;
    function GetAsInt32: Int32;
    function GetAsUInt64: UInt64;
    function GetAsInt64: Int64;
    function GetAsSingle: Single;
    function GetAsDouble: Double;
    function GetAsCurrency: Currency;
  end;

  TAqFDReader = class(TAqFDObject, IAqDBReader)
  strict private
    FConnection: TAqFDCustomConnection;
    FQuery: TAqFDMappedQuery;
    FOwnsQuery: Boolean;
    FRecNo: Int32;
  public
    constructor Create(const pConnection: TAqFDCustomConnection; const pQuery: TAqFDMappedQuery;
      const pOwnsQuery: Boolean = True);
    destructor Destroy; override;

    function GetValueByIndex(pIndex: Int32): IAqDBReadValue;
    function GetValueByName(pName: string): IAqDBReadValue;
    function GetCount: Int32;

    function Next: Boolean;

    property Connection: TAqFDCustomConnection read FConnection;
  end;

  TAqFDCustomConnection = class(TAqDBConnection)
  strict private
    FFDConnection: TAqFDMappedConnection;
    FPreparedQueries: TAqIDDictionary<TAqFDMappedQuery>;

    function CreateQuery(const pSQL: string): TAqFDMappedQuery;

    function GetParams: TAqFDMappedConnectionParameters;
    function GetDriverName: string;
    procedure SetDriverName(const pValue: string);

    function GetFDAdapter: TAqFDAdapter;
    procedure SetFDAdapter(const pValue: TAqFDAdapter);
  strict protected
    procedure DoConnect; override;
    procedure DoDisconnect; override;

    function GetActive: Boolean; override;

    function DoPrepareCommand(const pSQL: string;
      const pParametersInitializer: TAqDBParametersHandlerMethod): TAqID; override;
    procedure DoUnprepareCommand(const pCommandID: TAqID); override;

    function DoExecuteCommand(const pSQL: string;
      const pParametersHandler: TAqDBParametersHandlerMethod): Int64; override;
    function DoExecuteCommand(const pCommandID: TAqID;
      const pParametersHandler: TAqDBParametersHandlerMethod): Int64; override;

    function DoOpenQuery(const pSQL: string;
      const pParametersHandler: TAqDBParametersHandlerMethod): IAqDBReader; override;
    function DoOpenQuery(const pCommandID: TAqID;
      const pParametersHandler: TAqDBParametersHandlerMethod): IAqDBReader; override;

    class function GetDefaultAdapter: TAqDBAdapterClass; override;

    function GetParameterValueByIndex(const pIndex: Int32): string; virtual;
    procedure SetParameterValueByIndex(const pIndex: Int32; const pValue: string); virtual;

    procedure DoStartTransaction; override;
    procedure DoCommitTransaction; override;
    procedure DoRollbackTransaction; override;

    property Params: TAqFDMappedConnectionParameters read GetParams;
    property DriverName: string read GetDriverName write SetDriverName;
  protected
    procedure SetAdapter(const pAdapter: TAqDBAdapter); override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property FDAdapter: TAqFDAdapter read GetFDAdapter write SetFDAdapter;
  end;

  TAqFDConnection = class(TAqFDCustomConnection)
  public
    property Params;
    property DriverName;
  end;


implementation

uses
  System.SysUtils,
  System.DateUtils,
{$if CompilerVersion >= 26}
{$else}
  uADStanParam,
{$endif}
  AqDrop.Core.Exceptions,
  AqDrop.Core.Helpers;

{ TAqFDCustomConnection }

constructor TAqFDCustomConnection.Create;
begin
  inherited;

  FFDConnection := TAqFDMappedConnection.Create(nil);
  FPreparedQueries := TAqIDDictionary<TAqFDMappedQuery>.Create(True);
end;

function TAqFDCustomConnection.CreateQuery(const pSQL: string): TAqFDMappedQuery;
begin
  Result := TAqFDMappedQuery.Create(nil);

  try
    Result.Connection := FFDConnection;
    Result.SQL.Text := pSQL;
    Result.FetchOptions.Unidirectional := True;
  except
    on E: Exception do
    begin
      Result.Free;
      E.RaiseOuterException(EAqInternal.Create('Could not create a new FDQuery.'));
    end;
  end;
end;

destructor TAqFDCustomConnection.Destroy;
begin
  FPreparedQueries.Free;
  FFDConnection.Free;

  inherited;
end;

procedure TAqFDCustomConnection.DoCommitTransaction;
begin
  FFDConnection.Commit;

  inherited;
end;

procedure TAqFDCustomConnection.DoConnect;
begin
  inherited;

  try
    FFDConnection.Open;
  except
    on E: Exception do
    begin
      RaiseImpossibleToConnect(E);
    end;
  end;
end;

procedure TAqFDCustomConnection.DoDisconnect;
begin
  inherited;

  FFDConnection.Close;
end;

function TAqFDCustomConnection.DoExecuteCommand(const pSQL: string;
  const pParametersHandler: TAqDBParametersHandlerMethod): Int64;
var
  lQuery: TAqFDMappedQuery;
begin
  lQuery := CreateQuery(pSQL);

  try
    if Assigned(pParametersHandler) then
    begin
      pParametersHandler(TAqFDParameters.Create(Self, lQuery));
    end;

    lQuery.ExecSQL;

    Result := lQuery.RowsAffected;
  finally
    lQuery.Free;
  end;
end;

function TAqFDCustomConnection.DoExecuteCommand(const pCommandID: TAqID;
  const pParametersHandler: TAqDBParametersHandlerMethod): Int64;
var
  lQuery: TAqFDMappedQuery;
begin
  if FPreparedQueries.TryGetValue(pCommandID, lQuery) then
  begin
    if Assigned(pParametersHandler) then
    begin
      pParametersHandler(TAqFDParameters.Create(Self, lQuery));
    end;

    lQuery.ExecSQL;
    Result := lQuery.RowsAffected;
  end else begin
    raise EAqInternal.Create('Command from ID ' + pCommandID.ToString + ' not found.');
  end;
end;

function TAqFDCustomConnection.DoOpenQuery(const pSQL: string;
  const pParametersHandler: TAqDBParametersHandlerMethod): IAqDBReader;
var
  lQuery: TAqFDMappedQuery;
begin
  lQuery := CreateQuery(pSQL);

  try
    if Assigned(pParametersHandler) then
    begin
      pParametersHandler(TAqFDParameters.Create(Self, lQuery));
    end;

    Result := TAqFDReader.Create(Self, lQuery);
  except
    lQuery.Free;
    raise;
  end;
end;

function TAqFDCustomConnection.DoOpenQuery(const pCommandID: TAqID;
  const pParametersHandler: TAqDBParametersHandlerMethod): IAqDBReader;
var
  lQuery: TAqFDMappedQuery;
begin
  if FPreparedQueries.TryGetValue(pCommandID, lQuery) then
  begin
    if Assigned(pParametersHandler) then
    begin
      pParametersHandler(TAqFDParameters.Create(Self, lQuery));
    end;

    Result := TAqFDReader.Create(Self, lQuery, False);
  end else begin
    raise EAqInternal.Create('Command from ID ' + pCommandID.ToString + ' not found.');
  end;
end;

function TAqFDCustomConnection.DoPrepareCommand(const pSQL: string;
  const pParametersInitializer: TAqDBParametersHandlerMethod): TAqID;
var
  lQuery: TAqFDMappedQuery;
begin
  Result := 0;

  lQuery := CreateQuery(pSQL);

  try
    if Assigned(pParametersInitializer) then
    begin
      pParametersInitializer(TAqFDParameters.Create(Self, lQuery));
    end;

    lQuery.Prepare;
    Result := FPreparedQueries.Add(lQuery);
  except
    on E: Exception do
    begin
      lQuery.Free;
      E.RaiseOuterException(EAqInternal.Create('Could not prepare the query component.'));
    end;
  end;
end;

procedure TAqFDCustomConnection.DoRollbackTransaction;
begin
  FFDConnection.Rollback;

  inherited;
end;

procedure TAqFDCustomConnection.DoStartTransaction;
begin
  inherited;

  FFDConnection.StartTransaction;
end;

procedure TAqFDCustomConnection.DoUnprepareCommand(const pCommandID: TAqID);
begin
  FPreparedQueries.Remove(pCommandID);

  inherited;
end;

function TAqFDCustomConnection.GetActive: Boolean;
begin
  Result := FFDConnection.Connected;
end;

class function TAqFDCustomConnection.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := TAqFDAdapter;
end;

function TAqFDCustomConnection.GetDriverName: string;
begin
  Result := FFDConnection.DriverName;
end;

function TAqFDCustomConnection.GetFDAdapter: TAqFDAdapter;
begin
  Result := TAqFDAdapter(Adapter);
end;

function TAqFDCustomConnection.GetParameterValueByIndex(const pIndex: Int32): string;
begin
  raise EAqInternal.Create('Index not defined to get a parameter connection.');
end;

function TAqFDCustomConnection.GetParams: TAqFDMappedConnectionParameters;
begin
  Result := FFDConnection.Params;
end;

procedure TAqFDCustomConnection.SetDriverName(const pValue: string);
begin
  FFDConnection.DriverName := pValue;
end;

procedure TAqFDCustomConnection.SetFDAdapter(const pValue: TAqFDAdapter);
begin
  SetAdapter(pValue);
end;

procedure TAqFDCustomConnection.SetAdapter(const pAdapter: TAqDBAdapter);
begin
  if not (pAdapter is TAqFDAdapter) then
  begin
    raise EAqInternal.Create('Invalid Adapter for a FD Connection.');
  end;

  inherited;
end;

procedure TAqFDCustomConnection.SetParameterValueByIndex(const pIndex: Int32; const pValue: string);
begin
  raise EAqInternal.Create('Index not defined to set a parameter connection.');
end;

{ TAqFDParameters }

constructor TAqFDParameters.Create(const pConnection: TAqFDCustomConnection; const pQuery: TAqFDMappedQuery);
begin
  FConnection := pConnection;
  FQuery := pQuery;
end;

function TAqFDParameters.GetCount: Int32;
begin
  Result := FQuery.ParamCount;
end;

function TAqFDParameters.GetValueByIndex(pIndex: Int32): IAqDBValue;
begin
  Result := TAqFDParameter.Create(Self, FQuery.Params[pIndex]);
end;

function TAqFDParameters.GetValueByName(pName: string): IAqDBValue;
begin
  Result := TAqFDParameter.Create(Self, FQuery.ParamByName(pName));
end;

{ TAqFDParameter }

constructor TAqFDParameter.Create(const pParameters: TAqFDParameters; const pParameter: TAqFDMappedParam);
begin
  FParameters := pParameters;
  FParameter := pParameter;
end;

{$IFNDEF AQMOBILE}
function TAqFDParameter.GetAsAnsiString: AnsiString;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToAnsiString(FParameter);
end;
{$ENDIF}

function TAqFDParameter.GetAsBCD: TBcd;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToBCD(FParameter);
end;

function TAqFDParameter.GetAsBoolean: Boolean;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToBoolean(FParameter);
end;

function TAqFDParameter.GetAsCurrency: Currency;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToCurrency(FParameter);
end;

function TAqFDParameter.GetAsDate: TDate;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToDate(FParameter);
end;

function TAqFDParameter.GetAsDateTime: TDateTime;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToDateTime(FParameter);
end;

function TAqFDParameter.GetAsDouble: Double;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToDouble(FParameter);
end;

function TAqFDParameter.GetAsInt16: Int16;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToInt16(FParameter);
end;

function TAqFDParameter.GetAsInt32: Int32;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToInt32(FParameter);
end;

function TAqFDParameter.GetAsInt64: Int64;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToInt64(FParameter);
end;

function TAqFDParameter.GetAsInt8: Int8;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToInt8(FParameter);
end;

function TAqFDParameter.GetAsSingle: Single;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToSingle(FParameter);
end;

function TAqFDParameter.GetAsString: string;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToString(FParameter);
end;

function TAqFDParameter.GetAsTime: TTime;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToTime(FParameter);
end;

function TAqFDParameter.GetAsTimeStamp: TSQLTimeStamp;
begin
  raise EAqInternal.Create('TSQLTimeStamp not implemented in Drop to FD.');
end;

function TAqFDParameter.GetAsTimeStampOffset: TSQLTimeStampOffset;
begin
  raise EAqInternal.Create('TSQLTimeStampOffset not implemented in Drop to FD.');
end;

function TAqFDParameter.GetAsUInt16: UInt16;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToUInt16(FParameter);
end;

function TAqFDParameter.GetAsUInt32: UInt32;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToUInt32(FParameter);
end;

function TAqFDParameter.GetAsUInt64: UInt64;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToUInt64(FParameter);
end;

function TAqFDParameter.GetAsUInt8: UInt8;
begin
  Result := FParameters.Connection.FDAdapter.FDDataConverter.ParamToUInt8(FParameter);
end;

function TAqFDParameter.GetIsNull: Boolean;
begin
  Result := FParameter.IsNull;
end;

function TAqFDParameter.GetName: string;
begin
  Result := FParameter.Name;
end;

{$IFNDEF AQMOBILE}
procedure TAqFDParameter.SetAsAnsiString(const pValue: AnsiString);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.AnsiStringToParam(FParameter, pValue);
end;
{$ENDIF}

procedure TAqFDParameter.SetAsBCD(const pValue: TBcd);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.BCDToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsBoolean(const pValue: Boolean);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.BooleanToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsCurrency(const pValue: Currency);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.CurrencyToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsDate(const pValue: TDate);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.DateToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsDateTime(const pValue: TDateTime);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.DateTimeToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsDouble(const pValue: Double);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.DoubleToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsInt16(const pValue: Int16);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.Int16ToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsInt32(const pValue: Int32);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.Int32ToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsInt64(const pValue: Int64);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.Int64ToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsInt8(const pValue: Int8);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.Int8ToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsSingle(const pValue: Single);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.SingleToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsString(const pValue: string);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.StringToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsTime(const pValue: TTime);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.TimeToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsTimeStamp(const pValue: TSQLTimeStamp);
begin
  raise EAqInternal.Create('TSQLTimeStamp not implemented in Drop to FD.');
end;

procedure TAqFDParameter.SetAsTimeStampOffset(const pValue: TSQLTimeStampOffset);
begin
  raise EAqInternal.Create('TSQLTimeStampOffset not implemented in Drop to FD.');
end;

procedure TAqFDParameter.SetAsUInt16(const pValue: UInt16);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.UInt16ToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsUInt32(const pValue: UInt32);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.UInt32ToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsUInt64(const pValue: UInt64);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.UInt64ToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetAsUInt8(const pValue: UInt8);
begin
  FParameters.Connection.FDAdapter.FDDataConverter.UInt8ToParam(FParameter, pValue);
end;

procedure TAqFDParameter.SetDataType(const pDataType: TAqDataType);
begin
  FParameter.DataType := TAqFDDataTypeMapping[pDataType];
end;

procedure TAqFDParameter.SetName(const pName: string);
begin
  FParameter.Name := pName;
end;

procedure TAqFDParameter.SetNull;
begin
  FParameter.DataType := TAqFDDataTypeMapping[pDataType];
  FParameter.Clear;
end;

{ TAqFDDataConverter }

{$IFNDEF AQMOBILE}
procedure TAqFDDataConverter.AnsiStringToParam(const pParameter: TAqFDMappedParam; const pValue: AnsiString);
begin
  pParameter.AsAnsiString := pValue;
end;
{$ENDIF}

procedure TAqFDDataConverter.BCDToParam(const pParameter: TAqFDMappedParam; const pValue: TBcd);
begin
  pParameter.AsFMTBCD := pValue;
end;

procedure TAqFDDataConverter.BooleanToParam(const pParameter: TAqFDMappedParam; const pValue: Boolean);
begin
  pParameter.AsBoolean := pValue;
end;

procedure TAqFDDataConverter.CurrencyToParam(const pParameter: TAqFDMappedParam; const pValue: Currency);
begin
  pParameter.AsCurrency := pValue;
end;

procedure TAqFDDataConverter.DateTimeToParam(const pParameter: TAqFDMappedParam; const pValue: TDateTime);
begin
  pParameter.AsDateTime := pValue;
end;

procedure TAqFDDataConverter.DateToParam(const pParameter: TAqFDMappedParam; const pValue: TDate);
begin
  pParameter.AsDate := pValue;
end;

procedure TAqFDDataConverter.DoubleToParam(const pParameter: TAqFDMappedParam; const pValue: Double);
begin
  pParameter.AsFloat := pValue;
end;

{$IFNDEF AQMOBILE}
function TAqFDDataConverter.FieldToAnsiString(const pField: TField): AnsiString;
begin
  Result := AnsiString(FieldToString(pField));
end;
{$ENDIF}

function TAqFDDataConverter.FieldToBCD(const pField: TField): TBcd;
begin
  case pField.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pField.AsString.ToCurrency.ToBcd;
    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
      Result := pField.AsLargeInt.ToString;
    ftBoolean:
      Result := pField.AsBoolean.ToString;
    ftFloat, ftExtended, ftSingle:
      Result := pField.AsFloat;
    ftCurrency:
      Result := pField.AsCurrency.ToBcd;
    ftBCD, ftFMTBcd:
      Result := pField.AsBCD;
  else
    raise EAqInternal.Create('Unexpected type when trying to get a BCD field.');
  end;
end;

function TAqFDDataConverter.FieldToBoolean(const pField: TField): Boolean;
begin
  case pField.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pField.AsString.ToBoolean;
    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
      Result := Boolean(pField.AsLargeInt);
    ftBoolean:
      Result := pField.AsBoolean;
  else
    raise EAqInternal.Create('Unexpected type when trying to get a boolean field.');
  end;
end;

function TAqFDDataConverter.FieldToCurrency(const pField: TField): Currency;
begin
  case pField.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pField.AsString.ToCurrency;
    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
      Result := pField.AsLargeInt;
    ftBoolean:
      Result := pField.AsBoolean.ToInt8;
    ftFloat, ftExtended, ftSingle:
      Result := pField.AsFloat;
    ftCurrency, ftBCD:
      Result := pField.AsCurrency;
  else
    raise EAqInternal.Create('Unexpected type when trying to get a Currency field.');
  end;
end;

function TAqFDDataConverter.FieldToDate(const pField: TField): TDate;
begin
  Result := FieldToDateTime(pField).DateOf;
end;

function TAqFDDataConverter.FieldToDateTime(const pField: TField): TDateTime;
begin
  case pField.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pField.AsString.ToDateTime;
    ftFloat, ftExtended, ftSingle:
      Result := pField.AsFloat;
    ftDate, ftTime, ftDateTime, ftTimeStamp:
      Result := pField.AsDateTime;
  else
    raise EAqInternal.Create('Unexpected type when trying to get a datetime field.');
  end;
end;

function TAqFDDataConverter.FieldToDouble(const pField: TField): Double;
begin
  case pField.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pField.AsString.ToDouble;
    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
      Result := pField.AsLargeInt;
    ftBoolean:
      Result := pField.AsBoolean.ToInt8;
    ftFloat, ftExtended, ftSingle, ftBCD, ftFMTBcd:
      Result := pField.AsFloat;
    ftCurrency:
      Result := pField.AsCurrency;
  else
    raise EAqInternal.Create('Unexpected type when trying to get a single field.');
  end;
end;

function TAqFDDataConverter.FieldToInt16(const pField: TField): Int16;
begin
  Result := FieldToInt64(pField);
end;

function TAqFDDataConverter.FieldToInt32(const pField: TField): Int32;
begin
  Result := FieldToInt64(pField);
end;

function TAqFDDataConverter.FieldToInt64(const pField: TField): Int64;
begin
  case pField.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pField.AsString.ToInt64;
    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte, ftAutoInc:
      Result := pField.AsLargeInt;
    ftBoolean:
      Result := pField.AsBoolean.ToInt32;
    ftFloat, ftExtended, ftSingle:
      Result := pField.AsFloat.Trunc;
    ftCurrency, ftBCD, ftFMTBcd:
      Result := pField.AsBCD.ToDouble.Trunc;
  else
    raise EAqInternal.Create('Unexpected type when trying to get an integer field.');
  end;
end;

function TAqFDDataConverter.FieldToInt8(const pField: TField): Int8;
begin
  Result := FieldToInt64(pField);
end;

function TAqFDDataConverter.FieldToSingle(const pField: TField): Single;
begin
  case pField.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pField.AsString.ToDouble;
    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
      Result := pField.AsLargeInt;
    ftBoolean:
      Result := pField.AsBoolean.ToInt8;
    ftFloat, ftExtended, ftSingle:
      Result := pField.AsFloat;
    ftCurrency, ftBCD:
      Result := pField.AsCurrency;
  else
    raise EAqInternal.Create('Unexpected type when trying to get a single field.');
  end;
end;

function TAqFDDataConverter.FieldToString(const pField: TField): string;
begin
  case pField.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo, ftMemo:
      Result := pField.AsString;
    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
      Result := pField.AsLargeInt.ToString;
    ftBoolean:
      Result := pField.AsBoolean.ToString;
    ftFloat, ftExtended, ftSingle:
      Result := pField.AsFloat.ToString;
    ftCurrency, ftBCD:
      Result := pField.AsCurrency.ToString;
    ftDate, ftTime, ftDateTime, ftTimeStamp:
      Result := pField.AsDateTime.ToString;
  else
    raise EAqInternal.Create('Unexpected type when trying to get a string field.');
  end;
end;

function TAqFDDataConverter.FieldToTime(const pField: TField): TTime;
begin
  Result := FieldToDateTime(pField).TimeOf;
end;

function TAqFDDataConverter.FieldToUInt16(const pField: TField): UInt16;
begin
  Result := FieldToUInt64(pField);
end;

function TAqFDDataConverter.FieldToUInt32(const pField: TField): UInt32;
begin
  Result := FieldToUInt64(pField);
end;

function TAqFDDataConverter.FieldToUInt64(const pField: TField): UInt64;
begin
  Result := UInt64(FieldToInt64(pField));
end;

function TAqFDDataConverter.FieldToUInt8(const pField: TField): UInt8;
begin
  Result := FieldToUInt64(pField);
end;

procedure TAqFDDataConverter.Int16ToParam(const pParameter: TAqFDMappedParam; const pValue: Int16);
begin
  pParameter.AsSmallInt := pValue;
end;

procedure TAqFDDataConverter.Int32ToParam(const pParameter: TAqFDMappedParam; const pValue: Int32);
begin
  pParameter.AsInteger := pValue;
end;

procedure TAqFDDataConverter.Int64ToParam(const pParameter: TAqFDMappedParam; const pValue: Int64);
begin
  pParameter.AsLargeInt := pValue;
end;

procedure TAqFDDataConverter.Int8ToParam(const pParameter: TAqFDMappedParam; const pValue: Int8);
begin
  pParameter.AsShortInt := pValue;
end;

{$IFNDEF AQMOBILE}
function TAqFDDataConverter.ParamToAnsiString(const pParameter: TAqFDMappedParam): AnsiString;
begin
  Result := AnsiString(ParamToString(pParameter));
end;
{$ENDIF}

function TAqFDDataConverter.ParamToBCD(const pParameter: TAqFDMappedParam): TBcd;
begin
  case pParameter.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pParameter.AsString.ToCurrency.ToBcd;
    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
      Result := pParameter.AsLargeInt.ToString;
    ftBoolean:
      Result := pParameter.AsBoolean.ToString;
    ftFloat, ftExtended, ftSingle:
      Result := pParameter.AsFloat;
    ftCurrency:
      Result := pParameter.AsCurrency.ToBcd;
    ftBCD, ftFMTBcd:
      Result := pParameter.AsFMTBCD.ToCurrency.ToBcd;
  else
    raise EAqInternal.Create('Unexpected type when trying to get a BCD field.');
  end;
end;

function TAqFDDataConverter.ParamToBoolean(const pParameter: TAqFDMappedParam): Boolean;
begin
  case pParameter.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pParameter.AsString.ToBoolean;
    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
      Result := Boolean(pParameter.AsLargeInt);
    ftBoolean:
      Result := pParameter.AsBoolean;
  else
    raise EAqInternal.Create('Unexpected type when trying to get a boolean field.');
  end;
end;

function TAqFDDataConverter.ParamToCurrency(const pParameter: TAqFDMappedParam): Currency;
begin
  case pParameter.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pParameter.AsString.ToCurrency;
    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
      Result := pParameter.AsLargeInt;
    ftBoolean:
      Result := pParameter.AsBoolean.ToInt8;
    ftFloat, ftExtended, ftSingle:
      Result := pParameter.AsFloat;
    ftCurrency, ftBCD:
      Result := pParameter.AsCurrency;
    ftFMTBcd:
      Result := pParameter.AsFMTBCD.ToCurrency;
  else
    raise EAqInternal.Create('Unexpected type when trying to get a Currency field.');
  end;
end;

function TAqFDDataConverter.ParamToDate(const pParameter: TAqFDMappedParam): TDate;
begin
  Result := ParamToDateTime(pParameter).DateOf;
end;

function TAqFDDataConverter.ParamToDateTime(const pParameter: TAqFDMappedParam): TDateTime;
begin
  case pParameter.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pParameter.AsString.ToDateTime;
    ftFloat, ftExtended, ftSingle:
      Result := pParameter.AsFloat;
    ftDate, ftTime, ftDateTime, ftTimeStamp:
      Result := pParameter.AsDateTime;
  else
    raise EAqInternal.Create('Unexpected type when trying to get a datetime field.');
  end;
end;

function TAqFDDataConverter.ParamToDouble(const pParameter: TAqFDMappedParam): Double;
begin
  case pParameter.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pParameter.AsString.ToDouble;
    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
      Result := pParameter.AsLargeInt;
    ftBoolean:
      Result := pParameter.AsBoolean.ToInt8;
    ftFloat, ftExtended, ftSingle:
      Result := pParameter.AsFloat;
    ftCurrency, ftBCD:
      Result := pParameter.AsCurrency;
    ftFMTBcd:
      Result := pParameter.AsFMTBCD.ToCurrency;
  else
    raise EAqInternal.Create('Unexpected type when trying to get a double field.');
  end;
end;

function TAqFDDataConverter.ParamToInt16(const pParameter: TAqFDMappedParam): Int16;
begin
  Result := ParamToInt64(pParameter);
end;

function TAqFDDataConverter.ParamToInt32(const pParameter: TAqFDMappedParam): Int32;
begin
  Result := ParamToInt64(pParameter);
end;

function TAqFDDataConverter.ParamToInt64(const pParameter: TAqFDMappedParam): Int64;
begin
  case pParameter.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pParameter.AsString.ToInt64;
    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
      Result := pParameter.AsLargeInt;
    ftBoolean:
      Result := pParameter.AsBoolean.ToInt32;
    ftFloat, ftExtended, ftSingle:
      Result := pParameter.AsFloat.Trunc;
    ftCurrency, ftBCD:
      Result := pParameter.AsCurrency.ToString.ToDouble.Trunc;
    ftFMTBcd:
      Result := pParameter.AsFMTBCD.ToString.ToDouble.Trunc;
  else
    raise EAqInternal.Create('Unexpected type when trying to get an integer field.');
  end;
end;

function TAqFDDataConverter.ParamToInt8(const pParameter: TAqFDMappedParam): Int8;
begin
  Result := ParamToInt64(pParameter);
end;

function TAqFDDataConverter.ParamToSingle(const pParameter: TAqFDMappedParam): Single;
begin
  case pParameter.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pParameter.AsString.ToDouble;
    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
      Result := pParameter.AsLargeInt;
    ftBoolean:
      Result := pParameter.AsBoolean.ToInt8;
    ftFloat, ftExtended, ftSingle:
      Result := pParameter.AsFloat;
    ftCurrency, ftBCD:
      Result := pParameter.AsCurrency;
    ftFMTBcd:
      Result := pParameter.AsFMTBCD.ToCurrency;
  else
    raise EAqInternal.Create('Unexpected type when trying to get a single field.');
  end;
end;

function TAqFDDataConverter.ParamToString(const pParameter: TAqFDMappedParam): string;
begin
  case pParameter.DataType of
    ftString, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      Result := pParameter.AsString;
    ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint, ftByte:
      Result := pParameter.AsLargeInt.ToString;
    ftBoolean:
      Result := pParameter.AsBoolean.ToString;
    ftFloat, ftExtended, ftSingle:
      Result := pParameter.AsFloat.ToString;
    ftCurrency, ftBCD:
      Result := pParameter.AsCurrency.ToString;
    ftDate, ftTime, ftDateTime, ftTimeStamp:
      Result := pParameter.AsDateTime.ToString;
    ftFMTBcd:
      Result := pParameter.AsFMTBCD.ToString;
  else
    raise EAqInternal.Create('Unexpected type when trying to get a string field.');
  end;
end;

function TAqFDDataConverter.ParamToTime(const pParameter: TAqFDMappedParam): TTime;
begin
  Result := ParamToDateTime(pParameter).TimeOf;
end;

function TAqFDDataConverter.ParamToUInt16(const pParameter: TAqFDMappedParam): UInt16;
begin
  Result := ParamToUInt64(pParameter);
end;

function TAqFDDataConverter.ParamToUInt32(const pParameter: TAqFDMappedParam): UInt32;
begin
  Result := ParamToUInt64(pParameter);
end;

function TAqFDDataConverter.ParamToUInt64(const pParameter: TAqFDMappedParam): UInt64;
begin
  Result := UInt64(ParamToInt64(pParameter));
end;

function TAqFDDataConverter.ParamToUInt8(const pParameter: TAqFDMappedParam): UInt8;
begin
  Result := ParamToUInt64(pParameter);
end;

procedure TAqFDDataConverter.SingleToParam(const pParameter: TAqFDMappedParam; const pValue: Single);
begin
  pParameter.AsSingle := pValue;
end;

procedure TAqFDDataConverter.StringToParam(const pParameter: TAqFDMappedParam; const pValue: string);
begin
  pParameter.AsWideString := pValue;
end;

procedure TAqFDDataConverter.TimeToParam(const pParameter: TAqFDMappedParam; const pValue: TTime);
begin
  pParameter.AsTime := pValue;
end;

procedure TAqFDDataConverter.UInt16ToParam(const pParameter: TAqFDMappedParam; const pValue: UInt16);
begin
  pParameter.AsWord := pValue;
end;

procedure TAqFDDataConverter.UInt32ToParam(const pParameter: TAqFDMappedParam; const pValue: UInt32);
begin
  pParameter.AsLongword := pValue;
end;

procedure TAqFDDataConverter.UInt64ToParam(const pParameter: TAqFDMappedParam; const pValue: UInt64);
begin
  pParameter.AsLargeInt := Int64(pValue);
end;

procedure TAqFDDataConverter.UInt8ToParam(const pParameter: TAqFDMappedParam; const pValue: UInt8);
begin
  pParameter.AsByte := pValue;
end;

{ TAqFDField }

constructor TAqFDField.Create(const pReader: TAqFDReader; const pField: TField);
begin
  FReader := pReader;
  FField := pField;
end;

{$IFNDEF AQMOBILE}
function TAqFDField.GetAsAnsiString: AnsiString;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToAnsiString(FField);
end;
{$ENDIF}

function TAqFDField.GetAsBCD: TBcd;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToBCD(FField);
end;

function TAqFDField.GetAsBoolean: Boolean;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToBoolean(FField);
end;

function TAqFDField.GetAsCurrency: Currency;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToCurrency(FField);
end;

function TAqFDField.GetAsDate: TDate;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToDate(FField);
end;

function TAqFDField.GetAsDateTime: TDateTime;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToDateTime(FField);
end;

function TAqFDField.GetAsDouble: Double;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToDouble(FField);
end;

function TAqFDField.GetAsInt16: Int16;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToInt16(FField);
end;

function TAqFDField.GetAsInt32: Int32;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToInt32(FField);
end;

function TAqFDField.GetAsInt64: Int64;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToInt64(FField);
end;

function TAqFDField.GetAsInt8: Int8;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToInt8(FField);
end;

function TAqFDField.GetAsSingle: Single;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToSingle(FField);
end;

function TAqFDField.GetAsString: string;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToString(FField);
end;

function TAqFDField.GetAsTime: TTime;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToTime(FField);
end;

function TAqFDField.GetAsTimeStamp: TSQLTimeStamp;
begin

end;

function TAqFDField.GetAsTimeStampOffset: TSQLTimeStampOffset;
begin

end;

function TAqFDField.GetAsUInt16: UInt16;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToUInt16(FField);
end;

function TAqFDField.GetAsUInt32: UInt32;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToUInt32(FField);
end;

function TAqFDField.GetAsUInt64: UInt64;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToUInt64(FField);
end;

function TAqFDField.GetAsUInt8: UInt8;
begin
  Result := FReader.Connection.FDAdapter.FDDataConverter.FieldToUInt8(FField);
end;

function TAqFDField.GetIsNull: Boolean;
begin
  Result := FField.IsNull;
end;

function TAqFDField.GetName: string;
begin
  Result := FField.FieldName;
end;

procedure TAqFDField.SetName(const pName: string);
begin
  raise EAqInternal.Create('Feature SetName for field not implemented in Drop to FD.');
end;

{ TAqFDReader }

constructor TAqFDReader.Create(const pConnection: TAqFDCustomConnection; const pQuery: TAqFDMappedQuery;
  const pOwnsQuery: Boolean);
begin
  FConnection := pConnection;
  FConnection.IncreaseReaderes;
  FQuery := pQuery;
  FOwnsQuery := pOwnsQuery;
  FQuery.Close;
  FQuery.Open;
end;

destructor TAqFDReader.Destroy;
begin
  FConnection.DecrementReaders;

  if FOwnsQuery then
  begin
    FQuery.Free;
  end;

  inherited;
end;

function TAqFDReader.GetCount: Int32;
begin
  Result := FQuery.FieldCount;
end;

function TAqFDReader.GetValueByIndex(pIndex: Int32): IAqDBReadValue;
begin
  Result := TAqFDField.Create(Self, FQuery.Fields[pIndex]);
end;

function TAqFDReader.GetValueByName(pName: string): IAqDBReadValue;
begin
  Result := TAqFDField.Create(Self, FQuery.FieldByName(pName));
end;

function TAqFDReader.Next: Boolean;
begin
  if FRecNo > 0 then
  begin
    FQuery.Next;
  end;

  Result := not FQuery.Eof;

  if Result then
  begin
    Inc(FRecNo);

    if FRecNo <> FQuery.RecNo then
    begin
      raise EAqInternal.Create('Reader lost the sync with the result query.');
    end;
  end;
end;

{ TAqFDAdapter }

constructor TAqFDAdapter.Create;
begin
  inherited;

  SetFDDataConverter(CreateDataConverter);
end;

function TAqFDAdapter.CreateDataConverter: TAqFDDataConverter;
begin
  Result := GetDefaultDataConverter.Create;
end;

destructor TAqFDAdapter.Destroy;
begin
  FFDDataConverter.Free;

  inherited;
end;

class function TAqFDAdapter.GetDefaultDataConverter: TAqFDDataConverterClass;
begin
  Result := TAqFDDataConverter;
end;

procedure TAqFDAdapter.SetFDDataConverter(const pDataConverter: TAqFDDataConverter);
begin
  FreeAndNil(FFDDataConverter);
  FFDDataConverter := pDataConverter;
end;

{ TAqFDObject }

class function TAqFDObject.MustCountReferences: Boolean;
begin
  Result := True;
end;

end.
