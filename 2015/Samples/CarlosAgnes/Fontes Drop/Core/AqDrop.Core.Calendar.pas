unit AqDrop.Core.Calendar;

interface

uses
  AqDrop.Core.Observable,
  AqDrop.Core.Helpers;

type
  TAqCalendarEvent = class(TAqObservable)
  strict private
    FStart: TDateTime;
    FLength: TDateTime;
    FAllDay: Boolean;

    function CalcEndDateTime: TDateTime;

    function GetStartDate: TDate;
    function GetStartTime: TTime;
    function GetStartDateTime: TDateTime;
    function GetEndDate: TDate;
    function GetEndTime: TTime;
    function GetEndDateTime: TDateTime;
    function GetLength: TDateTime;
    procedure SetStartDate(const Value: TDate);
    procedure SetStartTime(const Value: TTime);
    procedure SetEndDate(const Value: TDate);
    procedure SetEndTime(const Value: TTime);
    procedure SetEndDateTime(const Value: TDateTime);
    procedure SetAllDay(const Value: Boolean);
    procedure SetLength(const Value: TDateTime);
  private
    { Private declarations }
  strict protected
    procedure SetStartDateTime(Value: TDateTime); virtual;
  public
    constructor Create;

    function ActiveAt(pDateTime: TDateTime): Boolean; virtual;

    property StartDate: TDate read GetStartDate write SetStartDate;
    property StartTime: TTime read GetStartTime write SetStartTime;
    property EndDate: TDate read GetEndDate write SetEndDate;
    property EndTime: TTime read GetEndTime write SetEndTime;
    property StartDateTime: TDateTime read GetStartDateTime write SetStartDateTime;
    property EndDateTime: TDateTime read GetEndDateTime write SetEndDateTime;
    property AllDay: Boolean read FAllDay write SetAllDay;
    property Length: TDateTime read GetLength write SetLength;
  end;

  TAqCalendarEventRecurrenceClass = class of TAqCalendarEventRecurrence;

  TAqCalendarEventRecurrence = class(TAqObservable)
  strict private
    FCalendarEvent: TAqCalendarEvent;
    FEnd: TDate;
    FInterval: UInt8;

    procedure SetInterval(const Value: UInt8);
    procedure SetEnd(const Value: TDate);

    function GetIsInfinite: Boolean;
    procedure SetIsInfinite(const Value: Boolean);
  strict protected
    function GetOccurrences: UInt32; virtual; abstract;
    procedure SetOccurrences(const Value: UInt32); virtual;

    property CalendarEvent: TAqCalendarEvent read FCalendarEvent;
  public
    constructor Create(const pCalendarEvent: TAqCalendarEvent); virtual;

    function ActiveAt(pDateTime: TDate): Boolean; virtual;

    property Interval: UInt8 read FInterval write SetInterval;
    property Occurrences: UInt32 read GetOccurrences write SetOccurrences;
    property &End: TDate read FEnd write SetEnd;
    property Infinite: Boolean read GetIsInfinite write SetIsInfinite;
  end;

  TAqCalendarEventDailyRecurrence = class(TAqCalendarEventRecurrence)
  strict protected
    function GetOccurrences: UInt32; override;
    procedure SetOccurrences(const Value: UInt32); override;
  public
    function ActiveAt(pDateTime: TDate): Boolean; override;
  end;

  TAqCalendarEventWeeklyRecurrence = class(TAqCalendarEventRecurrence)
  strict private
    FDaysOfTheWeek: TAqWeekDays;
    function GetDaysOnTheWeek: UInt8;

    procedure SetDaysOfTheWeek(const Value: TAqWeekDays);
  strict protected
    function GetOccurrences: UInt32; override;
    procedure SetOccurrences(const Value: UInt32); override;
  public
    constructor Create(const pCalendarEvent: TAqCalendarEvent); override;

    function ActiveAt(pDateTime: TDate): Boolean; override;

    property DaysOfTheWeek: TAqWeekDays read FDaysOfTheWeek write SetDaysOfTheWeek;
  end;

  TAqCalendarEventMonthlyRecurrence = class(TAqCalendarEventRecurrence)
  strict private
    function GetDay: UInt8;
    function GetMonthsUntilDate(const pDateTime: TDate): UInt32;
  strict protected
    function GetOccurrences: UInt32; override;
    procedure SetOccurrences(const Value: UInt32); override;
  public
    function ActiveAt(pDateTime: TDate): Boolean; override;

    property Day: UInt8 read GetDay;
  end;

  TAqCalendarEventMonthlyOnTheWeekRecurrence = class(TAqCalendarEventRecurrence)
  strict private
    function GetWeek: UInt8;
    function GetWeekDay: TAqWeekDay;

    function CalcMonthOccurrence(const pDataTeste: TDate): TDate;
  strict protected
    function GetOccurrences: UInt32; override;
    procedure SetOccurrences(const Value: UInt32); override;
  public
    function ActiveAt(pDateTime: TDate): Boolean; override;

    property Week: UInt8 read GetWeek;
    property WeekDay: TAqWeekDay read GetWeekDay;
  end;

  TAqCalendarEventYearlyRecurrence = class (TAqCalendarEventRecurrence)
  strict private
    function GetDay: UInt8;
    function GetMonth: UInt8;
    function GetYearsUntilDate(const pDateTime: TDate): UInt32;
  strict protected
    function GetOccurrences: UInt32; override;
    procedure SetOccurrences(const Value: UInt32); override;
  public
    function ActiveAt(pDateTime: TDate): Boolean; override;

    property Month: UInt8 read GetMonth;
    property Day: UInt8 read GetDay;
  end;

  TAqCalendarEventYearlyInMonthAndWeekRecurrence = class (TAqCalendarEventRecurrence)
  strict private
    function GetMonth: UInt8;
    function GetWeek: UInt8;
    function GetWeekDay: TAqWeekDay;

    function CalcYearOccurrence(const pDateTime: TDate): TDate;
  strict protected
    function GetOccurrences: UInt32; override;
    procedure SetOccurrences(const Value: UInt32); override;
  public
    function ActiveAt(pDateTime: TDate): Boolean; override;

    property Month: UInt8 read GetMonth;
    property Week: UInt8 read GetWeek;
    property WeekDay: TAqWeekDay read GetWeekDay;
  end;

  TAqRecurrentCalendarEvent = class(TAqCalendarEvent)
  strict private
    FRecurrence: TAqCalendarEventRecurrence;

    function GetDailyRecurrence: TAqCalendarEventDailyRecurrence;
    function GetWeeklyRecurrence: TAqCalendarEventWeeklyRecurrence;
    function GetMonthlyRecurrence: TAqCalendarEventMonthlyRecurrence;
    function GetMonthlyOnTheWeekRecurrence: TAqCalendarEventMonthlyOnTheWeekRecurrence;
    function GetYearlyRecurrence: TAqCalendarEventYearlyRecurrence;
    function GetYearlyInMonthAndWeekRecurrence: TAqCalendarEventYearlyInMonthAndWeekRecurrence;

    function ActivateRecurrence<T: TAqCalendarEventRecurrence>: T;
    function GetIsRecurrent: Boolean;
  strict protected
    procedure SetStartDateTime(Value: TDateTime); override;
  public
    destructor Destroy; override;

    [AqNotifyObserversTag]
    procedure DeactivateRecurrence; virtual;

    function ActiveAt(pDateTime: TDateTime): Boolean; override;

    property Recurrence: TAqCalendarEventRecurrence read FRecurrence;
    property DailyRecurrence: TAqCalendarEventDailyRecurrence read GetDailyRecurrence;
    property WeeklyRecurrence: TAqCalendarEventWeeklyRecurrence read GetWeeklyRecurrence;
    property MonthlyRecurrence: TAqCalendarEventMonthlyRecurrence read GetMonthlyRecurrence;
    property MonthlyOnTheWeekRecurrence: TAqCalendarEventMonthlyOnTheWeekRecurrence read
      GetMonthlyOnTheWeekRecurrence;
    property YearlyRecurrence: TAqCalendarEventYearlyRecurrence read GetYearlyRecurrence;
    property YearlyInMonthAndWeekRecurrence: TAqCalendarEventYearlyInMonthAndWeekRecurrence read
      GetYearlyInMonthAndWeekRecurrence;
    property IsRecurrent: Boolean read GetIsRecurrent;
  end;

