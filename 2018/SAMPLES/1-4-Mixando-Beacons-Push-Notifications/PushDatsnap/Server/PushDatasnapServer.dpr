program PushDatasnapServer;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  fAppPushDatasnap in 'fAppPushDatasnap.pas' {Form1},
  aPushMethods in 'aPushMethods.pas' {PushMethods: TDataModule},
  wPushDatasnap in 'wPushDatasnap.pas' {wmPushServer: TWebModule},
  aDBPush in 'aDBPush.pas' {dmPush: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
