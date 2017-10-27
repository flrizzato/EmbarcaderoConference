unit SQLMonitor;

interface

uses
  DB,
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ormbr.monitor;

type
  TFSQLMonitor = class(TForm, ICommandMonitor)
    MemoSQL: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    class var
      FInstance: TFSQLMonitor;
    procedure Command(ASQL: string; AParams: TParams);
  public
    { Public declarations }
    class function GetInstance: TFSQLMonitor;
  end;

var
  FSQLMonitor: TFSQLMonitor;

implementation

uses
  TypInfo;

{$R *.dfm}

{ TFSQLMonitor }

procedure TFSQLMonitor.Button1Click(Sender: TObject);
begin
  MemoSQL.Lines.Clear;
end;

procedure TFSQLMonitor.Command(ASQL: string; AParams: TParams);
var
  iFor: Integer;
  AsValue: string;
begin
  MemoSQL.Lines.Add('');
  MemoSQL.Lines.Add(ASQL);
  for iFor := 0 to AParams.Count -1 do
  begin
    if AParams.Items[iFor].Value = Variants.Null then
      AsValue := 'NULL'
    else
    if AParams.Items[iFor].DataType = ftDateTime then
      AsValue := '"' + DateTimeToStr(AParams.Items[iFor].Value) + '"'
    else
    if AParams.Items[iFor].DataType = ftDate then
      AsValue := '"' + DateToStr(AParams.Items[iFor].Value) + '"'
    else
      AsValue := '"' + VarToStr(AParams.Items[iFor].Value) + '"';

    MemoSQL.Lines.Add(AParams.Items[iFor].Name + ' = ' + AsValue + ' (' +
          GetEnumName(TypeInfo(TFieldType), Ord(AParams.Items[iFor].DataType)) + ')');
  end;
end;

class function TFSQLMonitor.GetInstance: TFSQLMonitor;
begin
  if FInstance = nil then
    FInstance := TFSQLMonitor.Create(Application);
  Result := FInstance;
end;

end.
