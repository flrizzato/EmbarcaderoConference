unit AqDrop.DB.FD.Ora;

{$I '..\Core\AqDrop.Core.Defines.Inc'}

interface

uses
{$IFNDEF AQMOBILE}
{$if CompilerVersion >= 26}
  FireDAC.Phys.Oracle,
{$else}
  uADPhysOracle,
{$endif}
{$ENDIF}
  AqDrop.DB.Adapter,
  AqDrop.DB.FD,
  AqDrop.DB.FD.TypeMapping;

type
  TAqFDOraDataConverter = class(TAqFDDataConverter)
  public
    procedure BooleanToParam(const pParameter: TAqFDMappedParam; const pValue: Boolean); override;
  end;

  TAqFDOraAdapter = class(TAqFDAdapter)
  strict protected
    class function GetDefaultSolver: TAqDBSQLSolverClass; override;
    class function GetDefaultDataConverter: TAqFDDataConverterClass; override;
    function GetAutoIncrementType: TAqDBAutoIncrementType; override;
  end;

  TAqFDOraConnection = class(TAqFDCustomConnection)
  strict protected
    function GetParameterValueByIndex(const pIndex: Int32): string; override;
    procedure SetParameterValueByIndex(const pIndex: Int32; const pValue: string); override;

    class function GetDefaultAdapter: TAqDBAdapterClass; override;
  public
    constructor Create; override;

    property DataBase: string index $80 read GetParameterValueByIndex write SetParameterValueByIndex;
    property UserName: string index $81 read GetParameterValueByIndex write SetParameterValueByIndex;
    property Password: string index $82 read GetParameterValueByIndex write SetParameterValueByIndex;
  end;

implementation

uses
{$if CompilerVersion >= 26}
  FireDAC.Stan.Param,
{$endif}
  AqDrop.Core.Exceptions,
  AqDrop.DB.Types,
  AqDrop.DB.Ora;

{ TAqFDOraConnection }

constructor TAqFDOraConnection.Create;
begin
  inherited;

  DriverName := 'Ora';
  Params.Values['CharacterSet'] := 'UTF8';
end;

class function TAqFDOraConnection.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := TAqFDOraAdapter;
end;

function TAqFDOraConnection.GetParameterValueByIndex(const pIndex: Int32): string;
begin
  case pIndex of
    $80:
      Result := Params.Values['Database'];
    $81:
      Result := Params.Values['User_Name'];
    $82:
      Result := Params.Values['Password'];
  else
    Result := inherited;
  end;
end;

procedure TAqFDOraConnection.SetParameterValueByIndex(const pIndex: Int32; const pValue: string);
begin
  case pIndex of
    $80:
      Params.Values['Database'] := pValue;
    $81:
      Params.Values['User_Name'] := pValue;
    $82:
      Params.Values['Password'] := pValue;
  else
    inherited;
  end;
end;

{ TAqFDOraDataConverter }

procedure TAqFDOraDataConverter.BooleanToParam(const pParameter: TAqFDMappedParam; const pValue: Boolean);
begin
  if pValue then
  begin
    pParameter.AsString := '1';
  end else begin
    pParameter.AsString := '0';
  end;
end;

{ TAqFDOraAdapter }

function TAqFDOraAdapter.GetAutoIncrementType: TAqDBAutoIncrementType;
begin
  Result := TAqDBAutoIncrementType.aiGenerator;
end;

class function TAqFDOraAdapter.GetDefaultDataConverter: TAqFDDataConverterClass;
begin
  Result := TAqFDOraDataConverter;
end;

class function TAqFDOraAdapter.GetDefaultSolver: TAqDBSQLSolverClass;
begin
  Result := TAqDBOraSQLSolver;
end;

end.
