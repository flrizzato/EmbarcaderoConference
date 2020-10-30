program Exemplo05;

uses
  Vcl.Forms,
  U_CadastroBase in 'U_CadastroBase.pas' {F_CadastroBase},
  U_Principal in 'U_Principal.pas' {F_Principal},
  U_CadastroCliente in 'U_CadastroCliente.pas' {F_CadastroCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TF_Principal, F_Principal);
  Application.CreateForm(TF_CadastroCliente, F_CadastroCliente);
  Application.Run;
end.
