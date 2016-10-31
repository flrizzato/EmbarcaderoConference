unit fPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uFuncoes, uValidador, System.UITypes, Vcl.ComCtrls, fLogin,
  uSistema, dImporta;

type
  TfrmPrincipal = class(TForm)
    stbInfo: TStatusBar;
    GroupBox1: TGroupBox;
    btnValidarCpf: TButton;
    edtCpf: TEdit;
    btnTValidadorCpf: TButton;
    ScrollBox1: TScrollBox;
    GroupBox2: TGroupBox;
    btnLoginComum: TButton;
    btnLoginWith: TButton;
    btnLoginOO: TButton;
    GroupBox3: TGroupBox;
    bntAlteraUsuario: TButton;
    edtUsuario: TEdit;
    GroupBox4: TGroupBox;
    Button2: TButton;
    Button1: TButton;
    pgbStatus: TProgressBar;
    memNome: TMemo;
    Button3: TButton;
    Button4: TButton;
    procedure btnValidarCpfClick(Sender: TObject);
    procedure btnTValidadorCpfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLoginComumClick(Sender: TObject);
    procedure btnLoginWithClick(Sender: TObject);
    procedure btnLoginOOClick(Sender: TObject);
    procedure bntAlteraUsuarioClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ExibirUsuarioAtual;
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uImporta;

{$R *.dfm}

procedure TfrmPrincipal.btnTValidadorCpfClick(Sender: TObject);
begin
  if TValidador.CPF(edtCpf.Text) then
  begin
    MessageDlg('Cpf válido.',mtInformation,[mbOk],0);
  end else begin
    MessageDlg('Cpf inválido.',mtError,[mbOk],0);
  end;
end;

procedure TfrmPrincipal.btnValidarCpfClick(Sender: TObject);
begin
  if ValidaCPF(edtCpf.Text) then
  begin
    MessageDlg('Cpf válido.',mtInformation,[mbOk],0);
  end else begin
    MessageDlg('Cpf inválido.',mtError,[mbOk],0);
  end;
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
var
  lArquivo: TextFile;
  lLinha: WideString;
  li : integer;
begin
  AssignFile(lArquivo, 'Exemplo.txt');
  Reset(lArquivo);
  try
    // Retorna numero de Linha
    li := 0;
    while not Eof(lArquivo) do
    begin
      Readln(lArquivo, lLinha);
      inc(li);
    end;

    pgbStatus.Position := 0;
    pgbStatus.Max := li;
    Reset(lArquivo);
    while not Eof(lArquivo) do
    begin
      Readln(lArquivo, lLinha);
      if (copy(lLinha,1,1) = '1') then
        memNome.Lines.Add(copy(lLinha,3,40));

      Application.ProcessMessages;
      pgbStatus.Position := pgbStatus.Position + 1;
    end;
  finally
    CloseFile(lArquivo);
  end;
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
  dmdImporta.ProgressBar := pgbStatus;
  memNome.Text := dmdImporta.Importar;
end;

procedure TfrmPrincipal.Button3Click(Sender: TObject);
var
  lImporta : TImporta;
begin
  lImporta := TImporta.Create(pgbStatus);
  try
    memNome.Text := lImporta.Importar;
  finally
    lImporta.Free;
  end;
end;

procedure TfrmPrincipal.Button4Click(Sender: TObject);
begin
  memNome.Text := TImporta.CarregarArquivo(pgbStatus);
end;

procedure TfrmPrincipal.bntAlteraUsuarioClick(Sender: TObject);
begin
  TSistema.Usuario.Nome  := edtUsuario.Text;
  stbInfo.Panels[0].Text := 'Usuario: '+ TSistema.Usuario.Nome;
end;

procedure TfrmPrincipal.btnLoginWithClick(Sender: TObject);
begin
  with TfrmLogin.Create(Application) do
  begin
    ShowModal;
    stbInfo.Panels[0].Text := 'Usuario: '+ TSistema.Usuario.Nome;
    //ExibirUsuarioAtual; //-> Se o objeto do With passa a ter o método, este será executado no bloco
    Free;
  end;
end;

procedure TfrmPrincipal.btnLoginComumClick(Sender: TObject);
var
  lfrmLogin : TfrmLogin;
begin
  lfrmLogin := TfrmLogin.Create(Application);
  if lfrmLogin.ShowModal = mrOk then
  begin
    stbInfo.Panels[0].Text := 'Usuario: '+ TSistema.Usuario.Nome;
  end;
  lfrmLogin.Free;
end;

procedure TfrmPrincipal.btnLoginOOClick(Sender: TObject);
begin
  TfrmLogin.Logar;
  ExibirUsuarioAtual;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

procedure TfrmPrincipal.ExibirUsuarioAtual;
begin
  stbInfo.Panels[0].Text := 'Usuario: '+ TSistema.Usuario.Nome;
end;

end.
