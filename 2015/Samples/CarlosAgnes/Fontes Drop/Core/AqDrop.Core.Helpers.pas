unit AqDrop.Core.Helpers;

interface

{$I 'AqDrop.Core.Defines.inc'}

uses
  System.SysUtils,
  System.DateUtils,
  Data.FmtBcd,
  Data.SqlTimSt;

type
  TAqBooleanHelper = record helper for Boolean
  public
    class function Size: Int32; inline; static;
    class function ToString(const pValue: Boolean): string; overload; inline; static;

    function ToInt32: Int32; inline;
    function ToInt8: Int8; inline;
    function ToString: string; overload; inline;
{$IFNDEF AQMOBILE}
    function ToAnsiChar: AnsiChar;
{$ENDIF}
  end;

  TAqWeekDay = (Monday = DayMonday, Tuesday = DayTuesday, Wednesday = DayWednesday, Thursday = DayThursday,
    Friday = DayFriday, Saturday = DaySaturday, Sunday = DaySunday);
  TAqWeekDays = set of TAqWeekDay;

  TAqDateTimeHelper = record helper for TDateTime
  public
    function Format(const pMask: string): string; inline;

    function ToString: string; inline;

    function ToSQLTimeStamp: TSQLTimeStamp;

    function GetYearsDifference(const pFromDateTime: TDateTime): Int32; inline;
    function GetMonthsDifference(const pFromDateTime: TDateTime): Int32; inline;

    function GetYearsBetween(const pFromDateTime: TDateTime): Int32;
    function GetMonthsBetween(const pFromDateTime: TDateTime): Int32;
    function GetDaysBetween(const pFromDateTime: TDateTime): Int32;
    function GetHoursBetween(const pFromDateTime: TDateTime): Int32;
    function GetMinutesBetween(const pFromDateTime: TDateTime): Int32;
    function GetSecondsBetween(const pFromDateTime: TDateTime): Int32;
    function GetMillisecondsBetween(const pFromDateTime: TDateTime): Int64;

    function DateOf: TDate;
    function TimeOf: TTime;

    function YearOf: UInt16; inline;
    function MonthOf: UInt8; inline;
    function DayOf: UInt8; inline;
    function HourOf: UInt8; inline;
    function MinuteOf: UInt8; inline;
    function SecondOf: UInt8; inline;
    function MilliSecondOf: UInt16; inline;

    function DaysInMonth: UInt8; inline;

    function IncYear(const pCount: Int32 = 1): TDateTime; inline;
    function IncMonth(const pCount: Int32 = 1): TDateTime; inline;
    function IncDay(const pCount: Int32 = 1): TDateTime; inline;
    function IncHour(const pCount: Int32 = 1): TDateTime; inline;
    function IncMinute(const pCount: Int32 = 1): TDateTime; inline;
    function IncSecond(const pCount: Int32 = 1): TDateTime; inline;
    function IncMilliSecond(const pCount: Int32 = 1): TDateTime; inline;

    function GetMonthWeek: UInt8;
    function GetWeekDay: TAqWeekDay;

    procedure DecodeDateTime(out pYear: UInt16; out pMonth: UInt8; out pDay: UInt8; out pHour: UInt8;
      out pMinute: UInt8; out pSecond: UInt8; out pMillisecond: UInt16);
    procedure DecodeDate(out pYear: UInt16; out pMonth: UInt8; out pDay: UInt8);
    procedure DecodeTime(out pHour: UInt8; out pMinute: UInt8; out pSecond: UInt8; out pMillisecond: UInt16);

    class function EncodeDateTime(const pYear: UInt16; const pMonth: UInt8; const pDay: UInt8; const pHour: UInt8;
      const pMinute: UInt8; const pSecond: UInt8; const pMillisecond: UInt16): TDateTime; static;
    class function EncodeDate(const pYear: UInt16; const pMonth: UInt8; const pDay: UInt8): TDateTime; static;
    class function EncodeTime(const pHour: UInt8; const pMinute: UInt8; const pSecond: UInt8;
      const pMillisecond: UInt16): TDateTime; static;
  end;

  TAqDateHelper = record helper for TDate
  public
    function ToDateTime: TDateTime;
    function Format(const pMask: string): string;

    function GetYearsDifference(const pFromDate: TDate): Int32; inline;
    function GetMonthsDifference(const pFromDate: TDate): Int32; inline;

    function GetYearsBetween(const pFromDate: TDate): Int32;
    function GetMonthsBetween(const pFromDate: TDate): Int32;
    function GetDaysBetween(const pFromDate: TDate): Int32;

    function DateOf: TDate; inline;

    function YearOf: UInt16; inline;
    function MonthOf: UInt8; inline;
    function DayOf: UInt8; inline;

    function DaysInMonth: UInt8; inline;

    function GetMonthWeek: UInt8;
    function GetWeekDay: TAqWeekDay;

    function IncYear(const pCount: Int32 = 1): TDateTime; inline;
    function IncMonth(const pCount: Int32 = 1): TDateTime; inline;
    function IncDay(const pCount: Int32 = 1): TDateTime; inline;
    function IncHour(const pCount: Int32 = 1): TDateTime; inline;
    function IncMinute(const pCount: Int32 = 1): TDateTime; inline;
    function IncSecond(const pCount: Int32 = 1): TDateTime; inline;
    function IncMilliSecond(const pCount: Int32 = 1): TDateTime; inline;

    procedure DecodeDate(out pYear: UInt16; out pMonth: UInt8; out pDay: UInt8);

    class function GetDateToTheWeekDay(const pYear: UInt16; const pMonth: UInt8; const pWeek: UInt8;
      const pWeekDay: TAqWeekDay): TDate; overload; static;
    class function GetDateToTheWeekDay(const pBaseDate: TDate; const pWeek: UInt8;
      const pWeekDay: TAqWeekDay): TDate; overload; static;
    class function EncodeDate(const pYear: UInt16; const pMonth: UInt8; const pDay: UInt8): TDate; static;
  end;

  TAqTimeHelper = record helper for TTime
  public
    function ToDateTime: TDateTime;
    function Format(const pMask: string): string;

    function GetHoursBetween(const pFromTime: TTime): Int32;
    function GetMinutesBetween(const pFromTime: TTime): Int32;
    function GetSecondsBetween(const pFromTime: TTime): Int32;
    function GetMillisecondsBetween(const pFromTime: TTime): Int64;

    function TimeOf: TTime;

    function HourOf: UInt8; inline;
    function MinuteOf: UInt8; inline;
    function SecondOf: UInt8; inline;
    function MilliSecondOf: UInt16; inline;

    function IncYear(const pCount: Int32 = 1): TDateTime; inline;
    function IncMonth(const pCount: Int32 = 1): TDateTime; inline;
    function IncDay(const pCount: Int32 = 1): TDateTime; inline;
    function IncHour(const pCount: Int32 = 1): TDateTime; inline;
    function IncMinute(const pCount: Int32 = 1): TDateTime; inline;
    function IncSecond(const pCount: Int32 = 1): TDateTime; inline;
    function IncMilliSecond(const pCount: Int32 = 1): TDateTime; inline;

    procedure DecodeTime(out pHour: UInt8; out pMinute: UInt8; out pSecond: UInt8; out pMillisecond: UInt16);

    class function EncodeTime(const pHour: UInt8; const pMinute: UInt8; const pSecond: UInt8;
      const pMillisecond: UInt16): TDateTime; static;
  end;

  TAqBcdHelper = record helper for TBcd
  public
    function ToCurrency: Currency; inline;
    function ToDouble: Double; inline;
    function ToInt64: Int64; inline;
    function ToString: string; inline;
  end;

  TAqCurrencyHelper = record helper for Currency
  public
    function ToBcd: TBcd;
    function ToString: string;
  end;

  TAqStringHelper = record helper for string
  strict private
    procedure RaiseInvalidConversionToIntType;
    procedure RaiseInvalidConversionToDateTimeType;

    function GetChar(Index: Int32): Char;
    function GetLength: Int32;
  private
    function CompareTo(pString2: string; const pCaseSensitive: Boolean): Int32;
  public
    const Empty = '';
    const LineBreak = sLineBreak;

    function IndexOf(const pValue: string): Int32; overload; inline;
    function IsEmpty: Boolean;
    function Quote: string;
    function Substring(StartIndex: Int32; Length: Int32): string; overload;
    function LeftFromPosition(const pPosition: Int32; const pInclusive: Boolean = False): string;
    function RightFromPosition(const pPosition: Int32; const pInclusive: Boolean = False): string;
    function ToUpper: string; overload; inline;
    function Trim: string;

    function ToBoolean: Boolean;

    function TryToInt8(out pInt8: Int8): Boolean;
    function TryToUInt8(out pUInt8: UInt8): Boolean;
    function TryToInt16(out pInt16: Int16): Boolean;
    function TryToUInt16(out pUInt16: UInt16): Boolean;
    function TryToInt32(out pInt32: Int32): Boolean; inline;
    function TryToUInt32(out pUInt32: UInt32): Boolean;
    function TryToInt64(out pInt64: Int64): Boolean; inline;
    function TryToUInt64(out pUInt64: UInt64): Boolean;

    function TryToDouble(out pDouble: Double): Boolean; inline;
    function TryToCurrency(out pCurrency: Currency): Boolean; inline;

    function TryToDateTime(out pDateTime: TDateTime): Boolean; inline;
    function TryToDate(out pDate: TDate): Boolean;
    function TryToTime(out pTime: TTime): Boolean;

    function ToInt8: Int8;
    function ToUInt8: UInt8;
    function ToInt16: Int16;
    function ToUInt16: UInt16;
    function ToInt32: Int32;
    function ToUInt32: UInt32;
    function ToInt64: Int64;
    function ToUInt64: UInt64;

    function ToDouble: Double;
    function ToCurrency: Currency;

    function ToDateTime: TDateTime;
    function ToDate: TDate;
    function ToTime: TTime;

    function ToInt8Def(const pDefault: Int8): Int8;
    function ToUInt8Def(const pDefault: UInt8): UInt8;
    function ToInt16Def(const pDefault: Int16): Int16;
    function ToUInt16Def(const pDefault: UInt16): UInt16;
    function ToInt32Def(const pDefault: Int32): Int32;
    function ToUInt32Def(const pDefault: UInt32): UInt32;
    function ToInt64Def(const pDefault: Int64): Int64;
    function ToUInt64Def(const pDefault: UInt64): UInt64;

    function ToDoubleDef(const pDefault: Double): Double;
    function ToCurrencyDef(const pDefault: Currency): Currency;

    function ToDateTimeDef(const pDefault: TDateTime): TDateTime;
    function ToDateDef(const pDefault: TDate): TDate;
    function ToTimeDef(const pDefault: TTime): TTime;

    class function SameText(const pText1, pText2: string): Boolean; static; inline;

    property Chars[Index: Int32]: Char read GetChar;
    property Length: Int32 read GetLength;
  end;

  TAqDoubleHelper = record helper for Double
  public
    function ToString: string; inline;
    function Trunc: Int64; inline;
    function Frac: Double; inline;
  end;

  TAqSingleHelper = record helper for Single
  public
    function ToString: string; inline;
    function Trunc: Int64; inline;
    function Frac: Single; inline;
  end;

  TAqInt8Helper = record helper for Int8
  public
    function ToString: string; inline;
  end;

  TAqUInt8Helper = record helper for UInt8
  public
    function ToString: string; inline;
  end;

  TAqInt16Helper = record helper for Int16
  public
    function ToString: string; inline;
  end;

  TAqUInt16Helper = record helper for UInt16
  public
    function ToString: string; inline;
  end;

  TAqInt32Helper = record helper for Int32
  public
    function ToString: string; inline;
  end;

  TAqUInt32Helper = record helper for UInt32
  public
    function ToString: string; inline;
  end;

  TAqInt64Helper = record helper for Int64
  public
    function ToString: string; inline;
  end;

  TAqUInt64Helper = record helper for UInt64
  public
    function ToString: string; inline;
  end;

  TAqNativeUInt = record helper for NativeUInt
    function ToString: string; inline;
  end;

