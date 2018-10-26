program BeaconAlarmSvc;

uses
  System.Android.ServiceApplication,
  BeaconAlarmService in 'BeaconAlarmService.pas' {DM: TAndroidService},
  aIni in 'aIni.pas',
  ccPush in '..\PushDatsnap\Client\ccPush.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMDistAlarmService, DMDistAlarmService);
  Application.Run;
end.
