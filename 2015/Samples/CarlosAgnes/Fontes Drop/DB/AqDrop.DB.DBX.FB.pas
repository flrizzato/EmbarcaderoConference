unit AqDrop.DB.DBX.FB;

{$I '..\Core\AqDrop.Core.Defines.Inc'}

interface

uses
  Data.DBXCommon,
{$IFNDEF AQMOBILE}
  Data.DBXFirebird,
{$ENDIF}
  AqDrop.DB.Connection,
  AqDrop.DB.DBX,
  AqDrop.DB.SQL.Intf,
  AqDrop.DB.Adapter;

type
  TAqDBXFBDataConverter = class(TAqDBXDataConverter)
  public
    procedure BooleanToParameter(const pParameter: TDBXParameter; const pValue: Boolean); override;
  end;

  TAqDBXFBAdapter = class(TAqDBXAdapter)
  strict protected
    function GetAutoIncrementType: TAqDBAutoIncrementType; override;
    class function GetDefaultConverter: TAqDBXDataConverterClass; override;
    class function GetDefaultSolver: TAqDBSQLSolverClass; override;
  end;


  TAqDBXFBConnection = class(TAqDBXCustomConnection)
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
  System.SysUtils,
  AqDrop.Core.Exceptions,
  AqDrop.Core.Helpers,
  AqDrop.DB.Types,
  AqDrop.DB.FB;

{ TAqDBXFBConnection }

constructor TAqDBXFBConnection.Create;
begin
  inherited;

  Self.DriverName := 'Firebird';
  Self.VendorLib := 'fbclient.dll';
  Self.LibraryName := 'dbxfb.dll';
  Self.GetDriverFunc := 'getSQLDriverINTERBASE';
end;

class function TAqDBXFBConnection.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := TAqDBXFBAdapter;
end;

function TAqDBXFBConnection.GetPropertyValueAsString(const pIndex: Int32): string;
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

procedure TAqDBXFBConnection.SetPropertyValueAsString(const pIndex: Int32; const pValue: string);
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

{ TAqDBXFBDataConverter }

procedure TAqDBXFBDataConverter.BooleanToParameter(const pParameter: TDBXParameter; const pValue: Boolean);
begin
  pParameter.DataType := TDBXDataTypes.AnsiStringType;

  if pValue then
  begin
    pParameter.Value.SetString('1');
  end else begin
    pParameter.Value.SetString('0');
  end;
end;

{ TAqDBXFBAdapter }

function TAqDBXFBAdapter.GetAutoIncrementType: TAqDBAutoIncrementType;
begin
  Result := TAqDBAutoIncrementType.aiGenerator;
end;

class function TAqDBXFBAdapter.GetDefaultConverter: TAqDBXDataConverterClass;
begin
  Result := TAqDBXFBDataConverter;
end;

class function TAqDBXFBAdapter.GetDefaultSolver: TAqDBSQLSolverClass;
begin
  Result := TAqDBFBSQLSolver;
end;

end.