implementation

uses
  System.Math,
  AqDrop.Core.Exceptions
{$IF defined(MSWINDOWS)}
  ,Winapi.Windows
{$ENDIF}
  ;

{ TAqBooleanHelper }

class function TAqBooleanHelper.Size: Int32;
begin
  Result := SizeOf(Boolean);
end;

{$IFNDEF AQMOBILE}
function TAqBooleanHelper.ToAnsiChar: AnsiChar;
begin
  if Self then
  begin
    Result := '1';
  end else begin
    Result := '0';
  end;
end;
{$ENDIF}

function TAqBooleanHelper.ToInt8: Int8;
begin
  if Self then
  begin
    Result := 1;
  end else begin
    Result := 0;
  end;
end;

function TAqBooleanHelper.ToInt32: Int32;
begin
  Result := ToInt8;
end;

class function TAqBooleanHelper.ToString(const pValue: Boolean): string;
begin
  Result := BoolToStr(pValue);
end;

function TAqBooleanHelper.ToString: string;
begin
  Result := BoolToStr(Self, True);
end;

{ TAqDateTimeHelper }

function TAqDateTimeHelper.DateOf: TDate;
begin
  Result := System.DateUtils.DateOf(Self);
end;

function TAqDateTimeHelper.DayOf: UInt8;
begin
  Result := System.DateUtils.DayOf(Self);
