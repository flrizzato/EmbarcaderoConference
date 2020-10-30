unit AqDrop.DB.DBX.Ora;

{$I '..\Core\AqDrop.Core.Defines.Inc'}

interface

uses
  Data.DBXCommon,
{$IFNDEF AQMOBILE}
  Data.DBXOracle,
{$ENDIF}
  AqDrop.DB.Ora,
  AqDrop.DB.DBX,
  AqDrop.DB.Adapter;

type
  TAqDBXOraDataConverter = class(TAqDBXDataConverter)
  public
    procedure BooleanToParameter(const pParameter: TDBXParameter; const pValue: Boolean); override;
    procedure Int64ToParameter(const pParameter: TDBXParameter; const pValue: Int64); override;
    procedure DateToParameter(const pParameter: TDBXParameter; const pValue: TDate); override;
  end;

  TAqDBXOraAdapter = class(TAqDBXAdapter)
  strict protected
    class function GetDefaultConverter: TAqDBXDataConverterClass; override;
    class function GetDefaultSolver: TAqDBSQLSolverClass; override;
    function GetAutoIncrementType: TAqDBAutoIncrementType; override;
  end;

  TAqDBXOraConnection = class(TAqDBXCustomConnection)
  strict protected
    function GetPropertyValueAsString(const pIndex: Int32): string; override;
    procedure SetPropertyValueAsString(const pIndex: Int32; const pValue: string); override;

    class function GetDefaultAdapter: TAqDBAdapterClass; override;
  public
    constructor Create; override;

    property DataBase: string index $80 read GetPropertyValueAsString write SetPropertyValueAsString;
    property UserName: string index $81 read GetPropertyValueAsString write SetPropertyValueAsString;
    property Password: string index $82 read GetPropertyValueAsString write SetPropertyValueAsString;
  end;

implementation

uses
  AqDrop.Core.Exceptions,
  AqDrop.DB.Types;

{ TAqDBXOraDataConverter }

procedure TAqDBXOraDataConverter.BooleanToParameter(const pParameter: TDBXParameter; const pValue: Boolean);
begin
  pParameter.DataType := TDBXDataTypes.AnsiStringType;

  if pValue then
  begin
    pParameter.Value.SetString('1');
  end else begin
    pParameter.Value.SetString('0');
  end;
end;

procedure TAqDBXOraDataConverter.DateToParameter(const pParameter: TDBXParameter; const pValue: TDate);
begin
  DateTimeToParameter(pParameter, pValue);
end;

procedure TAqDBXOraDataConverter.Int64ToParameter(const pParameter: TDBXParameter; const pValue: Int64);
begin
  BCDToParameter(pParameter, pValue);
end;

{ TAqDBXOraAdapter }

function TAqDBXOraAdapter.GetAutoIncrementType: TAqDBAutoIncrementType;
begin
  Result := TAqDBAutoIncrementType.aiGenerator;
end;

class function TAqDBXOraAdapter.GetDefaultConverter: TAqDBXDataConverterClass;
begin
  Result := TAqDBXOraDataConverter;
end;

class function TAqDBXOraAdapter.GetDefaultSolver: TAqDBSQLSolverClass;
begin
  Result := TAqDBOraSQLSolver;
end;

{ TAqDBXOraConnection }

constructor TAqDBXOraConnection.Create;
begin
  inherited;

  Self.DriverName := 'Oracle';
  Self.VendorLib := 'oci.dll';
  Self.LibraryName := 'dbxora.dll';
  Self.GetDriverFunc := 'getSQLDriverORACLE';
end;

class function TAqDBXOraConnection.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := TAqDBXOraAdapter;
end;

function TAqDBXOraConnection.GetPropertyValueAsString(const pIndex: Int32): string;
begin
  case pIndex of
    $80:
      Result := Properties[TDBXPropertyNames.Database];
    $81:
      Result := Properties[TDBXPropertyNames.UserName];
    $82:
      Result := Properties[TDBXPropertyNames.Password];
  else
    Result := inherited;
  end;
end;

procedure TAqDBXOraConnection.SetPropertyValueAsString(const pIndex: Int32; const pValue: string);
begin
  case pIndex of
    $80:
      Properties[TDBXPropertyNames.Database] := pValue;
    $81:
      Properties[TDBXPropertyNames.UserName] := pValue;
    $82:
      Properties[TDBXPropertyNames.Password] := pValue;
  else
    inherited;
  end;
end;

end.
