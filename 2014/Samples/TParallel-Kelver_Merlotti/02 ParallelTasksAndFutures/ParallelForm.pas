unit ParallelForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, System.Threading, System.RTTI;

type
  TTaskStatusHelper = record helper for TTaskStatus
    function ToString: String;
  end;


  TFormThreading = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormThreading: TFormThreading;

implementation

{$R *.dfm}

uses
  System.SyncObjs;

procedure TFormThreading.Button1Click(Sender: TObject);
var
  aTask: ITask;
begin
  // not a thread safe snippet
  aTask := TTask.Create (procedure ()
    begin
      sleep (3000); // 3 seconds
      ShowMessage ('Hello');
    end);
  aTask.Start;
end;

procedure TFormThreading.Button2Click(Sender: TObject);
var
  tasks: array of ITask;
  value: Integer;
  Ini, Fim: TDateTime;
begin
  Setlength (tasks ,2);
  value := 0;

  Ini := Now;

  tasks[0] := TTask.Create (procedure ()
    begin
      sleep (3000); // 3 seconds
      TInterlocked.Add (value, 3000);
    end);
  tasks[0].Start;

  tasks[1] := TTask.Create (procedure ()
    begin
      sleep (5000); // 5 seconds
      TInterlocked.Add (value, 5000);
    end);
  tasks[1].Start;

  TTask.WaitForAll(tasks);
  Fim := Now;

  ShowMessage ('All done: ' + value.ToString + sLineBreak +
    FormatDateTime('SS.ZZZ', Fim-Ini));
end;

function ComputeSomething: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to 10000 do
    Result := Result + Round(Sqrt(I));
end;

procedure TFormThreading.Button3Click(Sender: TObject);
var
  FutureValue: IFuture <Integer>;
  OtherValue: Integer;
  Total: Integer;
begin
  FutureValue := TTask.Future<Integer>(
    function: Integer
    begin
      Sleep(1000);
      Result := ComputeSomething;
    end);

  Memo1.Lines.Add(FutureValue.Status.ToString); //Waiting to Run
  //Memo1.Lines.Add(TRttiEnumerationType.
  //  GetName<TTaskStatus>(FutureValue.Status));

  OtherValue := ComputeSomething;
  Memo1.Lines.Add(FutureValue.Status.ToString); //Running

  Total := OtherValue + FutureValue.Value;
  Memo1.Lines.Add(FutureValue.Status.ToString); //Completed

  // result
  Memo1.Lines.Add(Total.ToString);
end;

{ TTaskStatusHelper }

function TTaskStatusHelper.ToString: String;
begin
  result := TRttiEnumerationType.GetName<TTaskStatus>(Self);
end;

end.
