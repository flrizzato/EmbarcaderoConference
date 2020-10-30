program APIdoiOS;

uses
  System.StartUpCopy,
  FMX.Forms,
  fPrincipal in 'fPrincipal.pas' {frmPrincipal},
  uMapeamento in 'uMapeamento.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
