program ApiServer;

uses
  Vcl.Forms,
  DatabaseUtils in 'DatabaseUtils.pas',
  MainForm in 'MainForm.pas' {fmServer},
  MusicEntities in 'MusicEntities.pas',
  Server in 'Server.pas',
  SQLiteConnectionModule in 'SQLiteConnectionModule.pas' {SQLiteConnection: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmServer, fmServer);
  Application.Run;
end.
