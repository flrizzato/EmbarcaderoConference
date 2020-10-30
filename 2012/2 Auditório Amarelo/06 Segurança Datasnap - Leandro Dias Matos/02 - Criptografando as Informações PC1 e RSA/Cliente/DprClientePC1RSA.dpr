program DprClientePC1RSA;

uses
  Vcl.Forms,
  UClientePC1RSA in 'UClientePC1RSA.pas' {Form1},
  UServerMethodsClient in 'UServerMethodsClient.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
