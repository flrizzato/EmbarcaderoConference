program Restaurante;

uses
  Vcl.Forms,
  uRestaurante in 'uRestaurante.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
