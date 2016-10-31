unit AqDrop.DB.DBX;

interface

{$I '..\Core\AqDrop.Core.Defines.Inc'}

uses
  System.Classes,
  System.Rtti,
  System.SysUtils,
  Data.DBXCommon,
  Data.SqlTimSt,
  Data.FmtBcd,
  AqDrop.Core.InterfacedObject,
  AqDrop.Core.Collections,
  AqDrop.Core.Types,
  AqDrop.DB.Types,
  AqDrop.DB.Adapter,
  AqDrop.DB.Connection;

const
  TAqDBXDataTypeMapping: array[TAqDataType] of TDBXType = (
    TDBXDataTypes.UnknownType,           // adtUnknown
    TDBXDataTypes.BooleanType,           // adtBoolean
    TDBXDataTypes.Int32Type,             // adtEnumerated
    TDBXDataTypes.UInt8Type,             // adtUInt8
    TDBXDataTypes.Int8Type,              // adtInt8
    TDBXDataTypes.UInt16Type,            // adtUInt16
    TDBXDataTypes.Int16Type,             // adtInt16
    TDBXDataTypes.UInt32Type,            // adtUInt32
    TDBXDataTypes.Int32Type,             // adtInt32
    TDBXDataTypes.UInt64Type,            // adtUInt64
    TDBXDataTypes.Int64Type,             // adtInt64
    TDBXDataTypes.CurrencyType,          // adtCurrency
    TDBXDataTypes.DoubleType,            // adtDouble
    TDBXDataTypes.SingleType,            // adtSingle
    TDBXDataTypes.DateTimeType,          // adtDatetime
    TDBXDataTypes.DateType,              // adtDate
    TDBXDataTypes.TimeType,              // adtTime
    TDBXDataTypes.AnsiStringType,        // adtAnsiChar
    TDBXDataTypes.WideStringType,        // adtChar
    TDBXDataTypes.AnsiStringType,        // adtAnsiString
    TDBXDataTypes.WideStringType,        // adtString
    TDBXDataTypes.WideStringType,        // adtWideString
    TDBXDataTypes.UnknownType,           // adtSet
    TDBXDataTypes.UnknownType,           // adtClass
    TDBXDataTypes.UnknownType,           // adtMethod
    TDBXDataTypes.VariantType,           // adtVariant
    TDBXDataTypes.UnknownType,           // adtRecord
    TDBXDataTypes.UnknownType);          // adtInterface

