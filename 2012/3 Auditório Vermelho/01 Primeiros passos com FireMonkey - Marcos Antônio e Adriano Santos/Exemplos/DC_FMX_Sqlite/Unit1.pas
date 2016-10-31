unit Unit1;

{$IFDEF FPC}
{$mode objfpc}{$H+}
{$modeswitch objectivec1}
{$ENDIF}

interface

uses
  SysUtils, Types, UITypes, Classes, Variants, FMX_Types, FMX_Controls, FMX_Forms,
  FMX_Dialogs, FMX_Layouts, FMX_Memo, FMX_Edit
{$IFDEF FPC}
  , iPhoneAll, SQLite3db, SQLite
{$ENDIF}
  ;

type
  TForm1 = class(TForm)
    DropBtn: TButton;
    Display: TMemo;
    CreateBtn: TButton;
    InsertBtn: TButton;
    SelectBtn: TButton;
    StyleBook1: TStyleBook;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    FirstName: TEdit;
    LastName: TEdit;
    procedure CreateBtnClick(Sender: TObject);
    procedure InsertBtnClick(Sender: TObject);
    procedure SelectBtnClick(Sender: TObject);
    procedure DropBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{$IFDEF FPC}
function MyDirectory : NSString;
var
  paths : NSArray;
  fileName : NSString;
begin
  paths := NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, True);
  fileName := paths.objectAtIndex(0);
  Result := fileName;
end;
{$ENDIF}

function MyFileName : String;
begin
{$IFDEF FPC}
  Result := String(MyDirectory.UTF8String)+'/MyDB.sqlite';
{$ENDIF}
end;

procedure TForm1.CreateBtnClick(Sender: TObject);
{$IFDEF FPC}
var
  SQL : String;
  DB : TSQLite;
{$ENDIF}
begin
{$IFDEF FPC}
  DB := TSQLite.Create(MyFileName);

  // Create the table
  SQL := 'create table Customers (Id integer not null, LastName char(25), FirstName char(25))';
  DB.Query(SQL,nil);

  DB.Free;
{$ENDIF}
end;

procedure TForm1.DropBtnClick(Sender: TObject);
{$IFDEF FPC}
var
  SQL : String;
  DB : TSQLite;
{$ENDIF}
begin
  {$IFDEF FPC}
  DB := TSQLite.Create(MyFileName);

  // Drop the table and start from scratch
  SQL := 'drop table Customers';
  DB.Query(SQL,nil);

  DB.Free;
{$ENDIF}
end;

procedure TForm1.InsertBtnClick(Sender: TObject);
{$IFDEF FPC}
var
  SQL : String;
  DB : TSQLite;
{$ENDIF}
begin
{$IFDEF FPC}
  DB := TSQLite.Create(MyFileName);

  // Insert a record
  SQL := 'insert into Customers values(1, "'+LastName.Text+'", "'+FirstName.Text+'")';
  DB.Query(SQL,nil);

  DB.Free;

  // Display the record as well
  SelectBtnClick(Self);
{$ENDIF}
end;

procedure TForm1.SelectBtnClick(Sender: TObject);
{$IFDEF FPC}
var
  SQL : String;
  DB : TSQLite;
  SL : Classes.TStringList;
{$ENDIF}
begin
{$IFDEF FPC}
  DB := TSQLite.Create(MyFileName);

  // Get the records back and list them in the memo
  SL := Classes.TStringList.Create;
  SQL := 'select * from Customers';
  if DB.Query(SQL,SL) then
    Display.Text := SL.Text;
  SL.Free;

  DB.Free;
{$ENDIF}
end;

end.
