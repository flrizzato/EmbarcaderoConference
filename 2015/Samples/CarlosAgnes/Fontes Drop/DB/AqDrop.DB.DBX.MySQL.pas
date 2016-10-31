unit AqDrop.DB.DBX.MySQL;

{$I '..\Core\AqDrop.Core.Defines.Inc'}

interface

uses
  Data.DBXCommon,
{$IFNDEF AQMOBILE}
  Data.DBXMySQL,
{$ENDIF}
  AqDrop.DB.Adapter,
  AqDrop.DB.Connection,
  AqDrop.DB.DBX,
  AqDrop.DB.SQL.Intf;

type
  TAqDBXMySQLDataConverter = class(TAqDBXDataConverter)
  public
    procedure BooleanToParameter(const pParameter: TDBXParameter; const pValue: Boolean); override;
    procedure UInt8ToParameter(const pParameter: TDBXParameter; const pValue: UInt8); override;
    procedure UInt16ToParameter(const pParameter: TDBXParameter; const pValue: UInt16); override;
  end;

  TAqDBXMySQLAdapter = class(TAqDBXAdapter)
  strict protected
    class function GetDefaultConverter: TAqDBXDataConverterClass; override;
    class function GetDefaultSolver: TAqDBSQLSolverClass; override;
  end;

  TAqDBXMySQLConnection = class(TAqDBXCustomConnection)
  strict protected
    function GetPropertyValueAsString(const pIndex: Int32): string; override;
    procedure SetPropertyValueAsString(const pIndex: Int32; const pValue: string); override;

    class function GetDefaultAdapter: TAqDBAdapterClass; override;
  public
    constructor Create; override;

    property HostName: string index $80 read GetPropertyValueAsString write SetPropertyValueAsString;
    property DataBase: string index $81 read GetPropertyValueAsString write SetPropertyValueAsString;
    property UserName: string index $82 read GetPropertyValueAsString write SetPropertyValueAsString;
    property Password: string index $83 read GetPropertyValueAsString write SetPropertyValueAsString;
  end;

implementation

uses
  System.SysUtils,
  AqDrop.Core.Exceptions,
  AqDrop.Core.Helpers,
  AqDrop.DB.Types,
  AqDrop.DB.MySQL;

{ TAqDBXMySQLDataConverter }

procedure TAqDBXMySQLDataConverter.BooleanToParameter(const pParameter: TDBXParameter; const pValue: Boolean);
begin
  pParameter.DataType := TDBXDataTypes.Int8Type;
  pParameter.Value.SetInt8(pValue.ToInt8);
end;

procedure TAqDBXMySQLDataConverter.UInt16ToParameter(const pParameter: TDBXParameter; const pValue: UInt16);
begin
  UInt32ToParameter(pParameter, pValue);
end;

procedure TAqDBXMySQLDataConverter.UInt8ToParameter(const pParameter: TDBXParameter; const pValue: UInt8);
begin
  UInt32ToParameter(pParameter, pValue);
end;

{ TAqDBXMySQLConnection }

constructor TAqDBXMySQLConnection.Create;
begin
  inherited;

  Self.DriverName := 'MySQL';
  Self.VendorLib := 'LIBMYSQL.dll';
  Self.LibraryName := 'dbxmys.dll';
  Self.GetDriverFunc := 'getSQLDriverMYSQL';
end;

class function TAqDBXMySQLConnection.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := TAqDBXMySQLAdapter;
end;

function TAqDBXMySQLConnection.GetPropertyValueAsString(const pIndex: Int32): string;
begin
  case pIndex of
    $80:
      Result := Properties[TDBXPropertyNames.HostName];
    $81:
      Result := Properties[TDBXPropertyNames.Database];
    $82:
      Result := Properties[TDBXPropertyNames.UserName];
    $83:
      Result := Properties[TDBXPropertyNames.Password];
  else
    Result := inherited;
  end;
end;

procedure TAqDBXMySQLConnection.SetPropertyValueAsString(const pIndex: Int32; const pValue: string);
begin
  case pIndex of
    $80:
      Properties[TDBXPropertyNames.HostName] := pValue;
    $81:
      Properties[TDBXPropertyNames.Database] := pValue;
    $82:
      Properties[TDBXPropertyNames.UserName] := pValue;
    $83:
      Properties[TDBXPropertyNames.Password] := pValue;
  else
    inherited;
  end;
end;

{ TAqDBXMySQLAdapter }

class function TAqDBXMySQLAdapter.GetDefaultConverter: TAqDBXDataConverterClass;
begin
  Result := TAqDBXMySQLDataConverter;
end;

class function TAqDBXMySQLAdapter.GetDefaultSolver: TAqDBSQLSolverClass;
begin
  Result := TAqDBMySQLSQLSolver;
end;

end.