end;

function TAqDateTimeHelper.DaysInMonth: UInt8;
begin
  Result := System.DateUtils.DaysInMonth(Self);
end;

procedure TAqDateTimeHelper.DecodeDate(out pYear: UInt16; out pMonth, pDay: UInt8);
var
  lMonth: UInt16;
  lDay: UInt16;
begin
  System.SysUtils.DecodeDate(Self, pYear, lMonth, lDay);

  pMonth := lMonth;
  pDay := lDay;
end;

procedure TAqDateTimeHelper.DecodeDateTime(out pYear: UInt16; out pMonth, pDay, pHour, pMinute, pSecond: UInt8;
  out pMillisecond: UInt16);
var
  lMonth: UInt16;
  lDay: UInt16;
  lHour: UInt16;
  lMinute: UInt16;
  lSecond: UInt16;
begin
  System.DateUtils.DecodeDateTime(Self, pYear, lMonth, lDay, lHour, lMinute, lSecond, pMillisecond);

  pMonth := lMonth;
  pDay := lDay;
  pHour := lHour;
  pMinute := lMinute;
  pSecond := lSecond;
end;

procedure TAqDateTimeHelper.DecodeTime(out pHour, pMinute, pSecond: UInt8; out pMillisecond: UInt16);
var
  lHour: UInt16;
  lMinute: UInt16;
  lSecond: UInt16;
begin
  System.SysUtils.DecodeTime(Self, lHour, lMinute, lSecond, pMillisecond);

  pHour := lHour;
  pMinute := lMinute;
  pSecond := lSecond;
end;

class function TAqDateTimeHelper.EncodeDate(const pYear: UInt16; const pMonth, pDay: UInt8): TDateTime;
begin
  Result := System.SysUtils.EncodeDate(pYear, pMonth, pDay);
end;

class function TAqDateTimeHelper.EncodeDateTime(const pYear: UInt16; const pMonth, pDay, pHour, pMinute, pSecond: UInt8;
  const pMillisecond: UInt16): TDateTime;
begin
  Result := System.DateUtils.EncodeDateTime(pYear, pMonth, pDay, pHour, pMinute, pSecond, pMillisecond);
end;

class function TAqDateTimeHelper.EncodeTime(const pHour, pMinute, pSecond: UInt8;
  const pMillisecond: UInt16): TDateTime;
begin
  Result := System.SysUtils.EncodeTime(pHour, pMinute, pSecond, pMillisecond);
end;

function TAqDateTimeHelper.Format(const pMask: string): string;
begin
  Result := System.SysUtils.FormatDateTime(pMask, Self);
end;

function TAqDateTimeHelper.GetDaysBetween(const pFromDateTime: TDateTime): Int32;
begin
  Result := System.Trunc(Self - pFromDateTime);
end;

function TAqDateTimeHelper.GetHoursBetween(const pFromDateTime: TDateTime): Int32;
begin
  Result := System.Trunc((Self - pFromDateTime) / OneHour);
