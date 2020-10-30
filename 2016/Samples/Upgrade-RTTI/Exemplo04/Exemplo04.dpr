program Exemplo04;

uses
  Vcl.Forms,
  U_Exemplo04 in 'U_Exemplo04.pas' {F_Exemplo04},
  U_Atributos in 'U_Atributos.pas',
  U_LinhaBase in 'U_LinhaBase.pas',
  U_Linhas in 'U_Linhas.pas',
  U_GeradorDocto in 'U_GeradorDocto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TF_Exemplo04, F_Exemplo04);
  Application.Run;
end.
