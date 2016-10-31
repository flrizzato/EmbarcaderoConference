unit uMainDM;

interface

uses
  SysUtils, Classes, DB, SqlExpr, WideStrings, DBXInterbase;

type
  TMainDM = class(TDataModule)
    SQLConnection: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure SQLConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainDM: TMainDM;

implementation

uses
  Forms, uMainForm;

{$R *.dfm}

procedure TMainDM.DataModuleCreate(Sender: TObject);
begin
  if not SQLConnection.Connected then
    SQLConnection.Open;
  TMainForm(Application.MainForm).DBConnection := SQLConnection;
end;

procedure TMainDM.SQLConnectionBeforeConnect(Sender: TObject);
begin
  SQLConnection.LoadParamsFromIniFile(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'dbxconnections.ini');
end;

end.