end;

function TAqDateTimeHelper.GetMillisecondsBetween(const pFromDateTime: TDateTime): Int64;
begin
  Result := System.Trunc((Self - pFromDateTime) / OneMillisecond);
end;

function TAqDateTimeHelper.GetMinutesBetween(const pFromDateTime: TDateTime): Int32;
begin
  Result := System.Trunc((Self - pFromDateTime) / OneMinute);
end;

function TAqDateTimeHelper.GetMonthsBetween(const pFromDateTime: TDateTime): Int32;
var
  lStartDateTime: TDateTime;
  lFinalDateTime: TDateTime;
  lStartDateDay: UInt8;
  lFinalDateDay: UInt8;
  lDaysInTheFinalMonth: UInt16;
  lStartTime: TTime;
  lFinalTime: TTime;
begin
  if Self <> pFromDateTime then
  begin
    lStartDateTime := Min(pFromDateTime, Self);
    lFinalDateTime := Max(pFromDateTime, Self);

    lStartDateDay := lStartDateTime.DayOf;
    lFinalDateDay := lFinalDateTime.DayOf;
    lStartTime := lStartDateTime.TimeOf;
    lFinalTime := lFinalDateTime.TimeOf;
    lDaysInTheFinalMonth := lFinalDateTime.DaysInMonth;

    Result := lFinalDateTime.GetMonthsDifference(lStartDateTime) +
      IfThen(((lFinalDateDay > lStartDateDay) or ((lFinalDateDay = lStartDateDay) and (lFinalTime >= lStartTime)))
      or ((lFinalDateDay = lDaysInTheFinalMonth) and (lStartDateDay > lDaysInTheFinalMonth)), 1) - 1;

    if pFromDateTime > Self then
    begin
      Result := Result * -1;
    end;
  end else begin
    Result := 0;
  end;
end;

function TAqDateTimeHelper.GetMonthsDifference(const pFromDateTime: TDateTime): Int32;
begin
  Result := (GetYearsDifference(pFromDateTime) * MonthsPerYear) + (MonthOf - pFromDateTime.MonthOf);
end;

function TAqDateTimeHelper.GetMonthWeek: UInt8;
begin
  Result := (Self.DayOf - 1) div DaysPerWeek;
end;

function TAqDateTimeHelper.GetSecondsBetween(const pFromDateTime: TDateTime): Int32;
begin
  Result := System.Trunc((Self - pFromDateTime) / OneSecond);
end;

function TAqDateTimeHelper.GetWeekDay: TAqWeekDay;
begin
  Result := TAqWeekDay(DayOfTheWeek(Self));
end;

function TAqDateTimeHelper.GetYearsBetween(const pFromDateTime: TDateTime): Int32;
begin
  Result := Self.GetMonthsBetween(pFromDateTime) div MonthsPerYear;
end;

function TAqDateTimeHelper.GetYearsDifference(const pFromDateTime: TDateTime): Int32;
begin
  Result := Self.YearOf - pFromDateTime.YearOf;
end;

function TAqDateTimeHelper.HourOf: UInt8;
begin
  Result := System.DateUtils.HourOf(Self);
end;

function TAqDateTimeHelper.IncDay(const pCount: Int32): TDateTime;
begin
  Result := System.DateUtils.IncDay(Self, pCount);
end;

function TAqDateTimeHelper.IncHour(const pCount: Int32): TDateTime;
begin
  Result := System.DateUtils.IncHour(Self, pCount);
end;

function TAqDateTimeHelper.IncMilliSecond(const pCount: Int32): TDateTime;
begin
  Result := System.DateUtils.IncMilliSecond(Self, pCount);
end;

function TAqDateTimeHelper.IncMinute(const pCount: Int32): TDateTime;
begin
  Result := System.DateUtils.IncMinute(Self, pCount);
end;

function TAqDateTimeHelper.IncMonth(const pCount: Int32): TDateTime;
begin
  Result := System.SysUtils.IncMonth(Self, pCount);
end;

function TAqDateTimeHelper.IncSecond(const pCount: Int32): TDateTime;
begin
  Result := System.DateUtils.IncSecond(Self, pCount);
end;

function TAqDateTimeHelper.IncYear(const pCount: Int32): TDateTime;
begin
  Result := System.DateUtils.IncYear(Self, pCount);
end;

function TAqDateTimeHelper.MilliSecondOf: UInt16;
begin
  Result := System.DateUtils.MilliSecondOf(Self);
end;

function TAqDateTimeHelper.MinuteOf: UInt8;
begin
  Result := System.DateUtils.MinuteOf(Self);
end;

function TAqDateTimeHelper.MonthOf: UInt8;
begin
  Result := System.DateUtils.MonthOf(Self);
end;

function TAqDateTimeHelper.SecondOf: UInt8;
begin
  Result := System.DateUtils.SecondOf(Self);
end;

function TAqDateTimeHelper.TimeOf: TTime;
begin
  Result := System.DateUtils.TimeOf(Self);
end;

function TAqDateTimeHelper.ToSQLTimeStamp: TSQLTimeStamp;
begin
  Result.Year := Self.YearOf;
  Result.Month := Self.MonthOf;
  Result.Day := Self.DayOf;
  Result.Hour := Self.HourOf;
  Result.Minute := Self.MinuteOf;
  Result.Second := Self.SecondOf;
  Result.Fractions := Self.MilliSecondOf;
end;

function TAqDateTimeHelper.ToString: string;
begin
  Result := DateToStr(Self);
end;