type
  TAqDBXParameterCreationOrder = (pcoCreateBeforePrepare, pcoCreateAfterPrepare);

  TAqDBXBaseValue = class;

  TAqDBXDataConverter = class
  public
    function DBToString(const pValue: TAqDBXBaseValue): string; virtual;
{$IFNDEF AQMOBILE}
    function DBToAnsiString(const pValue: TAqDBXBaseValue): AnsiString; virtual;
{$ENDIF}
    function DBToBoolean(const pValue: TAqDBXBaseValue): Boolean; virtual;
    function DBToTimeStamp(const pValue: TAqDBXBaseValue): TSQLTimeStamp; virtual;
    function DBToTimeStampOffset(const pValue: TAqDBXBaseValue): TSQLTimeStampOffset; virtual;
    function DBToBCD(const pValue: TAqDBXBaseValue): TBcd; virtual;
    function DBToDate(const pValue: TAqDBXBaseValue): TDate; virtual;
    function DBToTime(const pValue: TAqDBXBaseValue): TTime; virtual;
    function DBToDateTime(const pValue: TAqDBXBaseValue): TDateTime; virtual;
    function DBToUInt8(const pValue: TAqDBXBaseValue): UInt8; virtual;
    function DBToInt8(const pValue: TAqDBXBaseValue): Int8; virtual;
    function DBToUInt16(const pValue: TAqDBXBaseValue): UInt16; virtual;
    function DBToInt16(const pValue: TAqDBXBaseValue): Int16; virtual;
    function DBToUInt32(const pValue: TAqDBXBaseValue): UInt32; virtual;
    function DBToInt32(const pValue: TAqDBXBaseValue): Int32; virtual;
    function DBToUInt64(const pValue: TAqDBXBaseValue): UInt64; virtual;
    function DBToInt64(const pValue: TAqDBXBaseValue): Int64; virtual;
    function DBToSingle(const pValue: TAqDBXBaseValue): Single; virtual;
    function DBToDouble(const pValue: TAqDBXBaseValue): Double; virtual;
    function DBToCurrency(const pValue: TAqDBXBaseValue): Currency; virtual;

    procedure StringToParameter(const pParameter: TDBXParameter; const pValue: string); virtual;
{$IFNDEF AQMOBILE}
    procedure AnsiStringToParameter(const pParameter: TDBXParameter; const pValue: AnsiString); virtual;
{$ENDIF}
    procedure BooleanToParameter(const pParameter: TDBXParameter; const pValue: Boolean); virtual;
    procedure TimeStampToParameter(const pParameter: TDBXParameter; const pValue: TSQLTimeStamp); virtual;
    procedure TimeStampOffsetToParameter(const pParameter: TDBXParameter;
      const pValue: TSQLTimeStampOffset); virtual;
    procedure BCDToParameter(const pParameter: TDBXParameter; const pValue: TBcd); virtual;
    procedure DateToParameter(const pParameter: TDBXParameter; const pValue: TDate); virtual;
    procedure TimeToParameter(const pParameter: TDBXParameter; const pValue: TTime); virtual;
    procedure DateTimeToParameter(const pParameter: TDBXParameter; const pValue: TDateTime); virtual;
    procedure UInt8ToParameter(const pParameter: TDBXParameter; const pValue: UInt8); virtual;
    procedure Int8ToParameter(const pParameter: TDBXParameter; const pValue: Int8); virtual;
    procedure UInt16ToParameter(const pParameter: TDBXParameter; const pValue: UInt16); virtual;
    procedure Int16ToParameter(const pParameter: TDBXParameter; const pValue: Int16); virtual;
    procedure UInt32ToParameter(const pParameter: TDBXParameter; const pValue: UInt32); virtual;
    procedure Int32ToParameter(const pParameter: TDBXParameter; const pValue: Int32); virtual;
    procedure UInt64ToParameter(const pParameter: TDBXParameter; const pValue: UInt64); virtual;
    procedure Int64ToParameter(const pParameter: TDBXParameter; const pValue: Int64); virtual;
    procedure SingleToParameter(const pParameter: TDBXParameter; const pValue: Single); virtual;
    procedure DoubleToParameter(const pParameter: TDBXParameter; const pValue: Double); virtual;
    procedure CurrencyToParameter(const pParameter: TDBXParameter; const pValue: Currency); virtual;
  end;

  TAqDBXDataConverterClass = class of TAqDBXDataConverter;

  TAqDBXAdapter = class(TAqDBAdapter)
  strict private
    FDBXConverter: TAqDBXDataConverter;

    procedure SetDBXConverter(const pValue: TAqDBXDataConverter);
  strict protected
    function GetParameterCreationOrder: TAqDBXParameterCreationOrder; virtual;

    function CreateConverter: TAqDBXDataConverter; virtual;
    class function GetDefaultConverter: TAqDBXDataConverterClass; virtual;
  public
    constructor Create; override;
    destructor Destroy; override;

    property DBXConverter: TAqDBXDataConverter read FDBXConverter write SetDBXConverter;
    property ParameterCreationOrder: TAqDBXParameterCreationOrder read GetParameterCreationOrder;
  end;

  TAqDBXBaseValues = class;
  TAqDBXCustomConnection = class;

  TAqDBXBaseValue = class(TAqInterfacedObject, IAqDBReadValue)
  strict private
    [weak]
    FValues: TAqDBXBaseValues;
    FName: string;
    FIndex: Int32;
  strict protected
    function GetDBXValue: TDBXValue; virtual; abstract;

    function GetName: string; virtual;
    procedure SetName(const pName: string); virtual;

    function GetIsNull: Boolean; virtual;

    function GetAsString: string; virtual;
{$IFNDEF AQMOBILE}
    function GetAsAnsiString: AnsiString; virtual;
{$ENDIF}
    function GetAsBoolean: Boolean; virtual;
    function GetAsTimeStamp: TSQLTimeStamp; virtual;
    function GetAsTimeStampOffset: TSQLTimeStampOffset; virtual;
    function GetAsBCD: TBcd; virtual;
    function GetAsDate: TDate; virtual;
    function GetAsTime: TTime; virtual;
    function GetAsDateTime: TDateTime; virtual;
    function GetAsUInt8: UInt8; virtual;
    function GetAsInt8: Int8; virtual;
    function GetAsUInt16: UInt16; virtual;
    function GetAsInt16: Int16; virtual;
    function GetAsUInt32: UInt32; virtual;
    function GetAsInt32: Int32; virtual;
    function GetAsUInt64: UInt64; virtual;
    function GetAsInt64: Int64; virtual;
    function GetAsSingle: Single; virtual;
    function GetAsDouble: Double; virtual;
    function GetAsCurrency: Currency; virtual;

    class function MustCountReferences: Boolean; override;
  public
    constructor Create(const pValues: TAqDBXBaseValues; const pName: string; const pIndex: Int32);

    property Values: TAqDBXBaseValues read FValues;
    property DBXValue: TDBXValue read GetDBXValue;
    property Name: string read FName;
    property Index: Int32 read FIndex;
  end;

  TAqDBXValue = class(TAqDBXBaseValue)
  strict private
    FValue: TDBXValue;
  strict protected
    function GetDBXValue: TDBXValue; override;
  public
    constructor Create(const pValues: TAqDBXBaseValues; const pName: string; const pIndex: Int32;
      const pValue: TDBXValue);
  end;

  TAqDBXParameter = class(TAqDBXBaseValue, IAqDBValue)
  strict private
    FDBXParameter: TDBXParameter;
  strict protected
    function GetDBXValue: TDBXValue; override;

    procedure SetDataType(const pDataType: TAqDataType);

    procedure SetAsString(const pValue: string); virtual;
{$IFNDEF AQMOBILE}
    procedure SetAsAnsiString(const pValue: AnsiString); virtual;
{$ENDIF}
    procedure SetAsBoolean(const pValue: Boolean); virtual;
    procedure SetAsTimeStamp(const pValue: TSQLTimeStamp); virtual;
    procedure SetAsTimeStampOffset(const pValue: TSQLTimeStampOffset); virtual;
    procedure SetAsBCD(const pValue: TBcd); virtual;
    procedure SetAsDate(const pValue: TDate); virtual;
    procedure SetAsTime(const pValue: TTime); virtual;
    procedure SetAsDateTime(const pValue: TDateTime); virtual;
    procedure SetAsUInt8(const pValue: UInt8); virtual;
    procedure SetAsInt8(const pValue: Int8); virtual;
    procedure SetAsUInt16(const pValue: UInt16); virtual;
    procedure SetAsInt16(const pValue: Int16); virtual;
    procedure SetAsUInt32(const pValue: UInt32); virtual;
    procedure SetAsInt32(const pValue: Int32); virtual;
    procedure SetAsUInt64(const pValue: UInt64); virtual;
    procedure SetAsInt64(const pValue: Int64); virtual;
    procedure SetAsSingle(const pValue: Single); virtual;
    procedure SetAsDouble(const pValue: Double); virtual;
    procedure SetAsCurrency(const pValue: Currency); virtual;

    procedure SetNull(const pDataType: TAqDataType = TAqDataType.adtUnknown);
  public
    constructor Create(const pValues: TAqDBXBaseValues; const pName: string; const pIndex: Int32;
      const pDBXParameter: TDBXParameter);

    property DBXParameter: TDBXParameter read FDBXParameter;
  end;

  TAqDBXParameterByNameSetterMethod =
    reference to procedure(const pParameterSetterMethod: TAqDBValueHandlerMethod);

  TAqDBXFakeParameterByName = class(TAqDBXParameter)
  strict private
    FParameterByNameSetterMethod: TAqDBXParameterByNameSetterMethod;
  strict protected
    procedure SetAsString(const pValue: string); override;
    procedure SetAsBoolean(const pValue: Boolean); override;
{$IFNDEF AQMOBILE}
    procedure SetAsAnsiString(const pValue: AnsiString); override;
{$ENDIF}
    procedure SetAsTimeStamp(const pValue: TSQLTimeStamp); override;
    procedure SetAsTimeStampOffset(const pValue: TSQLTimeStampOffset); override;
    procedure SetAsBCD(const pValue: TBcd); override;
    procedure SetAsDate(const pValue: TDate); override;
    procedure SetAsTime(const pValue: TTime); override;
    procedure SetAsDateTime(const pValue: TDateTime); override;
    procedure SetAsUInt8(const pValue: UInt8); override;
    procedure SetAsInt8(const pValue: Int8); override;
    procedure SetAsUInt16(const pValue: UInt16); override;
    procedure SetAsInt16(const pValue: Int16); override;
    procedure SetAsUInt32(const pValue: UInt32); override;
    procedure SetAsInt32(const pValue: Int32); override;
    procedure SetAsUInt64(const pValue: UInt64); override;
    procedure SetAsInt64(const pValue: Int64); override;
    procedure SetAsSingle(const pValue: Single); override;
    procedure SetAsDouble(const pValue: Double); override;
    procedure SetAsCurrency(const pValue: Currency); override;
  public
    constructor Create(const pValues: TAqDBXBaseValues; const pName: string; const pDBXParameter: TDBXParameter;
      const pParameterByNameSetterMethod: TAqDBXParameterByNameSetterMethod);
  end;

  TAqDBXBaseValues = class(TAqInterfacedObject)
  strict private
    FConnection: TAqDBXCustomConnection;
  strict protected
    function GetByteReader: TDBXByteReader; virtual; abstract;
  public
    constructor Create(const pConnection: TAqDBXCustomConnection);

    property Connection: TAqDBXCustomConnection read FConnection;
    property ByteReader: TDBXByteReader read GetByteReader;
  end;

  TAqDBXValues<I: IAqDBReadValue> = class(TAqDBXBaseValues)
  strict private
    FValues: TAqList<I>;
  strict protected
    class function MustCountReferences: Boolean; override;
  public
    constructor Create(const pConnection: TAqDBXCustomConnection);
    destructor Destroy; override;

    function GetValueByIndex(pIndex: Int32): I; virtual;
    function GetValueByName(pName: string): I; virtual;
    function GetCount: Int32;

    procedure Add(pValue: I);
  end;

  TAqDBXParameters = class(TAqDBXValues<IAqDBValue>, IAqDBParameters)
  strict private
    FDBXCommand: TDBXCommand;
  strict protected
    function GetByteReader: TDBXByteReader; override;

    class function MustCountReferences: Boolean; override;
  public
    constructor Create(const pConnection: TAqDBXCustomConnection; const pDBXCommand: TDBXCommand);

    procedure CreateParameter(const pName: string);
    function GetValueByName(pName: string): IAqDBValue; override;
  end;

  TAqDBXReader = class;

  TAqDBXCommand = class
  strict private
    FConnection: TAqDBXCustomConnection;
    FDBXCommand: TDBXCommand;
    FParameters: TAqDBXParameters;
    FPrepared: Boolean;
  public
    constructor Create(const pConnection: TAqDBXCustomConnection; const pDBXCommand: TDBXCommand);
    destructor Destroy; override;

    function Execute(const pParametersHandler: TAqDBParametersHandlerMethod): Int64;
    function Open(const pParametersHandler: TAqDBParametersHandlerMethod): TAqDBXReader;

    procedure Prepare(const pParametersInitializer: TAqDBParametersHandlerMethod);

    property DBXCommand: TDBXCommand read FDBXCommand;
    property Parameters: TAqDBXParameters read FParameters;
    property Prepared: Boolean read FPrepared;
  end;

  TAqDBXReader = class(TAqDBXValues<IAqDBReadValue>, IAqDBReader)
  strict private
    FCommand: TAqDBXCommand;
    FDBXReader: TDBXReader;
  strict protected
    function GetByteReader: TDBXByteReader; override;
  public
    constructor Create(const pConnection: TAqDBXCustomConnection; const pCommand: TAqDBXCommand);
    destructor Destroy; override;

    function Next: Boolean;
  end;

  TAqDBXParser = class
  strict private type
    TAqDBParserHandlerMethod = reference to procedure(const pName: string);
  strict private
    class procedure Execute(const pHandlerMethod: TAqDBParserHandlerMethod; var pSQL: string); overload;
  public
    class procedure Execute(var pSQL: string; const pIdentifiedParameters: TStrings); overload;
  end;

  /// ------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Base class for connections using DBX framework.
  ///   PT-BR:
  ///     Classe base para conexões usando DBX framework.
  /// </summary>
  /// ------------------------------------------------------------------------------------------------------------------
  TAqDBXCustomConnection = class (TAqDBConnection)
  strict private
    FDBXConnection: TDBXConnection;
    FDBXTransaction: TDBXTransaction;
    FProperties: TDBXProperties;
    FPreparedQueries: TAqIDDictionary<TAqDBXCommand>;

    function CreateCommand: TAqDBXCommand;
    function PrepareDBXCommand(pSQL: string): TAqDBXCommand;

    function GetProperty(pName: string): string;
    procedure SetProperty(pName: string; const pValue: string);
    function GetDBXAdapter: TAqDBXAdapter;
    procedure SetDBXAdapter(const pValue: TAqDBXAdapter);
  strict protected
    procedure DoConnect; override;
    procedure DoDisconnect; override;

    function GetPropertyValueAsString(const pIndex: Int32): string; virtual;
    procedure SetPropertyValueAsString(const pIndex: Int32; const pValue: string); virtual;

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

    procedure DoStartTransaction; override;
    procedure DoCommitTransaction; override;
    procedure DoRollbackTransaction; override;

    class function GetDefaultAdapter: TAqDBAdapterClass; override;

    property DriverName: string index $00 read GetPropertyValueAsString write SetPropertyValueAsString;
    property VendorLib: string index $01 read GetPropertyValueAsString write SetPropertyValueAsString;
    property LibraryName: string index $02 read GetPropertyValueAsString write SetPropertyValueAsString;
    property GetDriverFunc: string index $03 read GetPropertyValueAsString write SetPropertyValueAsString;

    property Properties[Name: string]: string read GetProperty write SetProperty;
  protected
    procedure SetAdapter(const pAdapter: TAqDBAdapter); override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property DBXAdapter: TAqDBXAdapter read GetDBXAdapter write SetDBXAdapter;
  end;

  /// ------------------------------------------------------------------------------------------------------------------
  /// <summary>
  ///   EN-US:
  ///     Generic class for connections with DBMSs using DBX framework.
  ///   PT-BR:
  ///     Classe genérica para conexão com SGBDs usando DBX framework.
  /// </summary>
  /// ------------------------------------------------------------------------------------------------------------------
  TAqDBXConnection = class(TAqDBXCustomConnection)
  strict private
    FGetterAutoIncrement: TFunc<Int64>;
  public
    function GetAutoIncrement(const pGeneratorName: string = ''): Int64; override;

    property DriverName;
    property VendorLib;
    property LibraryName;
    property GetDriverFunc;
    property Properties;

    property GetterAutoIncrement: TFunc<Int64> read FGetterAutoIncrement write FGetterAutoIncrement;
  end;

