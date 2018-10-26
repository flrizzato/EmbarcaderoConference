program LSP;

uses
  Vcl.Forms,
  ExemploSemLSP in 'ExemploSemLSP.pas',
  ExemploComLSP in 'ExemploComLSP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
