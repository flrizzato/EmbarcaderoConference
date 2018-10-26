program pCliente;

uses
  Vcl.Forms,
  uCliente in 'uCliente.pas' {Form1},
  ormbr.model.cliente in '..\Models\ormbr.model.cliente.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
