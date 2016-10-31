program Server;

uses
  Vcl.Forms,
  uServer in 'uServer.pas' {Form4},
  uServerMetodo in 'uServerMetodo.pas' {ServerMethods1: TDSServerModule},
  uServerContainer in 'uServerContainer.pas' {ServerContainer1: TDataModule},
  uNota in 'uNota.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.Run;
end.

