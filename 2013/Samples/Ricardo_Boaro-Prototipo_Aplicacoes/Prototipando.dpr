program Prototipando;

uses
  Vcl.Forms,
  uModelo1 in 'uModelo1.pas' {Form2},
  uModelo2 in 'uModelo2.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Amakrits');
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
