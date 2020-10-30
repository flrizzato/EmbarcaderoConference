program AplicacoesModernas;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit3 in 'Unit3.pas' {MainForm},
  Form_NFe in 'Form_NFe.pas' {frmNotaFiscalEletronica},
  Form_Principal in 'Form_Principal.pas' {FormPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
