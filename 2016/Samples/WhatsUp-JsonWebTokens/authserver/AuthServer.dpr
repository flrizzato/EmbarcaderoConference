program AuthServer;

uses
  Vcl.Forms,
  ConnectionModule in 'ConnectionModule.pas' {SQLiteSQLiteConnection: TDataModule},
  LoginService in 'LoginService.pas',
  LoginServiceImpl in 'LoginServiceImpl.pas',
  MainForm in 'MainForm.pas' {fmServer},
  Server in 'Server.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmServer, fmServer);
  Application.Run;
end.
