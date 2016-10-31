program Exemplo_CriticalSection;

uses
  Vcl.Forms,
  Unt_Tela in 'Unt_Tela.pas' {Form1},
  Unt_ThreadProcessamento in 'Unt_ThreadProcessamento.pas',
  Unt_ThreadCliente in 'Unt_ThreadCliente.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
