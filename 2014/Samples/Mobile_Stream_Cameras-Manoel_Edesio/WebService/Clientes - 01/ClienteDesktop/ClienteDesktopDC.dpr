program ClienteDesktopDC;

uses
  Vcl.Forms,
  uFrmCliente in 'uFrmCliente.pas' {Form5},
  untIDelphiConference in 'untIDelphiConference.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
