program DIP;

uses
  Vcl.Forms,
  ExemploSemDIP1 in 'ExemploSemDIP1.pas',
  ExemploComDIP1 in 'ExemploComDIP1.pas',
  ExemploSemDIP2 in 'ExemploSemDIP2.pas',
  ExemploComDIP2 in 'ExemploComDIP2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
