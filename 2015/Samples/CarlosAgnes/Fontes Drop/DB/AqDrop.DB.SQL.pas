unit AqDrop.DB.SQL;

interface

uses
  System.Rtti,
  AqDrop.Core.Collections.Intf,
  AqDrop.Core.Collections,
  AqDrop.Core.InterfacedObject,
  AqDrop.DB.SQL.Intf;

type
  TAqDBSQLAliasable = class;
  TAqDBSQLColumn = class;
  TAqDBSQLSubselect = class;
  TAqDBSQLSource = class;
  TAqDBSQLTable = class;
  TAqDBSQLSelect = class;

  TAqDBSQLAbstraction = class(TAqInterfacedObject)
  strict protected
    class function MustCountReferences: Boolean; override;
  end;

  TAqDBSQLAliasable = class(TAqDBSQLAbstraction, IAqDBSQLAliasable)
  strict private
    FAlias: string;

    function GetAlias: string;
    function GetIsAliasDefined: Boolean;
  public
    constructor Create(const pAlias: string = '');
  end;

  TAqDBSQLValue = class(TAqDBSQLAliasable, IAqDBSQLValue)
  strict private
    FAggregator: TAqDBSQLAggregatorType;
    function GetAggregator: TAqDBSQLAggregatorType;
  strict protected
    function GetValueType: TAqDBSQLValueType; virtual; abstract;
    function GetAsColumn: IAqDBSQLColumn; virtual;
    function GetAsOperation: IAqDBSQLOperation; virtual;
    function GetAsSubselect: IAqDBSQLSubselect; virtual;
    function GetAsConstant: IAqDBSQLConstant; virtual;
    function GetAsParameter: IAqDBSQLParameter; virtual;
  public
    constructor Create(const pAlias: string = ''; const pAggregator: TAqDBSQLAggregatorType = atNone);
  end;

  TAqDBSQLColumn = class(TAqDBSQLValue, IAqDBSQLColumn)
  strict private
    FExpression: string;
    FSource: IAqDBSQLSource;

    function GetExpression: string;
    function GetSource: IAqDBSQLSource;
    function GetIsSourceDefined: Boolean;
  strict protected
    function GetValueType: TAqDBSQLValueType; override;
    function GetAsColumn: IAqDBSQLColumn; override;
  public
    constructor Create(const pExpression: string; pSource: IAqDBSQLSource = nil;
      const pAlias: string = ''; const pAggregator: TAqDBSQLAggregatorType = atNone);
  end;

  TAqDBSQLOperation = class(TAqDBSQLValue, IAqDBSQLOperation)
  strict private
    FLeftOperand: IAqDBSQLValue;
    FOperator: TAqDBSQLOperator;
    FRightOperand: IAqDBSQLValue;

    function GetOperator: TAqDBSQLOperator;
    function GetRightOperand: IAqDBSQLValue;
    function GetLeftOperand: IAqDBSQLValue;
  strict protected
    function GetValueType: TAqDBSQLValueType; override;
    function GetAsOperation: IAqDBSQLOperation; override;
  public
    constructor Create(pLeftOperand: IAqDBSQLValue; const pOperator: TAqDBSQLOperator;
      pRightOperand: IAqDBSQLValue; const pAlias: string = '';
      const pAggregator: TAqDBSQLAggregatorType = atNone);
  end;

  TAqDBSQLSubselect = class(TAqDBSQLValue, IAqDBSQLSubselect)
  strict private
    FSelect: IAqDBSQLSelect;

    function GetSelect: IAqDBSQLSelect;
  strict protected
    function GetValueType: TAqDBSQLValueType; override;
    function GetAsSubselect: IAqDBSQLSubselect; override;
  public
    constructor Create(pSelect: IAqDBSQLSelect; const pAlias: string = '';
      const pAggregator: TAqDBSQLAggregatorType = atNone);
  end;

  TAqDBSQLConstant = class abstract(TAqDBSQLValue, IAqDBSQLConstant)
  strict protected
    function GetValueType: TAqDBSQLValueType; override;
    function GetAsConstant: IAqDBSQLConstant; override;

    function GetConstantType: TAqDBSQLConstantValueType; virtual; abstract;
    function GetAsTextConstant: IAqDBSQLTextConstant; virtual;
    function GetAsIntConstant: IAqDBSQLIntConstant; virtual;
    function GetAsUIntConstant: IAqDBSQLUIntConstant; virtual;
    function GetAsDoubleConstant: IAqDBSQLDoubleConstant; virtual;
    function GetAsCurrencyConstant: IAqDBSQLCurrencyConstant; virtual;
    function GetAsDateTimeConstant: IAqDBSQLDateTimeConstant; virtual;
    function GetAsDateConstant: IAqDBSQLDateConstant; virtual;
    function GetAsTimeConstant: IAqDBSQLTimeConstant; virtual;
    function GetAsBooleanConstant: IAqDBSQLBooleanConstant; virtual;
  end;

  TAqDBSQLGenericConstant<T> = class(TAqDBSQLConstant)
  strict private
    FValue: T;
  public
    constructor Create(const pValue: T; const pAlias: string = '';
      const pAggregator: TAqDBSQLAggregatorType = atNone);
    function GetValue: T;
  end;

  TAqDBSQLTextConstant = class(TAqDBSQLGenericConstant<string>, IAqDBSQLTextConstant)
  strict protected
    function GetConstantType: TAqDBSQLConstantValueType; override;
    function GetAsTextConstant: IAqDBSQLTextConstant; override;
  end;

  TAqDBSQLIntConstant = class(TAqDBSQLGenericConstant<Int64>, IAqDBSQLIntConstant)
  strict protected
    function GetConstantType: TAqDBSQLConstantValueType; override;
    function GetAsIntConstant: IAqDBSQLIntConstant; override;
  end;

  TAqDBSQLUIntConstant = class(TAqDBSQLGenericConstant<UInt64>, IAqDBSQLUIntConstant)
  strict protected
    function GetConstantType: TAqDBSQLConstantValueType; override;
    function GetAsUIntConstant: IAqDBSQLUIntConstant; override;
  end;

  TAqDBSQLDoubleConstant = class(TAqDBSQLGenericConstant<Double>, IAqDBSQLDoubleConstant)
  strict protected
    function GetConstantType: TAqDBSQLConstantValueType; override;
    function GetAsDoubleConstant: IAqDBSQLDoubleConstant; override;
  end;

  TAqDBSQLCurrencyConstant = class(TAqDBSQLGenericConstant<Currency>, IAqDBSQLCurrencyConstant)
  strict protected
    function GetConstantType: TAqDBSQLConstantValueType; override;
    function GetAsCurrencyConstant: IAqDBSQLCurrencyConstant; override;
  end;

  TAqDBSQLDateTimeConstant = class(TAqDBSQLGenericConstant<TDateTime>, IAqDBSQLDateTimeConstant)
  strict protected
    function GetConstantType: TAqDBSQLConstantValueType; override;
    function GetAsDateTimeConstant: IAqDBSQLDateTimeConstant; override;
  end;

  TAqDBSQLDateConstant = class(TAqDBSQLGenericConstant<TDate>, IAqDBSQLDateConstant)
  strict protected
    function GetConstantType: TAqDBSQLConstantValueType; override;
    function GetAsDateConstant: IAqDBSQLDateConstant; override;
  end;

  TAqDBSQLTimeConstant = class(TAqDBSQLGenericConstant<TTime>, IAqDBSQLTimeConstant)
  strict protected
    function GetConstantType: TAqDBSQLConstantValueType; override;
    function GetAsTimeConstant: IAqDBSQLTimeConstant; override;
  end;

  TAqDBSQLBooleanConstant = class(TAqDBSQLGenericConstant<Boolean>, IAqDBSQLBooleanConstant)
  strict protected
    function GetConstantType: TAqDBSQLConstantValueType; override;
    function GetAsBooleanConstant: IAqDBSQLBooleanConstant; override;
  end;

  TAqDBSQLParameter = class(TAqDBSQLValue, IAqDBSQLParameter)
  strict private
    FName: string;

    function GetName: string;
  strict protected
    function GetValueType: TAqDBSQLValueType; override;
    function GetAsParameter: IAqDBSQLParameter; override;
  public
    constructor Create(const pName: string; const pAlias: string = '';
      const pAggregator: TAqDBSQLAggregatorType = atNone);
  end;

  TAqDBSQLSource = class(TAqDBSQLAliasable, IAqDBSQLSource)
  strict protected
    function GetSourceType: TAqDBSQLSourceType; virtual; abstract;
    function GetAsTable: IAqDBSQLTable; virtual;
    function GetAsSelect: IAqDBSQLSelect; virtual;
  end;

  TAqDBSQLTable = class(TAqDBSQLSource, IAqDBSQLTable, IAqDBSQLSource)
  strict private
    FName: string;

    function GetName: string;
  strict protected
    function GetSourceType: TAqDBSQLSourceType; override;
    function GetAsTable: IAqDBSQLTable; override;
  public
    constructor Create(const pName: string; const pAlias: string = '');
  end;

  TAqDBSQLCondition = class(TAqDBSQLAbstraction, IAqDBSQLCondition)
  strict protected
    function GetConditionType: TAqDBSQLConditionType; virtual; abstract;

    function GetAsComparison: IAqDBSQLComparisonCondition; virtual;
    function GetAsValueIsNull: IAqDBSQLValueIsNullCondition; virtual;
    function GetAsComposed: IAqDBSQLComposedCondition; virtual;
    function GetAsBetween: IAqDBSQLBetweenCondition; virtual;
  end;

  TAqDBSQLComparisonCondition = class(TAqDBSQLCondition, IAqDBSQLComparisonCondition)
  strict private
    FLeftValue: IAqDBSQLValue;
    FComparison: TAqDBSQLComparison;
    FRightValue: IAqDBSQLValue;

    function GetLeftValue: IAqDBSQLValue;
    function GetComparison: TAqDBSQLComparison;
    function GetRightValue: IAqDBSQLValue;

    procedure SetLeftValue(pValue: IAqDBSQLValue);
    procedure SetRightValue(pValue: IAqDBSQLValue);
    procedure SetComparison(const pComparison: TAqDBSQLComparison);
  strict protected
    function GetConditionType: TAqDBSQLConditionType; override;
    function GetAsComparison: IAqDBSQLComparisonCondition; override;
  public
    constructor Create(pLeftValue: IAqDBSQLValue; const pComparison: TAqDBSQLComparison;
      pRightValue: IAqDBSQLValue);
  end;

  TAqDBSQLValueIsNullCondition = class(TAqDBSQLCondition, IAqDBSQLValueIsNullCondition)
  strict private
    FValue: IAqDBSQLValue;
    function GetValue: IAqDBSQLValue;
  strict protected
    function GetConditionType: TAqDBSQLConditionType; override;
    function GetAsValueIsNull: IAqDBSQLValueIsNullCondition; override;
  public
    constructor Create(pValue: IAqDBSQLValue);
  end;

  TAqDBSQLComposedCondition = class(TAqDBSQLCondition, IAqDBSQLComposedCondition)
  strict private
    FConditions: TAqList<IAqDBSQLCondition>;
    FOperators: TAqList<TAqDBSQLBooleanOperator>;

    function GetConditions: AqDrop.Core.Collections.Intf.IAqReadList<AqDrop.DB.SQL.Intf.IAqDBSQLCondition>;
    function GetLinkOperators: AqDrop.Core.Collections.Intf.IAqReadList<AqDrop.DB.SQL.Intf.TAqDBSQLBooleanOperator>;
  strict protected
    function GetConditionType: TAqDBSQLConditionType; override;
    function GetAsComposed: IAqDBSQLComposedCondition; override;
  public
    constructor Create(pInitialCondition: IAqDBSQLCondition = nil);
    destructor Destroy; override;

    function GetIsInitialized: Boolean;

    function AddCondition(const pLinkOperator: TAqDBSQLBooleanOperator; pCondition: IAqDBSQLCondition): Int32;
    function AddAnd(pCondition: IAqDBSQLCondition): IAqDBSQLComposedCondition;
    function AddOr(pCondition: IAqDBSQLCondition): IAqDBSQLComposedCondition;
    function AddXor(pCondition: IAqDBSQLCondition): IAqDBSQLComposedCondition;

    function AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(const pColumnName: string; pValue: IAqDBSQLValue;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: string;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(const pColumnName: string; pValue: string;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: Int64;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(const pColumnName: string; pValue: Int64;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: UInt64;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(const pColumnName: string; pValue: UInt64;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: Double;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(const pColumnName: string; pValue: Double;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: Currency;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(const pColumnName: string; pValue: Currency;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: TDateTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(const pColumnName: string; pValue: TDateTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: TDate;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(const pColumnName: string; pValue: TDate;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: TTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(const pColumnName: string; pValue: TTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: Boolean;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnEqual(const pColumnName: string; pValue: Boolean;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;

    function AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(const pColumnName: string; pValue: IAqDBSQLValue;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: string;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(const pColumnName: string; pValue: string;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: Int64;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(const pColumnName: string; pValue: Int64;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: Double;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(const pColumnName: string; pValue: Double;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: Currency;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(const pColumnName: string; pValue: Currency;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: TDateTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(const pColumnName: string; pValue: TDateTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: TDate;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(const pColumnName: string; pValue: TDate;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: TTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterThan(const pColumnName: string; pValue: TTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;

    function AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(const pColumnName: string; pValue: IAqDBSQLValue;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: string;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(const pColumnName: string; pValue: string;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: Int64;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(const pColumnName: string; pValue: Int64;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: Double;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(const pColumnName: string; pValue: Double;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: Currency;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(const pColumnName: string; pValue: Currency;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: TDateTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(const pColumnName: string; pValue: TDateTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: TDate;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(const pColumnName: string; pValue: TDate;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: TTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnGreaterEqualThan(const pColumnName: string; pValue: TTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;

    function AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(const pColumnName: string; pValue: IAqDBSQLValue;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: string;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(const pColumnName: string; pValue: string;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: Int64;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(const pColumnName: string; pValue: Int64;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: Double;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(const pColumnName: string; pValue: Double;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: Currency;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(const pColumnName: string; pValue: Currency;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: TDateTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(const pColumnName: string; pValue: TDateTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: TDate;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(const pColumnName: string; pValue: TDate;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: TTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessThan(const pColumnName: string; pValue: TTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;

    function AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(const pColumnName: string; pValue: IAqDBSQLValue;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: string;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(const pColumnName: string; pValue: string;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: Int64;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(const pColumnName: string; pValue: Int64;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: Double;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(const pColumnName: string; pValue: Double;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: Currency;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(const pColumnName: string; pValue: Currency;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: TDateTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(const pColumnName: string; pValue: TDateTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: TDate;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(const pColumnName: string; pValue: TDate;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: TTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnLessEqualThan(const pColumnName: string; pValue: TTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;

    function AddColumnIsNull(pColumn: IAqDBSQLColumn;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnIsNull(const pColumnName: string;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;

    function AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: IAqDBSQLValue;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(const pColumnName: string; const pRangeBegin, pRangeEnd: IAqDBSQLValue;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: string;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(const pColumnName: string; const pRangeBegin, pRangeEnd: string;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: Int64;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(const pColumnName: string; const pRangeBegin, pRangeEnd: Int64;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: Double;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(const pColumnName: string; const pRangeBegin, pRangeEnd: Double;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: Currency;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(const pColumnName: string; const pRangeBegin, pRangeEnd: Currency;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: TDateTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(const pColumnName: string; const pRangeBegin, pRangeEnd: TDateTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: TDate;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(const pColumnName: string; const pRangeBegin, pRangeEnd: TDate;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: TTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
    function AddColumnBetween(const pColumnName: string; const pRangeBegin, pRangeEnd: TTime;
      const pLinkOperator: TAqDBSQLBooleanOperator = TAqDBSQLBooleanOperator.boAnd):
      IAqDBSQLComposedCondition; overload;
  end;

  TAqDBSQLBetweenCondition = class(TAqDBSQLCondition, IAqDBSQLBetweenCondition)
  strict private
    FValue: IAqDBSQLValue;
    FRangeBegin: IAqDBSQLValue;
    FRangeEnd: IAqDBSQLValue;
    function GetValue: IAqDBSQLValue;
    function GetRangeBegin: IAqDBSQLValue;
    function GetRangeEnd: IAqDBSQLValue;
  strict protected
    function GetAsBetween: IAqDBSQLBetweenCondition; override;
    function GetConditionType: TAqDBSQLConditionType; override;
  public
    constructor Create(pValue, pRangeBegin, pRangeEnd: IAqDBSQLValue);
  end;

  TAqDBSQLJoin = class(TAqDBSQLAliasable, IAqDBSQLJoin)
  strict private
    FType: TAqDBSQLJoinType;
    FMainSource: IAqDBSQLSource;
    FJoinSource: IAqDBSQLSource;
    FCondition: IAqDBSQLCondition;

    function GetSource: IAqDBSQLSource;
    function GetCondition: IAqDBSQLCondition;
    function GetJoinType: TAqDBSQLJoinType;
  public
    constructor Create(const pType: TAqDBSQLJoinType; pMainSource: IAqDBSQLSource; pJoinSource: IAqDBSQLSource;
      pCondition: IAqDBSQLCondition); overload;

    function &On(const pColumnName: string): IAqDBSQLJoin;
    function EqualsTo(const pColumnName: string): IAqDBSQLJoin;
  end;

  TAqDBSQLOrderByItem = class(TAqDBSQLAbstraction, IAqDBSQLOrderByItem)
  strict private
    FValue: IAqDBSQLValue;
    FDesc: Boolean;

    function GetValue: IAqDBSQLValue;
    function GetDesc: Boolean;
  public
    constructor Create(pValue: IAqDBSQLValue; const pDesc: Boolean);

    property Value: IAqDBSQLValue read GetValue;
    property Desc: Boolean read GetDesc;
  end;

  TAqDBSQLSelect = class(TAqDBSQLSource, IAqDBSQLSource, IAqDBSQLSelect, IAqDBSQLCommand)
  strict private
    FColumns: TAqList<IAqDBSQLValue>;
    FSource: IAqDBSQLSource;
    FJoins: TAqList<IAqDBSQLJoin>;
    FLimit: UInt32;
    FCondition: IAqDBSQLCondition;
    FOrderBy: TAqList<IAqDBSQLOrderByItem>;

    constructor InternalCreate(const pAlias: string);

    function GetColumns: IAqReadList<IAqDBSQLValue>;
    function GetSource: IAqDBSQLSource;

    function GetHasJoins: Boolean;
    function GetJoins: IAqReadList<IAqDBSQLJoin>;

    function GetIsConditionDefined: Boolean;
    function GetCondition: IAqDBSQLCondition;
    procedure SetCondition(pValue: IAqDBSQLCondition);
    function CustomizeCondition(pNewCondition: IAqDBSQLCondition = nil): IAqDBSQLComposedCondition;

    function GetIsLimitDefined: Boolean;
    function GetLimit: UInt32;
    procedure SetLimit(const pValue: UInt32);

    function GetIsOrderByDefined: Boolean;
    function GetOrderBy: IAqReadList<IAqDBSQLOrderbyItem>;

    function GetAsDelete: IAqDBSQLDelete;
    function GetAsInsert: IAqDBSQLInsert;
    function GetAsUpdate: IAqDBSQLUpdate;
  strict protected
    function GetCommandType: TAqDBSQLCommandType;
    function GetSourceType: TAqDBSQLSourceType; override;
    function GetAsSelect: IAqDBSQLSelect; override;
  public
    constructor Create(const pSource: TAqDBSQLSource; const pAlias: string = ''); overload;
    constructor Create(const pSourceTable: string; const pAlias: string = ''); overload;
    destructor Destroy; override;

    function GetColumnByExpression(const pExpression: string): IAqDBSQLColumn;

    function AddColumn(pValue: IAqDBSQLValue): Int32; overload;
    function AddColumn(const pExpression: string; const pAlias: string = ''; pSource: IAqDBSQLSource = nil;
      const pAggregator: TAqDBSQLAggregatorType = atNone): IAqDBSQLColumn; overload;

    function AddJoin(const pType: TAqDBSQLJoinType; pSource: IAqDBSQLSource;
      pCondition: IAqDBSQLCondition): IAqDBSQLJoin;
    function InnerJoin(const pTableName: string): IAqDBSQLJoin;

    function AddOrderBy(pValue: IAqDBSQLValue; const pDesc: Boolean): Int32;

    procedure UnsetLimit;
  end;

  TAqDBSQLCommand = class(TAqDBSQLAbstraction, IAqDBSQLCommand)
  strict protected
    function GetCommandType: TAqDBSQLCommandType; virtual; abstract;
    function GetAsDelete: IAqDBSQLDelete; virtual;
    function GetAsInsert: IAqDBSQLInsert; virtual;
    function GetAsSelect: IAqDBSQLSelect; virtual;
    function GetAsUpdate: IAqDBSQLUpdate; virtual;
  end;

  TAqDBSQLAssignment = class(TAqDBSQLAbstraction, IAqDBSQLAssignment)
  strict private
    FColumn: IAqDBSQLColumn;
    FValue: IAqDBSQLValue;

    function GetColumn: IAqDBSQLColumn;
    function GetValue: IAqDBSQLValue;
  public
    constructor Create(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue);
  end;

  TAqDBSQLInsert = class(TAqDBSQLCommand, IAqDBSQLInsert)
  strict private
    FTable: IAqDBSQLTable;
    FAssignments: TAqList<IAqDBSQLAssignment>;

    function GetAssignments: IAqReadList<IAqDBSQLAssignment>;
    function GetTable: IAqDBSQLTable;
  strict protected
    function GetCommandType: TAqDBSQLCommandType; override;
    function GetAsInsert: IAqDBSQLInsert; override;
  public
    constructor Create(pTable: IAqDBSQLTable); overload;
    constructor Create(const pTableName: string); overload;
    destructor Destroy; override;

    function AddAssignment(pAssignment: IAqDBSQLAssignment): Int32; overload;
    function AddAssignment(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue): IAqDBSQLAssignment; overload;
  end;

  TAqDBSQLUpdate = class(TAqDBSQLCommand, IAqDBSQLUpdate)
  strict private
    FTable: IAqDBSQLTable;
    FAssignments: TAqList<IAqDBSQLAssignment>;
    FCondition: IAqDBSQLCondition;

    function GetAssignments: IAqReadList<IAqDBSQLAssignment>;
    function GetTable: IAqDBSQLTable;
    function GetIsConditionDefined: Boolean;
    function GetCondition: IAqDBSQLCondition;
    procedure SetCondition(pValue: IAqDBSQLCondition);
    function CustomizeCondition(pNewCondition: IAqDBSQLCondition = nil): IAqDBSQLComposedCondition;
  strict protected
    function GetCommandType: TAqDBSQLCommandType; override;
    function GetAsUpdate: IAqDBSQLUpdate; override;
  public
    constructor Create(pTable: IAqDBSQLTable); overload;
    constructor Create(const pTableName: string); overload;
    destructor Destroy; override;

    function AddAssignment(pAssignment: IAqDBSQLAssignment): Int32; overload;
    function AddAssignment(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue): IAqDBSQLAssignment; overload;
  end;

  TAqDBSQLDelete = class(TAqDBSQLCommand, IAqDBSQLDelete)
  strict private
    FTable: IAqDBSQLTable;
    FCondition: IAqDBSQLCondition;

    function GetTable: IAqDBSQLTable;
    function GetIsConditionDefined: Boolean;
    function GetCondition: IAqDBSQLCondition;
    procedure SetCondition(pValue: IAqDBSQLCondition);
    function CustomizeCondition(pNewCondition: IAqDBSQLCondition = nil): IAqDBSQLComposedCondition;
  strict protected
    function GetCommandType: TAqDBSQLCommandType; override;
    function GetAsDelete: IAqDBSQLDelete; override;
  public
    constructor Create(pTable: IAqDBSQLTable); overload;
    constructor Create(const pTableName: string); overload;
  end;

implementation

uses
  AqDrop.Core.Exceptions;

{ TAqDBSQLColumn }

function TAqDBSQLColumn.GetAsColumn: IAqDBSQLColumn;
begin
  Result := Self;
end;

constructor TAqDBSQLColumn.Create(const pExpression: string; pSource: IAqDBSQLSource;
  const pAlias: string; const pAggregator: TAqDBSQLAggregatorType);
begin
  inherited Create(pAlias, pAggregator);

  FExpression := pExpression;
  FSource := pSource;
end;

function TAqDBSQLColumn.GetExpression: string;
begin
  Result := FExpression;
end;

function TAqDBSQLColumn.GetSource: IAqDBSQLSource;
begin
  Result := FSource;
end;

function TAqDBSQLColumn.GetIsSourceDefined: Boolean;
begin
  Result := Assigned(FSource);
end;

function TAqDBSQLColumn.GetValueType: TAqDBSQLValueType;
begin
  Result := TAqDBSQLValueType.vtColumn;
end;

{ TAqDBSQLAliasable }

constructor TAqDBSQLAliasable.Create(const pAlias: string);
begin
  FAlias := pAlias;
end;

{ TAqDBSQLSubselectColumn }

function TAqDBSQLSubselect.GetAsSubselect: IAqDBSQLSubselect;
begin
  Result := Self;
end;

constructor TAqDBSQLSubselect.Create(pSelect: IAqDBSQLSelect; const pAlias: string;
  const pAggregator: TAqDBSQLAggregatorType);
begin
  inherited Create(pAlias, pAggregator);

  FSelect := pSelect;
end;

function TAqDBSQLSubselect.GetSelect: IAqDBSQLSelect;
begin
  Result := FSelect;
end;

function TAqDBSQLSubselect.GetValueType: TAqDBSQLValueType;
begin
  Result := TAqDBSQLValueType.vtSubselect;
end;

{ TAqDBSQLTable }

function TAqDBSQLTable.GetAsTable: IAqDBSQLTable;
begin
  Result := Self;
end;

constructor TAqDBSQLTable.Create(const pName, pAlias: string);
begin
  inherited Create(pAlias);

  FName := pName;
end;

function TAqDBSQLTable.GetName: string;
begin
  Result := FName;
end;

function TAqDBSQLTable.GetSourceType: TAqDBSQLSourceType;
begin
  Result := TAqDBSQLSourceType.stTable;
end;

{ TAqDBSQLSelect }

constructor TAqDBSQLSelect.Create(const pSourceTable, pAlias: string);
begin
  InternalCreate(pAlias);
  FSource := TAqDBSQLTable.Create(pSourceTable);
end;

function TAqDBSQLSelect.CustomizeCondition(pNewCondition: IAqDBSQLCondition = nil): IAqDBSQLComposedCondition;
begin
  if GetIsConditionDefined then
  begin
    Result := TAqDBSQLComposedCondition.Create(FCondition);
    if Assigned(pNewCondition) then
    begin
      Result.AddAnd(pNewCondition);
    end;
  end else begin
    Result := TAqDBSQLComposedCondition.Create(pNewCondition);
  end;

  FCondition := Result;
end;

function TAqDBSQLSelect.AddColumn(const pExpression: string; const pAlias: string; pSource: IAqDBSQLSource;
  const pAggregator: TAqDBSQLAggregatorType): IAqDBSQLColumn;
begin
  if Assigned(pSource) then
  begin
    Result := TAqDBSQLColumn.Create(pExpression, pSource, pAlias, pAggregator);
  end else begin
    Result := TAqDBSQLColumn.Create(pExpression, Self.FSource, pAlias, pAggregator);
  end;
  FColumns.Add(Result);
end;

function TAqDBSQLSelect.AddColumn(pValue: IAqDBSQLValue): Int32;
begin
  Result := FColumns.Add(pValue);
end;

function TAqDBSQLSelect.AddJoin(const pType: TAqDBSQLJoinType; pSource: IAqDBSQLSource;
  pCondition: IAqDBSQLCondition): IAqDBSQLJoin;
begin
  Result := TAqDBSQLJoin.Create(pType, Self.FSource, pSource, pCondition);

  if not Assigned(FJoins) then
  begin
    FJoins := TAqList<IAqDBSQLJoin>.Create;
  end;

  FJoins.Add(Result);
end;

function TAqDBSQLSelect.AddOrderBy(pValue: IAqDBSQLValue; const pDesc: Boolean): Int32;
begin
  if not Assigned(FOrderBy) then
  begin
    FOrderBy := TAqList<IAqDBSQLOrderByItem>.Create;
  end;

  Result := FOrderBy.Add(TAqDBSQLOrderByItem.Create(pValue, pDesc));
end;

function TAqDBSQLSelect.GetAsDelete: IAqDBSQLDelete;
begin
  raise EAqInternal.Create('Objects of ' + Self.QualifiedClassName + ' cannot be consumed as IAqDBDelete.');
end;

function TAqDBSQLSelect.GetAsInsert: IAqDBSQLInsert;
begin
  raise EAqInternal.Create('Objects of ' + Self.QualifiedClassName + ' cannot be consumed as IAqDBInsert.');
end;

function TAqDBSQLSelect.GetAsSelect: IAqDBSQLSelect;
begin
  Result := Self;
end;

function TAqDBSQLSelect.GetAsUpdate: IAqDBSQLUpdate;
begin
  raise EAqInternal.Create('Objects of ' + Self.QualifiedClassName + ' cannot be consumed as IAqDBSQLUpdate.');
end;

function TAqDBSQLSelect.InnerJoin(const pTableName: string): IAqDBSQLJoin;
begin
  Result := AddJoin(TAqDBSQLJoinType.jtInnerJoin, TAqDBSQLTable.Create(pTableName), nil);
end;

constructor TAqDBSQLSelect.InternalCreate(const pAlias: string);
begin
  inherited Create(pAlias);

  FColumns := TAqList<IAqDBSQLValue>.Create;
  FLimit :=  High(FLimit);
end;

procedure TAqDBSQLSelect.SetCondition(pValue: IAqDBSQLCondition);
begin
  FCondition := pValue;
end;

procedure TAqDBSQLSelect.SetLimit(const pValue: UInt32);
begin
  FLimit := pValue;
end;

procedure TAqDBSQLSelect.UnsetLimit;
begin
  FLimit := High(FLimit);
end;

constructor TAqDBSQLSelect.Create(const pSource: TAqDBSQLSource; const pAlias: string);
begin
  InternalCreate(pAlias);
  FSource := pSource;
end;

destructor TAqDBSQLSelect.Destroy;
begin
  FOrderBy.Free;
  FJoins.Free;
  FColumns.Free;

  inherited;
end;

function TAqDBSQLSelect.GetColumnByExpression(const pExpression: string): IAqDBSQLColumn;
var
  lI: Int32;
begin
  lI := 0;
  Result := nil;

  while not Assigned(Result) and (lI < FColumns.Count) do
  begin
    if (FColumns[lI].ValueType = TAqDBSQLValueType.vtColumn) and
      (FColumns[lI].GetAsColumn.Expression = pExpression) then
    begin
      Result := FColumns[lI].GetAsColumn;
    end else begin
      Inc(lI);
    end;
  end;
end;

function TAqDBSQLSelect.GetColumns: IAqReadList<IAqDBSQLValue>;
begin
  Result := FColumns.GetIReadList;
end;

function TAqDBSQLSelect.GetSource: IAqDBSQLSource;
begin
  Result := FSource;
end;

function TAqDBSQLSelect.GetCommandType: TAqDBSQLCommandType;
begin
  Result := TAqDBSQLCommandType.ctSelect;
end;

function TAqDBSQLSelect.GetCondition: IAqDBSQLCondition;
begin
  Result := FCondition;
end;

function TAqDBSQLSelect.GetHasJoins: Boolean;
begin
  Result := Assigned(FJoins) and (FJoins.Count > 0);
end;

function TAqDBSQLSelect.GetIsConditionDefined: Boolean;
begin
  Result := Assigned(FCondition);
end;

function TAqDBSQLSelect.GetIsLimitDefined: Boolean;
begin
  Result := FLimit <> High(FLimit);
end;

function TAqDBSQLSelect.GetIsOrderByDefined: Boolean;
begin
  Result := Assigned(FOrderBy) and (FOrderBy.Count > 0);
end;

function TAqDBSQLSelect.GetJoins: IAqReadList<IAqDBSQLJoin>;
begin
  Result := FJoins.GetIReadList;
end;

function TAqDBSQLSelect.GetLimit: UInt32;
begin
  Result := FLimit;
end;

function TAqDBSQLSelect.GetOrderBy: IAqReadList<IAqDBSQLOrderByItem>;
begin
  Result := FOrderBy.GetIReadList;
end;

function TAqDBSQLSelect.GetSourceType: TAqDBSQLSourceType;
begin
  Result := TAqDBSQLSourceType.stSelect;
end;

{ TAqDBSQLSource }

function TAqDBSQLSource.GetAsSelect: IAqDBSQLSelect;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName + ' cannot be consumed as IAqDBSQLSelect.');
end;

function TAqDBSQLSource.GetAsTable: IAqDBSQLTable;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName + ' cannot be consumed as IAqDBTable.');
end;

{ TAqDBOperationColumn }

function TAqDBSQLOperation.GetAsOperation: IAqDBSQLOperation;
begin
  Result := Self;
end;

constructor TAqDBSQLOperation.Create(pLeftOperand: IAqDBSQLValue; const pOperator: TAqDBSQLOperator;
  pRightOperand: IAqDBSQLValue; const pAlias: string; const pAggregator: TAqDBSQLAggregatorType);
begin
  inherited Create(pAlias, pAggregator);

  FLeftOperand := pLeftOperand;
  FOperator := pOperator;
  FRightOperand := pRightOperand;
end;

function TAqDBSQLOperation.GetOperator: TAqDBSQLOperator;
begin
  Result := FOperator;
end;

function TAqDBSQLOperation.GetRightOperand: IAqDBSQLValue;
begin
  Result := FRightOperand;
end;

function TAqDBSQLOperation.GetLeftOperand: IAqDBSQLValue;
begin
  Result := FLeftOperand;
end;

function TAqDBSQLOperation.GetValueType: TAqDBSQLValueType;
begin
  Result := TAqDBSQLValueType.vtOperation;
end;

{ TAqDBSQLValue }

function TAqDBSQLValue.GetAsColumn: IAqDBSQLColumn;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName + ' cannot be consumed as IAqDBColumn.');
end;

function TAqDBSQLValue.GetAsConstant: IAqDBSQLConstant;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName + ' cannot be consumed as IAqDBSQLConstant.');
end;

function TAqDBSQLValue.GetAsOperation: IAqDBSQLOperation;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName +
    ' cannot be consumed as IAqDBOperationValue.');
end;

function TAqDBSQLValue.GetAsParameter: IAqDBSQLParameter;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName + ' cannot be consumed as IAqDBSQLParameter.');
end;

function TAqDBSQLValue.GetAsSubselect: IAqDBSQLSubselect;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName + ' cannot be consumed as IAqDBSQLSubselect.');
end;

constructor TAqDBSQLValue.Create(const pAlias: string; const pAggregator: TAqDBSQLAggregatorType);
begin
  inherited Create(pAlias);

  FAggregator := pAggregator;
end;

function TAqDBSQLAliasable.GetAlias: string;
begin
  Result := FAlias;
end;

function TAqDBSQLAliasable.GetIsAliasDefined: Boolean;
begin
  Result := FAlias <> '';
end;

function TAqDBSQLValue.GetAggregator: TAqDBSQLAggregatorType;
begin
  Result := FAggregator;
end;

{ TAqDBSQLComparisonCondition }

constructor TAqDBSQLComparisonCondition.Create(pLeftValue: IAqDBSQLValue; const pComparison: TAqDBSQLComparison;
  pRightValue: IAqDBSQLValue);
begin
  FLeftValue := pLeftValue;
  FComparison := pComparison;
  FRightValue := pRightValue;
end;

function TAqDBSQLComparisonCondition.GetAsComparison: IAqDBSQLComparisonCondition;
begin
  Result := Self;
end;

function TAqDBSQLComparisonCondition.GetComparison: TAqDBSQLComparison;
begin
  Result := FComparison;
end;

function TAqDBSQLComparisonCondition.GetConditionType: TAqDBSQLConditionType;
begin
  Result := TAqDBSQLConditionType.ctComparison;
end;

function TAqDBSQLComparisonCondition.GetLeftValue: IAqDBSQLValue;
begin
  Result := FLeftValue;
end;

function TAqDBSQLComparisonCondition.GetRightValue: IAqDBSQLValue;
begin
  Result := FRightValue;
end;

procedure TAqDBSQLComparisonCondition.SetComparison(const pComparison: TAqDBSQLComparison);
begin
  FComparison := pComparison;
end;

procedure TAqDBSQLComparisonCondition.SetLeftValue(pValue: IAqDBSQLValue);
begin
  FLeftValue := pValue;
end;

procedure TAqDBSQLComparisonCondition.SetRightValue(pValue: IAqDBSQLValue);
begin
  FRightValue := pValue;
end;

{ TAqDBSQLValueIsNullCondition }

constructor TAqDBSQLValueIsNullCondition.Create(pValue: IAqDBSQLValue);
begin
  FValue := pValue;
end;

function TAqDBSQLValueIsNullCondition.GetAsValueIsNull: IAqDBSQLValueIsNullCondition;
begin
  Result := Self;
end;

function TAqDBSQLValueIsNullCondition.GetConditionType: TAqDBSQLConditionType;
begin
  Result := TAqDBSQLConditionType.ctValueIsNull;
end;

function TAqDBSQLValueIsNullCondition.GetValue: IAqDBSQLValue;
begin
  Result := FValue;
end;

{ TAqDBSQLAbstraction }

class function TAqDBSQLAbstraction.MustCountReferences: Boolean;
begin
  Result := True;
end;

{ TAqDBSQLJoin }

function TAqDBSQLJoin.&On(const pColumnName: string): IAqDBSQLJoin;
begin
  FCondition := TAqDBSQLComparisonCondition.Create(TAqDBSQLColumn.Create(pColumnName, FJoinSource),
    TAqDBSQLComparison.cpEqual, nil);
  Result := Self;
end;

constructor TAqDBSQLJoin.Create(const pType: TAqDBSQLJoinType; pMainSource: IAqDBSQLSource; pJoinSource: IAqDBSQLSource;
  pCondition: IAqDBSQLCondition);
begin
  inherited Create;

  FMainSource := pMainSource;
  FJoinSource := pJoinSource;
  FCondition := pCondition;
end;

function TAqDBSQLJoin.EqualsTo(const pColumnName: string): IAqDBSQLJoin;
begin
  if (FCondition.ConditionType = TAqDBSQLConditionType.ctComparison) then
  begin
    FCondition.GetAsComparison.RightValue := TAqDBSQLColumn.Create(pColumnName, FMainSource);
  end;

  Result := Self;
end;

function TAqDBSQLJoin.GetCondition: IAqDBSQLCondition;
begin
  Result := FCondition;
end;

function TAqDBSQLJoin.GetJoinType: TAqDBSQLJoinType;
begin
  Result := FType;
end;

function TAqDBSQLJoin.GetSource: IAqDBSQLSource;
begin
  Result := FJoinSource;
end;

{ TAqDBSQLComposedCondition }

function TAqDBSQLComposedCondition.AddAnd(pCondition: IAqDBSQLCondition): IAqDBSQLComposedCondition;
begin
  AddCondition(TAqDBSQLBooleanOperator.boAnd, pCondition);
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: TDateTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator, TAqDBSQLBetweenCondition.Create(pColumn,
    TAqDBSQLDateTimeConstant.Create(pRangeBegin), TAqDBSQLDateTimeConstant.Create(pRangeEnd)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnBetween(const pColumnName: string; const pRangeBegin, pRangeEnd: TDateTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnBetween(TAqDBSQLColumn.Create(pColumnName), pRangeBegin, pRangeEnd, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: Currency;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator, TAqDBSQLBetweenCondition.Create(pColumn,
    TAqDBSQLCurrencyConstant.Create(pRangeBegin), TAqDBSQLCurrencyConstant.Create(pRangeEnd)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnBetween(const pColumnName: string; const pRangeBegin, pRangeEnd: Currency;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnBetween(TAqDBSQLColumn.Create(pColumnName), pRangeBegin, pRangeEnd, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: TTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator, TAqDBSQLBetweenCondition.Create(pColumn,
    TAqDBSQLTimeConstant.Create(pRangeBegin), TAqDBSQLTimeConstant.Create(pRangeEnd)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnBetween(const pColumnName: string; const pRangeBegin, pRangeEnd: TTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnBetween(TAqDBSQLColumn.Create(pColumnName), pRangeBegin, pRangeEnd, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: TDate;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator, TAqDBSQLBetweenCondition.Create(pColumn,
    TAqDBSQLDateConstant.Create(pRangeBegin), TAqDBSQLDateConstant.Create(pRangeEnd)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnBetween(const pColumnName: string; const pRangeBegin, pRangeEnd: TDate;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnBetween(TAqDBSQLColumn.Create(pColumnName), pRangeBegin, pRangeEnd, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: string;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator, TAqDBSQLBetweenCondition.Create(pColumn,
    TAqDBSQLTextConstant.Create(pRangeBegin), TAqDBSQLTextConstant.Create(pRangeEnd)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnBetween(const pColumnName, pRangeBegin, pRangeEnd: string;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnBetween(TAqDBSQLColumn.Create(pColumnName), pRangeBegin, pRangeEnd, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin,
  pRangeEnd: IAqDBSQLValue; const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator, TAqDBSQLBetweenCondition.Create(pColumn, pRangeBegin, pRangeEnd));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnBetween(const pColumnName: string; const pRangeBegin,
  pRangeEnd: IAqDBSQLValue; const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnBetween(TAqDBSQLColumn.Create(pColumnName), pRangeBegin, pRangeEnd, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: Double;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator, TAqDBSQLBetweenCondition.Create(pColumn,
    TAqDBSQLDoubleConstant.Create(pRangeBegin), TAqDBSQLDoubleConstant.Create(pRangeEnd)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnBetween(const pColumnName: string; const pRangeBegin, pRangeEnd: Double;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnBetween(TAqDBSQLColumn.Create(pColumnName), pRangeBegin, pRangeEnd, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnBetween(pColumn: IAqDBSQLColumn; const pRangeBegin, pRangeEnd: Int64;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator, TAqDBSQLBetweenCondition.Create(pColumn,
    TAqDBSQLIntConstant.Create(pRangeBegin), TAqDBSQLIntConstant.Create(pRangeEnd)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnBetween(const pColumnName: string; const pRangeBegin, pRangeEnd: Int64;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnBetween(TAqDBSQLColumn.Create(pColumnName), pRangeBegin, pRangeEnd, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnEqual(const pColumnName: string; pValue: TDateTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnEqual(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: TDate;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpEqual,
    TAqDBSQLDateConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnEqual(const pColumnName: string; pValue: Currency;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnEqual(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: TDateTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpEqual,
    TAqDBSQLDateTimeConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnEqual(const pColumnName: string; pValue: TDate;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnEqual(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: Boolean;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpEqual,
    TAqDBSQLBooleanConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnEqual(const pColumnName: string; pValue: Boolean;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnEqual(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: UInt64;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpEqual,
    TAqDBSQLUIntConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnEqual(const pColumnName: string; pValue: UInt64;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnEqual(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: TTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpEqual,
    TAqDBSQLTimeConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnEqual(const pColumnName: string; pValue: TTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnEqual(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: string;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpEqual,
    TAqDBSQLTextConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnEqual(const pColumnName: string; pValue: string;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnEqual(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpEqual, pValue));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnEqual(const pColumnName: string; pValue: IAqDBSQLValue;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnEqual(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: Int64;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpEqual,
    TAqDBSQLIntConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnEqual(const pColumnName: string; pValue: Double;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnEqual(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: Currency;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpEqual,
    TAqDBSQLCurrencyConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnEqual(const pColumnName: string; pValue: Int64;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnEqual(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnEqual(pColumn: IAqDBSQLColumn; pValue: Double;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpEqual,
    TAqDBSQLDoubleConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: TDateTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterEqual,
    TAqDBSQLDateTimeConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(const pColumnName: string; pValue: TDateTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: Currency;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterEqual,
    TAqDBSQLCurrencyConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(const pColumnName: string; pValue: Currency;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: TTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterEqual,
    TAqDBSQLTimeConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(const pColumnName: string; pValue: TTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: TDate;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterEqual,
    TAqDBSQLDateConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(const pColumnName: string; pValue: TDate;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: string;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterEqual,
    TAqDBSQLTextConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(const pColumnName: string; pValue: string;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterEqual, pValue));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(const pColumnName: string; pValue: IAqDBSQLValue;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: Double;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterEqual,
    TAqDBSQLDoubleConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(const pColumnName: string; pValue: Double;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(pColumn: IAqDBSQLColumn; pValue: Int64;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterEqual,
    TAqDBSQLIntConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterEqualThan(const pColumnName: string; pValue: Int64;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: Double;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterThan,
    TAqDBSQLDoubleConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(const pColumnName: string; pValue: Int64;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: Currency;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterThan,
    TAqDBSQLCurrencyConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(const pColumnName: string; pValue: Double;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: Int64;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterThan,
    TAqDBSQLIntConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterThan, pValue));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(const pColumnName: string; pValue: IAqDBSQLValue;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(const pColumnName: string; pValue: string;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: string;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterThan,
    TAqDBSQLTextConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(const pColumnName: string; pValue: TDate;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: TTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterThan,
    TAqDBSQLTimeConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(const pColumnName: string; pValue: TTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: TDate;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterThan,
    TAqDBSQLDateConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(const pColumnName: string; pValue: Currency;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(pColumn: IAqDBSQLColumn; pValue: TDateTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpGreaterThan,
    TAqDBSQLDateTimeConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnGreaterThan(const pColumnName: string; pValue: TDateTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnGreaterThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnIsNull(const pColumnName: string;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnIsNull(TAqDBSQLColumn.Create(pColumnName), pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnIsNull(pColumn: IAqDBSQLColumn;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator, TAqDBSQLValueIsNullCondition.Create(pColumn));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(const pColumnName: string; pValue: Int64;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: Int64;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessEqual,
    TAqDBSQLIntConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(const pColumnName: string; pValue: Double;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: Double;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessEqual,
    TAqDBSQLDoubleConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(const pColumnName: string; pValue: IAqDBSQLValue;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessEqual, pValue));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(const pColumnName: string; pValue: string;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: string;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessEqual,
    TAqDBSQLTextConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(const pColumnName: string; pValue: TDate;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: TDate;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessEqual,
    TAqDBSQLDateConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(const pColumnName: string; pValue: TTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: TTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessEqual,
    TAqDBSQLTimeConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(const pColumnName: string; pValue: Currency;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: Currency;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessEqual,
    TAqDBSQLCurrencyConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(const pColumnName: string; pValue: TDateTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessEqualThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessEqualThan(pColumn: IAqDBSQLColumn; pValue: TDateTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessEqual,
    TAqDBSQLDateTimeConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: TDateTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessThan,
    TAqDBSQLDateTimeConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(const pColumnName: string; pValue: TDateTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: Currency;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessThan,
    TAqDBSQLCurrencyConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(const pColumnName: string; pValue: Currency;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: TTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessThan,
    TAqDBSQLTimeConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(const pColumnName: string; pValue: TTime;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: TDate;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessThan,
    TAqDBSQLDateConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(const pColumnName: string; pValue: TDate;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: string;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessThan,
    TAqDBSQLTextConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(const pColumnName: string; pValue: string;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessThan, pValue));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(const pColumnName: string; pValue: IAqDBSQLValue;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: Double;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessThan,
    TAqDBSQLDoubleConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(const pColumnName: string; pValue: Double;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(pColumn: IAqDBSQLColumn; pValue: Int64;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  AddCondition(pLinkOperator,
    TAqDBSQLComparisonCondition.Create(pColumn, TAqDBSQLComparison.cpLessThan,
    TAqDBSQLIntConstant.Create(pValue)));
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddColumnLessThan(const pColumnName: string; pValue: Int64;
  const pLinkOperator: TAqDBSQLBooleanOperator): IAqDBSQLComposedCondition;
begin
  Result := AddColumnLessThan(TAqDBSQLColumn.Create(pColumnName), pValue, pLinkOperator);
end;

function TAqDBSQLComposedCondition.AddCondition(const pLinkOperator: TAqDBSQLBooleanOperator;
  pCondition: IAqDBSQLCondition): Int32;
begin
  if GetIsInitialized then
  begin
    FOperators.Add(pLinkOperator);
  end;

  Result := FConditions.Add(pCondition);
end;

function TAqDBSQLComposedCondition.AddOr(pCondition: IAqDBSQLCondition): IAqDBSQLComposedCondition;
begin
  AddCondition(TAqDBSQLBooleanOperator.boOr, pCondition);
  Result := Self;
end;

function TAqDBSQLComposedCondition.AddXor(pCondition: IAqDBSQLCondition): IAqDBSQLComposedCondition;
begin
  AddCondition(TAqDBSQLBooleanOperator.boXor, pCondition);
  Result := Self;
end;

constructor TAqDBSQLComposedCondition.Create(pInitialCondition: IAqDBSQLCondition);
begin
  FConditions := TAqList<IAqDBSQLCondition>.Create;
  FOperators := TAqList<TAqDBSQLBooleanOperator>.Create;

  if Assigned(pInitialCondition) then
  begin
    FConditions.Add(pInitialCondition);
  end;
end;

destructor TAqDBSQLComposedCondition.Destroy;
begin
  FOperators.Free;
  FConditions.Free;

  inherited;
end;

function TAqDBSQLComposedCondition.GetAsComposed: IAqDBSQLComposedCondition;
begin
  Result := Self;
end;

function TAqDBSQLComposedCondition.GetConditions: IAqReadList<AqDrop.DB.SQL.Intf.IAqDBSQLCondition>;
begin
  Result := FConditions.GetIReadList;
end;

function TAqDBSQLComposedCondition.GetConditionType: TAqDBSQLConditionType;
begin
  Result := TAqDBSQLConditionType.ctComposed;
end;

function TAqDBSQLComposedCondition.GetIsInitialized: Boolean;
begin
  Result := FConditions.Count > 0;
end;

function TAqDBSQLComposedCondition.GetLinkOperators: IAqReadList<AqDrop.DB.SQL.Intf.TAqDBSQLBooleanOperator>;
begin
  Result := FOperators.GetIReadList;
end;

{ TAqDBSQLCondition }

function TAqDBSQLCondition.GetAsBetween: IAqDBSQLBetweenCondition;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName +
    ' cannot be consumed as IAqDBSQLComparisonCondition.');
end;

function TAqDBSQLCondition.GetAsComparison: IAqDBSQLComparisonCondition;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName +
    ' cannot be consumed as IAqDBSQLComparisonCondition.');
end;

function TAqDBSQLCondition.GetAsComposed: IAqDBSQLComposedCondition;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName +
    ' cannot be consumed as IAqDBSQLComposedCondition.');
end;

function TAqDBSQLCondition.GetAsValueIsNull: IAqDBSQLValueIsNullCondition;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName +
    ' cannot be consumed as IAqDBSQLValueIsNullCondition.');
end;

{ TAqDBSQLCommand }

function TAqDBSQLCommand.GetAsDelete: IAqDBSQLDelete;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName + ' cannot be consumed as IAqDBSQLDelete.');
end;

function TAqDBSQLCommand.GetAsInsert: IAqDBSQLInsert;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName + ' cannot be consumed as IAqDBSQLInsert.');
end;

function TAqDBSQLCommand.GetAsSelect: IAqDBSQLSelect;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName + ' cannot be consumed as IAqDBSQLSelect.');
end;

function TAqDBSQLCommand.GetAsUpdate: IAqDBSQLUpdate;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName + ' cannot be consumed as IAqDBSQLUpdate.');
end;

{ TAqDBSQLInsert }

constructor TAqDBSQLInsert.Create(pTable: IAqDBSQLTable);
begin
  FTable := pTable;
  FAssignments := TAqList<IAqDBSQLAssignment>.Create;
end;

function TAqDBSQLInsert.AddAssignment(pAssignment: IAqDBSQLAssignment): Int32;
begin
  Result := FAssignments.Add(pAssignment);
end;

function TAqDBSQLInsert.AddAssignment(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue): IAqDBSQLAssignment;
begin
  Result := TAqDBSQLAssignment.Create(pColumn, pValue);
  FAssignments.Add(Result);
end;

constructor TAqDBSQLInsert.Create(const pTableName: string);
begin
  Create(TAqDBSQLTable.Create(pTableName));
end;

destructor TAqDBSQLInsert.Destroy;
begin
  FAssignments.Free;

  inherited;
end;

function TAqDBSQLInsert.GetAsInsert: IAqDBSQLInsert;
begin
  Result := Self;
end;

function TAqDBSQLInsert.GetAssignments: IAqReadList<IAqDBSQLAssignment>;
begin
  Result := FAssignments.GetIReadList;
end;

function TAqDBSQLInsert.GetCommandType: TAqDBSQLCommandType;
begin
  Result := TAqDBSQLCommandType.ctInsert;
end;

function TAqDBSQLInsert.GetTable: IAqDBSQLTable;
begin
  Result := FTable;
end;

{ TAqDBSQLAssignment }

constructor TAqDBSQLAssignment.Create(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue);
begin
  FColumn := pColumn;
  FValue := pValue;
end;

function TAqDBSQLAssignment.GetColumn: IAqDBSQLColumn;
begin
  Result := FColumn;
end;

function TAqDBSQLAssignment.GetValue: IAqDBSQLValue;
begin
  Result := FValue;
end;

{ TAqDBSQLParameter }

constructor TAqDBSQLParameter.Create(const pName: string; const pAlias: string = '';
  const pAggregator: TAqDBSQLAggregatorType = atNone);
begin
  inherited Create(pAlias, pAggregator);

  FName := pName;
end;

function TAqDBSQLParameter.GetAsParameter: IAqDBSQLParameter;
begin
  Result := Self;
end;

function TAqDBSQLParameter.GetName: string;
begin
  Result := FName;
end;

function TAqDBSQLParameter.GetValueType: TAqDBSQLValueType;
begin
  Result := TAqDBSQLValueType.vtParameter;
end;

{ TAqDBSQLBetweenCondition }

constructor TAqDBSQLBetweenCondition.Create(pValue, pRangeBegin, pRangeEnd: IAqDBSQLValue);
begin
  FValue := pValue;
  FRangeBegin := pRangeBegin;
  FRangeEnd := pRangeEnd;
end;

function TAqDBSQLBetweenCondition.GetAsBetween: IAqDBSQLBetweenCondition;
begin
  Result := Self;
end;

function TAqDBSQLBetweenCondition.GetConditionType: TAqDBSQLConditionType;
begin
  Result := TAqDBSQLConditionType.ctBetween;
end;

function TAqDBSQLBetweenCondition.GetRangeEnd: IAqDBSQLValue;
begin
  Result := FRangeEnd;
end;

function TAqDBSQLBetweenCondition.GetRangeBegin: IAqDBSQLValue;
begin
  Result := FRangeBegin;
end;

function TAqDBSQLBetweenCondition.GetValue: IAqDBSQLValue;
begin
  Result := FValue;
end;

{ TAqDBSQLConstant }

function TAqDBSQLConstant.GetAsBooleanConstant: IAqDBSQLBooleanConstant;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName +
    ' cannot be consumed as IAqDBSQLBooleanConstant.');
end;

function TAqDBSQLConstant.GetAsConstant: IAqDBSQLConstant;
begin
  Result := Self;
end;

function TAqDBSQLConstant.GetAsCurrencyConstant: IAqDBSQLCurrencyConstant;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName +
    ' cannot be consumed as IAqDBSQLCurrencyConstant.');
end;

function TAqDBSQLConstant.GetAsDateConstant: IAqDBSQLDateConstant;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName +
    ' cannot be consumed as IAqDBSQLDateConstant.');
end;

function TAqDBSQLConstant.GetAsDateTimeConstant: IAqDBSQLDateTimeConstant;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName +
    ' cannot be consumed as IAqDBSQLDateTimeConstant.');
end;

function TAqDBSQLConstant.GetAsDoubleConstant: IAqDBSQLDoubleConstant;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName +
    ' cannot be consumed as IAqDBSQLDoubleConstant.');
end;

function TAqDBSQLConstant.GetAsIntConstant: IAqDBSQLIntConstant;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName
    + ' cannot be consumed as IAqDBSQLIntConstant.');
end;

function TAqDBSQLConstant.GetAsTextConstant: IAqDBSQLTextConstant;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName +
    ' cannot be consumed as IAqDBSQLTextConstant.');
end;

function TAqDBSQLConstant.GetAsTimeConstant: IAqDBSQLTimeConstant;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName +
    ' cannot be consumed as IAqDBSQLTimeConstant.');
end;

function TAqDBSQLConstant.GetAsUIntConstant: IAqDBSQLUIntConstant;
begin
  raise EAqInternal.Create('Objects of type ' + Self.QualifiedClassName
    + ' cannot be consumed as IAqDBSQLUIntConstant.');
end;

function TAqDBSQLConstant.GetValueType: TAqDBSQLValueType;
begin
  Result := TAqDBSQLValueType.vtConstant;
end;

{ TAqDBSQLTextConstant }

function TAqDBSQLTextConstant.GetAsTextConstant: IAqDBSQLTextConstant;
begin
  Result := Self;
end;

function TAqDBSQLTextConstant.GetConstantType: TAqDBSQLConstantValueType;
begin
  Result := TAqDBSQLConstantValueType.cvText;
end;

{ TAqDBSQLDateTimeConstant }

function TAqDBSQLDateTimeConstant.GetAsDateTimeConstant: IAqDBSQLDateTimeConstant;
begin
  Result := Self;
end;

function TAqDBSQLDateTimeConstant.GetConstantType: TAqDBSQLConstantValueType;
begin
  Result := TAqDBSQLConstantValueType.cvDateTime;
end;

{ TAqDBSQLBooleanConstant }

function TAqDBSQLBooleanConstant.GetAsBooleanConstant: IAqDBSQLBooleanConstant;
begin
  Result := Self;
end;

function TAqDBSQLBooleanConstant.GetConstantType: TAqDBSQLConstantValueType;
begin
  Result := TAqDBSQLConstantValueType.cvBoolean;
end;

{ TAqDBSQLDateConstant }

function TAqDBSQLDateConstant.GetAsDateConstant: IAqDBSQLDateConstant;
begin
  Result := Self;
end;

function TAqDBSQLDateConstant.GetConstantType: TAqDBSQLConstantValueType;
begin
  Result := TAqDBSQLConstantValueType.cvDate;
end;

{ TAqDBSQLTimeConstant }

function TAqDBSQLTimeConstant.GetAsTimeConstant: IAqDBSQLTimeConstant;
begin
  Result := Self;
end;

function TAqDBSQLTimeConstant.GetConstantType: TAqDBSQLConstantValueType;
begin
  Result := TAqDBSQLConstantValueType.cvTime;
end;

{ TAqDBSQLUpdate }

function TAqDBSQLUpdate.AddAssignment(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue): IAqDBSQLAssignment;
begin
  Result := TAqDBSQLAssignment.Create(pColumn, pValue);
  FAssignments.Add(Result);
end;

function TAqDBSQLUpdate.AddAssignment(pAssignment: IAqDBSQLAssignment): Int32;
begin
  Result := FAssignments.Add(pAssignment);
end;

constructor TAqDBSQLUpdate.Create(const pTableName: string);
begin
  Create(TAqDBSQLTable.Create(pTableName));
end;

function TAqDBSQLUpdate.CustomizeCondition(pNewCondition: IAqDBSQLCondition): IAqDBSQLComposedCondition;
begin
  if GetIsConditionDefined then
  begin
    Result := TAqDBSQLComposedCondition.Create(FCondition);
    if Assigned(pNewCondition) then
    begin
      Result.AddAnd(pNewCondition);
    end;
  end else begin
    Result := TAqDBSQLComposedCondition.Create(pNewCondition);
  end;

  FCondition := Result;
end;

destructor TAqDBSQLUpdate.Destroy;
begin
  FAssignments.Free;

  inherited;
end;

constructor TAqDBSQLUpdate.Create(pTable: IAqDBSQLTable);
begin
  FTable := pTable;
  FAssignments := TAqList<IAqDBSQLAssignment>.Create;
end;

function TAqDBSQLUpdate.GetAssignments: IAqReadList<IAqDBSQLAssignment>;
begin
  Result := FAssignments.GetIReadList;
end;

function TAqDBSQLUpdate.GetAsUpdate: IAqDBSQLUpdate;
begin
  Result := Self;
end;

function TAqDBSQLUpdate.GetCommandType: TAqDBSQLCommandType;
begin
  Result := TAqDBSQLCommandType.ctUpdate;
end;

function TAqDBSQLUpdate.GetCondition: IAqDBSQLCondition;
begin
  Result := FCondition;
end;

function TAqDBSQLUpdate.GetIsConditionDefined: Boolean;
begin
  Result := Assigned(FCondition);
end;

function TAqDBSQLUpdate.GetTable: IAqDBSQLTable;
begin
  Result := FTable;
end;

procedure TAqDBSQLUpdate.SetCondition(pValue: IAqDBSQLCondition);
begin
  FCondition := pValue;
end;

{ TAqDBSQLDelete }

constructor TAqDBSQLDelete.Create(pTable: IAqDBSQLTable);
begin
  FTable := pTable;
end;

constructor TAqDBSQLDelete.Create(const pTableName: string);
begin
  Create(TAqDBSQLTable.Create(pTableName));
end;

function TAqDBSQLDelete.CustomizeCondition(pNewCondition: IAqDBSQLCondition): IAqDBSQLComposedCondition;
begin
  if GetIsConditionDefined then
  begin
    Result := TAqDBSQLComposedCondition.Create(FCondition);
    if Assigned(pNewCondition) then
    begin
      Result.AddAnd(pNewCondition);
    end;
  end else begin
    Result := TAqDBSQLComposedCondition.Create(pNewCondition);
  end;

  FCondition := Result;
end;

function TAqDBSQLDelete.GetAsDelete: IAqDBSQLDelete;
begin
  Result := Self;
end;

function TAqDBSQLDelete.GetCommandType: TAqDBSQLCommandType;
begin
  Result := TAqDBSQLCommandType.ctDelete;
end;

function TAqDBSQLDelete.GetCondition: IAqDBSQLCondition;
begin
  Result := FCondition;
end;

function TAqDBSQLDelete.GetIsConditionDefined: Boolean;
begin
  Result := Assigned(FCondition);
end;

function TAqDBSQLDelete.GetTable: IAqDBSQLTable;
begin
  Result := FTable;
end;

procedure TAqDBSQLDelete.SetCondition(pValue: IAqDBSQLCondition);
begin
  FCondition := pValue;
end;

{ TAqDBSQLGenericConstant<T> }

constructor TAqDBSQLGenericConstant<T>.Create(const pValue: T; const pAlias: string;
  const pAggregator: TAqDBSQLAggregatorType);
begin
  inherited Create(pAlias, pAggregator);

  FValue := pValue;
end;

function TAqDBSQLGenericConstant<T>.GetValue: T;
begin
  Result := FValue;
end;

{ TAqDBSQLIntConstant }

function TAqDBSQLIntConstant.GetAsIntConstant: IAqDBSQLIntConstant;
begin
  Result := Self;
end;

function TAqDBSQLIntConstant.GetConstantType: TAqDBSQLConstantValueType;
begin
  Result := TAqDBSQLConstantValueType.cvInt;
end;

{ TAqDBSQLDoubleConstant }

function TAqDBSQLDoubleConstant.GetAsDoubleConstant: IAqDBSQLDoubleConstant;
begin
  Result := Self;
end;

function TAqDBSQLDoubleConstant.GetConstantType: TAqDBSQLConstantValueType;
begin
  Result := TAqDBSQLConstantValueType.cvDouble;
end;

{ TAqDBSQLCurrencyConstant }

function TAqDBSQLCurrencyConstant.GetAsCurrencyConstant: IAqDBSQLCurrencyConstant;
begin
  Result := Self;
end;

function TAqDBSQLCurrencyConstant.GetConstantType: TAqDBSQLConstantValueType;
begin
  Result := TAqDBSQLConstantValueType.cvCurrency;
end;

{ TAqDBSQLUIntConstant }

function TAqDBSQLUIntConstant.GetAsUIntConstant: IAqDBSQLUIntConstant;
begin
  Result := Self;
end;

function TAqDBSQLUIntConstant.GetConstantType: TAqDBSQLConstantValueType;
begin
  Result := TAqDBSQLConstantValueType.cvUInt;
end;

{ TAqDBSQLOderByItem }

constructor TAqDBSQLOrderByItem.Create(pValue: IAqDBSQLValue; const pDesc: Boolean);
begin
  FValue := pValue;
  FDesc := pDesc;
end;

function TAqDBSQLOrderByItem.GetDesc: Boolean;
begin
  Result := FDesc;
end;

function TAqDBSQLOrderByItem.GetValue: IAqDBSQLValue;
begin
  Result := FValue;
end;

end.
