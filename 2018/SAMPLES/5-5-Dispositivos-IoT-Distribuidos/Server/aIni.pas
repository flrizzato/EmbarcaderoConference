unit aIni;
interface
uses System.SysUtils, System.IniFiles, System.IOUtils, System.Classes;

const
  DEFAULT_SECTION_NAME = 'CFG';

  STR_NAMES : array[1..1] of string = ('DBPath');
  STR_DEF   : array[1..1] of string = ('');

  {INT_NAMES      : array[1..1] of string = ('');
  INT_DEFAULTS   : array[1..1] of integer = (0);

  BOOL_NAMES     : array[1..1] of string = ('');
  BOOL_DEFAULTS  : array[1..1] of boolean = (true);}

type
  TAppIni = class(TIniFile)
  private
    function GetString(const Index: Integer): string;
    procedure SetString(const Index: Integer; const Value: string);
    {function GetInteger(const Index: integer): integer;
    procedure SetInteger(const Index, Value: integer);
    function GetBoolean(const Index: integer): boolean;
    procedure SetBoolean(const Index: integer; Value: boolean);}
  public
    property DBPath: string index 1 read GetString write SetString;
  end;

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

{function TAppIni.GetBoolean(const Index: integer): boolean;
begin
  result:= ReadBool(DEFAULT_SECTION_NAME, BOOL_NAMES[index], BOOL_DEFAULTS[index]);
end;

procedure TAppIni.SetBoolean(const Index: integer; Value: boolean);
begin
  WriteBool(DEFAULT_SECTION_NAME, BOOL_NAMES[index], Value);
end;

function TAppIni.GetInteger(const Index: integer): integer;
begin
  result:= ReadInteger(DEFAULT_SECTION_NAME, INT_NAMES[index], INT_DEFAULTS[index]);
end;

procedure TAppIni.SetInteger(const Index, Value: integer);
begin
  WriteInteger(DEFAULT_SECTION_NAME, INT_NAMES[index], Value);
end;
}
end.
