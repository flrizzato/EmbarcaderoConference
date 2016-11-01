program Cliente;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmClienteUnt in 'frmClienteUnt.pas' {frmCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCliente, frmCliente);
  Application.Run;
end.
