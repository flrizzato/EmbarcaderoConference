program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  uEmpresa in '..\Prototipo\classes\uEmpresa.pas',
  uNotaFiscal in '..\Prototipo\classes\uNotaFiscal.pas',
  uProduto in '..\Prototipo\classes\uProduto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
