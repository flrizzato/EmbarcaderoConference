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
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Samples.Gauges;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Memo1: TMemo;
    gGaugeCritico: TGauge;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
  private
    procedure EventoQuandoTerminar(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unt_Thread;

procedure TForm1.Button1Click(Sender: TObject);

  procedure _IniciarThread(AGauge: TGauge; AMascaraAfinidade: Byte);
  begin
    with TThreadExemplo.Create(True) do
    begin
      ProgressBar := AGauge;
      Nucleo := AMascaraAfinidade;
      UsarSynchronize := Self.CheckBox1.Checked;
      FreeOnTerminate := True;
      OnTerminate := Self.EventoQuandoTerminar;
      Start;
    end;
  end;

begin
  Memo1.Clear;
  _IniciarThread(Self.gGaugeCritico, 1); //Processador 1 = 0001
  _IniciarThread(Self.gGaugeCritico, 2); //Processador 2 = 0010
  _IniciarThread(Self.gGaugeCritico, 4); //Processador 3 = 0100
  _IniciarThread(Self.gGaugeCritico, 8); //Processaror 4 = 1000
end;

procedure TForm1.EventoQuandoTerminar(Sender: TObject);
begin
  Memo1.Lines.Add(TimeToStr(Time) + ' - Thread terminada!')
end;

end.
