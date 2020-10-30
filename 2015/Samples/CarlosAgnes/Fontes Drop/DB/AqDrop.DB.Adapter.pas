unit AqDrop.DB.Adapter;

interface

uses
  AqDrop.Core.Collections.Intf,
  AqDrop.DB.SQL.Intf,
  AqDrop.DB.SQL;

type
  TAqDBAutoIncrementType = (aiAutoIncrement, aiGenerator);

  TAqDBSQLSolver = class
  strict protected
    function SolveOperator(const pOperator: TAqDBSQLOperator): string; virtual;
    function SolveDisambiguation(pColumn: IAqDBSQLColumn): string; virtual;
    function SolveAlias(pAliasable: IAqDBSQLAliasable; const pQuoteAlias: Boolean): string; virtual;
    function SolveAggregator(pValue: IAqDBSQLValue): string; virtual;
    function SolveValue(pValue: IAqDBSQLValue; const pUseAlias: Boolean): string; virtual;
    function SolveValueType(pValue: IAqDBSQLValue): string; virtual;
    function SolveColumn(pColumn: IAqDBSQLColumn): string; virtual;
    function SolveOperation(pOperation: IAqDBSQLOperation): string; virtual;
    function SolveSubselectValue(pColumn: IAqDBSQLSubselect): string; virtual;
    function SolveConstant(pConstant: IAqDBSQLConstant): string; virtual;
    function SolveParameter(pParameter: IAqDBSQLParameter): string; virtual;
    function SolveTextConstant(pConstant: IAqDBSQLTextConstant): string; virtual;
    function SolveIntConstant(pConstant: IAqDBSQLIntConstant): string; virtual;
    function SolveUIntConstant(pConstant: IAqDBSQLUIntConstant): string; virtual;
    function SolveDoubleConstant(pConstant: IAqDBSQLDoubleConstant): string; virtual;
    function SolveCurrencyConstant(pConstant: IAqDBSQLCurrencyConstant): string; virtual;
    function SolveDateTimeConstant(pConstant: IAqDBSQLDateTimeConstant): string; virtual;
    function SolveDateConstant(pConstant: IAqDBSQLDateConstant): string; virtual;
    function SolveTimeConstant(pConstant: IAqDBSQLTimeConstant): string; virtual;
    function SolveBooleanConstant(pConstant: IAqDBSQLBooleanConstant): string; virtual;
    function SolveColumns(pColumnsList: IAqReadList<IAqDBSQLValue>): string; virtual;
    function SolveSource(pSource: IAqDBSQLSource): string; virtual;
    function SolveFrom(pSource: IAqDBSQLSource): string; virtual;
    function SolveTable(pTable: IAqDBSQLTable): string; virtual;
    function SolveSubselect(pSelect: IAqDBSQLSelect): string; virtual;
    function SolveSelectBody(pSelect: IAqDBSQLSelect): string; virtual;
    function SolveJoins(pSelect: IAqDBSQLSelect): string; virtual;
    function SolveJoin(pJoin: IAqDBSQLJoin): string; virtual;
    function SolveCondition(pCondition: IAqDBSQLCondition): string; virtual;
    function SolveOrderBy(pSelect: IAqDBSQLSelect): string; virtual;
    function SolveOrderByDesc(const pDesc: Boolean): string; virtual;
    function SolveLimit(pSelect: IAqDBSQLSelect): string; virtual;
    function SolveComparisonCondition(pComparisonCondition: IAqDBSQLComparisonCondition): string; virtual;
    function SolveValueIsNullCondition(pValueIsNullCondition: IAqDBSQLValueIsNullCondition): string; virtual;
    function SolveComposedCondition(pComposedCondition: IAqDBSQLComposedCondition): string; virtual;
    function SolveBetweenCondition(pBetweenCondition: IAqDBSQLBetweenCondition): string; virtual;
    function SolveComparison(const pComparison: TAqDBSQLComparison): string; virtual;
    function SolveBooleanOperator(const pBooleanOperator: TAqDBSQLBooleanOperator): string; virtual;
  public
    function SolveSelect(pSelect: IAqDBSQLSelect): string; virtual;
    function SolveInsert(pInsert: IAqDBSQLInsert): string; virtual;
    function SolveUpdate(pUpdate: IAqDBSQLUpdate): string; virtual;
    function SolveDelete(pDelete: IAqDBSQLDelete): string; virtual;
    function SolveCommand(pCommand: IAqDBSQLCommand): string; virtual;

    function SolveGeneratorName(const pTableName: string): string; virtual;

    function GetAutoIncrementQuery(const pGeneratorName: string): string; virtual;
  end;

  TAqDBSQLSolverClass = class of TAqDBSQLSolver;

  TAqDBAdapter = class
  strict private
    FSQLSolver: TAqDBSQLSolver;

    procedure SetSQLSolver(const Value: TAqDBSQLSolver);
  strict protected
    function GetAutoIncrementType: TAqDBAutoIncrementType; virtual;

    function CreateSolver: TAqDBSQLSolver; virtual;
    class function GetDefaultSolver: TAqDBSQLSolverClass; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    property SQLSolver: TAqDBSQLSolver read FSQLSolver write SetSQLSolver;
    property AutoIncrementType: TAqDBAutoIncrementType read GetAutoIncrementType;
  end;


  TAqDBAdapterClass = class of TAqDBAdapter;


