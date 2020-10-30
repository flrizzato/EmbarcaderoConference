program BoasPraticas;

uses
  Vcl.Forms,
  fPrincipal in 'fPrincipal.pas' {frmPrincipal},
  dImporta in 'Regra7\dImporta.pas' {dmdImporta: TDataModule},
  uImporta in 'Regra7\uImporta.pas',
  uFuncoes in 'Regra2\uFuncoes.pas',
  uValidador in 'Regra2\uValidador.pas',
  uSistema in 'Regra3\uSistema.pas',
  uUsuario in 'Regra3\uUsuario.pas',
  fLogin in 'Regra4\fLogin.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmdImporta, dmdImporta);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
