program Teste;

uses
  FMX.Forms,
  uTestePainel in 'uTestePainel.pas' {TestePainel},
  uTesteDialogo in 'uTesteDialogo.pas' {TesteDialogo},
  uTesteDesign in 'uTesteDesign.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTestePainel, TestePainel);
  Application.CreateForm(TTesteDialogo, TesteDialogo);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