implementation

uses
  System.SysUtils,
  System.Classes,
  AqDrop.Core.Exceptions,
  AqDrop.Core.Helpers;

{ TAqDBSQLSolver }

function TAqDBSQLSolver.SolveGeneratorName(const pTableName: string): string;
begin
  raise EAqInternal.Create('Function not implemented to this DB.');
end;

function TAqDBSQLSolver.GetAutoIncrementQuery(const pGeneratorName: string): string;
begin
  Result := '';
end;

function TAqDBSQLSolver.SolveAggregator(pValue: IAqDBSQLValue): string;
var
  lAggregatorMask: string;
begin
  case pValue.Aggregator of
    TAqDBSQLAggregatorType.atNone:
      lAggregatorMask := '%s';
    TAqDBSQLAggregatorType.atCount:
      lAggregatorMask := 'count(%s)';
    TAqDBSQLAggregatorType.atSum:
      lAggregatorMask := 'sum(%s)';
    TAqDBSQLAggregatorType.atAvg:
      lAggregatorMask := 'avg(%s)';
    TAqDBSQLAggregatorType.atMax:
      lAggregatorMask := 'max(%s)';
    TAqDBSQLAggregatorType.atMin:
      lAggregatorMask := 'min(%s)';
  else
    raise EAqInternal.Create('Aggragator not expected.');
  end;

  Result := Format(lAggregatorMask, [SolveValueType(pValue)]);
end;

function TAqDBSQLSolver.SolveAlias(pAliasable: IAqDBSQLAliasable; const pQuoteAlias: Boolean): string;
begin
  if pAliasable.IsAliasDefined then
  begin
    Result := pAliasable.Alias;

    if pQuoteAlias then
    begin
      Result := '"' + Result + '"';
    end;
  end else begin
    Result := '';
  end;
end;

function TAqDBSQLSolver.SolveBetweenCondition(pBetweenCondition: IAqDBSQLBetweenCondition): string;
begin
  Result := SolveValue(pBetweenCondition.Value, False) + ' between ' +
    SolveValue(pBetweenCondition.RangeBegin, False) + ' and ' + SolveValue(pBetweenCondition.RangeEnd, False);
end;

function TAqDBSQLSolver.SolveBooleanConstant(pConstant: IAqDBSQLBooleanConstant): string;
begin
  if pConstant.Value then
  begin
    Result := 'True'.Quote;
  end else begin
    Result := 'False'.Quote;
  end;
end;

function TAqDBSQLSolver.SolveBooleanOperator(const pBooleanOperator: TAqDBSQLBooleanOperator): string;
begin
  case pBooleanOperator of
    TAqDBSQLBooleanOperator.boAnd:
      Result := 'and';
    TAqDBSQLBooleanOperator.boOr:
      Result := 'or';
    TAqDBSQLBooleanOperator.boXor:
      Result := 'xor';
  else
    raise EAqInternal.Create('Unexpected Boolean Operator.');
  end;
end;

function TAqDBSQLSolver.SolveValue(pValue: IAqDBSQLValue; const pUseAlias: Boolean): string;
begin
  Result := SolveAggregator(pValue);

  if pUseAlias and pValue.IsAliasDefined then
  begin
    Result := Result + ' ' + SolveAlias(pValue, True);
  end;