implementation

uses
  System.StrUtils,
  System.DateUtils,
  AqDrop.Core.Exceptions,
  AqDrop.Core.Helpers,
  AqDrop.DB.Tokenizer;


{ TAqDBXCustomConnection }

procedure TAqDBXCustomConnection.DoConnect;
begin
  inherited;

  try
    FDBXConnection := TDBXConnectionFactory.GetConnectionFactory.GetConnection(FProperties);
  except
    on E: Exception do
    begin
      FreeAndNil(FDBXConnection);
      RaiseImpossibleToConnect(E);
    end;
  end;
end;

constructor TAqDBXCustomConnection.Create;
begin
  inherited;

  FProperties := TDBXProperties.Create;
  FPreparedQueries := TAqIDDictionary<TAqDBXCommand>.Create(True);
end;

function TAqDBXCustomConnection.CreateCommand: TAqDBXCommand;
begin
  Result := TAqDBXCommand.Create(Self, Self.FDBXConnection.CreateCommand);
end;

procedure TAqDBXCustomConnection.DoDisconnect;
var
  lID: TAqID;
begin
  for lID in FPreparedQueries.Keys do
  begin
    UnprepareCommand(lID);
  end;

  FreeAndNil(FDBXConnection);
end;

destructor TAqDBXCustomConnection.Destroy;
begin
  if Assigned(FDBXTransaction) then
  begin
    FDBXConnection.RollbackFreeAndNil(FDBXTransaction);
  end;

  FPreparedQueries.Free;
  FDBXConnection.Free;
  FProperties.Free;

  inherited;
end;

function TAqDBXCustomConnection.GetProperty(pName: string): string;
begin
  Result := FProperties.Values[pName];
end;

function TAqDBXCustomConnection.GetActive: Boolean;
begin
  Result := Assigned(FDBXConnection);
end;

function TAqDBXCustomConnection.GetDBXAdapter: TAqDBXAdapter;
begin
  Result := TAqDBXAdapter(Adapter);
end;

class function TAqDBXCustomConnection.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := TAqDBXAdapter;
end;

function TAqDBXCustomConnection.GetPropertyValueAsString(const pIndex: Int32): string;
begin
  case pIndex of
    $00:
      Result := FProperties.Values[TDBXPropertyNames.DriverName];
    $01:
      Result := FProperties.Values[TDBXPropertyNames.VendorLib];
    $02:
      Result := FProperties.Values[TDBXPropertyNames.LibraryName];
    $03:
      Result := FProperties.Values[TDBXPropertyNames.GetDriverFunc];
  else
    raise EAqInternal.Create('Index not expected in TAqDBXCustomConnection.GetPropertyValueAsString.');
  end;
end;

function TAqDBXCustomConnection.PrepareDBXCommand(pSQL: string): TAqDBXCommand;
var
  lIdentifiedParameters: TStringList;
  lParameter: string;
begin
  Result := CreateCommand;

  try
    lIdentifiedParameters := TStringList.Create;

    try
      TAqDBXParser.Execute(pSQL, lIdentifiedParameters);

      if DBXAdapter.ParameterCreationOrder = TAqDBXParameterCreationOrder.pcoCreateBeforePrepare then
      begin
        for lParameter in lIdentifiedParameters do
        begin
          Result.Parameters.CreateParameter(lParameter);
        end;
      end;

      Result.DBXCommand.Text := pSQL;
      Result.DBXCommand.Prepare;

      if DBXAdapter.ParameterCreationOrder = TAqDBXParameterCreationOrder.pcoCreateAfterPrepare then
      begin
        for lParameter in lIdentifiedParameters do
        begin
          Result.Parameters.CreateParameter(lParameter);
        end;
      end;
    finally
      lIdentifiedParameters.Free;
    end;
  except
    Result.Free;
    raise;
  end;
end;

function TAqDBXCustomConnection.DoOpenQuery(const pSQL: string;
  const pParametersHandler: TAqDBParametersHandlerMethod): IAqDBReader;
var
  lCommand: TAqDBXCommand;
begin
  lCommand := PrepareDBXCommand(pSQL);

  try
    if Assigned(pParametersHandler) then
    begin
      pParametersHandler(lCommand.Parameters);
    end;
  except
    lCommand.Free;
    raise;
  end;

  Result := TAqDBXReader.Create(Self, lCommand);
end;

function TAqDBXCustomConnection.DoExecuteCommand(const pSQL: string;
  const pParametersHandler: TAqDBParametersHandlerMethod): Int64;
var
  lCommand: TAqDBXCommand;
begin
  lCommand := PrepareDBXCommand(pSQL);

  try
    Result := lCommand.Execute(pParametershandler);
  finally
    lCommand.Free;
  end;
end;

procedure TAqDBXCustomConnection.SetDBXAdapter(const pValue: TAqDBXAdapter);
begin
  SetAdapter(pValue);
end;

procedure TAqDBXCustomConnection.SetAdapter(const pAdapter: TAqDBAdapter);
begin
  if not (pAdapter is TAqDBXAdapter) then
  begin
    raise EAqInternal.Create('Invalid Adapter for a DBX Connection.');
  end;

  inherited;
end;

procedure TAqDBXCustomConnection.SetProperty(pName: string; const pValue: string);
begin
  FProperties.Values[pName] := pValue;
end;

procedure TAqDBXCustomConnection.SetPropertyValueAsString(const pIndex: Int32; const pValue: string);
begin
  case pIndex of
    $00:
      FProperties.Values[TDBXPropertyNames.DriverName] := pValue;
    $01:
      FProperties.Values[TDBXPropertyNames.VendorLib] := pValue;
    $02:
      FProperties.Values[TDBXPropertyNames.LibraryName] := pValue;
    $03:
      FProperties.Values[TDBXPropertyNames.GetDriverFunc] := pValue;
  else
    raise EAqInternal.Create('Wrong index for setting connection properties.');
  end;
end;

function TAqDBXCustomConnection.DoOpenQuery(const pCommandID: TAqID;
  const pParametersHandler: TAqDBParametersHandlerMethod): IAqDBReader;
var
  lCommand: TAqDBXCommand;
begin
  if FPreparedQueries.TryGetValue(pCommandID, lCommand) then
  begin
    Result := lCommand.Open(pParametersHandler);
  end else begin
    raise EAqInternal.Create('Command of ID ' + pCommandID.ToString + ' not found.');
  end;
end;

procedure TAqDBXCustomConnection.DoStartTransaction;
begin
  inherited;

  FDBXTransaction := FDBXConnection.BeginTransaction;
end;

procedure TAqDBXCustomConnection.DoCommitTransaction;
begin
  FDBXConnection.CommitFreeAndNil(FDBXTransaction);

  inherited;
end;

function TAqDBXCustomConnection.DoExecuteCommand(const pCommandID: TAqID;
  const pParametersHandler: TAqDBParametersHandlerMethod): Int64;
var
  lCommand: TAqDBXCommand;
begin
  if FPreparedQueries.TryGetValue(pCommandID, lCommand) then
  begin
    Result := lCommand.Execute(pParametersHandler);
  end else begin
    raise EAqInternal.Create('Command from ID ' + pCommandID.ToString + ' not found.');
  end;
end;

