program ClienteMobileDC;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {Form5},
  untIDelphiConference in 'untIDelphiConference.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.InvertedLandscape];
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
