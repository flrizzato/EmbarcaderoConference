program DistanceAlarm;

uses
  System.StartUpCopy,
  FMX.Forms,
  fAppDistAlarm in 'fAppDistAlarm.pas' {frmAppDistAlarm},
  BeaconAlarmService in '..\Service\BeaconAlarmService.pas' {DM: TAndroidService},
  aIni in '..\Service\aIni.pas',
  ccPush in '..\PushDatsnap\Client\ccPush.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAppDistAlarm, frmAppDistAlarm);
  Application.Run;
end.
