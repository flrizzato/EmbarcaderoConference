program PharmacyApp;

uses
  Vcl.Forms,
  formPharmacy in 'formPharmacy.pas' {frmPharmacy},
  dmLocalData in 'dmLocalData.pas' {dtmdLocalDB: TDataModule},
  formPharmacyController in 'formPharmacyController.pas' {dmPharmacyController: TDataModule},
  frameData in 'frameData.pas' {Frame1: TFrame},
  dmDelta in 'dmDelta.pas' {dtmdlDelta: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPharmacy, frmPharmacy);
  Application.Run;
end.
