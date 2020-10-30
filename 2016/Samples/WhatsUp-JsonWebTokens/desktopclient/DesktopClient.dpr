program DesktopClient;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas',
  MusicEntities in '..\apiserver\MusicEntities.pas',
  LoginService in '..\authserver\LoginService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
