program MobileCRUD;

uses
  System.StartUpCopy,
  FMX.Forms,
  uAppLib in 'uAppLib.pas',
  uMainForm in 'uMainForm.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
