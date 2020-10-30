unit aIni;
interface
uses System.IOUtils, System.Classes, System.SysUtils, System.IniFiles;

const
  INI_NAME = 'PushDemo.ini';
  STR_SECTION_CONFIG = 'CONFIG';

  STR_NAMES      : array[1..4] of string =   ('UserName', 'UserEmail', 'DeviceToken', 'RegUrl');
  STR_DEFAULTS   : array[1..4] of string =   ('', '', '', 'http://<>:8088/reg');

  BOOL_NAMES     : array[1..1] of string =  ('Registered');
  BOOL_DEFAULTS  : array[1..1] of boolean = (false);

type
  TIni = class
  private
    FIni: TIniFile;
    FSection: string;
    function GetBoolean(const Index: Integer): boolean;
    procedure SetBoolean(const Index: Integer; const Value: boolean);
    procedure SetString(const index: integer; value: string);
    function GetString(const index: integer): string;
  public
    constructor Create(const FileName: String); reintroduce;
    destructor Destroy; override;
    //boolean properties
    property Registered: boolean index 1 read GetBoolean write SetBoolean;
    //string properties
    property UserName: string index 1 read GetString write SetString;
    property UserEmail: string index 2 read GetString write SetString;
    property DeviceToken: string index 3 read GetString write SetString;
    property RegUrl: string index 4 read GetString write SetString;
  end;

var
  Ini: TIni;

implementation

constructor TIni.create(const FileName: String);
begin
  inherited create;
  FIni:= TIniFile.Create(FileName);
  FSection:= STR_SECTION_CONFIG;
end;

destructor TIni.destroy;
begin
  FIni.free;
  inherited;
end;

function TIni.GetBoolean(const Index: Integer): boolean;
begin
  result:= FIni.ReadBool(FSection, BOOL_NAMES[Index], BOOL_DEFAULTS[Index]);
end;

procedure TIni.SetBoolean(const Index: Integer; const Value: boolean);
begin
  FIni.WriteBool(FSection, BOOL_NAMES[Index], Value);
end;

procedure TIni.SetString(const index: integer; value: string);
begin
  FIni.WriteString(FSection, STR_NAMES[index], value);
end;

function TIni.GetString(const index: integer): string;
begin
  result:= FIni.ReadString(FSection, STR_NAMES[index], STR_DEFAULTS[index]);
end;

initialization
  Ini:= TIni.Create(TPath.Combine(TPath.GetSharedDocumentsPath, INI_NAME));

finalization
  Ini.free;

end.
