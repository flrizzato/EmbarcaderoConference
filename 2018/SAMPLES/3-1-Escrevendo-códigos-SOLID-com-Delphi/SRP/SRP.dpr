program SRP;

uses
  Vcl.Forms,
  ExemploSemSRP in 'ExemploSemSRP.pas',
  ExemploComSRP in 'ExemploComSRP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
