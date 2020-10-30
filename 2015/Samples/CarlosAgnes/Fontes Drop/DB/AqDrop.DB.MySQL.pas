unit AqDrop.DB.MySQL;

interface

uses
  AqDrop.DB.Adapter,
  AqDrop.DB.SQL.Intf;

type
  TAqDBMySQLSQLSolver = class(TAqDBSQLSolver)
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

{ TAqDBMySQLSQLSolver }

function TAqDBMySQLSQLSolver.GetAutoIncrementQuery(const pGeneratorName: string): string;
begin
  Result := 'select last_insert_id()';
end;

function TAqDBMySQLSQLSolver.SolveBooleanConstant(pConstant: IAqDBSQLBooleanConstant): string;
begin
  if pConstant.Value then
  begin
    Result := 'True';
  end else begin
    Result := 'False';
  end;
end;

function TAqDBMySQLSQLSolver.SolveLimit(pSelect: IAqDBSQLSelect): string;
begin
  if pSelect.IsLimitDefined then
  begin
    Result := ' limit ' + pSelect.Limit.ToString;
  end else begin
    Result := '';
  end;
end;

function TAqDBMySQLSQLSolver.SolveSelect(pSelect: IAqDBSQLSelect): string;
begin
  Result := inherited + SolveLimit(pSelect);
end;

end.
