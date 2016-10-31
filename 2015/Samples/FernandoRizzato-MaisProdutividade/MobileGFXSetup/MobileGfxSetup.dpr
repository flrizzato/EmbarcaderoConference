program MobileGfxSetup;

uses
  FMX.Forms,
  MobileGfxSetupMain in 'MobileGfxSetupMain.pas' {frmMobileGfxSetup},
  FrameRatio in 'FrameRatio.pas' {RatioFrame: TFrame},
  iOSOptset in 'iOSOptset.pas',
  AndroidOptset in 'AndroidOptset.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMobileGfxSetup, frmMobileGfxSetup);
  Application.Run;
end.
