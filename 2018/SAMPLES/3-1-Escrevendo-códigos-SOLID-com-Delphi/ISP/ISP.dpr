program ISP;

uses
  Vcl.Forms,
  ExemploSemISP in 'ExemploSemISP.pas',
  ExemploComISP in 'ExemploComISP.pas',
  Utils in 'Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
