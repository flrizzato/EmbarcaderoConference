unit aIni;
interface
uses System.SysUtils, System.IniFiles, System.IOUtils, System.Classes;

const
  DEFAULT_SECTION_NAME = 'CFG';

  STR_NAMES : array[1..2] of string = ('Nome', 'Conta');
  STR_DEF   : array[1..2] of string = ('', '');

  INT_NAMES      : array[1..1] of string = ('');
  INT_DEFAULTS   : array[1..1] of integer = (0);

  BOOL_NAMES     : array[1..1] of string = ('');
  BOOL_DEFAULTS  : array[1..1] of boolean = (false);

type
  TAppIni = class(TIniFile)
  private
    function GetString(const Index: Integer): string;
    procedure SetString(const Index: Integer; const Value: string);
  public
    property Nome: string index 1 read GetString write SetString;
    property Conta: string index 2 read GetString write SetString;
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

initialization
  Ini:= TAppIni.Create(TPath.Combine(TPath.GetDocumentsPath, 'bnr.ini'));

finalization
  Ini.Free;
end.
