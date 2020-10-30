unit UnitFormMain;

{ ===============================================================================
  CodeRage 9 - Demo for Task Chaining using WaitForAll

  This code shows how to chain Tasks together (Fork / Join pattern)

  Using the ITask interface you can let new Tasks wait for results from previous
  Tasks.

  Be careful when using Synchronize in a TTask.Run combined with a WaitForAll or
  WaitForAny in the main thread. These may cause a deadlock, because the Task
  is waiting for the main thread to perform the Synchronize and the main thread
  is waiting for the task to complete in WaitForAll or WaitForAny. It is safe to
  use Synchronize if you do the WaitForAll from inside the TTask.Run as in this
  example.

  Author: Danny Wind
  =============================================================================== }

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  System.Threading, FMX.Ani, FMX.Controls.Presentation;

type
  TFormMain = class(TForm)
    ButtonTask1: TButton;
    ButtonTask2: TButton;
    ButtonTask1Plus2: TButton;
    LabelTask1: TLabel;
    LabelTask2: TLabel;
    LabelTask1Plus2: TLabel;
    procedure ButtonTask1Click(Sender: TObject);
    procedure ButtonTask2Click(Sender: TObject);
    procedure ButtonTask1Plus2Click(Sender: TObject);
  private
    { Private declarations }
    AllTasks: array [0 .. 1] of ITask;
  public
    { Public declarations }
    procedure RunTask(aLabel: TLabel; var aTask: ITask);
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

procedure TFormMain.ButtonTask1Click(Sender: TObject);
begin
  RunTask(LabelTask1, AllTasks[0]);
end;

procedure TFormMain.ButtonTask2Click(Sender: TObject);
begin
  RunTask(LabelTask2, AllTasks[1]);
end;

procedure TFormMain.ButtonTask1Plus2Click(Sender: TObject);
begin
  LabelTask1Plus2.Text := '--';
  TTask.Run(
    procedure
    begin
      TTask.WaitForAll(AllTasks);
      TThread.Queue(TThread.CurrentThread,
        procedure
        begin
          //ShowMessage(GetStatus(Tasks1to2[0].Status));
          LabelTask1Plus2.Text := LabelTask1.Text + ' + ' + LabelTask2.Text;
        end);
    end);
end;

procedure TFormMain.RunTask(aLabel: TLabel; var aTask: ITask);
begin
  aLabel.Text := '--';
  aTask := TTask.Run(
    procedure
    var
      lValue: Integer;
    begin
      { Some calculation that takes time }
      Sleep(3000);
      lValue := Random(10);
      TThread.Synchronize(nil,
        procedure
        begin
          aLabel.Text := lValue.ToString;
        end);
    end);
end;

initialization
ReportMemoryLeaksOnShutdown := True;

end.
