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
  Vcl.ExtCtrls,
  Unt_ThreadProcessamento,
  Unt_ThreadCliente;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Button1: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    Timer1: TTimer;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label2: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FPilhaObjetos: TThreadProcessamento;
    FClienteA    : TThreadCliente;
    FClienteB    : TThreadCliente;
    FClienteC    : TThreadCliente;
    FClienteD    : TThreadCliente;
    procedure FinalizarThreads;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Self.FPilhaObjetos := TThreadProcessamento.Create(True);
  Self.FPilhaObjetos.Start;

  Self.Button1.Enabled := False;

  Self.Timer1.Enabled := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Self.FClienteA := TThreadCliente.Create(Self.FPilhaObjetos);
  Self.FClienteA.Start;
  Self.Button2.Enabled := False;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Self.FClienteB := TThreadCliente.Create(Self.FPilhaObjetos);
  Self.FClienteB.Start;
  Self.Button3.Enabled := False;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Self.FClienteC := TThreadCliente.Create(Self.FPilhaObjetos);
  Self.FClienteC.Start;
  Self.Button4.Enabled := False;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Self.FClienteD := TThreadCliente.Create(Self.FPilhaObjetos);
  Self.FClienteD.Start;
  Self.Button5.Enabled := False;
end;

procedure TForm1.FinalizarThreads;
begin
  Self.FClienteA.Terminate;
  Self.FClienteB.Terminate;
  Self.FClienteC.Terminate;
  Self.FClienteD.Terminate;

  Self.FClienteA.WaitFor;
  Self.FClienteB.WaitFor;
  Self.FClienteC.WaitFor;
  Self.FClienteD.WaitFor;

  FreeAndNil(Self.FClienteA);
  FreeAndNil(Self.FClienteB);
  FreeAndNil(Self.FClienteC);
  FreeAndNil(Self.FClienteD);

  Self.FPilhaObjetos.Terminate;
  Self.FPilhaObjetos.WaitFor;
  FreeAndNil(Self.FPilhaObjetos);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.Label1.Caption := EmptyStr;
  Self.Label2.Caption := EmptyStr;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Self.FinalizarThreads;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Self.Label1.Caption := 'Itens processados: ' + FormatFloat('#,##0', Self.FPilhaObjetos.ItensProcessados);
  Self.Label2.Caption := 'Itens a processar: ' + FormatFloat('#,##0', Self.FPilhaObjetos.ItensNaoProcessados);
end;

end.
