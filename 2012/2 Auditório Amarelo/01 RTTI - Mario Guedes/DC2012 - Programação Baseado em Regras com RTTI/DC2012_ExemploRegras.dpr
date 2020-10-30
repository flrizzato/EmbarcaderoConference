program DC2012_ExemploRegras;

uses
  Vcl.Forms,
  Unt_FrontEnd in 'Unt_FrontEnd.pas' {fFrondEnd},
  Unt_ClassesAtributos in 'Unt_ClassesAtributos.pas',
  Unt_ClassesLinhas in 'Unt_ClassesLinhas.pas',
  Unt_ClasseLista in 'Unt_ClasseLista.pas',
  Unt_ClasseLinhaBase in 'Unt_ClasseLinhaBase.pas',
  Unt_ClasseException in 'Unt_ClasseException.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfFrondEnd, fFrondEnd);
  Application.Run;
end.
