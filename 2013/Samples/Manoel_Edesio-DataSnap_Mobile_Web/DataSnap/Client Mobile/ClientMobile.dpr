program ClientMobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmHome},
  uFrmProdutos in 'uFrmProdutos.pas' {frmProdutos},
  uDMDados in 'uDMDados.pas' {DMDados: TDataModule},
  uFrmClientes in 'uFrmClientes.pas' {frmClientes},
  uFrmPedidos in 'uFrmPedidos.pas' {FrmPedidos},
  uFrmconfig in 'uFrmconfig.pas' {frmConfig},
  uWebService in 'uWebService.pas',
  uFrmBuscaCliente in 'uFrmBuscaCliente.pas' {FrmBuscaCliente},
  uFrmIncClientes in 'uFrmIncClientes.pas' {frmIncClientes};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMDados, DMDados);
  Application.CreateForm(TFrmHome, FrmHome);
  Application.CreateForm(TfrmProdutos, frmProdutos);
  Application.CreateForm(TfrmClientes, frmClientes);
  Application.CreateForm(TFrmPedidos, FrmPedidos);
  Application.CreateForm(TfrmConfig, frmConfig);
  Application.CreateForm(TFrmBuscaCliente, FrmBuscaCliente);
  Application.CreateForm(TfrmIncClientes, frmIncClientes);
  Application.Run;
end.
