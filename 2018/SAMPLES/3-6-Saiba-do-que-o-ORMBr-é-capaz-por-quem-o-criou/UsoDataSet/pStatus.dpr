program pStatus;

uses
  Vcl.Forms,
  uStatus in 'uStatus.pas' {Form1},
  ormbr.model.status in '..\Models\ormbr.model.status.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
