program ExemploEmbarcaderoConference;

uses
  Forms,
  fPrinicpal in 'fPrinicpal.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