resourcestring
  StrFimDoEventoNaoPodeSerInferiorAoInIcioDoEvento = 'Fim do evento não pode ser inferior ao início do evento.';
  StrDuracaoDoEventoNaoPodeSerNegativa = 'Duração do evento não pode ser negativa.';
  StrOFimDaRecorrenciaNaoPodeAcontecerAntesDoPrimeiroDiaDoEvento =
    'O fim da recorrência não pode acontecer antes do primeiro dia do evento.';
  StrAIntermitenciaEntreOcorrenciasDeveEstarEntre1E100 = 'A intermitência entre ocorrências deve estar entre 1 e 100.';
  StrNaoEPossivelAtivarUmaRecorrenciaSemanalSemInformarPeloMenosUmDiaDaSemanaParaARecorrencia =
    'Não é possível ativar uma recorrência semanal sem informar pelo menos um dia da semana para a recorrência.';

implementation

uses
  System.SysUtils,
  System.Math,
  AqDrop.Core.Exceptions,
  System.DateUtils;

{ TAqCalendarEvent }

constructor TAqCalendarEvent.Create;
begin
  inherited;

  FStart := Date + EncodeTime(9, 0, 0, 0);
  FLength := EncodeTime(1, 0, 0, 0);
end;

function TAqCalendarEvent.ActiveAt(pDateTime: TDateTime): Boolean;
begin
  Result := (FStart <= pDateTime) and (pDateTime < EndDateTime);
