program app;

uses
  System.StartUpCopy,
  FMX.Forms,
  uApp in 'uApp.pas' {Form2},
  RestRequest in 'RestRequest.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
