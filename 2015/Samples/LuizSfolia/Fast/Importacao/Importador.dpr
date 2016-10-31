program Importador;

uses
  Vcl.Forms,
  fImportadorRelatorios in 'fImportadorRelatorios.pas' {Form1},
  ConverterRR2FR in 'C:\Program Files\FastReports\FastReport 5\LibD23\ConverterRR2FR.pas' {RaveLoaderForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