end;

function TAqDBSQLSolver.SolveValueIsNullCondition(pValueIsNullCondition: IAqDBSQLValueIsNullCondition): string;
begin
  Result := SolveValue(pValueIsNullCondition.Value, False) + ' is null';
end;

function TAqDBSQLSolver.SolveOperation(pOperation: IAqDBSQLOperation): string;
begin
  Result := '(' + SolveValue(pOperation.LeftOperand, False) + ' ' + SolveOperator(pOperation.Operator) + ' ' +
    SolveValue(pOperation.RightOperand, False) + ')';
end;

function TAqDBSQLSolver.SolveColumn(pColumn: IAqDBSQLColumn): string;
begin
  Result := SolveDisambiguation(pColumn) + pColumn.Expression;
end;

function TAqDBSQLSolver.SolveColumns(pColumnsList: IAqReadList<IAqDBSQLValue>): string;
var
  lColumn: IAqDBSQLValue;
  lColumnsText: TStringList;
begin
  lColumnsText := TStringList.Create;

  try
    if pColumnsList.Count = 0 then
    begin
      lColumnsText.Add('*');
    end else begin
      for lColumn in pColumnsList do
      begin
        lColumnsText.Add(SolveValue(lColumn, True));
      end;
    end;

    lColumnsText.StrictDelimiter := True;
    lColumnsText.QuoteChar := #0;
    lColumnsText.Delimiter := ',';
    Result := lColumnsText.DelimitedText;
  finally
    lColumnsText.Free;
  end;
end;

function TAqDBSQLSolver.SolveSubselectValue(pColumn: IAqDBSQLSubselect): string;
begin
  Result := SolveSubselect(pColumn.Select);
end;

function TAqDBSQLSolver.SolveCommand(pCommand: IAqDBSQLCommand): string;
begin
  case pCommand.CommandType of
    TAqDBSQLCommandType.ctSelect:
      Result := SolveSelect(pCommand.GetAsSelect);
    TAqDBSQLCommandType.ctInsert:
      Result := SolveInsert(pCommand.GetAsInsert);
    TAqDBSQLCommandType.ctUpdate:
      Result := SolveUpdate(pCommand.GetAsUpdate);
    TAqDBSQLCommandType.ctDelete:
      Result := SolveDelete(pCommand.GetAsDelete);
  else
    raise EAqInternal.Create('Command type not supoorted.');
  end;
end;

function TAqDBSQLSolver.SolveComparison(const pComparison: TAqDBSQLComparison): string;
begin
  case pComparison of
    TAqDBSQLComparison.cpEqual:
      Result := '=';
    TAqDBSQLComparison.cpGreaterThan:
      Result := '>';
    TAqDBSQLComparison.cpGreaterEqual:
      Result := '>=';
    TAqDBSQLComparison.cpLessThan:
      Result := '<';
    TAqDBSQLComparison.cpLessEqual:
      Result := '<=';
  else
    raise EAqInternal.Create('Unexpected Comparison Type.');
  end;
end;

function TAqDBSQLSolver.SolveComparisonCondition(pComparisonCondition: IAqDBSQLComparisonCondition): string;
begin
  Result := SolveValue(pComparisonCondition.LeftValue, False) + ' ' +
    SolveComparison(pComparisonCondition.Comparison) + ' ' + SolveValue(pComparisonCondition.RightValue, False);
end;

function TAqDBSQLSolver.SolveComposedCondition(pComposedCondition: IAqDBSQLComposedCondition): string;
var
  lI: Int32;
begin
  if pComposedCondition.Conditions.Count = 0 then
  begin
    Result := '';
  end else begin
    Result := '(' + SolveCondition(pComposedCondition.Conditions.First);

    for lI := 1 to pComposedCondition.Conditions.Count - 1 do
    begin
      Result := Result + ' ' + SolveBooleanOperator(pComposedCondition.LinkOperators[lI - 1]) + ' ' +
        SolveCondition(pComposedCondition.Conditions[lI]);
    end;

    Result := Result + ')';
  end;
end;

