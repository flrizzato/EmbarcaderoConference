unit AqDrop.DB.FD.FB;

interface

uses
  Data.DB,
{$if CompilerVersion >= 26}
  FireDAC.Phys.FB,
{$else}
  uADPhysIB,
{$endif}
  AqDrop.DB.Adapter,
  AqDrop.DB.FB,
  AqDrop.DB.FD,
  AqDrop.DB.FD.TypeMapping;

type
  TAqFDFBDataConverter = class(TAqFDDataConverter)
  public
    procedure BooleanToParam(const pParameter: TAqFDMappedParam; const pValue: Boolean); override;
  end;

  TAqFDFBAdapter = class(TAqFDAdapter)
  strict protected
    function GetAutoIncrementType: TAqDBAutoIncrementType; override;
    class function GetDefaultSolver: TAqDBSQLSolverClass; override;
    class function GetDefaultDataConverter: TAqFDDataConverterClass; override;
  end;

  TAqFDFBConnection = class(TAqFDCustomConnection)
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
  AqDrop.DB.Types;

{ TAqFDFBDataConverter }

procedure TAqFDFBDataConverter.BooleanToParam(const pParameter: TAqFDMappedParam; const pValue: Boolean);
begin
  if pValue then
  begin
    pParameter.AsString := '1';
  end else begin
    pParameter.AsString := '0';
  end;
end;

{ TAqFDFBAdapter }

function TAqFDFBAdapter.GetAutoIncrementType: TAqDBAutoIncrementType;
begin
  Result := TAqDBAutoIncrementType.aiGenerator;
end;

class function TAqFDFBAdapter.GetDefaultDataConverter: TAqFDDataConverterClass;
begin
  Result := TAqFDFBDataConverter;
end;

class function TAqFDFBAdapter.GetDefaultSolver: TAqDBSQLSolverClass;
begin
  Result := TAqDBFBSQLSolver;
end;

{ TAqFDFBConnection }

constructor TAqFDFBConnection.Create;
begin
  inherited;

{$if CompilerVersion >= 26}
  DriverName := 'FB';
{$else}
  DriverName := 'IB';
{$endif}
end;

class function TAqFDFBConnection.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := TAqFDFBAdapter;
end;

function TAqFDFBConnection.GetParameterValueByIndex(const pIndex: Int32): string;
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

procedure TAqFDFBConnection.SetParameterValueByIndex(const pIndex: Int32; const pValue: string);
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

end.
