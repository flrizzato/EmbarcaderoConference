program EmbConf2015DUnitXMonitorTest;

uses
  Vcl.Forms,
  FMonitorDeTeste in 'FMonitorDeTeste.pas' {Form2},
  uMukaConsoleLogger in 'uMukaConsoleLogger.pas',
  uTesteExemplo7 in 'uTesteExemplo7.pas',
  Exemplo7_6 in '..\Exemplo7_6.pas',
  Exemplo7_5 in '..\Exemplo7_5.pas',
  Exemplo7_4 in '..\Exemplo7_4.pas',
  Exemplo7_3 in '..\Exemplo7_3.pas',
  Exemplo7_2 in '..\Exemplo7_2.pas',
  Exemplo7_1 in '..\Exemplo7_1.pas',
  Exemplo7 in '..\Exemplo7.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