function TAqDBXCustomConnection.DoPrepareCommand(const pSQL: string;
  const pParametersInitializer: TAqDBParametersHandlerMethod): TAqID;
var
  lCommand: TAqDBXCommand;
begin
  lCommand := nil;

  try
    lCommand := PrepareDBXCommand(pSQL);

    lCommand.Prepare(pParametersInitializer);

    Result := FPreparedQueries.Add(lCommand);
  except
    lCommand.Free;
    raise;
  end;
end;

procedure TAqDBXCustomConnection.DoRollbackTransaction;
begin
  FDBXConnection.RollbackFreeAndNil(FDBXTransaction);

  inherited;
end;

procedure TAqDBXCustomConnection.DoUnprepareCommand(const pCommandID: TAqID);
begin
  FPreparedQueries.Remove(pCommandID);

  inherited;
end;

{ TAqDBXParser }

class procedure TAqDBXParser.Execute(var pSQL: string; const pIdentifiedParameters: TStrings);
begin
  Execute(
    procedure(const pName: string)
    begin
      pIdentifiedParameters.Add(pName);
    end, pSQL);
end;

class procedure TAqDBXParser.Execute(const pHandlerMethod: TAqDBParserHandlerMethod; var pSQL: string);
var
  lTokens: TAqBDTokenizer.IAqTokenizerResult;
  lToken: TAqBDTokenizer.TAqTokenizerToken;
begin
  lTokens := TAqBDTokenizer.GetInstance.Execute(pSQL);

  pSQL := '';

  for lToken in lTokens do
  begin
    if lToken.&Type = ttNamedParameter then
    begin
      pSQL := pSQL + '?';

      pHandlerMethod(RightStr(lToken.Text, Length(lToken.Text) - 1));
    end else begin
      if lToken.&Type = ttParameter then
      begin
        pHandlerMethod('');
      end;
      pSQL := pSQL + lToken.Text;
    end;
  end;
end;

{ TAqDBXBaseValue }

class function TAqDBXBaseValue.MustCountReferences: Boolean;
begin
  Result := True;
end;

constructor TAqDBXBaseValue.Create(const pValues: TAqDBXBaseValues; const pName: string; const pIndex: Int32);
begin
  inherited Create;

  FValues := pValues;
  FName := pName;
  FIndex := pIndex;
end;

{$IFNDEF AQMOBILE}
function TAqDBXBaseValue.GetAsAnsiString: AnsiString;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToAnsiString(Self);
end;
{$ENDIF}

function TAqDBXBaseValue.GetAsBCD: TBcd;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToBCD(Self);
end;

function TAqDBXBaseValue.GetAsBoolean: Boolean;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToBoolean(Self);
end;

function TAqDBXBaseValue.GetAsCurrency: Currency;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToCurrency(Self);
end;

function TAqDBXBaseValue.GetAsDate: TDate;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToDate(Self);
end;

function TAqDBXBaseValue.GetAsDateTime: TDateTime;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToDateTime(Self);
end;

function TAqDBXBaseValue.GetAsDouble: Double;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToDouble(Self);
end;

function TAqDBXBaseValue.GetAsInt16: Int16;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToInt16(Self);
end;

function TAqDBXBaseValue.GetAsInt32: Int32;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToInt32(Self);
end;

function TAqDBXBaseValue.GetAsInt64: Int64;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToInt64(Self);
end;

function TAqDBXBaseValue.GetAsInt8: Int8;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToInt8(Self);
end;

function TAqDBXBaseValue.GetAsSingle: Single;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToSingle(Self);
end;

function TAqDBXBaseValue.GetAsString: string;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToString(Self);
end;

function TAqDBXBaseValue.GetAsTime: TTime;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToTime(Self);
end;

function TAqDBXBaseValue.GetAsTimeStamp: TSQLTimeStamp;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToTimeStamp(Self);
end;

function TAqDBXBaseValue.GetAsTimeStampOffset: TSQLTimeStampOffset;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToTimeStampOffset(Self);
end;

function TAqDBXBaseValue.GetAsUInt16: UInt16;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToUInt16(Self);
end;

function TAqDBXBaseValue.GetAsUInt32: UInt32;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToUInt32(Self);
end;

function TAqDBXBaseValue.GetAsUInt64: UInt64;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToUInt64(Self);
end;

function TAqDBXBaseValue.GetAsUInt8: UInt8;
begin
  Result := Values.Connection.DBXAdapter.DBXConverter.DBToUInt8(Self);
end;

function TAqDBXBaseValue.GetName: string;
begin
  Result := FName;
end;

function TAqDBXBaseValue.GetIsNull: Boolean;
begin
  Result := DBXValue.IsNull;
end;

procedure TAqDBXBaseValue.SetName(const pName: string);
begin
  FName := pName;
end;

{ TAqDBXValue }

constructor TAqDBXValue.Create(const pValues: TAqDBXBaseValues; const pName: string; const pIndex: Int32;
   const pValue: TDBXValue);
begin
  inherited Create(pValues, pName, pIndex);

  FValue := pValue;
end;

function TAqDBXValue.GetDBXValue: TDBXValue;
begin
  Result := FValue;
end;

{ TAqDBXParameter }

constructor TAqDBXParameter.Create(const pValues: TAqDBXBaseValues; const pName: string; const pIndex: Int32;
  const pDBXParameter: TDBXParameter);
begin
  inherited Create(pValues, pName, pIndex);

  FDBXParameter := pDBXParameter;
end;

function TAqDBXParameter.GetDBXValue: TDBXValue;
begin
  Result := FDBXParameter.Value;
end;

{$IFNDEF AQMOBILE}
procedure TAqDBXParameter.SetAsAnsiString(const pValue: AnsiString);
begin
  Values.Connection.DBXAdapter.DBXConverter.AnsiStringToParameter(FDBXParameter, pValue);
end;
{$ENDIF}

procedure TAqDBXParameter.SetAsBCD(const pValue: TBcd);
begin
  Values.Connection.DBXAdapter.DBXConverter.BCDToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsBoolean(const pValue: Boolean);
begin
  Values.Connection.DBXAdapter.DBXConverter.BooleanToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsCurrency(const pValue: Currency);
begin
  Values.Connection.DBXAdapter.DBXConverter.CurrencyToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsDate(const pValue: TDate);
begin
  Values.Connection.DBXAdapter.DBXConverter.DateToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsDateTime(const pValue: TDateTime);
begin
  Values.Connection.DBXAdapter.DBXConverter.DateTimeToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsDouble(const pValue: Double);
begin
  Values.Connection.DBXAdapter.DBXConverter.DoubleToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsInt16(const pValue: Int16);
begin
  Values.Connection.DBXAdapter.DBXConverter.Int16ToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsInt32(const pValue: Int32);
begin
  Values.Connection.DBXAdapter.DBXConverter.Int32ToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsInt64(const pValue: Int64);
begin
  Values.Connection.DBXAdapter.DBXConverter.Int64ToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsInt8(const pValue: Int8);
begin
  Values.Connection.DBXAdapter.DBXConverter.Int8ToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsSingle(const pValue: Single);
begin
  Values.Connection.DBXAdapter.DBXConverter.SingleToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsString(const pValue: string);
begin
  Values.Connection.DBXAdapter.DBXConverter.StringToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsTime(const pValue: TTime);
begin
  Values.Connection.DBXAdapter.DBXConverter.TimeToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsTimeStamp(const pValue: TSQLTimeStamp);
begin
  Values.Connection.DBXAdapter.DBXConverter.TimeStampToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsTimeStampOffset(const pValue: TSQLTimeStampOffset);
begin
  Values.Connection.DBXAdapter.DBXConverter.TimeStampOffsetToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsUInt16(const pValue: UInt16);
begin
  Values.Connection.DBXAdapter.DBXConverter.UInt16ToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsUInt32(const pValue: UInt32);
begin
  Values.Connection.DBXAdapter.DBXConverter.UInt32ToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsUInt64(const pValue: UInt64);
begin
  Values.Connection.DBXAdapter.DBXConverter.UInt64ToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetAsUInt8(const pValue: UInt8);
begin
  Values.Connection.DBXAdapter.DBXConverter.UInt8ToParameter(FDBXParameter, pValue);
end;

procedure TAqDBXParameter.SetDataType(const pDataType: TAqDataType);
begin
  FDBXParameter.DataType := TAqDBXDataTypeMapping[pDataType];
end;

procedure TAqDBXParameter.SetNull;
begin
  FDBXParameter.DataType := TAqDBXDataTypeMapping[pDataType];
  FDBXParameter.Value.SetNull;
end;

{ TAqDBXFakeParameterByName }

constructor TAqDBXFakeParameterByName.Create(const pValues: TAqDBXBaseValues; const pName: string;
  const pDBXParameter: TDBXParameter; const pParameterByNameSetterMethod: TAqDBXParameterByNameSetterMethod);
