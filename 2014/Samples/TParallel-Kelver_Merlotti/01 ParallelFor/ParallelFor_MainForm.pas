unit ParallelFor_MainForm;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Windows;

type
  TFormParallelFor = class(TForm)
    btnPlainForLoop: TButton;
    Memo1: TMemo;
    btnParallelForLoop: TButton;
    procedure btnPlainForLoopClick(Sender: TObject);
    procedure btnParallelForLoopClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormParallelFor: TFormParallelFor;

implementation

{$R *.dfm}

uses
  SyncObjs, System.Threading, System.Diagnostics;

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
  Max = 100000; // 100K

procedure TFormParallelFor.btnPlainForLoopClick(Sender: TObject);
var
  I, Tot: Integer;
  Ticks: Cardinal;
begin
  // counts the prime numbers below a given value
  Tot := 0;
  Ticks := GetTickCount;
  for I := 1 to Max do
  begin
    if IsPrime (I) then
      Inc (Tot);
    //Application.ProcessMessages;
  end;
  Ticks := GetTickCount - Ticks;
  Memo1.Lines.Add (Format (
    'Plain for: %d - %d', [Ticks, Tot]));
end;

procedure TFormParallelFor.btnParallelForLoopClick(Sender: TObject);
var
  Tot: Integer;
  Ticks: Cardinal;
begin
  Tot := 0;
  Ticks := GetTickCount;
  TParallel.For(1, Max, procedure (I: Int64)
    begin
      if IsPrime (I) then
        InterlockedIncrement (Tot);
    end);
  Ticks := GetTickCount - Ticks;
  Memo1.Lines.Add (Format (
    'Parallel for: %d - %d', [Ticks, Tot]));
end;

end.