function TAqDBSQLSolver.SolveCondition(pCondition: IAqDBSQLCondition): string;
begin
  case pCondition.ConditionType of
    TAqDBSQLConditionType.ctComparison:
      Result := SolveComparisonCondition(pCondition.GetAsComparison);
    TAqDBSQLConditionType.ctValueIsNull:
      Result := SolveValueIsNullCondition(pCondition.GetAsValueIsNull);
    TAqDBSQLConditionType.ctComposed:
      Result := SolveComposedCondition(pCondition.GetAsComposed);
    TAqDBSQLConditionType.ctBetween:
      Result := SolveBetweenCondition(pCondition.GetAsBetween);
  else
    raise EAqInternal.Create('Unexpected condition type.');
  end;
end;

function TAqDBSQLSolver.SolveConstant(pConstant: IAqDBSQLConstant): string;
begin
  case pConstant.ConstantType of
    TAqDBSQLConstantValueType.cvText:
      Result := SolveTextConstant(pConstant.GetAsTextConstant);
    TAqDBSQLConstantValueType.cvInt:
      Result := SolveIntConstant(pConstant.GetAsIntConstant);
    TAqDBSQLConstantValueType.cvDouble:
      Result := SolveDoubleConstant(pConstant.GetAsDoubleConstant);
    TAqDBSQLConstantValueType.cvCurrency:
      Result := SolveCurrencyConstant(pConstant.GetAsCurrencyConstant);
    TAqDBSQLConstantValueType.cvDateTime:
      Result := SolveDateTimeConstant(pConstant.GetAsDateTimeConstant);
    TAqDBSQLConstantValueType.cvDate:
      Result := SolveDateConstant(pConstant.GetAsDateConstant);
    TAqDBSQLConstantValueType.cvTime:
      Result := SolveTimeConstant(pConstant.GetAsTimeConstant);
    TAqDBSQLConstantValueType.cvBoolean:
      Result := SolveBooleanConstant(pConstant.GetAsBooleanConstant);
    TAqDBSQLConstantValueType.cvUInt:
      Result := SolveUIntConstant(pConstant.GetAsUIntConstant);
  else
    raise EAqInternal.Create('Constant type not expected.');
  end;
end;

function TAqDBSQLSolver.SolveCurrencyConstant(pConstant: IAqDBSQLCurrencyConstant): string;
begin
  Result := pConstant.Value.ToString;
end;

function TAqDBSQLSolver.SolveDateConstant(pConstant: IAqDBSQLDateConstant): string;
begin
  Result := pConstant.Value.Format('yyyy.mm.dd').Quote;
end;

function TAqDBSQLSolver.SolveDateTimeConstant(pConstant: IAqDBSQLDateTimeConstant): string;
begin
  Result := pConstant.Value.Format('yyyy.mm.dd hh:mm:ss:zzz').Quote;
end;

function TAqDBSQLSolver.SolveDelete(pDelete: IAqDBSQLDelete): string;
begin
  Result := 'delete from ' + SolveTable(pDelete.Table);

  if pDelete.IsConditionDefined then
  begin
    Result := Result + ' where ' + SolveCondition(pDelete.Condition);
  end;
end;

function TAqDBSQLSolver.SolveDisambiguation(pColumn: IAqDBSQLColumn): string;
begin
  if pColumn.IsSourceDefined then
  begin
    if pColumn.Source.IsAliasDefined then
    begin
      Result := SolveAlias(pColumn.Source, False) + '.';
    end else if pColumn.Source.SourceType = stTable then
    begin
      Result := pColumn.Source.GetAsTable.Name + '.';
    end else begin
      raise EAqInternal.Create('Column source doesn''t have a valid desambiguation.');
    end;
  end else begin
    Result := '';
  end;
end;

function TAqDBSQLSolver.SolveDoubleConstant(pConstant: IAqDBSQLDoubleConstant): string;
begin
  Result := pConstant.Value.ToString;
end;

function TAqDBSQLSolver.SolveFrom(pSource: IAqDBSQLSource): string;
begin
  Result := 'from ' + SolveSource(pSource);
end;

function TAqDBSQLSolver.SolveInsert(pInsert: IAqDBSQLInsert): string;
var
  lColumns: TStringList;
  lValues: TStringList;
  lAssignment: IAqDBSQLAssignment;
