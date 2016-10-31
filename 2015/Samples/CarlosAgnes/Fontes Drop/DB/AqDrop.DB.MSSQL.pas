unit AqDrop.DB.MSSQL;

interface

uses
  AqDrop.DB.Adapter,
  AqDrop.DB.SQL.Intf;

type
  TAqDBMSSQLSQLSolver = class(TAqDBSQLSolver)
  strict protected
    function SolveLimit(pSelect: IAqDBSQLSelect): string; override;
  public
    function SolveSelect(pSelect: IAqDBSQLSelect): string; override;
    function GetAutoIncrementQuery(const pGeneratorName: string): string; override;
  end;

implementation

uses
  System.SysUtils,
  AqDrop.Core.Helpers;

{ TAqDBMSSQLSQLSolver }

function TAqDBMSSQLSQLSolver.GetAutoIncrementQuery(const pGeneratorName: string): string;
begin
  Result := 'select @@identity';
end;

function TAqDBMSSQLSQLSolver.SolveLimit(pSelect: IAqDBSQLSelect): string;
begin
  if pSelect.IsLimitDefined then
  begin
    Result := 'top ' + pSelect.Limit.ToString + ' ';
  end else begin
    Result := '';
  end;
end;

function TAqDBMSSQLSQLSolver.SolveSelect(pSelect: IAqDBSQLSelect): string;
begin
  Result := 'select ' + SolveLimit(pSelect) + SolveSelectBody(pSelect);
end;

end.