end;

function TAqCalendarEvent.GetEndDate: TDate;
begin
  Result := CalcEndDateTime.DateOf;
end;

function TAqCalendarEvent.GetEndDateTime: TDateTime;
begin
  Result := EndDate + EndTime;
end;

function TAqCalendarEvent.GetStartDateTime: TDateTime;
begin
  Result := StartDate + StartTime;
end;

function TAqCalendarEvent.CalcEndDateTime: TDateTime;
begin
  Result := FStart + FLength;
end;

function TAqCalendarEvent.GetStartDate: TDate;
begin
  Result := FStart.DateOf;
end;

function TAqCalendarEvent.GetLength: TDateTime;
begin
  if FAllDay then
  begin
    Result := EndDateTime - StartDateTime;
  end else begin
    Result := FLength;
  end;
end;

function TAqCalendarEvent.GetEndTime: TTime;
begin
  if FAllDay then
  begin
    Result := 1;
  end else begin
    Result := CalcEndDateTime.TimeOf;
  end;
end;

function TAqCalendarEvent.GetStartTime: TTime;
begin
  if FAllDay then
  begin
    Result := 0;
  end else begin
    Result := FStart.TimeOf;
  end;
end;

procedure TAqCalendarEvent.SetEndDate(const Value: TDate);
begin
  SetEndDateTime(Value.DateOf + EndTime);
end;

procedure TAqCalendarEvent.SetEndDateTime(const Value: TDateTime);
begin
  if Value < StartDateTime then
  begin
    raise EAqFriendly.Create(StrFimDoEventoNaoPodeSerInferiorAoInIcioDoEvento);
  end;

  SetAndNotify<TDateTime>(FLength, Value - FStart);
end;

procedure TAqCalendarEvent.SetStartDateTime(Value: TDateTime);
begin
  SetAndNotify<TDateTime>(FStart, Value);
end;

procedure TAqCalendarEvent.SetStartDate(const Value: TDate);
begin
  SetStartDateTime(Value.DateOf + FStart.TimeOf);
end;

procedure TAqCalendarEvent.SetAllDay(const Value: Boolean);
begin
  SetAndNotify<Boolean>(FAllDay, Value);
end;

procedure TAqCalendarEvent.SetLength(const Value: TDateTime);
begin
  if FLength < 0 then
  begin
    raise EAqFriendly.Create(StrDuracaoDoEventoNaoPodeSerNegativa);
  end;

  SetAndNotify<TDateTime>(FLength, Value);
end;

procedure TAqCalendarEvent.SetEndTime(const Value: TTime);
begin
  SetEndDateTime(CalcEndDateTime.DateOf + Value.TimeOf);
end;

procedure TAqCalendarEvent.SetStartTime(const Value: TTime);
begin
  SetStartDateTime(FStart.DateOf + Value.TimeOf);
