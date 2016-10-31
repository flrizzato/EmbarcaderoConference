program ExemploEmbConf2015;

uses
  Vcl.Forms,
  fPrincipal in 'fPrincipal.pas' {Form1},
  Exemplo1 in 'Exemplo1.pas',
  Exemplo2 in 'Exemplo2.pas',
  Exemplo3 in 'Exemplo3.pas',
  Exemplo4 in 'Exemplo4.pas',
  Exemplo4_1 in 'Exemplo4_1.pas',
  Exemplo4_2 in 'Exemplo4_2.pas',
  Exemplo4_3 in 'Exemplo4_3.pas',
  Exemplo5 in 'Exemplo5.pas',
  Exemplo5_1 in 'Exemplo5_1.pas',
  Exemplo6 in 'Exemplo6.pas',
  Exemplo6_1 in 'Exemplo6_1.pas',
  Exemplo6_2 in 'Exemplo6_2.pas',
  Exemplo7 in 'Exemplo7.pas',
  Exemplo7_1 in 'Exemplo7_1.pas',
  fExecutaExemplos4 in 'fExecutaExemplos4.pas' {frmExecutaExemplos4},
  fExecutaExemplos5 in 'fExecutaExemplos5.pas' {frmExecutaExemplos5},
  fExecutaExemplos6 in 'fExecutaExemplos6.pas' {frmExecutaExemplos6},
  fExecutaExemplos7 in 'fExecutaExemplos7.pas' {frmExecutaExemplos7},
  Exemplo7_2 in 'Exemplo7_2.pas',
  Exemplo7_3 in 'Exemplo7_3.pas',
  Exemplo7_4 in 'Exemplo7_4.pas',
  Exemplo7_5 in 'Exemplo7_5.pas',
  Exemplo7_6 in 'Exemplo7_6.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
