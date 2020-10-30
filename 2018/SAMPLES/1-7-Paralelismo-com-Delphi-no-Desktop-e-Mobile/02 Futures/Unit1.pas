unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Threading;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Button3: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    a: IFuture<string>;
    b: IFuture<string>;
    c: IFuture<string>;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  a, b, c: string;
  tempo: Cardinal;
  resultado: string;
begin
  tempo := GetTickCount;

  Sleep(5000);
  a := Random(100).ToString;

  Sleep(3000);
  b := Random(100).ToString;

  Sleep(2000);
  c := Random(100).ToString;

  tempo := GetTickCount - tempo;
  resultado := a + ', ' + b + ', ' + c;
  Label1.Caption := 'Tempo gasto: ' + IntToStr(tempo) + 'ms ' + 'Valor: ' + resultado;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if not Timer1.Enabled then
  begin
    Timer1.Enabled := True;
  end;

  TTask.Run(
    procedure
    var
      tempo: Cardinal;
      resultado: string;
    begin
      tempo := GetTickCount;

      a := TTask.Future<string>(
        function: string
        begin
          Sleep(5000);
          Result := Random(100).ToString;
        end);
      b := TTask.Future<string>(
        function: string
        begin
          Sleep(3000);
          Result := Random(100).ToString;
        end);
      c := TTask.Future<string>(
        function: string
        begin
          Sleep(2000);
          Result := Random(100).ToString;
        end);

      resultado := a.Value + ', ' + b.Value + ', ' + c.Value;
      tempo := GetTickCount - tempo;
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          Label1.Caption := 'Tempo gasto: ' + IntToStr(tempo) + 'ms ' + 'Valor: ' + resultado;
        end);
    end);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  tempo: Cardinal;
  resultado: string;
begin
  if not Timer1.Enabled then
  begin
    Timer1.Enabled := True;
  end;

  a := TTask.Future<string>(
    function: string
    begin
      Sleep(5000);
      Result := Random(100).ToString;
    end);
  b := TTask.Future<string>(
    function: string
    begin
      Sleep(3000);
      Result := Random(100).ToString;
    end);
  c := TTask.Future<string>(
    function: string
    begin
      Sleep(2000);
      Result := Random(100).ToString;
    end);

  tempo := GetTickCount;
  resultado := a.Value + ', ' + b.Value + ', ' + c.Value;
  tempo := GetTickCount - tempo;
  Label1.Caption := 'Tempo gasto: ' + IntToStr(tempo) + 'ms ' + 'Valor: ' + resultado;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if a.Status = TTaskStatus.Completed then
  begin
    Label2.Caption := 'Resultado A: ' + a.Value;
  end
  else
  begin
    Label2.Caption := 'Resultado A: ---';
  end;

  if b.Status = TTaskStatus.Completed then
  begin
    Label3.Caption := 'Resultado B: ' + b.Value;
  end
  else
  begin
    Label3.Caption := 'Resultado B: ---';
  end;
  if c.Status = TTaskStatus.Completed then
  begin
    Label4.Caption := 'Resultado C: ' + c.Value;
  end
  else
  begin
    Label4.Caption := 'Resultado C: ---';
  end;
end;

end.
