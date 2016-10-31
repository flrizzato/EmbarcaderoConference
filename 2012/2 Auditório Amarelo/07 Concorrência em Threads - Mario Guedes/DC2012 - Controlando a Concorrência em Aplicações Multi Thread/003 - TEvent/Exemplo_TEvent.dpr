program Exemplo_TEvent;

uses
  Vcl.Forms,
  Unt_Tela in 'Unt_Tela.pas' {Form1},
  Unt_ThreadComEvent in 'Unt_ThreadComEvent.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
