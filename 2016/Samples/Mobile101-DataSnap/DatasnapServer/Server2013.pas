program Server2013;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  frmServerUnt in 'frmServerUnt.pas' {frmServer},
  svrContainerUnt in 'svrContainerUnt.pas' {svrContainer: TDataModule},
  webModuloUnt in 'webModuloUnt.pas' {webModulo: TWebModule},
  svrSMEstoqueUnt in 'svrSMEstoqueUnt.pas' {DSServerModuleEstoque: TDSServerModule},
  uFuncoesSO in 'uFuncoesSO.pas',
  URotinasGenericas in 'URotinasGenericas.pas',
  Vcl.Themes,
  Vcl.Styles,
  DSServerModuleClientesUnt in 'DSServerModuleClientesUnt.pas' {DSServerClientes: TDSServerModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TfrmServer, frmServer);
  //  Application.CreateForm(TDSServerModuleEstoque, DSServerModuleEstoque);
  Application.Run;
end.