function TAqDateTimeHelper.YearOf: UInt16;
begin
  Result := System.DateUtils.YearOf(Self);
end;

{ TAqDateHelper }

function TAqDateHelper.DateOf: TDate;
begin
  Result := TDateTime(Self).DateOf;
end;

function TAqDateHelper.DayOf: UInt8;
begin
  Result := Self.ToDateTime.DayOf;
end;

function TAqDateHelper.DaysInMonth: UInt8;
begin
  Result := Self.ToDateTime.DaysInMonth;
end;

procedure TAqDateHelper.DecodeDate(out pYear: UInt16; out pMonth, pDay: UInt8);
begin
  Self.ToDateTime.DecodeDate(pYear, pMonth, pDay);
end;

class function TAqDateHelper.EncodeDate(const pYear: UInt16; const pMonth, pDay: UInt8): TDate;
begin
  Result := TDateTime.EncodeDate(pYear, pMonth, pDay);
end;

function TAqDateHelper.Format(const pMask: string): string;
begin
  Result := Self.ToDateTime.Format(pMask);
end;

class function TAqDateHelper.GetDateToTheWeekDay(const pYear: UInt16; const pMonth, pWeek: UInt8;
  const pWeekDay: TAqWeekDay): TDate;
begin
  Result := TDate.EncodeDate(pYear, pMonth, 1);
  Result := TDate.EncodeDate(pYear, pMonth,
    ((Int32(pWeekDay) - DayOfTheWeek(Result) + DaysPerWeek) mod DaysPerWeek) + (pWeek * DaysPerWeek) + 1);
end;

class function TAqDateHelper.GetDateToTheWeekDay(const pBaseDate: TDate; const pWeek: UInt8;
  const pWeekDay: TAqWeekDay): TDate;
begin
  Result := GetDateToTheWeekDay(pBaseDate.YearOf, pBaseDate.MonthOf, pWeek, pWeekDay);
end;

function TAqDateHelper.GetDaysBetween(const pFromDate: TDate): Int32;
begin
  Result := Self.ToDateTime.GetDaysBetween(pFromDate.ToDateTime);
end;

function TAqDateHelper.GetMonthsBetween(const pFromDate: TDate): Int32;
begin
  Result := Self.ToDateTime.GetMonthsBetween(pFromDate.ToDateTime);
end;

function TAqDateHelper.GetMonthsDifference(const pFromDate: TDate): Int32;
begin
  Result := Self.ToDateTime.GetMonthsDifference(pFromDate);
end;

function TAqDateHelper.GetMonthWeek: UInt8;
begin
  Result := Self.ToDateTime.GetMonthWeek;
end;

function TAqDateHelper.GetWeekDay: TAqWeekDay;
begin
  Result := Self.ToDateTime.GetWeekDay;
end;

function TAqDateHelper.GetYearsBetween(const pFromDate: TDate): Int32;
begin
  Result := Self.ToDateTime.GetYearsBetween(pFromDate.ToDateTime);
end;

function TAqDateHelper.GetYearsDifference(const pFromDate: TDate): Int32;
begin
  Result := Self.ToDateTime.GetYearsDifference(pFromDate)
end;

function TAqDateHelper.IncDay(const pCount: Int32): TDateTime;
begin
  Result := Self.ToDateTime.IncDay(pCount);
end;

function TAqDateHelper.IncHour(const pCount: Int32): TDateTime;
begin
  Result := Self.ToDateTime.IncHour(pCount);
end;

function TAqDateHelper.IncMilliSecond(const pCount: Int32): TDateTime;
begin
  Result := Self.ToDateTime.IncMilliSecond(pCount);
end;

function TAqDateHelper.IncMinute(const pCount: Int32): TDateTime;
begin
  Result := Self.ToDateTime.IncMinute(pCount);
end;

function TAqDateHelper.IncMonth(const pCount: Int32): TDateTime;
begin
  Result := Self.ToDateTime.IncMonth(pCount);
end;

function TAqDateHelper.IncSecond(const pCount: Int32): TDateTime;
begin
  Result := Self.ToDateTime.IncSecond(pCount);
end;

function TAqDateHelper.IncYear(const pCount: Int32): TDateTime;
begin
  Result := Self.ToDateTime.IncYear(pCount);
end;

function TAqDateHelper.MonthOf: UInt8;
begin
  Result := Self.ToDateTime.MonthOf;
end;

function TAqDateHelper.ToDateTime: TDateTime;
begin
  Result := Self.DateOf;
end;

function TAqDateHelper.YearOf: UInt16;
begin
  Result := Self.ToDateTime.YearOf;
end;

{ TAqTimeHelper }

procedure TAqTimeHelper.DecodeTime(out pHour, pMinute, pSecond: UInt8; out pMillisecond: UInt16);
begin
  Self.ToDateTime.DecodeTime(pHour, pMinute, pSecond, pMillisecond);
end;

class function TAqTimeHelper.EncodeTime(const pHour, pMinute, pSecond: UInt8; const pMillisecond: UInt16): TDateTime;
begin
  Result := TDateTime.EncodeTime(pHour, pMinute, pSecond, pMillisecond);
end;

function TAqTimeHelper.Format(const pMask: string): string;
begin
  Result := Self.ToDateTime.Format(pMask);
end;

function TAqTimeHelper.GetHoursBetween(const pFromTime: TTime): Int32;
begin
  Result := Self.ToDateTime.GetHoursBetween(pFromTime.ToDateTime);
end;

