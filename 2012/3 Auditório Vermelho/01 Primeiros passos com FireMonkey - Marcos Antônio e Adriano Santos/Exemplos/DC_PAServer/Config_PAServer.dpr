program Config_PAServer;

uses
  FMX.Forms,
  Exemplo1PAServer in 'Exemplo1PAServer.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
