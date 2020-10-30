program PushServerAdmin;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  aLog in 'aLog.pas',
  aClasses in '..\Common\aClasses.pas',
  aFormMDI in 'aFormMDI.pas' {FormMDI},
  fAppServer in 'fAppServer.pas' {frmAppServer},
  wServerActions in 'wServerActions.pas' {wmApp: TWebModule},
  mServer in 'mServer.pas' {mdiServer},
  dServer in 'dServer.pas' {dmPushDB: TDataModule},
  mSender in 'mSender.pas' {mdiSender},
  aConsts in '..\Common\aConsts.pas';

{$R *.res}

begin
  System.ReportMemoryLeaksOnShutdown:= true;
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfrmAppServer, frmAppServer);
  Application.CreateForm(TdmPushDB, dmPushDB);
  Application.Run;
end.