end;

{ TAqCalendarEventRecurrence }

constructor TAqCalendarEventRecurrence.Create(const pCalendarEvent: TAqCalendarEvent);
begin
  inherited Create;

  FCalendarEvent := pCalendarEvent;
  FEnd := Infinity;
  FInterval := 1;
end;

function TAqCalendarEventRecurrence.ActiveAt(pDateTime: TDate): Boolean;
var
  lDateTime: TDate;
begin
  lDateTime := pDateTime.DateOf;

  Result := (FCalendarEvent.StartDate <= lDateTime) and (pDateTime <= FEnd);
end;

function TAqCalendarEventRecurrence.GetIsInfinite: Boolean;
begin
  Result := FEnd = Infinity;
end;

procedure TAqCalendarEventRecurrence.SetEnd(const Value: TDate);
begin
  if Value < FCalendarEvent.StartDate then
  begin
    raise EAqFriendly.Create(StrOFimDaRecorrenciaNaoPodeAcontecerAntesDoPrimeiroDiaDoEvento);
  end;

  SetAndNotify<TDate>(FEnd, Value);
end;

procedure TAqCalendarEventRecurrence.SetInterval(const Value: UInt8);
begin
  if not(Value in [1..100]) then
  begin
    raise EAqFriendly.Create(StrAIntermitenciaEntreOcorrenciasDeveEstarEntre1E100);
  end;

  SetAndNotify<UInt8>(FInterval, Value);
end;

procedure TAqCalendarEventRecurrence.SetOccurrences(const Value: UInt32);
begin
  if Value = 0 then
  begin
    Infinite := True;
  end;
end;

procedure TAqCalendarEventRecurrence.SetIsInfinite(const Value: Boolean);
begin
  if Value then
  begin
    &End := Infinity;
  end else begin
    &End := CalendarEvent.StartDate;
  end;
end;

{ TAqRecurrentCalendarEvent }

function TAqRecurrentCalendarEvent.ActivateRecurrence<T>: T;
begin
  if not Assigned(FRecurrence) or not(FRecurrence.InheritsFrom(T)) then
  begin
    FreeAndNil(FRecurrence);
    FRecurrence := TAqCalendarEventRecurrenceClass(T).Create(Self);
    Result := T(FRecurrence);

    Notify;
  end;
end;

procedure TAqRecurrentCalendarEvent.DeactivateRecurrence;
begin
  FreeAndNil(FRecurrence);
end;

destructor TAqRecurrentCalendarEvent.Destroy;
begin
  FRecurrence.Free;

  inherited;
end;

function TAqRecurrentCalendarEvent.ActiveAt(pDateTime: TDateTime): Boolean;
var
  lTime: TTime;
begin
  if IsRecurrent then
  begin
    lTime := pDateTime.TimeOf;
    Result := ((StartTime <= lTime) and (lTime < EndTime)) and FRecurrence.ActiveAt(pDateTime.DateOf);
  end else begin
    Result := inherited;
  end;
end;

function TAqRecurrentCalendarEvent.GetYearlyRecurrence: TAqCalendarEventYearlyRecurrence;
begin
  Result := ActivateRecurrence<TAqCalendarEventYearlyRecurrence>;
end;

function TAqRecurrentCalendarEvent.GetYearlyInMonthAndWeekRecurrence: TAqCalendarEventYearlyInMonthAndWeekRecurrence;
begin
  Result := ActivateRecurrence<TAqCalendarEventYearlyInMonthAndWeekRecurrence>;
end;

function TAqRecurrentCalendarEvent.GetDailyRecurrence: TAqCalendarEventDailyRecurrence;
begin
  Result := ActivateRecurrence<TAqCalendarEventDailyRecurrence>;
end;

function TAqRecurrentCalendarEvent.GetMonthlyRecurrence: TAqCalendarEventMonthlyRecurrence;
begin
  Result := ActivateRecurrence<TAqCalendarEventMonthlyRecurrence>;
end;

function TAqRecurrentCalendarEvent.GetMonthlyOnTheWeekRecurrence: TAqCalendarEventMonthlyOnTheWeekRecurrence;
begin
  Result := ActivateRecurrence<TAqCalendarEventMonthlyOnTheWeekRecurrence>;
