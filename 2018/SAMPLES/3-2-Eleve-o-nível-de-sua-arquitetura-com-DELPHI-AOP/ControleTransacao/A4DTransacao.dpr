program A4DTransacao;

uses
  Vcl.Forms,
  ufrmCRUD in 'ufrmCRUD.pas' {Form2},
  uTransactionAspect in 'uTransactionAspect.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
