program CameraViewPlus;

uses
   System.StartUpCopy,
   FMX.MobilePreview,
   FMX.Forms,
   uFrmCameraViewPlus in 'uFrmCameraViewPlus.pas'{FrmCameraViewPlus};

{$R *.res}

begin
   Application.Initialize;
   Application.FormFactor.Orientations := [TFormOrientation.Portrait];
   Application.CreateForm(TFrmCameraViewPlus, FrmCameraViewPlus);
   Application.Run;

end.
