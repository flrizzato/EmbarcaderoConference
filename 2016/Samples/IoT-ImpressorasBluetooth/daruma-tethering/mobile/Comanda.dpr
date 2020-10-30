program Comanda;

uses
  System.StartUpCopy,
  FMX.Forms,
  UntMain in 'UntMain.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
