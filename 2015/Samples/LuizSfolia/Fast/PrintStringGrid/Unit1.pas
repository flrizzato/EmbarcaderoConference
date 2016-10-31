unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frxClass, StdCtrls, Grids, frxCross;

type
  TForm1 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    frxCrossObject1: TfrxCrossObject;
    frxReport1: TfrxReport;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxReport1BeforePrint(c: TfrxReportComponent);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  i, j: Integer;
begin
  for i := 1 to 16 do
    for j := 1 to 16 do
      StringGrid1.Cells[i - 1, j - 1] := IntToStr(i * j);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  frxReport1.ShowReport;
end;

procedure TForm1.frxReport1BeforePrint(c: TfrxReportComponent);
var
  Cross: TfrxCrossView;
  i, j: Integer;
begin
  if c is TfrxCrossView then
  begin
    Cross := TfrxCrossView(c);
    for i := 1 to 16 do
      for j := 1 to 16 do
        Cross.AddValue([i], [j], [StringGrid1.Cells[i - 1, j - 1]]);
  end;
end;

end.