begin
  Result := 'insert into ' + SolveTable(pInsert.Table);

  if pInsert.Assignments.Count = 0 then
  begin
    raise EAqInternal.Create('Insert has no assignments.');
  end;

  lColumns := TStringList.Create;

  try
    lValues := TStringList.Create;

    try
      for lAssignment in pInsert.Assignments do
      begin
        lColumns.Add(SolveColumn(lAssignment.Column));
        lValues.Add(SolveValue(lAssignment.Value, False));
      end;

      lColumns.StrictDelimiter := True;
      lColumns.Delimiter := ',';
      lValues.StrictDelimiter := True;
      lValues.Delimiter := ',';

      Result := Result + ' (' + lColumns.DelimitedText + ') values (' + lValues.DelimitedText + ')';
    finally
      lValues.Free;
    end;
  finally
    lColumns.Free;
  end;
end;

function TAqDBSQLSolver.SolveIntConstant(pConstant: IAqDBSQLIntConstant): string;
begin
  Result := pConstant.Value.ToString;
end;

function TAqDBSQLSolver.SolveJoin(pJoin: IAqDBSQLJoin): string;
begin
  case pJoin.JoinType of
    TAqDBSQLJoinType.jtInnerJoin:
      Result := 'inner join ';
    TAqDBSQLJoinType.jtLeftJoin:
      Result := 'left join ';
  else
    raise EAqInternal.Create('Unexpected Join Type.');
  end;

  Result := Result + SolveSource(pJoin.Source) + ' on ' + SolveCondition(pJoin.Condition);
end;

function TAqDBSQLSolver.SolveJoins(pSelect: IAqDBSQLSelect): string;
var
  lJoin: IAqDBSQLJoin;
begin
  Result := '';

  if pSelect.HasJoins then
  begin
    for lJoin in pSelect.Joins do
    begin
      Result := Result + SolveJoin(lJoin) + ' ';
    end;

    Result := ' ' + Result.Trim;
  end;
end;

function TAqDBSQLSolver.SolveLimit(pSelect: IAqDBSQLSelect): string;
begin
  Result := '';
end;

function TAqDBSQLSolver.SolveOperator(const pOperator: TAqDBSQLOperator): string;
begin
  case pOperator of
    TAqDBSQLOperator.opSum:
      Result := '+';
    TAqDBSQLOperator.opSubtraction:
      Result := '-';
    TAqDBSQLOperator.opMultiplication:
      Result := '*';
    TAqDBSQLOperator.opDivision:
      Result := '/';
  else
    raise EAqInternal.Create('Operator not expected.');
  end;
end;

function TAqDBSQLSolver.SolveOrderBy(pSelect: IAqDBSQLSelect): string;
var
  lValues: TStringList;
  lItem: IAqDBSQLOrderByItem;
begin
  if pSelect.IsOrderByDefined then
  begin
    lValues := TStringList.Create;

    try
      for lItem in pSelect.OrderBy do
      begin
        lValues.Add(SolveValue(lItem.Value, False) + SolveOrderByDesc(lItem.Desc));
      end;

      lValues.StrictDelimiter := True;
      lValues.Delimiter := ',';

      Result := ' order by ' + lValues.DelimitedText;
    finally
      lValues.Free;
    end;
  end;
end;

function TAqDBSQLSolver.SolveOrderByDesc(const pDesc: Boolean): string;
begin
  if pDesc then
  begin
    Result := ' desc';
  end else begin
    Result := '';
  end;
end;

function TAqDBSQLSolver.SolveParameter(pParameter: IAqDBSQLParameter): string;
begin
  Result := ':' + pParameter.Name;
end;

function TAqDBSQLSolver.SolveSource(pSource: IAqDBSQLSource): string;
begin
  case pSource.SourceType of
    stTable:
      Result := SolveTable(pSource.GetAsTable);
    stSelect:
      Result := SolveSubselect(pSource.GetAsSelect);
  else
    raise EAqInternal.Create('Unexpectes source type.');
  end;
end;

function TAqDBSQLSolver.SolveSelect(pSelect: IAqDBSQLSelect): string;
begin
  Result := 'select ' + SolveSelectBody(pSelect);
end;