end;

function TAqRecurrentCalendarEvent.GetWeeklyRecurrence: TAqCalendarEventWeeklyRecurrence;
begin
  Result := ActivateRecurrence<TAqCalendarEventWeeklyRecurrence>;
end;

function TAqRecurrentCalendarEvent.GetIsRecurrent: Boolean;
begin
  Result := Assigned(FRecurrence);
end;

procedure TAqRecurrentCalendarEvent.SetStartDateTime(Value: TDateTime);
var
  lOldValue: TDate;
begin
  lOldValue := StartDate;

  inherited;

  if Assigned(FRecurrence) and not FRecurrence.Infinite then
  begin
    FRecurrence.&End := FRecurrence.&End + (StartDate  - lOldValue);
  end;
end;

{ TAqCalendarEventDailyRecurrence }

function TAqCalendarEventDailyRecurrence.ActiveAt(pDateTime: TDate): Boolean;
begin
  Result := inherited and (Trunc(pDateTime - CalendarEvent.StartDate) mod Interval = 0);
end;

function TAqCalendarEventDailyRecurrence.GetOccurrences: UInt32;
var
  lAdditionalDays: Int64;
begin
  if Infinite then
  begin
    Result := 0;
  end else begin
    Assert(CalendarEvent.StartDate <= &End);
    lAdditionalDays := Trunc(&End - CalendarEvent.StartDate);
    Result := (lAdditionalDays div Interval) + 1;
  end;
end;

procedure TAqCalendarEventDailyRecurrence.SetOccurrences(const Value: UInt32);
var
  lAdditionalOccurrences: UInt32;
begin
  inherited;

  if Value <> 0 then
  begin
    lAdditionalOccurrences := (Value - 1);
    &End := CalendarEvent.StartDate + (lAdditionalOccurrences * Interval);
  end;
end;

{ TAqCalendarEventWeeklyRecurrence }

constructor TAqCalendarEventWeeklyRecurrence.Create(const pCalendarEvent: TAqCalendarEvent);
begin
  inherited;

  FDaysOfTheWeek := [CalendarEvent.StartDate.GetWeekDay];
end;

function TAqCalendarEventWeeklyRecurrence.ActiveAt(pDateTime: TDate): Boolean;
var
  lDifference: Int32;
begin
  Result := inherited;

  if Result then
  begin
    lDifference := Trunc(pDateTime - CalendarEvent.StartDate + 1) div (DaysPerWeek * Interval);
    pDateTime := pDateTime - (lDifference * DaysPerWeek * Interval);
    Result := (pDateTime - CalendarEvent.StartDate + 1 < DaysPerWeek) and
      (pDateTime.GetWeekDay in FDaysOfTheWeek);
  end;
end;

function TAqCalendarEventWeeklyRecurrence.GetDaysOnTheWeek: UInt8;
var
  lWeekDay: TAqWeekDay;
begin
  Result := 0;

  for lWeekDay in FDaysOfTheWeek do
  begin
    Inc(Result);
  end;
end;

function TAqCalendarEventWeeklyRecurrence.GetOccurrences: UInt32;
var
  lAdditionalWeeks: Int32;
  lLastWeekStart: TDate;
  lEndOfTheWeek: TDate;
begin
  if Infinite then
  begin
    Result := 0;
  end else begin
    lAdditionalWeeks := Trunc(&End - CalendarEvent.StartDate) div (DaysPerWeek * Interval);
    Result := lAdditionalWeeks * GetDaysOnTheWeek;
    lLastWeekStart := CalendarEvent.StartDate + (lAdditionalWeeks * DaysPerWeek * Interval);
    lEndOfTheWeek := lLastWeekStart + DaysPerWeek - 1;

    while lLastWeekStart <= Min(&End, lEndOfTheWeek) do
    begin
      if lLastWeekStart.GetWeekDay in FDaysOfTheWeek then
      begin
        Inc(Result);
      end;
      lLastWeekStart := lLastWeekStart + 1;
    end;
  end;
end;

procedure TAqCalendarEventWeeklyRecurrence.SetDaysOfTheWeek(const Value: TAqWeekDays);
begin
  if Value = [] then
  begin
    raise EAqFriendly.Create(
      StrNaoEPossivelAtivarUmaRecorrenciaSemanalSemInformarPeloMenosUmDiaDaSemanaParaARecorrencia);
  end;

  SetAndNotify<TAqWeekDays>(FDaysOfTheWeek, Value);
