program UtilizandoVMI;

uses
  FMX.Forms,
  fPrincipal in 'fPrincipal.pas' {frmPrincipal},
  uAspectos in 'uAspectos.pas',
  uUsuario in 'uUsuario.pas',
  uConexao in 'uConexao.pas',
  uNotaFiscal in 'uNotaFiscal.pas',
  uTeste in 'uTeste.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
