program GoogleDrive101;

uses
  Vcl.Forms,
  uGDriveDemo in 'uGDriveDemo.pas' {fmGDriveSimpleDemo},
  UscanGDdir in 'UscanGDdir.pas',
  Vcl.Themes,
  Vcl.Styles,
  uShowboard in 'uShowboard.pas' {fmShowboard};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmGDriveSimpleDemo, fmGDriveSimpleDemo);
  Application.CreateForm(TfmShowboard, fmShowboard);
  Application.Run;
end.
