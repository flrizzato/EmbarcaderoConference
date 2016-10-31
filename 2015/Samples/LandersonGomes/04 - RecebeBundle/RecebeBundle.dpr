program RecebeBundle;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmRecebeBundleUnt in 'frmRecebeBundleUnt.pas' {frmRecebeBundle};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmRecebeBundle, frmRecebeBundle);
  Application.Run;
end.