begin
  inherited Create(pValues, pName, pDBXParameter.Ordinal, pDBXParameter);

  FParameterByNameSetterMethod := pParameterByNameSetterMethod;
end;

{$IFNDEF AQMOBILE}
procedure TAqDBXFakeParameterByName.SetAsAnsiString(const pValue: AnsiString);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsAnsiString := pValue;
    end);
end;
{$ENDIF}

procedure TAqDBXFakeParameterByName.SetAsBCD(const pValue: TBcd);
var
  lValor: TBcd;
begin
  lValor := pValue;
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsBCD := lValor;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsBoolean(const pValue: Boolean);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsBoolean := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsCurrency(const pValue: Currency);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsCurrency := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsDate(const pValue: TDate);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsDate := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsDateTime(const pValue: TDateTime);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsDateTime := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsDouble(const pValue: Double);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsDouble := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsInt16(const pValue: Int16);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsInt16 := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsInt32(const pValue: Int32);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsInt32 := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsInt64(const pValue: Int64);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsInt64 := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsInt8(const pValue: Int8);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsInt8 := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsSingle(const pValue: Single);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsSingle := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsString(const pValue: string);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsString := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsTime(const pValue: TTime);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsTime := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsTimeStamp(const pValue: TSQLTimeStamp);
var
  lValor: TSQLTimeStamp;
begin
  lValor := pValue;
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsTimeStamp := lValor;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsTimeStampOffset(const pValue: TSQLTimeStampOffset);
var
  lValor: TSQLTimeStampOffset;
begin
  lValor := pValue;
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsTimeStampOffset := lValor;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsUInt16(const pValue: UInt16);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsUInt16 := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsUInt32(const pValue: UInt32);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsUInt32 := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsUInt64(const pValue: UInt64);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsUInt64 := pValue;
    end);
end;

procedure TAqDBXFakeParameterByName.SetAsUInt8(const pValue: UInt8);
begin
  FParameterByNameSetterMethod(
    procedure(pParameter: IAqDBValue)
    begin
      pParameter.AsUInt8 := pValue;
    end);
end;

{ TAqDBXValues<I> }

procedure TAqDBXValues<I>.Add(pValue: I);
begin
  FValues.Add(pValue);
end;

class function TAqDBXValues<I>.MustCountReferences: Boolean;
begin
  Result := True;
end;

constructor TAqDBXValues<I>.Create(const pConnection: TAqDBXCustomConnection);
begin
  inherited Create(pConnection);

  FValues := TAqList<I>.Create;
end;

destructor TAqDBXValues<I>.Destroy;
begin
  FValues.Free;

  inherited;
end;

function TAqDBXValues<I>.GetCount: Int32;
begin
  Result := FValues.Count;
end;

function TAqDBXValues<I>.GetValueByIndex(pIndex: Int32): I;
begin
  Result := FValues[pIndex];
end;

function TAqDBXValues<I>.GetValueByName(pName: string): I;
var
  lI: Int32;
begin
  lI := FValues.Count - 1;

  while (lI >= 0) and not string.SameText(FValues[lI].Name, pName) do
  begin
    Dec(lI);
  end;

  if lI < 0 then
  begin
    raise EAqInternal.Create('Value of name ' + pName + ' not found.');
  end;

  Result := FValues[lI];
end;

{ TAqDBXReader }

constructor TAqDBXReader.Create(const pConnection: TAqDBXCustomConnection; const pCommand: TAqDBXCommand);
var
  lValue: TDBXValue;
  lI: Int32;
begin
  pConnection.IncreaseReaderes;

  inherited Create(pConnection);

  FCommand := pCommand;
  FDBXReader := FCommand.DBXCommand.ExecuteQuery;

  for lI := 0 to FDBXReader.ColumnCount - 1 do
  begin
    lValue := FDBXReader.Values[lI];
    Add(TAqDBXValue.Create(Self, lValue.ValueType.Name, lI, lValue));
  end;
end;

destructor TAqDBXReader.Destroy;
begin
  FDBXReader.Free;

  if not FCommand.Prepared then
  begin
    FCommand.Free;
  end;

  Connection.DecrementReaders;

  inherited;
end;

function TAqDBXReader.GetByteReader: TDBXByteReader;
begin
  Result := FDBXReader.ByteReader;
end;

function TAqDBXReader.Next: Boolean;
begin
  Result := FDBXReader.Next;
end;

{ TAqDBXParameters }

class function TAqDBXParameters.MustCountReferences: Boolean;
begin
  Result := False;
end;

constructor TAqDBXParameters.Create(const pConnection: TAqDBXCustomConnection; const pDBXCommand: TDBXCommand);
begin
  inherited Create(pConnection);

  FDBXCommand := pDBXCommand;
end;

procedure TAqDBXParameters.CreateParameter(const pName: string);
var
  lParameter: TDBXParameter;
begin
  lParameter := FDBXCommand.CreateParameter;
  try
    FDBXCommand.Parameters.AddParameter(lParameter);
  except
    lParameter.Free;
    raise;
  end;

  lParameter.Name := pName;
  Add(TAqDBXParameter.Create(Self, pName, FDBXCommand.Parameters.Count - 1, lParameter));
end;

function TAqDBXParameters.GetByteReader: TDBXByteReader;
begin
  raise EAqInternal.Create('Error Message');
end;

function TAqDBXParameters.GetValueByName(pName: string): IAqDBValue;
begin
  Result := TAqDBXFakeParameterByName.Create(Self, pName,
    (inherited GetValueByName(pName) as TAqDBXParameter).DBXParameter,
    procedure(const pMetodoAqBDValor: TAqDBValueHandlerMethod)
    var
      lI: Int32;
      lValue: IAqDBValue;
    begin
      lI := GetCount;

      while lI > 0 do
      begin
        Dec(lI);

        lValue := GetValueByIndex(lI);
        if lValue.Name = pName then
        begin
          pMetodoAqBDValor(lValue);
        end;
      end;
    end);
end;

{ TAqDBXBaseValues }

constructor TAqDBXBaseValues.Create(const pConnection: TAqDBXCustomConnection);
begin
  FConnection := pConnection;
end;

{ TAqDBXDataConverter }

{$IFNDEF AQMOBILE}
procedure TAqDBXDataConverter.AnsiStringToParameter(const pParameter: TDBXParameter;
  const pValue: AnsiString);
begin
  StringToParameter(pParameter, string(pValue));
end;
{$ENDIF}

procedure TAqDBXDataConverter.BCDToParameter(const pParameter: TDBXParameter; const pValue: TBcd);
begin
  pParameter.DataType := TDBXDataTypes.BcdType;
  pParameter.Value.SetBcd(pValue);
end;

{$IFNDEF AQMOBILE}
function TAqDBXDataConverter.DBToAnsiString(const pValue: TAqDBXBaseValue): AnsiString;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := '';
  end else begin
    case pValue.DBXValue.ValueType.DataType of
      TDBXDataTypes.AnsiStringType:
        Result := pValue.DBXValue.GetAnsiString;
    else
      Result := AnsiString(DBToString(pValue));
    end;
  end;
end;
{$ENDIF}

