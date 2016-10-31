unit AqDrop.DB.FD.MSSQL;

interface
{$I '..\Core\AqDrop.Core.Defines.Inc'}

uses
{$IFNDEF AQMOBILE}
{$if CompilerVersion >= 26}
  FireDAC.Phys.MSSQL,
{$else}
  uADPhysMSSQL,
{$endif}
{$ENDIF}
  AqDrop.DB.Adapter,
  AqDrop.DB.FD;

type
  TAqFDMSSQLAdapter = class(TAqFDAdapter)
  strict protected
    class function GetDefaultSolver: TAqDBSQLSolverClass; override;
  end;

  TAqFDMSSQLConnection = class(TAqFDCustomConnection)
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
  AqDrop.Core.Exceptions,
  AqDrop.DB.Types,
  AqDrop.DB.MSSQL;

{ TAqFDMSSQLAdapter }

class function TAqFDMSSQLAdapter.GetDefaultSolver: TAqDBSQLSolverClass;
begin
  Result := TAqDBMSSQLSQLSolver;
end;

{ TAqFDMSSQLConnection }

constructor TAqFDMSSQLConnection.Create;
begin
  inherited;

  DriverName := 'MSSQL';
end;

class function TAqFDMSSQLConnection.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := TAqFDMSSQLAdapter;
end;

function TAqFDMSSQLConnection.GetParameterValueByIndex(const pIndex: Int32): string;
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

procedure TAqFDMSSQLConnection.SetParameterValueByIndex(const pIndex: Int32; const pValue: string);
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
