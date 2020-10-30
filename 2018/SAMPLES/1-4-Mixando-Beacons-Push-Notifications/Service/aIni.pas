unit aIni;
interface
uses System.SysUtils, System.IniFiles, System.IOUtils, System.Classes;

const
  DEFAULT_SECTION_NAME = 'CFG';

  //AF=Afastamento; AP=Aproximação
  MODE_AFASTAMENTO = 'AF';
  MODE_APROXIMACAO = 'AP';

  STR_NAMES : array[1..3] of string = ('BeaconGUID', 'Mode', 'Avisar');
  STR_DEF   : array[1..3] of string = ('', MODE_AFASTAMENTO, '');

  INT_NAMES      : array[1..1] of string = ('DistanceAlarm');
  INT_DEFAULTS   : array[1..1] of integer = (5);

  BOOL_NAMES     : array[1..1] of string = ('');
  BOOL_DEFAULTS  : array[1..1] of boolean = (false);

type
  TAppIni = class(TIniFile)
  private
    function GetString(const Index: Integer): string;
    procedure SetString(const Index: Integer; const Value: string);
    function GetInteger(const Index: integer): integer;
    procedure SetInteger(const Index, Value: integer);
  public
    property BeaconGUID: string index 1 read GetString write SetString;
    property Mode: string index 2 read GetString write SetString;
    property UserEmail: string index 3 read GetString write SetString;
    property DistanceAlarm: integer index 1 read GetInteger write SetInteger;
  end;

var
  Ini: TAppIni;

implementation

{ TAppIni }

function TAppIni.GetString(const Index: Integer): string;
begin
  result:= ReadString(DEFAULT_SECTION_NAME, STR_NAMES[Index], STR_DEF[Index]);
end;

procedure TAppIni.SetString(const Index: Integer; const Value: string);
begin
  WriteString(DEFAULT_SECTION_NAME, STR_NAMES[Index], Value);
end;

function TAppIni.GetInteger(const Index: integer): integer;
begin
  result:= ReadInteger(DEFAULT_SECTION_NAME, INT_NAMES[index], INT_DEFAULTS[index]);
end;

procedure TAppIni.SetInteger(const Index, Value: integer);
begin
  WriteInteger(DEFAULT_SECTION_NAME, INT_NAMES[index], Value);
end;

initialization
  Ini:= TAppIni.Create(TPath.Combine(TPath.GetDocumentsPath, 'st.ini'));

finalization
  Ini.Free;

end.
