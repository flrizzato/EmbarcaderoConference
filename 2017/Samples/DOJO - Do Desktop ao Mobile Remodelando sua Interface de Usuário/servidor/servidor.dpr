program servidor;
{$APPTYPE GUI}



uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  frmServidor in 'frmServidor.pas' {Form1},
  wmPOS in 'wmPOS.pas' {WebModule1: TWebModule},
  uPOS in 'uPOS.pas',
  uDMPOS in 'uDMPOS.pas' {dmPOS: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmPOS, dmPOS);
  Application.Run;
end.
