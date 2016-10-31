unit AqDrop.DB.Ora;

interface

uses
  AqDrop.DB.SQL.Intf,
  AqDrop.DB.Adapter;

type
  TAqDBOraSQLSolver = class(TAqDBSQLSolver)
  strict protected
    function SolveLimit(pSelect: IAqDBSQLSelect): string; override;
    function SolveBooleanConstant(pConstant: IAqDBSQLBooleanConstant): string; override;
    function SolveSelectBody(pSelect: IAqDBSQLSelect): string; override;
  public
    function SolveGeneratorName(const pTableName: string): string; override;
    function GetAutoIncrementQuery(const pGeneratorName: string): string; override;
  end;

implementation

uses
  System.SysUtils,
  AqDrop.Core.Helpers;

{ TAqDBOraSQLSolver }

function TAqDBOraSQLSolver.GetAutoIncrementQuery(const pGeneratorName: string): string;
begin
  Result := Format('select %s.nextval from dual', [pGeneratorName]);
end;

function TAqDBOraSQLSolver.SolveBooleanConstant(pConstant: IAqDBSQLBooleanConstant): string;
begin
  if pConstant.Value then
  begin
    Result := '1';
  end else begin
    Result := '0';
  end;

  Result := Result.Quote;
end;

function TAqDBOraSQLSolver.SolveGeneratorName(const pTableName: string): string;
begin
  Result := Format('%s_SEQ', [pTableName]);
end;

function TAqDBOraSQLSolver.SolveLimit(pSelect: IAqDBSQLSelect): string;
begin
  if pSelect.IsLimitDefined then
  begin
    pSelect.CustomizeCondition.AddColumnLessEqualThan('rownum', pSelect.Limit);
  end;

  Result := '';
end;

function TAqDBOraSQLSolver.SolveSelectBody(pSelect: IAqDBSQLSelect): string;
begin
  SolveLimit(pSelect);

  Result := inherited;
end;

end.
