program HelloServerStandAlone;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {fmHelloServer},
  HelloServerUnit in 'HelloServerUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmHelloServer, fmHelloServer);
  Application.Run;
end.
