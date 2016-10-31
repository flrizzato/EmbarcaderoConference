program Exemplo_Synchronize;

uses
  Vcl.Forms,
  Unt_Tela in 'Unt_Tela.pas' {Form1},
  Unt_Thread in 'Unt_Thread.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
