unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses System.Threading;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Sleep(10000); // 10s
  Label1.Caption := DateTimeToStr(Now);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  TTask.Run(procedure
  begin
    Sleep(10000); // 10s
    TThread.Synchronize(TThread.CurrentThread, procedure
    begin
      Label1.Caption := DateTimeToStr(Now);
    end);
  end);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  t2: ITask;
begin
  t2 := TTask.Create(procedure
  begin
    Sleep(10000); // 10s
    TThread.Synchronize(TThread.CurrentThread, procedure
    begin
      Label1.Caption := DateTimeToStr(Now);
    end);
  end);
  t2.Start;
end;

end.
