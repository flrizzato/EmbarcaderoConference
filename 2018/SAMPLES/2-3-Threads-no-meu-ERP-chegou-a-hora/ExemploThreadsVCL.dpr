program ExemploThreadsVCL;

uses
  Vcl.Forms,
  Form.Menu.Threads in 'Form.Menu.Threads.pas' {frmMenu},
  Form.Mensagens in 'Form.Mensagens.pas' {frmMensagens},
  Form.Sync in 'Form.Sync.pas' {frmSyncWays},
  Form.Tela.ERP in 'Form.Tela.ERP.pas' {frmTelaERP},
  Form.Externos in 'Form.Externos.pas' {frmExternos},
  Data.Tela.ERP in 'Data.Tela.ERP.pas' {dmdTelaERP: TDataModule},
  Classe.Cotacao in 'Classe.Cotacao.pas',
  Classe.ExecutorTh in 'Classe.ExecutorTh.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TdmdTelaERP, dmdTelaERP);
  Application.Run;
end.
