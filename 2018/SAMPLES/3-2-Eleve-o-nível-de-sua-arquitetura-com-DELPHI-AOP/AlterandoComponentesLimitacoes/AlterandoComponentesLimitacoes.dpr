program AlterandoComponentesLimitacoes;

uses
  Vcl.Forms,
  uAtributos in 'uAtributos.pas',
  uContextoAspecto in 'uContextoAspecto.pas',
  ufrmAlterandoComponentes in 'ufrmAlterandoComponentes.pas' {Form2},
  uLoginAspect in 'uLoginAspect.pas',
  uMeuDataSet in 'uMeuDataSet.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
