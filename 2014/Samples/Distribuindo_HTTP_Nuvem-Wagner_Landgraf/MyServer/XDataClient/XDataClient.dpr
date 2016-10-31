program XDataClient;

uses
  Vcl.Forms,
  XDataMainForm in 'XDataMainForm.pas' {Form2},
  MyServerOperations in '..\MyServerOperations.pas',
  DBDemosEntities in '..\DBDemosEntities.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