function TAqDBXDataConverter.DBToBCD(const pValue: TAqDBXBaseValue): TBcd;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString);
{$ENDIF}
      TDBXDataTypes.Int16Type:
        Result := Int32(pValue.DBXValue.AsInt16);
      TDBXDataTypes.Int32Type:
        Result := pValue.DBXValue.AsInt32;
      TDBXDataTypes.DoubleType:
        Result := pValue.DBXValue.AsDouble;
      TDBXDataTypes.BcdType:
        Result := pValue.DBXValue.AsBcd;
      TDBXDataTypes.UInt16Type:
        Result := Int32(pValue.DBXValue.AsUInt16);
      TDBXDataTypes.Int64Type:
        Result := pValue.DBXValue.AsInt64;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString;
      TDBXDataTypes.SingleType:
        Result := pValue.DBXValue.AsSingle;
      TDBXDataTypes.Int8Type:
        Result := Int32(pValue.DBXValue.AsInt8);
      TDBXDataTypes.UInt8Type:
        Result := Int32(pValue.DBXValue.AsUInt8);
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain a BCD field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToBoolean(const pValue: TAqDBXBaseValue): Boolean;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := False;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result :=  string(pValue.DBXValue.GetAnsiString).ToBoolean;
{$ENDIF}
      TDBXDataTypes.BooleanType:
        Result := pValue.DBXValue.AsBoolean;
      TDBXDataTypes.Int16Type:
        Result := Boolean(pValue.DBXValue.AsInt16);
      TDBXDataTypes.Int32Type:
        Result := Boolean(pValue.DBXValue.AsInt32);
      TDBXDataTypes.UInt16Type:
        Result := Boolean(pValue.DBXValue.AsUInt16);
      TDBXDataTypes.Int64Type:
        Result := Boolean(pValue.DBXValue.AsInt64);
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToBoolean;
      TDBXDataTypes.Int8Type:
        Result := Boolean(pValue.DBXValue.AsInt8);
      TDBXDataTypes.UInt8Type:
        Result := Boolean(pValue.DBXValue.AsUInt8);
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain a boolean field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToCurrency(const pValue: TAqDBXBaseValue): Currency;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString).ToCurrency;
{$ENDIF}
      TDBXDataTypes.BooleanType:
        Result := pValue.DBXValue.AsBoolean.ToInt8;
      TDBXDataTypes.Int16Type:
        Result := pValue.DBXValue.AsInt16;
      TDBXDataTypes.Int32Type:
        Result := pValue.DBXValue.AsInt32;
      TDBXDataTypes.DoubleType:
        Result := pValue.DBXValue.AsDouble;
      TDBXDataTypes.BcdType:
        Result := pValue.DBXValue.AsBcd.ToCurrency;
      TDBXDataTypes.UInt16Type:
        Result := pValue.DBXValue.AsUInt16;
      TDBXDataTypes.Int64Type:
        Result := pValue.DBXValue.AsInt64;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToCurrency;
      TDBXDataTypes.SingleType:
        Result := pValue.DBXValue.AsSingle;
      TDBXDataTypes.Int8Type:
        Result := pValue.DBXValue.AsInt8;
      TDBXDataTypes.UInt8Type:
        Result := pValue.DBXValue.AsUInt8;
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain a Currency field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToDate(const pValue: TAqDBXBaseValue): TDate;
var
  lTimeStamp: TSQLTimeStamp;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString).ToDate;
{$ENDIF}
      TDBXDataTypes.DateType:
        Result := pValue.DBXValue.AsDateTime.DateOf;
      TDBXDataTypes.DoubleType:
        Result := DateOf(pValue.DBXValue.AsDouble);
      TDBXDataTypes.DateTimeType:
        Result := pValue.DBXValue.AsDateTime.DateOf;
      TDBXDataTypes.TimeStampType:
        begin
          lTimeStamp := pValue.DBXValue.AsTimeStamp;
          Result := TDate.EncodeDate(lTimeStamp.Year, lTimeStamp.Month, lTimeStamp.Day);
        end;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToDate;
      TDBXDataTypes.SingleType:
        Result := DateOf(pValue.DBXValue.AsSingle);
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain a date field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToDateTime(const pValue: TAqDBXBaseValue): TDateTime;
var
  lTimeStamp: TSQLTimeStamp;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString).ToDateTime;
{$ENDIF}
      TDBXDataTypes.DateType:
        Result := pValue.DBXValue.AsDateTime;
      TDBXDataTypes.DoubleType:
        Result := pValue.DBXValue.AsDouble;
      TDBXDataTypes.DateTimeType:
        Result := pValue.DBXValue.AsDateTime;
      TDBXDataTypes.TimeStampType:
        begin
          lTimeStamp := pValue.DBXValue.AsTimeStamp;
          Result := TDateTime.EncodeDateTime(lTimeStamp.Year, lTimeStamp.Month, lTimeStamp.Day, lTimeStamp.Hour,
            lTimeStamp.Minute, lTimeStamp.Second, lTimeStamp.Fractions);
        end;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToDateTime;
      TDBXDataTypes.SingleType:
        Result := pValue.DBXValue.AsSingle;
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain a datetime field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToDouble(const pValue: TAqDBXBaseValue): Double;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString).ToDouble;
{$ENDIF}
      TDBXDataTypes.BooleanType:
        Result := pValue.DBXValue.AsBoolean.ToInt8;
      TDBXDataTypes.Int16Type:
        Result := pValue.DBXValue.AsInt16;
      TDBXDataTypes.Int32Type:
        Result := pValue.DBXValue.AsInt32;
      TDBXDataTypes.DoubleType:
        Result := pValue.DBXValue.AsDouble;
      TDBXDataTypes.BcdType:
        Result := pValue.DBXValue.AsBcd.ToString.ToDouble;
      TDBXDataTypes.UInt16Type:
        Result := pValue.DBXValue.AsUInt16;
      TDBXDataTypes.Int64Type:
        Result := pValue.DBXValue.AsInt64;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToDouble;
      TDBXDataTypes.SingleType:
        Result := pValue.DBXValue.AsSingle;
      TDBXDataTypes.Int8Type:
        Result := pValue.DBXValue.AsInt8;
      TDBXDataTypes.UInt8Type:
        Result := pValue.DBXValue.AsUInt8;
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain a Double field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToInt16(const pValue: TAqDBXBaseValue): Int16;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString).ToInt16;
{$ENDIF}
      TDBXDataTypes.BooleanType:
        Result := pValue.DBXValue.AsBoolean.ToInt8;
      TDBXDataTypes.Int16Type:
        Result := pValue.DBXValue.AsInt16;
      TDBXDataTypes.Int32Type:
        Result := pValue.DBXValue.AsInt32;
      TDBXDataTypes.DoubleType:
        Result := pValue.DBXValue.AsDouble.Trunc;
      TDBXDataTypes.BcdType:
        Result := Int32(pValue.DBXValue.AsBcd);
      TDBXDataTypes.UInt16Type:
        Result := pValue.DBXValue.AsUInt16;
      TDBXDataTypes.Int64Type:
        Result := pValue.DBXValue.AsInt64;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToInt16;
      TDBXDataTypes.SingleType:
        Result := pValue.DBXValue.AsSingle.Trunc;
      TDBXDataTypes.Int8Type:
        Result := pValue.DBXValue.AsInt8;
      TDBXDataTypes.UInt8Type:
        Result := pValue.DBXValue.AsUInt8;
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain an Int16 field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToInt32(const pValue: TAqDBXBaseValue): Int32;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString).ToInt32;
{$ENDIF}
      TDBXDataTypes.BooleanType:
        Result := pValue.DBXValue.AsBoolean.ToInt8;
      TDBXDataTypes.Int16Type:
        Result := pValue.DBXValue.AsInt16;
      TDBXDataTypes.Int32Type:
        Result := pValue.DBXValue.AsInt32;
      TDBXDataTypes.DoubleType:
        Result := pValue.DBXValue.AsDouble.Trunc;
      TDBXDataTypes.BcdType:
        Result := Int32(pValue.DBXValue.AsBcd);
      TDBXDataTypes.UInt16Type:
        Result := pValue.DBXValue.AsUInt16;
      TDBXDataTypes.Int64Type:
        Result := pValue.DBXValue.AsInt64;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToInt32;
      TDBXDataTypes.SingleType:
        Result := pValue.DBXValue.AsSingle.Trunc;
      TDBXDataTypes.Int8Type:
        Result := pValue.DBXValue.AsInt8;
      TDBXDataTypes.UInt8Type:
        Result := pValue.DBXValue.AsUInt8;
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain an Int32 field: ' +
        pValue.DBXValue.ValueType.DataType.ToString);
    end;
  end;
end;

