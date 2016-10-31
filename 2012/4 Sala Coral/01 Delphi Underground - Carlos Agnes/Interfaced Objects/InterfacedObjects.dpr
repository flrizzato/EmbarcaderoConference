program InterfacedObjects;

uses
  FMX.Forms,
  fPrincipal in 'fPrincipal.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
