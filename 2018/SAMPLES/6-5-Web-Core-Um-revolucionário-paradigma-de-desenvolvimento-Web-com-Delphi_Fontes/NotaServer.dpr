program NotaServer;

uses
  Vcl.Forms,
  Server in 'Server.pas' {Form4},
  NotaService in 'NotaService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