function TAqDBXDataConverter.DBToInt64(const pValue: TAqDBXBaseValue): Int64;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString).ToInt64;
{$ENDIF}
      TDBXDataTypes.BooleanType:
        Result := pValue.DBXValue.AsBoolean.ToInt8;
      TDBXDataTypes.Int16Type:
        Result := pValue.DBXValue.AsInt16;
      TDBXDataTypes.Int32Type:
        Result := pValue.DBXValue.AsInt32;
      TDBXDataTypes.DoubleType:
        Result := pValue.DBXValue.AsDouble.Trunc;
      TDBXDataTypes.BcdType:
        Result := pValue.DBXValue.AsBcd.ToString.ToDouble.Trunc;
      TDBXDataTypes.UInt16Type:
        Result := pValue.DBXValue.AsUInt16;
      TDBXDataTypes.Int64Type:
        Result := pValue.DBXValue.AsInt64;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToInt64;
      TDBXDataTypes.SingleType:
        Result := pValue.DBXValue.AsSingle.Trunc;
      TDBXDataTypes.Int8Type:
        Result := pValue.DBXValue.AsInt8;
      TDBXDataTypes.UInt8Type:
        Result := pValue.DBXValue.AsUInt8;
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain an Int64 field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToInt8(const pValue: TAqDBXBaseValue): Int8;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString).ToInt8;
{$ENDIF}
      TDBXDataTypes.BooleanType:
        Result := pValue.DBXValue.AsBoolean.ToInt8;
      TDBXDataTypes.Int16Type:
        Result := pValue.DBXValue.AsInt16;
      TDBXDataTypes.Int32Type:
        Result := pValue.DBXValue.AsInt32;
      TDBXDataTypes.DoubleType:
        Result := pValue.DBXValue.AsDouble.Trunc;
      TDBXDataTypes.BcdType:
        Result := Int32(pValue.DBXValue.AsBcd);
      TDBXDataTypes.UInt16Type:
        Result := pValue.DBXValue.AsUInt16;
      TDBXDataTypes.Int64Type:
        Result := pValue.DBXValue.AsInt64;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToInt8;
      TDBXDataTypes.SingleType:
        Result := pValue.DBXValue.AsSingle.Trunc;
      TDBXDataTypes.Int8Type:
        Result := pValue.DBXValue.AsInt8;
      TDBXDataTypes.UInt8Type:
        Result := pValue.DBXValue.AsUInt8;
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain an Int8 field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToSingle(const pValue: TAqDBXBaseValue): Single;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString).ToDouble;
{$ENDIF}
      TDBXDataTypes.BooleanType:
        Result := pValue.DBXValue.AsBoolean.ToInt8;
      TDBXDataTypes.Int16Type:
        Result := pValue.DBXValue.AsInt16;
      TDBXDataTypes.Int32Type:
        Result := pValue.DBXValue.AsInt32;
      TDBXDataTypes.DoubleType:
        Result := pValue.DBXValue.AsDouble;
      TDBXDataTypes.BcdType:
        Result := pValue.DBXValue.AsBcd.ToString.ToDouble;
      TDBXDataTypes.UInt16Type:
        Result := pValue.DBXValue.AsUInt16;
      TDBXDataTypes.Int64Type:
        Result := pValue.DBXValue.AsInt64;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToDouble;
      TDBXDataTypes.SingleType:
        Result := pValue.DBXValue.AsSingle;
      TDBXDataTypes.Int8Type:
        Result := pValue.DBXValue.AsInt8;
      TDBXDataTypes.UInt8Type:
        Result := pValue.DBXValue.AsUInt8;
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain a Single field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToString(const pValue: TAqDBXBaseValue): string;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := '';
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString);
{$ENDIF}
      TDBXDataTypes.BlobType:
        Result := pValue.DBXValue.AsString;
      TDBXDataTypes.BooleanType:
        Result := pValue.DBXValue.AsBoolean.ToString;
      TDBXDataTypes.Int16Type:
        Result := pValue.DBXValue.AsInt16.ToString;
      TDBXDataTypes.Int32Type:
        Result := pValue.DBXValue.AsInt32.ToString;
      TDBXDataTypes.DoubleType:
        Result := pValue.DBXValue.AsDouble.ToString;
      TDBXDataTypes.BcdType:
        Result := pValue.DBXValue.AsBcd.ToString;
      TDBXDataTypes.DateTimeType:
        Result := pValue.DBXValue.AsDateTime.ToString;
      TDBXDataTypes.UInt16Type:
        Result := pValue.DBXValue.AsUInt16.ToString;
      TDBXDataTypes.Int64Type:
        Result := pValue.DBXValue.AsInt64.ToString;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString;
      TDBXDataTypes.SingleType:
        Result := pValue.DBXValue.AsSingle.ToString;
      TDBXDataTypes.Int8Type:
        Result := pValue.DBXValue.AsInt8.ToString;
      TDBXDataTypes.UInt8Type:
        Result := pValue.DBXValue.AsUInt8.ToString;
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain a string field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToTime(const pValue: TAqDBXBaseValue): TTime;
var
  lTimeStamp: TSQLTimeStamp;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString).ToTime;
{$ENDIF}
      TDBXDataTypes.DoubleType:
        Result := TimeOf(pValue.DBXValue.AsDouble);
      TDBXDataTypes.TimeType:
        Result := pValue.DBXValue.AsDateTime.TimeOf;
      TDBXDataTypes.DateTimeType:
        Result := pValue.DBXValue.AsDateTime.TimeOf;
      TDBXDataTypes.TimeStampType:
        begin
          lTimeStamp := pValue.DBXValue.AsTimeStamp;
          Result := TTime.EncodeTime(lTimeStamp.Hour, lTimeStamp.Minute, lTimeStamp.Second, lTimeStamp.Fractions);
        end;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToTime;
      TDBXDataTypes.SingleType:
        Result := TimeOf(pValue.DBXValue.AsSingle);
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain a time field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToTimeStamp(const pValue: TAqDBXBaseValue): TSQLTimeStamp;
begin
  case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
    TDBXDataTypes.AnsiStringType:
      Result := string(pValue.DBXValue.GetAnsiString).ToDateTime.ToSQLTimeStamp;
{$ENDIF}
    TDBXDataTypes.DoubleType:
      Result := TDateTime(pValue.DBXValue.AsDouble).ToSQLTimeStamp;
    TDBXDataTypes.DateTimeType:
      Result := pValue.DBXValue.AsDateTime.ToSQLTimeStamp;
    TDBXDataTypes.TimeStampType:
      Result := pValue.DBXValue.AsTimeStamp;
    TDBXDataTypes.WideStringType:
      Result := pValue.DBXValue.AsString.ToDateTime.ToSQLTimeStamp;
  else
    raise EAqInternal.Create('Unexpectet type when trying to obtain a TimeStamp field.');
  end;
end;

function TAqDBXDataConverter.DBToTimeStampOffset(const pValue: TAqDBXBaseValue): TSQLTimeStampOffset;
begin
  case pValue.DBXValue.ValueType.DataType of
    TDBXDataTypes.TimeStampOffsetType:
      Result := pValue.DBXValue.GetTimeStampOffset;
  else
    raise EAqInternal.Create('Unexpectet type when trying to obtain a TimeStampOffset field.');
  end;
end;

function TAqDBXDataConverter.DBToUInt16(const pValue: TAqDBXBaseValue): UInt16;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString).ToUInt16;
{$ENDIF}
      TDBXDataTypes.BooleanType:
        Result := pValue.DBXValue.AsBoolean.ToInt8;
      TDBXDataTypes.Int16Type:
        Result := pValue.DBXValue.AsInt16;
      TDBXDataTypes.Int32Type:
        Result := pValue.DBXValue.AsInt32;
      TDBXDataTypes.DoubleType:
        Result := pValue.DBXValue.AsDouble.Trunc;
      TDBXDataTypes.BcdType:
        Result := Int32(pValue.DBXValue.AsBcd);
      TDBXDataTypes.UInt16Type:
        Result := pValue.DBXValue.AsUInt16;
      TDBXDataTypes.Int64Type:
        Result := pValue.DBXValue.AsInt64;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToUInt16;
      TDBXDataTypes.SingleType:
        Result := pValue.DBXValue.AsSingle.Trunc;
      TDBXDataTypes.Int8Type:
        Result := pValue.DBXValue.AsInt8;
      TDBXDataTypes.UInt8Type:
        Result := pValue.DBXValue.AsUInt8;
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain an UInt16 field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToUInt32(const pValue: TAqDBXBaseValue): UInt32;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString).ToUInt32;
{$ENDIF}
      TDBXDataTypes.BooleanType:
        Result := pValue.DBXValue.AsBoolean.ToInt8;
      TDBXDataTypes.Int16Type:
        Result := pValue.DBXValue.AsInt16;
      TDBXDataTypes.Int32Type:
        Result := pValue.DBXValue.AsInt32;
      TDBXDataTypes.DoubleType:
        Result := pValue.DBXValue.AsDouble.Trunc;
      TDBXDataTypes.BcdType:
        Result := Int32(pValue.DBXValue.AsBcd);
      TDBXDataTypes.UInt16Type:
        Result := pValue.DBXValue.AsUInt16;
      TDBXDataTypes.Int64Type:
        Result := pValue.DBXValue.AsInt64;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToUInt32;
      TDBXDataTypes.SingleType:
        Result := pValue.DBXValue.AsSingle.Trunc;
      TDBXDataTypes.Int8Type:
        Result := pValue.DBXValue.AsInt8;
      TDBXDataTypes.UInt8Type:
        Result := pValue.DBXValue.AsUInt8;
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain an UInt32 field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToUInt64(const pValue: TAqDBXBaseValue): UInt64;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString).ToUInt64;
{$ENDIF}
      TDBXDataTypes.BooleanType:
        Result := pValue.DBXValue.AsBoolean.ToInt8;
      TDBXDataTypes.Int16Type:
        Result := pValue.DBXValue.AsInt16;
      TDBXDataTypes.Int32Type:
        Result := pValue.DBXValue.AsInt32;
      TDBXDataTypes.DoubleType:
        Result := pValue.DBXValue.AsDouble.Trunc;
      TDBXDataTypes.BcdType:
        Result := pValue.DBXValue.AsBcd.ToString.ToDouble.Trunc;
      TDBXDataTypes.UInt16Type:
        Result := pValue.DBXValue.AsUInt16;
      TDBXDataTypes.Int64Type:
        Result := pValue.DBXValue.AsInt64;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToUInt64;
      TDBXDataTypes.SingleType:
        Result := pValue.DBXValue.AsSingle.Trunc;
      TDBXDataTypes.Int8Type:
        Result := pValue.DBXValue.AsInt8;
      TDBXDataTypes.UInt8Type:
        Result := pValue.DBXValue.AsUInt8;
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain an UInt64 field.');
    end;
  end;
