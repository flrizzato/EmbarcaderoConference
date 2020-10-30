program ServerWebServiceDC;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  unfFrmServer in 'unfFrmServer.pas' {Form1},
  untWebModule in 'untWebModule.pas' {webDMDC: TWebModule},
  untDelphiConferenceImpl in 'untDelphiConferenceImpl.pas',
  untDelphiConferenceIntf in 'untDelphiConferenceIntf.pas',
  untDmDados in 'untDmDados.pas' {DMDados: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
