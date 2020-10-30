unit AqDrop.DB.FD.MySQL;

{$I '..\Core\AqDrop.Core.Defines.Inc'}

interface

uses
{$IFNDEF AQMOBILE}
{$if CompilerVersion >= 26}
  FireDAC.Phys.MySQL,
{$else}
  uADPhysMySQL,
{$endif}
{$ENDIF}
  AqDrop.DB.Adapter,
  AqDrop.DB.FD,
  AqDrop.DB.FD.TypeMapping;

type
  TAqFDMySQLDataConverter = class(TAqFDDataConverter)
  public
    procedure BooleanToParam(const pParameter: TAqFDMappedParam; const pValue: Boolean); override;
  end;

  TAqFDMySQLAdapter = class(TAqFDAdapter)
  strict protected
    class function GetDefaultDataConverter: TAqFDDataConverterClass; override;
    class function GetDefaultSolver: TAqDBSQLSolverClass; override;
  end;

  TAqFDMySQLConnection = class(TAqFDCustomConnection)
  strict protected
    function GetParameterValueByIndex(const pIndex: Int32): string; override;
    procedure SetParameterValueByIndex(const pIndex: Int32; const pValue: string); override;
    class function GetDefaultAdapter: TAqDBAdapterClass; override;
  public
    constructor Create; override;

    property HostName: string index $80 read GetParameterValueByIndex write SetParameterValueByIndex;
    property DataBase: string index $81 read GetParameterValueByIndex write SetParameterValueByIndex;
    property UserName: string index $82 read GetParameterValueByIndex write SetParameterValueByIndex;
    property Password: string index $83 read GetParameterValueByIndex write SetParameterValueByIndex;
  end;

implementation

uses
{$if CompilerVersion >= 26}
  FireDAC.Stan.Param,
{$endif}
  AqDrop.Core.Exceptions,
  AqDrop.Core.Helpers,
  AqDrop.DB.Types,
  AqDrop.DB.MySQL;

{ TAqFDMySQLDataConverter }

procedure TAqFDMySQLDataConverter.BooleanToParam(const pParameter: TAqFDMappedParam; const pValue: Boolean);
begin
  pParameter.AsInteger := pValue.ToInt8;
end;

{ TAqFDMySQLAdapter }

class function TAqFDMySQLAdapter.GetDefaultDataConverter: TAqFDDataConverterClass;
begin
  Result := TAqFDMySQLDataConverter;
end;

class function TAqFDMySQLAdapter.GetDefaultSolver: TAqDBSQLSolverClass;
begin
  Result := TAqDBMySQLSQLSolver;
end;

{ TAqFDMySQLConnection }

constructor TAqFDMySQLConnection.Create;
begin
  inherited;

  DriverName := 'MySQL';
end;

class function TAqFDMySQLConnection.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := TAqFDMySQLAdapter;
end;

function TAqFDMySQLConnection.GetParameterValueByIndex(const pIndex: Int32): string;
begin
  case pIndex of
    $80:
      Result := Params.Values['Server'];
    $81:
      Result := Params.Values['Database'];
    $82:
      Result := Params.Values['User_Name'];
    $83:
      Result := Params.Values['Password'];
  else
    Result := inherited;
  end;
end;

procedure TAqFDMySQLConnection.SetParameterValueByIndex(const pIndex: Int32; const pValue: string);
begin
  case pIndex of
    $80:
      Params.Values['Server'] := pValue;
    $81:
      Params.Values['Database'] := pValue;
    $82:
      Params.Values['User_Name'] := pValue;
    $83:
      Params.Values['Password'] := pValue;
  else
    inherited;
  end;
end;

end.
