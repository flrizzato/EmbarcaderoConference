program ExportadorUsuarioResposta;

uses
  Vcl.Forms,
  frnExportaUsuarioResposta in 'frnExportaUsuarioResposta.pas' {Form2},
  uExportador in 'uExportador.pas',
  uUsuario in 'uUsuario.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
