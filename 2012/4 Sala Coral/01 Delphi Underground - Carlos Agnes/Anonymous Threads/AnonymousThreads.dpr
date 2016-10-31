program AnonymousThreads;

uses
  FMX.Forms,
  fPrincipal in 'fPrincipal.pas' {frmPrincipal},
  uFibonacci in 'uFibonacci.pas',
  uThreadDedicada in 'uThreadDedicada.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