end;

procedure TAqCalendarEventWeeklyRecurrence.SetOccurrences(const Value: UInt32);
var
  lDaysOnTheWeek: UInt8;
  lEnd: TDate;
  lDifference: UInt8;
  lAdditionalOccurrences: UInt32;
begin
  inherited;

  if Value <> 0 then
  begin
    lDaysOnTheWeek := GetDaysOnTheWeek;
    lAdditionalOccurrences := Value - 1;

    lEnd := CalendarEvent.StartDate + ((lAdditionalOccurrences div lDaysOnTheWeek) * DaysPerWeek * Interval) - 1;
    lDifference := Value mod lDaysOnTheWeek;

    while lDifference > 0 do
    begin
      repeat
        lEnd := lEnd + 1;
      until lEnd.GetWeekDay in FDaysOfTheWeek;

      Dec(lDifference);
    end;

    &End := lEnd;
  end;
end;

{ TAqCalendarEventMonthlyRecurrence }

function TAqCalendarEventMonthlyRecurrence.ActiveAt(pDateTime: TDate): Boolean;
var
  lDaysOfTheTestedMonth: UInt16;
begin
  Result := inherited;

  if Result then
  begin
    // verifica se o mês deve ter ocorrência E (o dia para teste é igual ao dia da
    // ocorrência OU o (o dia da ocorrência não existe no mês E o dia para teste é
    // o último dia))
    lDaysOfTheTestedMonth := pDateTime.DaysInMonth;
    Result := ((GetMonthsUntilDate(pDateTime)) mod Interval = 0) and
      ((pDateTime.DayOf = Day) or
      ((Day > lDaysOfTheTestedMonth) and (pDateTime.DayOf = lDaysOfTheTestedMonth)));
  end;
end;

function TAqCalendarEventMonthlyRecurrence.GetDay: UInt8;
begin
  Result := CalendarEvent.StartDate.DayOf;
end;

function TAqCalendarEventMonthlyRecurrence.GetMonthsUntilDate(const pDateTime: TDate): UInt32;
begin
  Result := pDateTime.GetMonthsBetween(CalendarEvent.StartDate);
end;

function TAqCalendarEventMonthlyRecurrence.GetOccurrences: UInt32;
begin
  if Infinite then
  begin
    Result := 0;
  end else begin
    Result := 1 + ((GetMonthsUntilDate(&End)) div Interval);
  end;
end;

procedure TAqCalendarEventMonthlyRecurrence.SetOccurrences(const Value: UInt32);
begin
  inherited;

  if Value <> 0 then
  begin
    &End := CalendarEvent.StartDate.IncMonth(Value - 1);
  end;
end;

{ TAqCalendarEventMonthlyOnTheWeekRecurrence }

function TAqCalendarEventMonthlyOnTheWeekRecurrence.CalcMonthOccurrence(const pDataTeste: TDate): TDate;
begin
  Result := TDate.GetDateToTheWeekDay(pDataTeste, Week, WeekDay);
end;

function TAqCalendarEventMonthlyOnTheWeekRecurrence.ActiveAt(pDateTime: TDate): Boolean;
begin
  Result := inherited and
    (CalendarEvent.StartDate.GetMonthsDifference(pDateTime) mod Interval = 0) and
    ((pDateTime.GetWeekDay = WeekDay) and
    (pDateTime.GetMonthWeek = Week));
end;

function TAqCalendarEventMonthlyOnTheWeekRecurrence.GetWeekDay: TAqWeekDay;
begin
  Result := CalendarEvent.StartDate.GetWeekDay;
end;

function TAqCalendarEventMonthlyOnTheWeekRecurrence.GetOccurrences: UInt32;
begin
  Result := (((&End.GetMonthsDifference(CalendarEvent.StartDate)+
   IfThen(&End >= CalcMonthOccurrence(&End), 1)) - 1)
   div Interval) + 1;
end;

function TAqCalendarEventMonthlyOnTheWeekRecurrence.GetWeek: UInt8;
begin
  Result := CalendarEvent.StartDate.GetMonthWeek;
