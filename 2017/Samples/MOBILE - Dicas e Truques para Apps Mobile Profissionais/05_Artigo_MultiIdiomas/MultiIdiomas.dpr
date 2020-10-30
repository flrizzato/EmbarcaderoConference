program MultiIdiomas;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmPrincipalUnt in 'frmPrincipalUnt.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