end;

function TAqDBXDataConverter.DBToUInt8(const pValue: TAqDBXBaseValue): UInt8;
begin
  if pValue.DBXValue.IsNull then
  begin
    Result := 0;
  end else begin
    case pValue.DBXValue.ValueType.DataType of
{$IFNDEF AQMOBILE}
      TDBXDataTypes.AnsiStringType:
        Result := string(pValue.DBXValue.GetAnsiString).ToUInt8;
{$ENDIF}
      TDBXDataTypes.BooleanType:
        Result := pValue.DBXValue.AsBoolean.ToInt8;
      TDBXDataTypes.Int16Type:
        Result := pValue.DBXValue.AsInt16;
      TDBXDataTypes.Int32Type:
        Result := pValue.DBXValue.AsInt32;
      TDBXDataTypes.DoubleType:
        Result := pValue.DBXValue.AsDouble.Trunc;
      TDBXDataTypes.BcdType:
        Result := Int32(pValue.DBXValue.AsBcd);
      TDBXDataTypes.UInt16Type:
        Result := pValue.DBXValue.AsUInt16;
      TDBXDataTypes.Int64Type:
        Result := pValue.DBXValue.AsInt64;
      TDBXDataTypes.WideStringType:
        Result := pValue.DBXValue.AsString.ToUInt8;
      TDBXDataTypes.SingleType:
        Result := pValue.DBXValue.AsSingle.Trunc;
      TDBXDataTypes.Int8Type:
        Result := pValue.DBXValue.AsInt8;
      TDBXDataTypes.UInt8Type:
        Result := pValue.DBXValue.AsUInt8;
    else
      raise EAqInternal.Create('Unexpectet type when trying to obtain an UInt8 field.');
    end;
  end;
end;

procedure TAqDBXDataConverter.BooleanToParameter(const pParameter: TDBXParameter; const pValue: Boolean);
begin
  pParameter.DataType := TDBXDataTypes.BooleanType;
  pParameter.Value.SetBoolean(pValue);
end;

procedure TAqDBXDataConverter.CurrencyToParameter(const pParameter: TDBXParameter; const pValue: Currency);
begin
  BCDToParameter(pParameter, pValue.ToBcd);
end;

procedure TAqDBXDataConverter.DateToParameter(const pParameter: TDBXParameter; const pValue: TDate);
begin
  pParameter.DataType := TDBXDataTypes.DateType;
  pParameter.Value.AsDateTime := DateOf(pValue);
end;

procedure TAqDBXDataConverter.DateTimeToParameter(const pParameter: TDBXParameter; const pValue: TDateTime);
begin
  pParameter.DataType := TDBXDataTypes.TimeStampType;
  pParameter.Value.AsDateTime := pValue;
end;

procedure TAqDBXDataConverter.DoubleToParameter(const pParameter: TDBXParameter; const pValue: Double);
begin
  pParameter.DataType := TDBXDataTypes.DoubleType;
  pParameter.Value.SetDouble(pValue);
end;

procedure TAqDBXDataConverter.Int16ToParameter(const pParameter: TDBXParameter; const pValue: Int16);
begin
  pParameter.DataType := TDBXDataTypes.Int16Type;
  pParameter.Value.SetInt16(pValue);
end;

procedure TAqDBXDataConverter.Int32ToParameter(const pParameter: TDBXParameter; const pValue: Int32);
begin
  pParameter.DataType := TDBXDataTypes.Int32Type;
  pParameter.Value.SetInt32(pValue);
end;

procedure TAqDBXDataConverter.Int64ToParameter(const pParameter: TDBXParameter; const pValue: Int64);
begin
  pParameter.DataType := TDBXDataTypes.Int64Type;
  pParameter.Value.SetInt64(pValue);
end;

procedure TAqDBXDataConverter.Int8ToParameter(const pParameter: TDBXParameter; const pValue: Int8);
begin
  pParameter.DataType := TDBXDataTypes.Int32Type;
  pParameter.Value.SetInt32(pValue);
end;

procedure TAqDBXDataConverter.SingleToParameter(const pParameter: TDBXParameter; const pValue: Single);
begin
  raise EAqInternal.Create('The type Single wasn''t mapped in the DBX Framework.');
end;

procedure TAqDBXDataConverter.StringToParameter(const pParameter: TDBXParameter; const pValue: string);
begin
  pParameter.DataType := TDBXDataTypes.WideStringType;
  pParameter.Value.SetString(pValue);
end;

procedure TAqDBXDataConverter.TimeToParameter(const pParameter: TDBXParameter; const pValue: TTime);
begin
  pParameter.DataType := TDBXDataTypes.TimeType;
  pParameter.Value.AsDateTime := TimeOf(pValue);
end;

procedure TAqDBXDataConverter.TimeStampOffsetToParameter(const pParameter: TDBXParameter;
  const pValue: TSQLTimeStampOffset);
begin
  pParameter.DataType := TDBXDataTypes.TimeStampOffsetType;
  pParameter.Value.SetTimeStampOffset(pValue);
end;

procedure TAqDBXDataConverter.TimeStampToParameter(const pParameter: TDBXParameter; const pValue: TSQLTimeStamp);
begin
  pParameter.DataType := TDBXDataTypes.TimeStampType;
  pParameter.Value.SetTimeStamp(pValue);
end;

procedure TAqDBXDataConverter.UInt16ToParameter(const pParameter: TDBXParameter; const pValue: UInt16);
begin
  pParameter.DataType := TDBXDataTypes.UInt16Type;
  pParameter.Value.SetUInt16(pValue);
end;

procedure TAqDBXDataConverter.UInt32ToParameter(const pParameter: TDBXParameter; const pValue: UInt32);
begin
  pParameter.DataType := TDBXDataTypes.Int64Type;
  pParameter.Value.SetInt64(pValue);
end;

procedure TAqDBXDataConverter.UInt64ToParameter(const pParameter: TDBXParameter; const pValue: UInt64);
begin
  raise EAqInternal.Create('Type UInt64 wasn''t mapped in the DBX Framework.');
end;

procedure TAqDBXDataConverter.UInt8ToParameter(const pParameter: TDBXParameter; const pValue: UInt8);
begin
  pParameter.DataType := TDBXDataTypes.UInt8Type;
  pParameter.Value.SetUInt8(pValue);
end;

{ TAqDBXCommand }

function TAqDBXCommand.Open(const pParametersHandler: TAqDBParametersHandlerMethod): TAqDBXReader;
begin
  if Assigned(pParametersHandler) then
  begin
    pParametersHandler(FParameters);
  end;

  Result := TAqDBXReader.Create(FConnection, Self);
end;

constructor TAqDBXCommand.Create(const pConnection: TAqDBXCustomConnection; const pDBXCommand: TDBXCommand);
begin
  FConnection := pConnection;
  FDBXCommand := pDBXCommand;
  FParameters := TAqDBXParameters.Create(FConnection, FDBXCommand);
end;

destructor TAqDBXCommand.Destroy;
begin
  FParameters.Free;
  FDBXCommand.Free;

  inherited;
end;

function TAqDBXCommand.Execute(const pParametersHandler: TAqDBParametersHandlerMethod): Int64;
begin
  if Assigned(pParametersHandler) then
  begin
    pParametersHandler(FParameters);
  end;

  FDBXCommand.ExecuteUpdate;
  Result := FDBXCommand.RowsAffected;
end;

procedure TAqDBXCommand.Prepare(const pParametersInitializer: TAqDBParametersHandlerMethod);
begin
  if Assigned(pParametersInitializer) then
  begin
    pParametersInitializer(FParameters);
  end;

  FPrepared := True;
end;

{ TAqDBXConnection }

function TAqDBXConnection.GetAutoIncrement(const pGeneratorName: string): Int64;
begin
  if Assigned(FGetterAutoIncrement) then
  begin
    Result := FGetterAutoIncrement;
  end else begin
    Result := inherited;
  end;
end;

{ TAqDBXAdapter }

constructor TAqDBXAdapter.Create;
begin
  inherited;

  SetDBXConverter(CreateConverter);
end;

function TAqDBXAdapter.CreateConverter: TAqDBXDataConverter;
begin
  Result := GetDefaultConverter.Create;
end;

destructor TAqDBXAdapter.Destroy;
begin
  FDBXConverter.Free;

  inherited;
end;

class function TAqDBXAdapter.GetDefaultConverter: TAqDBXDataConverterClass;
begin
  Result := TAqDBXDataConverter;
end;

function TAqDBXAdapter.GetParameterCreationOrder: TAqDBXParameterCreationOrder;
begin
  Result := TAqDBXParameterCreationOrder.pcoCreateBeforePrepare;
end;

procedure TAqDBXAdapter.SetDBXConverter(const pValue: TAqDBXDataConverter);
begin
  FreeAndNil(FDBXConverter);
  FDBXConverter := pValue;
end;

end.
