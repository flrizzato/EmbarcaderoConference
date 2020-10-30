unit AqDrop.DB.FD.PG;

{$I '..\Core\AqDrop.Core.Defines.Inc'}

interface

uses
{$IFNDEF AQMOBILE}
{$if CompilerVersion >= 26}
  FireDAC.Phys.PG,
{$else}
  uADPhysPG,
{$endif}
{$ENDIF}
  AqDrop.DB.Adapter,
  AqDrop.DB.FD;

type
  TAqFDPGAdapter = class(TAqFDAdapter)
  strict protected
    class function GetDefaultSolver: TAqDBSQLSolverClass; override;

    function GetAutoIncrementType: TAqDBAutoIncrementType; override;
  end;

  TAqFDPGConnection = class(TAqFDCustomConnection)
  strict protected
    function GetParameterValueByIndex(const pIndex: Int32): string; override;
    procedure SetParameterValueByIndex(const pIndex: Int32; const pValue: string); override;
    class function GetDefaultAdapter: TAqDBAdapterClass; override;
  public
    constructor Create; override;

    property Server: string index $80 read GetParameterValueByIndex write SetParameterValueByIndex;
    property DataBase: string index $81 read GetParameterValueByIndex write SetParameterValueByIndex;
    property UserName: string index $82 read GetParameterValueByIndex write SetParameterValueByIndex;
    property Password: string index $83 read GetParameterValueByIndex write SetParameterValueByIndex;
  end;


implementation

{ TAqFDPGAdapter }

uses
  AqDrop.DB.PG;

function TAqFDPGAdapter.GetAutoIncrementType: TAqDBAutoIncrementType;
begin
  Result := TAqDBAutoIncrementType.aiGenerator;
end;

class function TAqFDPGAdapter.GetDefaultSolver: TAqDBSQLSolverClass;
begin
  Result := TAqDBPGSQLSolver;
end;

{ TAqFDPGConnection }

constructor TAqFDPGConnection.Create;
begin
  inherited;

  DriverName := 'PG';
end;

class function TAqFDPGConnection.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := TAqFDPGAdapter;
end;

function TAqFDPGConnection.GetParameterValueByIndex(const pIndex: Int32): string;
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

procedure TAqFDPGConnection.SetParameterValueByIndex(const pIndex: Int32; const pValue: string);
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