end;

procedure TAqCalendarEventMonthlyOnTheWeekRecurrence.SetOccurrences(const Value: UInt32);
begin
  inherited;

  if Value <> 0 then
  begin
    &End := CalcMonthOccurrence(CalendarEvent.StartDate.IncMonth((Value - 1) * Interval));
  end;
end;

{ TAqCalendarEventYearlyRecurrence }

function TAqCalendarEventYearlyRecurrence.ActiveAt(pDateTime: TDate): Boolean;
var
  lDaysOfTheTestedMonth: UInt16;
begin
  Result := inherited;

  if Result then
  begin
    // verifica se o ano deve ter ocorrência E (o dia para teste é igual ao dia da
    // ocorrência OU o (o dia da ocorrência não existe no mês E o dia para teste é
    // o último dia))
    lDaysOfTheTestedMonth := pDateTime.DaysInMonth;
    Result := (GetYearsUntilDate(pDateTime) mod Interval = 0) and
      (pDateTime.MonthOf = Month) and
      ((pDateTime.DayOf = Day) or
      ((Day > lDaysOfTheTestedMonth) and (pDateTime.DayOf = lDaysOfTheTestedMonth)));
  end;
end;

function TAqCalendarEventYearlyRecurrence.GetDay: UInt8;
begin
  Result := CalendarEvent.StartDate.DayOf;
end;

function TAqCalendarEventYearlyRecurrence.GetMonth: UInt8;
begin
  Result := CalendarEvent.StartDate.MonthOf;
end;

function TAqCalendarEventYearlyRecurrence.GetOccurrences: UInt32;
begin
  if Infinite then
  begin
    Result := 0;
  end else begin
    Result := 1 + ((GetYearsUntilDate(&End)) div Interval);
  end;
end;

function TAqCalendarEventYearlyRecurrence.GetYearsUntilDate(const pDateTime: TDate): UInt32;
begin
  Result := pDateTime.GetYearsBetween(CalendarEvent.StartDate);
end;

procedure TAqCalendarEventYearlyRecurrence.SetOccurrences(const Value: UInt32);
begin
  inherited;

  if Value <> 0 then
  begin
    &End := CalendarEvent.StartDate.IncYear(Value - 1);
  end;
end;

{ TAqCalendarEventYearlyInMonthAndWeekRecurrence }

function TAqCalendarEventYearlyInMonthAndWeekRecurrence.CalcYearOccurrence(const pDateTime: TDate): TDate;
begin
  Result := TDate.GetDateToTheWeekDay(pDateTime, Week, WeekDay);
end;

function TAqCalendarEventYearlyInMonthAndWeekRecurrence.ActiveAt(pDateTime: TDate): Boolean;
begin
  Result := inherited and
    (CalendarEvent.StartDate.GetYearsDifference(pDateTime) mod Interval = 0) and
    (pDateTime.MonthOf = Month) and
    ((pDateTime.GetWeekDay = WeekDay) and
    (pDateTime.GetMonthWeek = Week));
end;

function TAqCalendarEventYearlyInMonthAndWeekRecurrence.GetWeekDay: TAqWeekDay;
begin
  Result := CalendarEvent.StartDate.GetWeekDay;
end;

function TAqCalendarEventYearlyInMonthAndWeekRecurrence.GetMonth: UInt8;
begin
  Result := CalendarEvent.StartDate.MonthOf;
end;

function TAqCalendarEventYearlyInMonthAndWeekRecurrence.GetOccurrences: UInt32;
begin
  Result := (((&End.GetYearsDifference(CalendarEvent.StartDate)+
   IfThen(&End >= CalcYearOccurrence(&End), 1)) - 1)
   div Interval) + 1;
end;

function TAqCalendarEventYearlyInMonthAndWeekRecurrence.GetWeek: UInt8;
begin
  Result := CalendarEvent.StartDate.GetMonthWeek;
end;

procedure TAqCalendarEventYearlyInMonthAndWeekRecurrence.SetOccurrences(const Value: UInt32);
begin
  inherited;

  if Value <> 0 then
  begin
    &End := CalcYearOccurrence(CalendarEvent.StartDate.IncYear((Value - 1) * Interval));
  end;
end;

end.
