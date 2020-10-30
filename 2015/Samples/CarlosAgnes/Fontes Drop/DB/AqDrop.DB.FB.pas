unit AqDrop.DB.FB;

interface

uses
  AqDrop.DB.Adapter,
  AqDrop.DB.SQL.Intf;

type
  TAqDBFBSQLSolver = class(TAqDBSQLSolver)
  strict protected
    function SolveLimit(pSelect: IAqDBSQLSelect): string; override;
    function SolveBooleanConstant(pConstant: IAqDBSQLBooleanConstant): string; override;
  public
    function SolveSelect(pSelect: IAqDBSQLSelect): string; override;
    function SolveGeneratorName(const pTableName: string): string; override;
    function GetAutoIncrementQuery(const pGeneratorName: string): string; override;
  end;

implementation

uses
  System.SysUtils,
  AqDrop.Core.Helpers;

{ TAqDBFBSQLSolver }

function TAqDBFBSQLSolver.GetAutoIncrementQuery(const pGeneratorName: string): string;
begin
  Result := Format('select GEN_ID(%s, 1) from RDB$DATABASE', [pGeneratorName]);
end;

function TAqDBFBSQLSolver.SolveBooleanConstant(pConstant: IAqDBSQLBooleanConstant): string;
begin
  if pConstant.Value then
  begin
    Result := '1';
  end else begin
    Result := '0';
  end;

  Result := Result.Quote;
end;

function TAqDBFBSQLSolver.SolveGeneratorName(const pTableName: string): string;
begin
  Result := Format('GEN_%s_ID', [pTableName]);
end;

function TAqDBFBSQLSolver.SolveLimit(pSelect: IAqDBSQLSelect): string;
begin
  if pSelect.IsLimitDefined then
  begin
    Result := 'first ' + pSelect.Limit.ToString + ' ';
  end else begin
    Result := '';
  end;
end;

function TAqDBFBSQLSolver.SolveSelect(pSelect: IAqDBSQLSelect): string;
begin
  Result := 'select ' + SolveLimit(pSelect) + SolveSelectBody(pSelect);
end;

end.
