unit AqDrop.DB.SQL.Intf;

interface

uses
  AqDrop.Core.Collections.Intf;

type
  TAqDBSQLCommandType = (ctSelect, ctInsert, ctUpdate, ctDelete);
  TAqDBSQLSourceType = (stTable, stSelect);
  TAqDBSQLValueType = (vtColumn, vtOperation, vtSubselect, vtConstant, vtParameter);
  TAqDBSQLConstantValueType = (cvText, cvInt, cvDouble, cvCurrency, cvDateTime, cvDate, cvTime, cvBoolean, cvUInt);
  TAqDBSQLAggregatorType = (atNone, atCount, atSum, atAvg, atMax, atMin);
  TAqDBSQLConditionType = (ctComparison, ctValueIsNull, ctComposed, ctBetween);
  TAqDBSQLOperator = (opSum, opSubtraction, opMultiplication, opDivision, opDiv, opMod);
  TAqDBSQLComparison = (cpEqual, cpGreaterThan, cpGreaterEqual, cpLessThan, cpLessEqual);
  TAqDBSQLJoinType = (jtInnerJoin, jtLeftJoin);
  TAqDBSQLBooleanOperator = (boAnd, boOr, boXor);


  IAqDBSQLAliasable = interface;

  IAqDBSQLColumn = interface;
  IAqDBSQLOperation = interface;
  IAqDBSQLSubselect = interface;
  IAqDBSQLConstant = interface;
  IAqDBSQLParameter = interface;

  IAqDBSQLComparisonCondition = interface;
  IAqDBSQLValueIsNullCondition = interface;
  IAqDBSQLComposedCondition = interface;
  IAqDBSQLBetweenCondition = interface;

  IAqDBSQLTextConstant = interface;
  IAqDBSQLIntConstant = interface;
  IAqDBSQLUIntConstant = interface;
  IAqDBSQLDoubleConstant = interface;
  IAqDBSQLCurrencyConstant = interface;
  IAqDBSQLDateTimeConstant = interface;
  IAqDBSQLDateConstant = interface;
  IAqDBSQLTimeConstant = interface;
  IAqDBSQLBooleanConstant = interface;

  IAqDBSQLSource = interface;
  IAqDBSQLTable = interface;
  IAqDBSQLSelect = interface;

  IAqDBSQLCommand = interface;
  IAqDBSQLInsert = interface;
  IAqDBSQLUpdate = interface;
  IAqDBSQLDelete = interface;

  IAqDBSQLAliasable = interface
    ['{E4657747-4933-46BB-97E9-D1883CC710B5}']
    function GetAlias: string;
    function GetIsAliasDefined: Boolean;

    property Alias: string read GetAlias;
    property IsAliasDefined: Boolean read GetIsAliasDefined;
  end;

  IAqDBSQLValue = interface(IAqDBSQLAliasable)
    ['{FC32DA9C-6B27-45F2-B532-6804FA4AA455}']

    function GetAggregator: TAqDBSQLAggregatorType;

    function GetValueType: TAqDBSQLValueType;
    function GetAsColumn: IAqDBSQLColumn;
    function GetAsOperation: IAqDBSQLOperation;
    function GetAsSubselect: IAqDBSQLSubselect;
    function GetAsConstant: IAqDBSQLConstant;
    function GetAsParameter: IAqDBSQLParameter;

    property ValueType: TAqDBSQLValueType read GetValueType;
    property Aggregator: TAqDBSQLAggregatorType read GetAggregator;
  end;

  IAqDBSQLColumn = interface(IAqDBSQLValue)
    ['{AEE2619F-6157-45C8-B758-AEB3EE523453}']
    function GetExpression: string;
    function GetIsSourceDefined: Boolean;
    function GetSource: IAqDBSQLSource;

    property Expression: string read GetExpression;
    property IsSourceDefined: Boolean read GetIsSourceDefined;
    property Source: IAqDBSQLSource read GetSource;
  end;

  IAqDBSQLOperation = interface(IAqDBSQLValue)
    ['{ADB54B9E-124B-4FBE-9343-9DB8D79B687E}']
    function GetLeftOperand: IAqDBSQLValue;
    function GetOperator: TAqDBSQLOperator;
    function GetRightOperand: IAqDBSQLValue;

    property LeftOperand: IAqDBSQLValue read GetLeftOperand;
    property Operator: TAqDBSQLOperator read GetOperator;
    property RightOperand: IAqDBSQLValue read GetRightOperand;
  end;

  // pode ser que este conjunto de classes seja desnecessário
  IAqDBSQLConstant = interface(IAqDBSQLValue)
    ['{D285A005-1E04-4195-8812-61A608469947}']
    function GetConstantType: TAqDBSQLConstantValueType;

    property ConstantType: TAqDBSQLConstantValueType read GetConstantType;

    function GetAsTextConstant: IAqDBSQLTextConstant;
    function GetAsIntConstant: IAqDBSQLIntConstant;
    function GetAsDoubleConstant: IAqDBSQLDoubleConstant;
    function GetAsCurrencyConstant: IAqDBSQLCurrencyConstant;
    function GetAsDateTimeConstant: IAqDBSQLDateTimeConstant;
    function GetAsDateConstant: IAqDBSQLDateConstant;
    function GetAsTimeConstant: IAqDBSQLTimeConstant;
    function GetAsBooleanConstant: IAqDBSQLBooleanConstant;
    function GetAsUIntConstant: IAqDBSQLUIntConstant;
  end;

  IAqDBSQLTextConstant = interface(IAqDBSQLConstant)
    ['{F6994A33-3466-45C2-A3A1-18F5FEC8A085}']

    function GetValue: string;

    property Value: string read GetValue;
  end;

  IAqDBSQLIntConstant = interface(IAqDBSQLConstant)
    ['{295A5BBB-BBF1-4116-AF2D-065AB1ACB319}']

    function GetValue: Int64;

    property Value: Int64 read GetValue;
  end;

  IAqDBSQLUIntConstant = interface(IAqDBSQLConstant)
    ['{B70B8502-A9E6-4785-98A6-B8E7884DD72A}']

    function GetValue: UInt64;

    property Value: UInt64 read GetValue;
  end;

  IAqDBSQLDoubleConstant = interface(IAqDBSQLConstant)
    ['{5A58062E-E2D2-4D01-A766-6C1D8B5D67FF}']

    function GetValue: Double;

    property Value: Double read GetValue;
  end;

  IAqDBSQLCurrencyConstant = interface(IAqDBSQLConstant)
    ['{C67AD516-8976-45C0-8201-0D46787E5DCA}']

    function GetValue: Currency;

    property Value: Currency read GetValue;
  end;

  IAqDBSQLDateTimeConstant = interface(IAqDBSQLConstant)
    ['{B86A810B-2C1B-4CE5-99B5-BC7A1CDA7A7F}']

    function GetValue: TDateTime;

    property Value: TDateTime read GetValue;
  end;

  IAqDBSQLDateConstant = interface(IAqDBSQLConstant)
    ['{6FCC3B86-E7D0-4B29-B1B5-F2B2617EC687}']

    function GetValue: TDate;

    property Value: TDate read GetValue;
  end;

  IAqDBSQLTimeConstant = interface(IAqDBSQLConstant)
    ['{E01C3405-6619-45DB-969D-26C564AE2636}']

    function GetValue: TTime;

    property Value: TTime read GetValue;
  end;

  IAqDBSQLBooleanConstant = interface(IAqDBSQLConstant)
    ['{920397AF-DBFE-4AA1-B304-9FF3CAD61ED0}']

    function GetValue: Boolean;

    property Value: Boolean read GetValue;
  end;

  IAqDBSQLSubselect = interface(IAqDBSQLValue)
    ['{77EB53C3-9B6F-4D3A-9FDD-758564209645}']
    function GetSelect: IAqDBSQLSelect;

    property Select: IAqDBSQLSelect read GetSelect;
  end;

  IAqDBSQLParameter = interface(IAqDBSQLValue)
    ['{B38B76A6-74EF-466F-92C9-0664CC5C6AEA}']
    function GetName: string;

    property Name: string read GetName;
  end;

  IAqDBSQLSource = interface(IAqDBSQLAliasable)
    ['{8890C50B-B2ED-4F5C-986E-6CE217DF639C}']
    function GetSourceType: TAqDBSQLSourceType;

    function GetAsTable: IAqDBSQLTable;
    function GetAsSelect: IAqDBSQLSelect;

    property SourceType: TAqDBSQLSourceType read GetSourceType;
  end;

  IAqDBSQLTable = interface(IAqDBSQLSource)
    ['{52EB5137-5D3E-4B2E-8CC1-556F63933205}']
    function GetName: string;

    property Name: string read GetName;
  end;

  IAqDBSQLCondition = interface
    ['{29E8EE3A-8CF5-404F-8A23-F2BEAB43F79D}']

    function GetConditionType: TAqDBSQLConditionType;

    function GetAsComparison: IAqDBSQLComparisonCondition;
    function GetAsValueIsNull: IAqDBSQLValueIsNullCondition;
    function GetAsComposed: IAqDBSQLComposedCondition;
    function GetAsBetween: IAqDBSQLBetweenCondition;

    property ConditionType: TAqDBSQLConditionType read GetConditionType;
  end;

  IAqDBSQLComparisonCondition = interface(IAqDBSQLCondition)
    ['{2448EC86-D178-422B-B283-7F677AD1CE95}']

    function GetLeftValue: IAqDBSQLValue;
    function GetComparison: TAqDBSQLComparison;
    function GetRightValue: IAqDBSQLValue;

    procedure SetLeftValue(pValue: IAqDBSQLValue);
    procedure SetRightValue(pValue: IAqDBSQLValue);
    procedure SetComparison(const pComparison: TAqDBSQLComparison);

    property LeftValue: IAqDBSQLValue read GetLeftValue write SetLeftValue;
    property Comparison: TAqDBSQLComparison read GetComparison write SetComparison;
    property RightValue: IAqDBSQLValue read GetRightValue write SetRightValue;
  end;

  IAqDBSQLValueIsNullCondition = interface(IAqDBSQLCondition)
    ['{095FEB07-4D62-48EE-AAD2-839BB91101FB}']

    function GetValue: IAqDBSQLValue;

    property Value: IAqDBSQLValue read GetValue;
  end;

  IAqDBSQLComposedCondition = interface(IAqDBSQLCondition)
    ['{3FF25D29-ECDF-4C9C-8C1A-23E4EE52CF65}']

    function GetConditions: IAqReadList<IAqDBSQLCondition>;
    function GetLinkOperators: IAqReadList<TAqDBSQLBooleanOperator>;
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

    property Conditions: IAqReadList<IAqDBSQLCondition> read GetConditions;
    property LinkOperators: IAqReadList<TAqDBSQLBooleanOperator> read GetLinkOperators;
    property IsInitialized: Boolean read GetIsInitialized;
  end;

  IAqDBSQLBetweenCondition = interface(IAqDBSQLCondition)
    function GetValue: IAqDBSQLValue;
    function GetRangeBegin: IAqDBSQLValue;
    function GetRangeEnd: IAqDBSQLValue;

    property Value: IAqDBSQLValue read GetValue;
    property RangeBegin: IAqDBSQLValue read GetRangeBegin;
    property RangeEnd: IAqDBSQLValue read GetRangeEnd;
  end;

  IAqDBSQLJoin = interface
    ['{311D15C5-7692-4E3B-AA83-179B624AC20C}']
    function GetSource: IAqDBSQLSource;
    function GetCondition: IAqDBSQLCondition;
    function GetJoinType: TAqDBSQLJoinType;

    function &On(const pColumnName: string): IAqDBSQLJoin;
    function EqualsTo(const pColumnName: string): IAqDBSQLJoin;

    property JoinType: TAqDBSQLJoinType read GetJoinType;
    property Source: IAqDBSQLSource read GetSource;
    property Condition: IAqDBSQLCondition read GetCondition;
  end;

  IAqDBSQLOrderByItem = interface
    ['{CBBDA2D1-FF3B-4C65-942A-D030AE76A572}']
    function GetValue: IAqDBSQLValue;
    function GetDesc: Boolean;

    property Value: IAqDBSQLValue read GetValue;
    property Desc: Boolean read GetDesc;
  end;

  IAqDBSQLSelect = interface(IAqDBSQLSource)
    ['{05EED8D5-FD87-4157-89D8-F295B921FC4E}']
    function GetColumns: IAqReadList<IAqDBSQLValue>;
    function GetColumnByExpression(const pExpression: string): IAqDBSQLColumn;
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
    procedure UnsetLimit;

    function GetIsOrderByDefined: Boolean;
    function GetOrderBy: IAqReadList<IAqDBSQLOrderByItem>;
    function AddOrderBy(pValue: IAqDBSQLValue; const pDesc: Boolean = False): Int32;

    function AddColumn(pValue: IAqDBSQLValue): Int32; overload;
    function AddColumn(const pExpression: string; const pAlias: string = ''; pSource: IAqDBSQLSource = nil;
      const pAggregator: TAqDBSQLAggregatorType = atNone): IAqDBSQLColumn; overload;

    function AddJoin(const pType: TAqDBSQLJoinType; pSource: IAqDBSQLSource;
      pCondition: IAqDBSQLCondition): IAqDBSQLJoin;
    function InnerJoin(const pTableName: string): IAqDBSQLJoin;

    property Columns: IAqReadList<IAqDBSQLValue> read GetColumns;
    property Source: IAqDBSQLSource read GetSource;

    property HasJoins: Boolean read GetHasJoins;
    property Joins: IAqReadList<IAqDBSQLJoin> read GetJoins;

    property IsConditionDefined: Boolean read GetIsConditionDefined;
    property Condition: IAqDBSQLCondition read GetCondition write SetCondition;

    property IsLimitDefined: Boolean read GetIsLimitDefined;
    property Limit: UInt32 read GetLimit write SetLimit;

    property IsOrderByDefined: Boolean read GetIsOrderByDefined;
    property OrderBy: IAqReadList<IAqDBSQLOrderByItem> read GetOrderBy;
  end;

  IAqDBSQLAssignment = interface
    ['{714E4AA7-EE36-476D-BFFF-6CEAF20C1B89}']

    function GetColumn: IAqDBSQLColumn;
    function GetValue: IAqDBSQLValue;

    property Column: IAqDBSQLColumn read GetColumn;
    property Value: IAqDBSQLValue read GetValue;
  end;

  IAqDBSQLCommand = interface
    ['{B9C3C25D-A47B-4FF3-AF08-88FAF40B37A7}']
    function GetCommandType: TAqDBSQLCommandType;

    function GetAsSelect: IAqDBSQLSelect;
    function GetAsInsert: IAqDBSQLInsert;
    function GetAsUpdate: IAqDBSQLUpdate;
    function GetAsDelete: IAqDBSQLDelete;

    property CommandType: TAqDBSQLCommandType read GetCommandType;
  end;

  IAqDBSQLInsert = interface(IAqDBSQLCommand)
    ['{A8E24816-1545-4291-B598-FC7872CBB6B7}']

    function GetTable: IAqDBSQLTable;
    function GetAssignments: IAqReadList<IAqDBSQLAssignment>;

    function AddAssignment(pAssignment: IAqDBSQLAssignment): Int32; overload;
    function AddAssignment(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue): IAqDBSQLAssignment; overload;

    property Table: IAqDBSQLTable read GetTable;
    property Assignments: IAqReadList<IAqDBSQLAssignment> read GetAssignments;
  end;

  IAqDBSQLUpdate = interface(IAqDBSQLCommand)
    ['{A8E24816-1545-4291-B598-FC7872CBB6B7}']

    function GetTable: IAqDBSQLTable;
    function GetAssignments: IAqReadList<IAqDBSQLAssignment>;

    function GetIsConditionDefined: Boolean;
    function GetCondition: IAqDBSQLCondition;
    procedure SetCondition(pValue: IAqDBSQLCondition);

    function AddAssignment(pAssignment: IAqDBSQLAssignment): Int32; overload;
    function AddAssignment(pColumn: IAqDBSQLColumn; pValue: IAqDBSQLValue): IAqDBSQLAssignment; overload;

    function CustomizeCondition(pNewCondition: IAqDBSQLCondition = nil): IAqDBSQLComposedCondition;

    property Table: IAqDBSQLTable read GetTable;
    property Assignments: IAqReadList<IAqDBSQLAssignment> read GetAssignments;
    property IsConditionDefined: Boolean read GetIsConditionDefined;
    property Condition: IAqDBSQLCondition read GetCondition write SetCondition;
  end;

  IAqDBSQLDelete = interface(IAqDBSQLCommand)
    ['{5CECF01F-FF67-43C6-895E-93E224150D71}']

    function GetTable: IAqDBSQLTable;

    function GetIsConditionDefined: Boolean;
    function GetCondition: IAqDBSQLCondition;
    procedure SetCondition(pValue: IAqDBSQLCondition);

    function CustomizeCondition(pNewCondition: IAqDBSQLCondition = nil): IAqDBSQLComposedCondition;

    property Table: IAqDBSQLTable read GetTable;

    property IsConditionDefined: Boolean read GetIsConditionDefined;
    property Condition: IAqDBSQLCondition read GetCondition write SetCondition;
  end;

implementation

end.
