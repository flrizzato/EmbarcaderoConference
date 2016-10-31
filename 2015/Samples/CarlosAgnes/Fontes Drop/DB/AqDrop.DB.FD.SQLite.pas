unit AqDrop.DB.FD.SQLite;

interface

uses
  Data.DB,
{$if CompilerVersion >= 26}
  FireDAC.Phys.SQLite,
{$else}
  uADPhysSQLite,
{$endif}
  AqDrop.DB.Adapter,
  AqDrop.DB.SQLite,
  AqDrop.DB.FD,
  AqDrop.DB.FD.TypeMapping;

type
  TAqFDSQLiteDataConverter = class(TAqFDDataConverter)
  public
    procedure DateTimeToParam(const pParameter: TAqFDMappedParam; const pValue: TDateTime); override;
    procedure DateToParam(const pParameter: TAqFDMappedParam; const pValue: TDate); override;
    procedure TimeToParam(const pParameter: TAqFDMappedParam; const pValue: TTime); override;
    function FieldToDate(const pField: TField): TDate; override;
    function FieldToDateTime(const pField: TField): TDateTime; override;
    function FieldToTime(const pField: TField): TTime; override;

{$if CompilerVersion = 25}
    procedure StringToParam(const pParameter: TAqFDMappedParam; const pValue: string); override;
{$endif}
  end;

  TAqFDSQLiteAdapter = class(TAqFDAdapter)
  strict protected
    class function GetDefaultSolver: TAqDBSQLSolverClass; override;
    class function GetDefaultDataConverter: TAqFDDataConverterClass; override;
  end;

  TAqFDSQLiteOpenMode = (somCreateUTF8, somCreateUTF16, somReadWrite, somReadOnly);

  TAqFDSQLiteConnection = class(TAqFDCustomConnection)
  strict private const
    OPEN_MODE_VALUES: array[TAqFDSQLiteOpenMode] of string = (
      'CreateUTF8',
      'CreateUTF16',
      'ReadWrite',
      'ReadOnly');
  strict private
    FOpenMode: TAqFDSQLiteOpenMode;

    procedure SetOpenMode(const pOpenMode: TAqFDSQLiteOpenMode);
  strict protected
    function GetParameterValueByIndex(const pIndex: Int32): string; override;
    procedure SetParameterValueByIndex(const pIndex: Int32; const pValue: string); override;

    class function GetDefaultAdapter: TAqDBAdapterClass; override;
  public
    constructor Create; override;

    property DataBase: string index $80 read GetParameterValueByIndex write SetParameterValueByIndex;
    property OpenMode: TAqFDSQLiteOpenMode read FOpenMode write SetOpenMode;
  end;

implementation

uses
{$if CompilerVersion >= 26}
  FireDAC.Stan.Param,
{$endif}
  AqDrop.Core.Helpers;

{ TAqFDSQLiteAdapter }

class function TAqFDSQLiteAdapter.GetDefaultDataConverter: TAqFDDataConverterClass;
begin
  Result := TAqFDSQLiteDataConverter;
end;

class function TAqFDSQLiteAdapter.GetDefaultSolver: TAqDBSQLSolverClass;
begin
  Result := TAqDBSQLiteSQLSolver;
end;

{ TAqFDSQLiteConnection }

constructor TAqFDSQLiteConnection.Create;
begin
  inherited;

  DriverName := 'SQLite';
end;

class function TAqFDSQLiteConnection.GetDefaultAdapter: TAqDBAdapterClass;
begin
  Result := TAqFDSQLiteAdapter;
end;

function TAqFDSQLiteConnection.GetParameterValueByIndex(const pIndex: Int32): string;
begin
  case pIndex of
    $80:
      Result := Params.Values['Database'];
  else
    Result := inherited;
  end;
end;

procedure TAqFDSQLiteConnection.SetOpenMode(const pOpenMode: TAqFDSQLiteOpenMode);
begin
  FOpenMode := pOpenMode;
  Params.Values['OpenMode'] := OPEN_MODE_VALUES[FOpenMode];
end;

procedure TAqFDSQLiteConnection.SetParameterValueByIndex(const pIndex: Int32; const pValue: string);
begin
  case pIndex of
    $80:
      Params.Values['Database'] := pValue;
  else
    inherited;
  end;
end;

{ TAqFDSQLiteDataConverter }

procedure TAqFDSQLiteDataConverter.DateTimeToParam(const pParameter: TAqFDMappedParam; const pValue: TDateTime);
begin
  pParameter.AsFloat := pValue;
end;

procedure TAqFDSQLiteDataConverter.DateToParam(const pParameter: TAqFDMappedParam; const pValue: TDate);
begin
  pParameter.AsFloat := pValue.DateOf;
end;

function TAqFDSQLiteDataConverter.FieldToDate(const pField: TField): TDate;
begin
  Result := pField.AsFloat.Trunc;
end;

function TAqFDSQLiteDataConverter.FieldToDateTime(const pField: TField): TDateTime;
begin
  Result := pField.AsFloat;
end;

function TAqFDSQLiteDataConverter.FieldToTime(const pField: TField): TTime;
begin
  Result := pField.AsFloat.Frac;
end;

{$if CompilerVersion = 25}
procedure TAqFDSQLiteDataConverter.StringToParam(const pParameter: TAqFDMappedParam; const pValue: string);
begin
  pParameter.AsString := pValue;
end;
{$endif}

procedure TAqFDSQLiteDataConverter.TimeToParam(const pParameter: TAqFDMappedParam; const pValue: TTime);
begin
  pParameter.AsFloat := pValue.TimeOf;
end;

end.
