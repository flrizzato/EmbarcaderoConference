program AgilePushDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  fAppPushDemo in 'fAppPushDemo.pas' {frmAppPushDemo},
  aClasses in '..\Common\aClasses.pas',
  aIni in 'aIni.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TfrmAppPushDemo, frmAppPushDemo);
  Application.Run;
end.
