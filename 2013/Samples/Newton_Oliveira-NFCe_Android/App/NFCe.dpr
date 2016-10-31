program NFCe;

uses
  System.StartUpCopy,
  FMX.Forms,
  uNFCe in 'uNFCe.pas' {frmNota},
  uDMNFCe in 'uDMNFCe.pas' {DMNFCe: TDataModule},
  uServerDataSnap in 'uServerDataSnap.pas',
  uNota in '..\Server\uNota.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmNota, frmNota);
  Application.CreateForm(TDMNFCe, DMNFCe);
  Application.Run;
end.
