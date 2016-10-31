program Exemplo01;

uses
  FMX.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  UsuarioUnit in 'UsuarioUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
