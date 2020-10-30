unit AqDrop.DB.DBX.MSSQL;

{$I '..\Core\AqDrop.Core.Defines.Inc'}

interface

uses
{$IFNDEF AQMOBILE}
  Data.DBXMSSQL,
{$ENDIF}
  AqDrop.DB.SQL.Intf,
  AqDrop.DB.Adapter,
  AqDrop.DB.Connection,
  AqDrop.DB.DBX;

type
  TAqDBXMSSQLAdapter = class(TAqDBXAdapter)
  strict protected
    class function GetDefaultSolver: TAqDBSQLSolverClass; override;
  end;

  TAqDBXMSSQLConnection = class(TAqDBXCustomConnection)
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
  Data.DBXCommon,
  AqDrop.Core.Exceptions,
  AqDrop.Core.Helpers,
  AqDrop.DB.Types, AqDrop.DB.MSSQL;

{ TAqDBXMSSQLConnection }

constructor TAqDBXMSSQLConnection.Create;
begin
  inherited;

  Self.DriverName := 'MSSQL';
  Self.VendorLib := 'sqlncli10.dll';
  Self.LibraryName := 'dbxmss.dll';
  Self.GetDriverFunc := 'getSQLDriverMSSQL';
end;

class function TAqDBXMSSQLConnection.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := TAqDBXMSSQLAdapter;
end;

function TAqDBXMSSQLConnection.GetPropertyValueAsString(const pIndex: Int32): string;
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

procedure TAqDBXMSSQLConnection.SetPropertyValueAsString(const pIndex: Int32; const pValue: string);
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

{ TAqDBXMSSQLAdapter }

class function TAqDBXMSSQLAdapter.GetDefaultSolver: TAqDBSQLSolverClass;
begin
  Result := TAqDBMSSQLSQLSolver;
end;

end.
