program AlterandoComponentes;

uses
  Vcl.Forms,
  ufrmAlterandoComponentes in 'ufrmAlterandoComponentes.pas' {Form3},
  uMeuDataSet in 'uMeuDataSet.pas',
  uTransactionAspect in '..\ControleTransacao\uTransactionAspect.pas',
  uLoginAspect in 'uLoginAspect.pas',
  uAtributos in 'uAtributos.pas',
  uContextoAspecto in 'uContextoAspecto.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;

end.
