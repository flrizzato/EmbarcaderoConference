program ServerMobile;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uFrmServidor in 'uFrmServidor.pas' {Form1},
  uSM in 'uSM.pas' {SM: TDataModule},
  WebDM in 'WebDM.pas' {WM: TWebModule},
  uSC in 'uSC.pas' {SC: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TSC, SC);
  Application.Run;
end.
