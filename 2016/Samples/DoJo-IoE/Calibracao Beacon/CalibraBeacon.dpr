program CalibraBeacon;

uses
  System.StartUpCopy,
  FMX.Forms,
  uCalibraBeacon in 'uCalibraBeacon.pas' {frmCalibrar},
  uCCalibraBeacon in 'uCCalibraBeacon.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCalibrar, frmCalibrar);
  Application.Run;
end.
