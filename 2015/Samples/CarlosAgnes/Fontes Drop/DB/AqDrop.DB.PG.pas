unit AqDrop.DB.PG;

interface

uses
  AqDrop.DB.Adapter,
  AqDrop.DB.SQL.Intf;

type
  TAqDBPGSQLSolver = class(TAqDBSQLSolver)
  strict protected
    function SolveLimit(pSelect: IAqDBSQLSelect): string; override;
    function SolveBooleanConstant(pConstant: IAqDBSQLBooleanConstant): string; override;
  public
    function SolveSelect(pSelect: IAqDBSQLSelect): string; override;
    function SolveGeneratorName(const pTableName: string): string; override;
    function GetAutoIncrementQuery(const pGeneratorName: string): string; override;
  end;


implementation

{ TAqDBPGSQLSolver }

uses
  System.SysUtils,
  AqDrop.Core.Helpers;

function TAqDBPGSQLSolver.GetAutoIncrementQuery(const pGeneratorName: string): string;
begin
  Result := Format('select nextval(''%s'')', [pGeneratorName]);
end;

function TAqDBPGSQLSolver.SolveBooleanConstant(pConstant: IAqDBSQLBooleanConstant): string;
begin
  if pConstant.Value then
  begin
    Result := 'true';
  end else begin
    Result := 'false';
  end;
end;

function TAqDBPGSQLSolver.SolveGeneratorName(const pTableName: string): string;
begin
  Result := Format('%s_ID_SEQ', [pTableName]);
end;

function TAqDBPGSQLSolver.SolveLimit(pSelect: IAqDBSQLSelect): string;
begin
  if pSelect.IsLimitDefined then
  begin
    Result := ' limit ' + pSelect.Limit.ToString;
  end else begin
    Result := '';
  end;
end;

function TAqDBPGSQLSolver.SolveSelect(pSelect: IAqDBSQLSelect): string;
begin
  Result := inherited + SolveLimit(pSelect);
end;

end.