function TAqDBSQLSolver.SolveSelectBody(pSelect: IAqDBSQLSelect): string;
begin
  Result := SolveColumns(pSelect.Columns) + ' ' + SolveFrom(pSelect.Source) + SolveJoins(pSelect);

  if pSelect.IsConditionDefined then
  begin
    Result := Result + ' where ' + SolveCondition(pSelect.Condition);
  end;

  Result := Result + SolveOrderBy(pSelect);
end;

function TAqDBSQLSolver.SolveSubselect(pSelect: IAqDBSQLSelect): string;
begin
  if not pSelect.IsAliasDefined then
  begin
    raise EAqInternal.Create('It''s not possible to generate a Subselect without an alias.');
  end;

  Result := '(' + SolveSelect(pSelect) + ') ' + SolveAlias(pSelect, False);
end;

function TAqDBSQLSolver.SolveTable(pTable: IAqDBSQLTable): string;
begin
  Result := pTable.Name;

  if pTable.IsAliasDefined then
  begin
    Result := Result + ' ' + SolveAlias(pTable, False);
  end;
end;

function TAqDBSQLSolver.SolveTextConstant(pConstant: IAqDBSQLTextConstant): string;
begin
  Result := pConstant.Value.Quote;
end;

function TAqDBSQLSolver.SolveTimeConstant(pConstant: IAqDBSQLTimeConstant): string;
begin
  Result := pConstant.Value.Format('hh:mm:ss:zzz').Quote;
end;

function TAqDBSQLSolver.SolveUIntConstant(pConstant: IAqDBSQLUIntConstant): string;
begin
  Result := pConstant.Value.ToString;
end;

function TAqDBSQLSolver.SolveUpdate(pUpdate: IAqDBSQLUpdate): string;
var
  lAssignments: TStringList;
  lAssignment: IAqDBSQLAssignment;
begin
  Result := 'update ' + SolveTable(pUpdate.Table) + ' set ';

  if pUpdate.Assignments.Count = 0 then
  begin
    raise EAqInternal.Create('Update has no assignments.');
  end;

  lAssignments := TStringList.Create;

  try
    for lAssignment in pUpdate.Assignments do
    begin
      lAssignments.Add(SolveColumn(lAssignment.Column) + ' = ' + SolveValue(lAssignment.Value, False));
    end;

    lAssignments.StrictDelimiter := True;
    lAssignments.Delimiter := ',';
    Result := Result + lAssignments.DelimitedText;

    if pUpdate.IsConditionDefined then
    begin
      Result := Result + ' where ' + SolveCondition(pUpdate.Condition);
    end;
  finally
    lAssignments.Free;
  end;
end;

function TAqDBSQLSolver.SolveValueType(pValue: IAqDBSQLValue): string;
begin
  case pValue.ValueType of
    TAqDBSQLValueType.vtColumn:
      Result := SolveColumn(pValue.GetAsColumn);
    TAqDBSQLValueType.vtOperation:
      Result := SolveOperation(pValue.GetAsOperation);
    TAqDBSQLValueType.vtSubselect:
      Result := SolveSubselectValue(pValue.GetAsSubselect);
    TAqDBSQLValueType.vtConstant:
      Result := SolveConstant(pValue.GetAsConstant);
    TAqDBSQLValueType.vtParameter:
      Result := SolveParameter(pValue.GetAsParameter);
  else
    raise EAqInternal.Create('Value type not expected.');
  end;
end;

{ TAqDBAdapter }

constructor TAqDBAdapter.Create;
begin
  SetSQLSolver(CreateSolver);
end;

function TAqDBAdapter.CreateSolver: TAqDBSQLSolver;
begin
  Result := GetDefaultSolver.Create;
end;

destructor TAqDBAdapter.Destroy;
begin
  FSQLSolver.Free;

  inherited;
end;

function TAqDBAdapter.GetAutoIncrementType: TAqDBAutoIncrementType;
begin
  Result := TAqDBAutoIncrementType.aiAutoIncrement;
end;

class function TAqDBAdapter.GetDefaultSolver: TAqDBSQLSolverClass;
begin
  Result := TAqDBSQLSolver;
end;

procedure TAqDBAdapter.SetSQLSolver(const Value: TAqDBSQLSolver);
begin
  FreeAndNil(FSQLSolver);
  FSQLSolver := Value;
end;

end.
