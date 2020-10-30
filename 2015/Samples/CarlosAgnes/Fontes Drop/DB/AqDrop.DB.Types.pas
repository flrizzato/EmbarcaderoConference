unit AqDrop.DB.Types;

interface

{$I '..\Core\AqDrop.Core.Defines.inc'}

uses
  System.Rtti,
  Data.SqlTimSt,
  Data.FmtBcd,
  AqDrop.Core.Collections,
  AqDrop.Core.Types;

type
  IAqDBReadValue = interface
    ['{F1900805-2836-42B7-88A5-776D97A02795}']
    function GetName: string;
    procedure SetName(const pName: string);

    function GetIsNull: Boolean;

    function GetAsString: string;
{$IFNDEF AQMOBILE}
    function GetAsAnsiString: AnsiString;
{$ENDIF}
    function GetAsBoolean: Boolean;
    function GetAsTimeStamp: TSQLTimeStamp;
    function GetAsTimeStampOffset: TSQLTimeStampOffset;
    function GetAsBCD: TBcd;
    function GetAsDate: TDate;
    function GetAsTime: TTime;
    function GetAsDateTime: TDateTime;
    function GetAsUInt8: UInt8;
    function GetAsInt8: Int8;
    function GetAsUInt16: UInt16;
    function GetAsInt16: Int16;
    function GetAsUInt32: UInt32;
    function GetAsInt32: Int32;
    function GetAsUInt64: UInt64;
    function GetAsInt64: Int64;
    function GetAsSingle: Single;
    function GetAsDouble: Double;
    function GetAsCurrency: Currency;

    property Name: string read GetName write SetName;

    property AsString: string read GetAsString;
{$IFNDEF AQMOBILE}
    property AsAnsiString: AnsiString read GetAsAnsiString;
{$ENDIF}
    property AsBoolean: Boolean read GetAsBoolean;
    property AsTimeStamp: TSQLTimeStamp read GetAsTimeStamp;
    property AsTimeStampOffset: TSQLTimeStampOffset read GetAsTimeStampOffset;
    property AsBCD: TBcd read GetAsBCD;
    property AsDate: TDate read GetAsDate;
    property AsTime: TTime read GetAsTime;
    property AsDateTime: TDateTime read GetAsDateTime;
    property AsUInt8: UInt8 read GetAsUInt8;
    property AsInt8: Int8 read GetAsInt8;
    property AsUInt16: UInt16 read GetAsUInt16;
    property AsInt16: Int16 read GetAsInt16;
    property AsUInt32: UInt32 read GetAsUInt32;
    property AsInt32: Int32 read GetAsInt32;
    property AsUInt64: UInt64 read GetAsUInt64;
    property AsInt64: Int64 read GetAsInt64;
    property AsSingle: Single read GetAsSingle;
    property AsDouble: Double read GetAsDouble;
    property AsCurrency: Currency read GetAsCurrency;
    property IsNull: Boolean read GetIsNull;
  end;

  IAqDBValue = interface(IAqDBReadValue)
    ['{6C1F05B1-85D1-4EA3-9DBB-0EC1F90FEC27}']
    procedure SetDataType(const pDataType: TAqDataType);

    procedure SetAsString(const pValue: string);
{$IFNDEF AQMOBILE}
    procedure SetAsAnsiString(const pValue: AnsiString);
{$ENDIF}
    procedure SetAsBoolean(const pValue: Boolean);
    procedure SetAsTimeStamp(const pValue: TSQLTimeStamp);
    procedure SetAsTimeStampOffset(const pValue: TSQLTimeStampOffset);
    procedure SetAsBCD(const pValue: TBcd);
    procedure SetAsDate(const pValue: TDate);
    procedure SetAsTime(const pValue: TTime);
    procedure SetAsDateTime(const pValue: TDateTime);
    procedure SetAsUInt8(const pValue: UInt8);
    procedure SetAsInt8(const pValue: Int8);
    procedure SetAsUInt16(const pValue: UInt16);
    procedure SetAsInt16(const pValue: Int16);
    procedure SetAsUInt32(const pValue: UInt32);
    procedure SetAsInt32(const pValue: Int32);
    procedure SetAsUInt64(const pValue: UInt64);
    procedure SetAsInt64(const pValue: Int64);
    procedure SetAsSingle(const pValue: Single);
    procedure SetAsDouble(const pValue: Double);
    procedure SetAsCurrency(const pValue: Currency);

    procedure SetNull(const pDataType: TAqDataType = TAqDataType.adtUnknown);

    property AsString: string read GetAsString write SetAsString;
{$IFNDEF AQMOBILE}
    property AsAnsiString: AnsiString read GetAsAnsiString write SetAsAnsiString;
{$ENDIF}
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsTimeStamp: TSQLTimeStamp read GetAsTimeStamp write SetAsTimeStamp;
    property AsTimeStampOffset: TSQLTimeStampOffset read GetAsTimeStampOffset write SetAsTimeStampOffset;
    property AsBCD: TBcd read GetAsBCD write SetAsBCD;
    property AsDate: TDate read GetAsDate write SetAsDate;
    property AsTime: TTime read GetAsTime write SetAsTime;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsUInt8: UInt8 read GetAsUInt8 write SetAsUInt8;
    property AsInt8: Int8 read GetAsInt8 write SetAsInt8;
    property AsUInt16: UInt16 read GetAsUInt16 write SetAsUInt16;
    property AsInt16: Int16 read GetAsInt16 write SetAsInt16;
    property AsUInt32: UInt32 read GetAsUInt32 write SetAsUInt32;
    property AsInt32: Int32 read GetAsInt32 write SetAsInt32;
    property AsUInt64: UInt64 read GetAsUInt64 write SetAsUInt64;
    property AsInt64: Int64 read GetAsInt64 write SetAsInt64;
    property AsSingle: Single read GetAsSingle write SetAsSingle;
    property AsDouble: Double read GetAsDouble write SetAsDouble;
    property AsCurrency: Currency read GetAsCurrency write SetAsCurrency;
  end;

  IAqDBValues<I: IAqDBReadValue> = interface
    ['{23BB2D01-268C-403A-B27B-120D72D45DA4}']
    function GetValueByIndex(pIndex: Int32): I;
    function GetValueByName(pName: string): I;
    function GetCount: Int32;

    property Values[pName: string]: I read GetValueByName; default;
    property Values[pIndex: Int32]: I read GetValueByIndex; default;
    property Count: Int32 read GetCount;
  end;

  IAqDBReader = interface(IAqDBValues<IAqDBReadValue>)
    ['{B56AAE49-6EC1-416C-89CF-5BD78F14D981}']
    function Next: Boolean;
  end;

  IAqDBParameters = interface(IAqDBValues<IAqDBValue>)
    ['{AF466B6B-264D-4EDA-80B7-3FECF0144B5B}']
  end;

  TAqDBValueHandlerMethod = reference to procedure(pValue: IAqDBValue);
  TAqDBParametersHandlerMethod = reference to procedure(pParameters: IAqDBParameters);

implementation

end.
