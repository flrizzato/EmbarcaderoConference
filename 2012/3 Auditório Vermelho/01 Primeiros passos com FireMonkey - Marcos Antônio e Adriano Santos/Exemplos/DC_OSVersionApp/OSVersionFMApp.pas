program OSVersionFMApp;

uses
  cwstring, cthreads, FMX_Forms,
  uFormOSVersion in 'uFormOSVersion.pas' {FormOSVersion},
  uOSVersionUtils in 'uOSVersionUtils.pas';

{.$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormOSVersion, FormOSVersion);
  Application.Run;
end.
