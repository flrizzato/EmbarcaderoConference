program XE6VCLMenusDemo;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form13},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Glossy');
  Application.CreateForm(TForm13, Form13);
  Application.Run;
end.
