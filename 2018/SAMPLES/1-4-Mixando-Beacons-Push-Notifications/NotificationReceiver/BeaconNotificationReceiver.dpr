program BeaconNotificationReceiver;

uses
  System.StartUpCopy,
  FMX.Forms,
  fAppNotificationReceiver in 'fAppNotificationReceiver.pas' {Form1},
  aConsts in 'aConsts.pas',
  aIni in 'aIni.pas',
  ccPush in '..\PushDatsnap\Client\ccPush.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
