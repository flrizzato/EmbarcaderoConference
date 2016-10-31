unit Unt_Tela;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    Timer1: TTimer;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
  private
    FAlvo: Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  StrUtils;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  iThread     : Integer;
  maIncremento: TProc;
  aThreads    : array [0 .. 9] of TThread;
  aHandles    : array [0 .. 9] of THandle;
  sObservacao : string;
  cRetorno    : Cardinal;
begin
  Self.Button1.Enabled := False;
  Self.Label1.Caption := 'Processando ...';
  Application.ProcessMessages;

  maIncremento := procedure
    var
      i          : Integer;
      bThreadSafe: Boolean;
    begin
      bThreadSafe := Self.CheckBox1.Checked;
      for i := 1 to 100000 do
      begin
        if (bThreadSafe) then
        begin
          InterlockedIncrement(Self.FAlvo);
        end else begin
          Self.FAlvo := Self.FAlvo + 1;
        end;
      end;
    end;

  Self.FAlvo := 0;
  for iThread := 0 to 9 do
  begin
    aThreads[iThread] := TThread.CreateAnonymousThread(maIncremento);
    aHandles[iThread] := aThreads[iThread].Handle;
  end;

  for iThread := 0 to 9 do
  begin
    aThreads[iThread].Start;
  end;

  cRetorno := WaitForMultipleObjects(10, @aHandles, True, INFINITE);

  if (cRetorno = WAIT_OBJECT_0) then
  begin
    sObservacao := IfThen(Self.FAlvo = 10 * 100000, 'CORRETO', ' *** ERRADO ***');
    Memo1.Lines.Insert(0, Format('%s - Valor: [%s] - %s', [TimeToStr(Now), FormatFloat('#,##0', Self.FAlvo), sObservacao]));

    Self.Button1.Enabled := True;
    Self.Label1.Caption := 'FIM!';
  end else begin
    Self.Memo1.Text := 'RETORNO DO WaitForMultipleObjects : ' + IntToStr(cRetorno) + ' - ' + SysErrorMessage(GetLastError);
  end;

end;

end.