function TAqTimeHelper.GetMillisecondsBetween(const pFromTime: TTime): Int64;
begin
  Result := Self.ToDateTime.GetMillisecondsBetween(pFromTime.ToDateTime);
end;

function TAqTimeHelper.GetMinutesBetween(const pFromTime: TTime): Int32;
begin
  Result := Self.ToDateTime.GetMinutesBetween(pFromTime.ToDateTime);
end;

function TAqTimeHelper.GetSecondsBetween(const pFromTime: TTime): Int32;
begin
  Result := Self.ToDateTime.GetSecondsBetween(pFromTime.ToDateTime);
end;

function TAqTimeHelper.HourOf: UInt8;
begin
  Result := Self.ToDateTime.HourOf;
end;

function TAqTimeHelper.IncDay(const pCount: Int32): TDateTime;
begin
  Result := Self.ToDateTime.IncDay(pCount);
end;

function TAqTimeHelper.IncHour(const pCount: Int32): TDateTime;
begin
  Result := Self.ToDateTime.IncHour(pCount);
end;

function TAqTimeHelper.IncMilliSecond(const pCount: Int32): TDateTime;
begin
  Result := Self.ToDateTime.IncMilliSecond(pCount);
end;

function TAqTimeHelper.IncMinute(const pCount: Int32): TDateTime;
begin
  Result := Self.ToDateTime.IncMinute(pCount);
end;

function TAqTimeHelper.IncMonth(const pCount: Int32): TDateTime;
begin
  Result := Self.ToDateTime.IncMonth(pCount);
end;

function TAqTimeHelper.IncSecond(const pCount: Int32): TDateTime;
begin
  Result := Self.ToDateTime.IncSecond(pCount);
end;

function TAqTimeHelper.IncYear(const pCount: Int32): TDateTime;
begin
  Result := Self.ToDateTime.IncYear(pCount);
end;

function TAqTimeHelper.MilliSecondOf: UInt16;
begin
  Result := Self.ToDateTime.MilliSecondOf;
end;

function TAqTimeHelper.MinuteOf: UInt8;
begin
  Result := Self.ToDateTime.MinuteOf;
end;

function TAqTimeHelper.SecondOf: UInt8;
begin
  Result := Self.ToDateTime.SecondOf;
end;

function TAqTimeHelper.TimeOf: TTime;
begin
  Result := TDateTime(Self).TimeOf;
end;

function TAqTimeHelper.ToDateTime: TDateTime;
begin
  Result := Self.TimeOf;
end;

{ TAqBcdHelper }

function TAqBcdHelper.ToCurrency: Currency;
begin
  Data.FmtBcd.BCDToCurr(Self, Result);
end;

function TAqBcdHelper.ToDouble: Double;
begin
  Result := Data.FmtBcd.BcdToDouble(Self);
end;

function TAqBcdHelper.ToInt64: Int64;
begin
{$if CompilerVersion >= 27}
  Result := Data.FmtBcd.BcdToInt64(Self);
{$else}
  Result := StrToInt64(BcdToStr(Self));
{$endif}
end;

function TAqBcdHelper.ToString: string;
begin
  Result := Data.FmtBcd.BcdToStr(Self);
end;

{ TAqCurrencyHelper }

function TAqCurrencyHelper.ToBcd: TBcd;
begin
  Data.FmtBcd.CurrToBCD(Self, Result);
end;

{ TAqStringHelper }

{$ZEROBASEDSTRINGS ON}

function TAqStringHelper.CompareTo(pString2: string; const pCaseSensitive: Boolean): Int32;
var
  lString1: string;
begin
  if pCaseSensitive then
  begin
    lString1 := Self;
  end else begin
    lString1 := Self.ToUpper;
    pString2 := pString2.ToUpper;
  end;

  Result := System.SysUtils.StrComp(PChar(lString1), PChar(pString2));
end;

function TAqStringHelper.GetChar(Index: Int32): Char;
begin
  Result := Self[Index];
end;

function TAqStringHelper.GetLength: Int32;
begin
  Result := System.Length(Self);
end;

function TAqStringHelper.IndexOf(const pValue: string): Int32;
begin
  Result := System.Pos(pValue, Self) - 1;
end;

function TAqStringHelper.IsEmpty: Boolean;
begin
  Result := Self = Empty;
end;

function TAqStringHelper.LeftFromPosition(const pPosition: Int32; const pInclusive: Boolean): string;
begin
  Result := Self.Substring(0, pPosition + IfThen(pInclusive, 1));
end;

procedure TAqStringHelper.RaiseInvalidConversionToDateTimeType;
begin
  raise EAqInternal.Create('Invalid conversion of string ' + Self + ' to a DateTime type.');
end;

procedure TAqStringHelper.RaiseInvalidConversionToIntType;
begin
  raise EAqInternal.Create('Invalid conversion of string ' + Self.Quote + ' to an integer type.');
end;

function TAqStringHelper.RightFromPosition(const pPosition: Int32; const pInclusive: Boolean): string;
var
  lStart: Int32;
begin
  lStart := pPosition + IfThen(not pInclusive, 1);
  Result := Self.Substring(lStart, Self.Length - lStart);
end;

function TAqStringHelper.Quote: string;
begin
  Result := System.SysUtils.QuotedStr(Self);
end;

class function TAqStringHelper.SameText(const pText1, pText2: string): Boolean;
begin
  Result := System.SysUtils.SameText(pText1, pText2);
end;

function TAqStringHelper.Substring(StartIndex, Length: Int32): string;
begin
  Result := System.Copy(Self, StartIndex + 1, Length);
end;

