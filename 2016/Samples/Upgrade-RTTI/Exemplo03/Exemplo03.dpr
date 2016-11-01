program Exemplo03;

uses
  Vcl.Forms,
  U_Exemplo03 in 'U_Exemplo03.pas' {F_Exemplo03},
  U_Cliente in 'U_Cliente.pas',
  U_Atributos in 'U_Atributos.pas',
  U_GeraSQL in 'U_GeraSQL.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TF_Exemplo03, F_Exemplo03);
  Application.Run;
end.
