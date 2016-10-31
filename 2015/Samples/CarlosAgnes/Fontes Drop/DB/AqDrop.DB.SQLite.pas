unit AqDrop.DB.SQLite;

interface

uses
  AqDrop.DB.SQL.Intf,
  AqDrop.DB.Adapter;

type
  TAqDBSQLiteSQLSolver = class(TAqDBSQLSolver)
  strict protected
    function SolveLimit(pSelect: IAqDBSQLSelect): string; override;
    function SolveBooleanConstant(pConstant: IAqDBSQLBooleanConstant): string; override;
  public
    function SolveSelect(pSelect: IAqDBSQLSelect): string; override;
    function GetAutoIncrementQuery(const pGeneratorName: string): string; override;
  end;


implementation

uses
  System.SysUtils,
  AqDrop.Core.Helpers;

{ TAqDBSQLiteSQLSolver }

function TAqDBSQLiteSQLSolver.GetAutoIncrementQuery(const pGeneratorName: string): string;
begin
  Result := 'select last_insert_rowid()';
end;

function TAqDBSQLiteSQLSolver.SolveBooleanConstant(pConstant: IAqDBSQLBooleanConstant): string;
begin
  if pConstant.Value then
  begin
    Result := '1';
  end else begin
    Result := '0';
  end;
end;

function TAqDBSQLiteSQLSolver.SolveLimit(pSelect: IAqDBSQLSelect): string;
begin
  if pSelect.IsLimitDefined then
  begin
    Result := ' limit ' + pSelect.Limit.ToString;
  end else begin
    Result := '';
  end;
end;

function TAqDBSQLiteSQLSolver.SolveSelect(pSelect: IAqDBSQLSelect): string;
begin
  Result := inherited + SolveLimit(pSelect);
end;

end.