function TAqStringHelper.ToBoolean: Boolean;
begin
  if (Self = '-1') or (Self = '1') or (CompareTo('True', True) = 0) then
  begin
    Result := True;
  end else if (Self = '0') or (CompareTo('False', True) = 0) then
  begin
    Result := False;
  end else begin
    raise EAqInternal.Create('Impossible to convert the string ' + Self + ' to boolean.');
  end;
end;

function TAqStringHelper.ToCurrency: Currency;
begin
  if not TryToCurrency(Result) then
  begin
    raise EAqInternal.Create('Invalid conversion of string ' + Self + ' to a Currency type.');
  end;
end;

function TAqStringHelper.ToCurrencyDef(const pDefault: Currency): Currency;
begin
  if not Self.TryToCurrency(Result) then
  begin
    Result := pDefault;
  end;
end;

function TAqStringHelper.ToDate: TDate;
begin
  if not TryToDate(Result) then
  begin
    RaiseInvalidConversionToDateTimeType;
  end;
end;

function TAqStringHelper.ToDateDef(const pDefault: TDate): TDate;
begin
  if not Self.TryToDate(Result) then
  begin
    Result := pDefault;
  end;
end;

function TAqStringHelper.ToDateTime: TDateTime;
begin
  if not TryToDateTime(Result) then
  begin
    RaiseInvalidConversionToDateTimeType;
  end;
end;

function TAqStringHelper.ToDateTimeDef(const pDefault: TDateTime): TDateTime;
begin
  if not Self.TryToDateTime(Result) then
  begin
    Result := pDefault;
  end;
end;

function TAqStringHelper.ToDouble: Double;
begin
  if not TryToDouble(Result) then
  begin
    raise EAqInternal.Create('Invalid conversion of string ' + Self + ' to a Double type.');
  end;
end;

function TAqStringHelper.ToDoubleDef(const pDefault: Double): Double;
begin
  if not Self.TryToDouble(Result) then
  begin
    Result := pDefault;
  end;
end;

function TAqStringHelper.ToInt16: Int16;
begin
  if not TryToInt16(Result) then
  begin
    RaiseInvalidConversionToIntType;
  end;
end;

function TAqStringHelper.ToInt16Def(const pDefault: Int16): Int16;
begin
  if not Self.TryToInt16(Result) then
  begin
    Result := pDefault;
  end;
end;

function TAqStringHelper.ToInt32: Int32;
begin
  if not TryToInt32(Result) then
  begin
    RaiseInvalidConversionToIntType;
  end;
end;

function TAqStringHelper.ToInt32Def(const pDefault: Int32): Int32;
begin
  if not Self.TryToInt32(Result) then
  begin
    Result := pDefault;
  end;
end;

function TAqStringHelper.ToInt64: Int64;
begin
  if not TryToInt64(Result) then
  begin
    RaiseInvalidConversionToIntType;
  end;
end;

function TAqStringHelper.ToInt64Def(const pDefault: Int64): Int64;
begin
  if not Self.TryToInt64(Result) then
  begin
    Result := pDefault;
  end;
end;

function TAqStringHelper.ToInt8: Int8;
begin
  if not TryToInt8(Result) then
  begin
    RaiseInvalidConversionToIntType;
  end;
end;

function TAqStringHelper.ToInt8Def(const pDefault: Int8): Int8;
begin
  if not Self.TryToInt8(Result) then
  begin
    Result := pDefault;
  end;
end;

function TAqStringHelper.ToTime: TTime;
begin
  if not TryToTime(Result) then
  begin
    RaiseInvalidConversionToDateTimeType;
  end;
end;

function TAqStringHelper.ToTimeDef(const pDefault: TTime): TTime;
begin
  if not Self.TryToTime(Result) then
  begin
    Result := pDefault;
  end;
end;

function TAqStringHelper.ToUpper: string;
begin
  Result := System.SysUtils.UpperCase(Self);
end;

function TAqStringHelper.ToUInt16: UInt16;
begin
  if not TryToUInt16(Result) then
  begin
    RaiseInvalidConversionToIntType;
  end;
end;

function TAqStringHelper.ToUInt16Def(const pDefault: UInt16): UInt16;
begin
  if not Self.TryToUInt16(Result) then
  begin
    Result := pDefault;
  end;
end;

function TAqStringHelper.ToUInt32: UInt32;
begin
  if not TryToUInt32(Result) then
  begin
    RaiseInvalidConversionToIntType;
  end;
end;

function TAqStringHelper.ToUInt32Def(const pDefault: UInt32): UInt32;
begin
  if not Self.TryToUInt32(Result) then
  begin
    Result := pDefault;
  end;
end;

function TAqStringHelper.ToUInt64: UInt64;
begin
  if not TryToUInt64(Result) then
  begin
    RaiseInvalidConversionToIntType;
  end;
end;

function TAqStringHelper.ToUInt64Def(const pDefault: UInt64): UInt64;
begin
  if not Self.TryToUInt64(Result) then
  begin
    Result := pDefault;
  end;
end;

function TAqStringHelper.ToUInt8: UInt8;
begin
  if not TryToUInt8(Result) then
  begin
    RaiseInvalidConversionToIntType;
  end;
end;

function TAqStringHelper.ToUInt8Def(const pDefault: UInt8): UInt8;
begin
  if not Self.TryToUInt8(Result) then
  begin
    Result := pDefault;
  end;
end;

function TAqStringHelper.Trim: string;
var
  lI: Int32;
  lL: Int32;
