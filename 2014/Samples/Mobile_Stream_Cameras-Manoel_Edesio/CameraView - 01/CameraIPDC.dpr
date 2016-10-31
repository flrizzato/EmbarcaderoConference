program CameraIPDC;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  uFrmCameraView in 'uFrmCameraView.pas' {frmCameraView};

{$R *.res}

begin
   Application.Initialize;
   Application.CreateForm(TfrmCameraView, frmCameraView);
  Application.Run;

end.
