program PushDatasnapClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  fAppPushClient in 'fAppPushClient.pas' {frmAppPushClient},
  aConsts in 'aConsts.pas',
  ccPush in 'ccPush.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAppPushClient, frmAppPushClient);
  Application.Run;
end.
