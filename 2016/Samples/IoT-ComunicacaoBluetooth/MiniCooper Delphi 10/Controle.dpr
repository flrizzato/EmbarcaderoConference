program Controle;

uses
  System.StartUpCopy,
  FMX.Forms,
  FPrincipal in 'FPrincipal.pas' {Form3},
  uComum in 'uComum.pas',
  uThreadControle in 'uThreadControle.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.InvertedLandscape];
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
