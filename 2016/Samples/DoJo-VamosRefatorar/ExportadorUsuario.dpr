program ExportadorUsuario;

uses
  Vcl.Forms,
  frmExportaUsuario in 'frmExportaUsuario.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