begin
  lL := Self.Length - 1;
  lI := 0;
  if (lL > -1) and (Self[lI] > ' ') and (Self[lL] > ' ') then
  begin
    Result := Self;
  end else begin
    while (lI <= lL) and (Self[lI] <= ' ') do
    begin
      Inc(lI);
    end;

    if lI > lL then
    begin
      Result := '';
    end else begin
      while Self[lL] <= ' ' do
      begin
        Dec(lL);
      end;

      Result := Self.SubString(lI, lL - lI + 1);
    end;
  end;
end;

function TAqStringHelper.TryToCurrency(out pCurrency: Currency): Boolean;
begin
  Result := TryStrToCurr(Self, pCurrency);
end;

function TAqStringHelper.TryToDate(out pDate: TDate): Boolean;
var
  lDateTime: TDateTime;
begin
  Result := TryStrToDate(Self, lDateTime);

  if Result then
  begin
    pDate := lDateTime.DateOf;
  end;
end;

function TAqStringHelper.TryToDateTime(out pDateTime: TDateTime): Boolean;
begin
  Result := TryStrToDateTime(Self, pDateTime);
end;

function TAqStringHelper.TryToDouble(out pDouble: Double): Boolean;
begin
  Result := TryStrToFloat(Self, pDouble);
end;

function TAqStringHelper.TryToInt16(out pInt16: Int16): Boolean;
var
  lInt32: Int32;
begin
  Result := TryStrToInt(Self, lInt32);

  if Result then
  begin
    pInt16 := lInt32;
  end;
end;

function TAqStringHelper.TryToUInt16(out pUInt16: UInt16): Boolean;
var
  lInt32: Int32;
begin
  Result := TryStrToInt(Self, lInt32);

  if Result then
  begin
    pUInt16 := lInt32;
  end;
end;

function TAqStringHelper.TryToInt8(out pInt8: Int8): Boolean;
var
  lInt32: Int32;
begin
  Result := TryStrToInt(Self, lInt32);

  if Result then
  begin
    pInt8 := lInt32;
  end;
end;

function TAqStringHelper.TryToTime(out pTime: TTime): Boolean;
var
  lDateTime: TDateTime;
begin
  Result := TryStrToDate(Self, lDateTime);

  if Result then
  begin
    pTime := lDateTime.TimeOf;
  end;
end;

function TAqStringHelper.TryToUInt8(out pUInt8: UInt8): Boolean;
var
  lInt32: Int32;
begin
  Result := TryStrToInt(Self, lInt32);

  if Result then
  begin
    pUInt8 := lInt32;
  end;
end;

function TAqStringHelper.TryToInt64(out pInt64: Int64): Boolean;
begin
  Result := TryStrToInt64(Self, pInt64);
end;

function TAqStringHelper.TryToUInt64(out pUInt64: UInt64): Boolean;
var
  lInt64: Int64;
begin
  Result := TryStrToInt64(Self, lInt64);

  if Result then
  begin
    pUInt64 := lInt64;
  end;
end;

function TAqStringHelper.TryToInt32(out pInt32: Int32): Boolean;
begin
  Result := TryStrToInt(Self, pInt32);
end;

function TAqStringHelper.TryToUInt32(out pUInt32: UInt32): Boolean;
var
  lInt64: Int64;
begin
  Result := TryStrToInt64(Self, lInt64);

  if Result then
  begin
    pUInt32 := lInt64;
  end;
end;

{$ZEROBASEDSTRINGS OFF}

function TAqCurrencyHelper.ToString: string;
begin
  Result := System.SysUtils.CurrToStr(Self);
end;

{ TAqDoubleHelper }

function TAqDoubleHelper.Frac: Double;
begin
  Result := System.Frac(Self);
end;

function TAqDoubleHelper.ToString: string;
begin
  Result := FloatToStr(Self);
end;

function TAqDoubleHelper.Trunc: Int64;
begin
  Result := System.Trunc(Self);
end;

{ TAqSingleHelper }

function TAqSingleHelper.Frac: Single;
begin
  Result := System.Frac(Self);
end;

function TAqSingleHelper.ToString: string;
begin
  Result := FloatToStr(Self);
end;

function TAqSingleHelper.Trunc: Int64;
begin
  Result := System.Trunc(Self);
end;

{ TAqUInt32Helper }

function TAqUInt32Helper.ToString: string;
begin
  Result := System.SysUtils.IntToStr(Self);
end;

{ TAqUInt64Helper }

function TAqUInt64Helper.ToString: string;
begin
  Result := System.SysUtils.IntToStr(Self);
end;

{ TAqNativeUInt }

function TAqNativeUInt.ToString: string;
begin
  Result := System.SysUtils.IntToStr(Self);
end;

{ TAqInt16Helper }

function TAqInt16Helper.ToString: string;
begin
  Result := System.SysUtils.IntToStr(Self);
end;

{ TAqUInt16Helper }

function TAqUInt16Helper.ToString: string;
begin
  Result := System.SysUtils.IntToStr(Self);
end;

{ TAqInt32Helper }

function TAqInt32Helper.ToString: string;
begin
  Result := System.SysUtils.IntToStr(Self);
end;

{ TAqInt64Helper }

function TAqInt64Helper.ToString: string;
begin
  Result := System.SysUtils.IntToStr(Self);
end;

{ TAqInt8Helper }

function TAqInt8Helper.ToString: string;
begin
  Result := System.SysUtils.IntToStr(Self);
end;

{ TAqUInt8Helper }

function TAqUInt8Helper.ToString: string;
begin
  Result := System.SysUtils.IntToStr(Self);
end;

end.
