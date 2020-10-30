unit ParallelForMultiForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Memo, FMX.StdCtrls;

type
  TForm5 = class(TForm)
    btnForLoop: TButton;
    GridPanelLayout1: TGridPanelLayout;
    btnParallelFor: TButton;
    Memo1: TMemo;
    procedure btnForLoopClick(Sender: TObject);
    procedure btnParallelForClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses
  System.Threading, System.Diagnostics, System.SyncObjs;

{$R *.fmx}

{function local to the unit}
function IsPrime (N: Integer): Boolean;
var
  Test: Integer;
begin
  IsPrime := True;
  for Test := 2 to N - 1 do
    if (N mod Test) = 0 then
    begin
      IsPrime := False;
      break; {jump out of the for loop}
    end;
end;

const
  Max = 300000; // 300k

procedure TForm5.btnForLoopClick(Sender: TObject);
var
  I, Tot: Integer;
  SW: TStopwatch;
begin
  // counts the prime numbers below a given value
  Tot := 0;
  SW := TStopWatch.Create;
  SW.Start;
  for I := 1 to Max do
  begin
    if IsPrime (I) then
      Inc (Tot);
    // Application.ProcessMessages;
  end;
  SW.Stop;
  Memo1.Lines.Add (Format (
    'Plain for loop: %d - %d', [SW.ElapsedMilliseconds, Tot]));
end;

procedure TForm5.btnParallelForClick(Sender: TObject);
var
  Tot: Integer;
  SW: TStopwatch;
begin
  // counts the prime numbers below a given value
  Tot := 0;
  SW := TStopWatch.Create;
  SW.Start;
  TParallel.For(2, 1, Max, procedure (I: Integer)
    begin
      if IsPrime (I) then
        TInterlocked.Increment (Tot);
    end);
  SW.Stop;
  Memo1.Lines.Add (Format (
    'Plain for loop: %d - %d', [SW.ElapsedMilliseconds, Tot]));
end;

end.
