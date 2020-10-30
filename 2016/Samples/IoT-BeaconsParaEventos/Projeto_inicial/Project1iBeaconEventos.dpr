program Project1iBeaconEventos;

uses
  System.StartUpCopy,
  FMX.Forms,
  UMenuPrincipal in 'UMenuPrincipal.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
