program OCP;

uses
  Vcl.Forms,
  ExemploSemOCP in 'ExemploSemOCP.pas',
  ExemploComOCP in 'ExemploComOCP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
