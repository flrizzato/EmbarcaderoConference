unit fLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  uSistema;

type
  TfrmLogin = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    pnlOkCancel: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnOkClick(Sender: TObject);
  private
    procedure Salvar;
    procedure ModificarUsuarioComDadosDaTela;
    function ValidarCamposDaTela: boolean;
    function ValidarCampoNome: boolean;
    function ValidarCampoSenha: boolean;
    { Private declarations }
  public
    { Public declarations }
    class function Logar: boolean;
    procedure ExibirUsuarioAtual;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.Salvar;
begin
  if Length(edtUsuario.Text) < 4 then
  begin
    MessageDlg('O usuário deve ter pelo menos 4 caracteres.',mtWarning,[mbOK],0);
    edtUsuario.SetFocus;
    Exit;
  end;

  if Length(edtSenha.Text) < 4 then
  begin
    MessageDlg('A senha deve ter pelo menos 4 caracteres.',mtWarning,[mbOK],0);
    edtUsuario.SetFocus;
    Exit;
  end;

  TSistema.Usuario.Nome   := edtUsuario.Text;
  TSistema.Usuario.Senha  := edtSenha.Text;
  ModalResult := mrOk;

  // Refatorando...

  if Length(edtUsuario.Text) < 4 then
  begin
    MessageDlg('O usuário deve ter pelo menos 4 caracteres.',mtWarning,[mbOK],0);
    edtUsuario.SetFocus;
  end else if Length(edtSenha.Text) < 4 then
  begin
    MessageDlg('A senha deve ter pelo menos 4 caracteres.',mtWarning,[mbOK],0);
    edtUsuario.SetFocus;
  end else begin
    TSistema.Usuario.Nome   := edtUsuario.Text;
    TSistema.Usuario.Senha  := edtSenha.Text;
    ModalResult := mrOk;
  end;

  // Refatorando...

  if ValidarCamposDaTela then
  begin
    TSistema.Usuario.Nome   := edtUsuario.Text;
    TSistema.Usuario.Senha  := edtSenha.Text;
    ModalResult := mrOk;
  end;

  // Refatorando...

  if ValidarCamposDaTela then
  begin
    ModificarUsuarioComDadosDaTela;
    ModalResult := mrOk;
  end;
end;



function TfrmLogin.ValidarCamposDaTela : boolean;
begin
  Result := True;

  //--------

  if Length(edtUsuario.Text) < 4 then
  begin
    MessageDlg('O usuário deve ter pelo menos 4 caracteres.',mtWarning,[mbOK],0);
    edtUsuario.SetFocus;
    Result := False;
  end else if Length(edtSenha.Text) < 4 then
  begin
    MessageDlg('A senha deve ter pelo menos 4 caracteres.',mtWarning,[mbOK],0);
    edtUsuario.SetFocus;
    Result := False;
  end;

  // Refatorando...

  if Result and (Length(edtUsuario.Text) < 4) then
  begin
    MessageDlg('O usuário deve ter pelo menos 4 caracteres.',mtWarning,[mbOK],0);
    edtUsuario.SetFocus;
    Result := False;
  end;

  if Result and (Length(edtSenha.Text) < 4) then
  begin
    MessageDlg('A senha deve ter pelo menos 4 caracteres.',mtWarning,[mbOK],0);
    edtUsuario.SetFocus;
    Result := False;
  end;

  // Refatorando...

  if Result then
    Result := ValidarCampoNome;

  if Result then
    Result := ValidarCampoSenha;

  // Refatorando...

  Result := ValidarCampoNome and
            ValidarCampoSenha;

end;

function TfrmLogin.ValidarCampoNome: boolean;
begin
  Result := True;
  if Length(edtUsuario.Text) < 4 then
  begin
    MessageDlg('O usuário deve ter pelo menos 4 caracteres.',mtWarning,[mbOK],0);
    edtUsuario.SetFocus;
    Result := False;
  end;
end;

function TfrmLogin.ValidarCampoSenha: boolean;
begin
  if (Length(edtSenha.Text) < 4) then
  begin
    MessageDlg('A senha deve ter pelo menos 4 caracteres.',mtWarning,[mbOK],0);
    edtUsuario.SetFocus;
    Result := False;
  end;
end;


procedure TfrmLogin.btnOkClick(Sender: TObject);
begin
  if Length(edtUsuario.Text) < 4 then
  begin
    MessageDlg('O usuário deve ter pelo menos 4 caracteres.',mtWarning,[mbOK],0);
    edtUsuario.SetFocus;
    Exit;
  end;

  if Length(edtSenha.Text) < 4 then
  begin
    MessageDlg('A senha deve ter pelo menos 4 caracteres.',mtWarning,[mbOK],0);
    edtUsuario.SetFocus;
    Exit;
  end;

  TSistema.Usuario.Nome   := edtUsuario.Text;
  TSistema.Usuario.Senha  := edtSenha.Text;
  ModalResult := mrOk;

  // Refatorando...

  Salvar;
end;

procedure TfrmLogin.ExibirUsuarioAtual;
begin
  edtUsuario.Text := TSistema.Usuario.Nome;
end;

class function TfrmLogin.Logar: boolean;
var
  lfrmLogin : TfrmLogin;
begin
  lfrmLogin := TfrmLogin.Create(Application);
  try
    Result := (lfrmLogin.ShowModal = mrOk);
  finally
    lfrmLogin.Free;
  end;
end;

procedure TfrmLogin.ModificarUsuarioComDadosDaTela;
begin
  TSistema.Usuario.Nome := edtUsuario.Text;
  TSistema.Usuario.Senha := edtSenha.Text;
end;

end.
