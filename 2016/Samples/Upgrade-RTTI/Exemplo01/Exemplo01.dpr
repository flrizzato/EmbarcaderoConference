program Exemplo01;

uses
  Vcl.Forms,
  U_Exemplo01 in 'U_Exemplo01.pas' {F_Exemplo01};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TF_Exemplo01, F_Exemplo01);
  Application.Run;
end.
