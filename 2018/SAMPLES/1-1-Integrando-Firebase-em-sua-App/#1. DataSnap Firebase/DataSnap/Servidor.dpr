program Servidor;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  UntMain in 'UntMain.pas' {frmMain},
  UntSrvMetodos in 'UntSrvMetodos.pas' {SrvMetodos: TDSServerModule},
  UntWM in 'UntWM.pas' {WM: TWebModule},
  Constantes in '..\common\Constantes.pas',
  ULGTDataSetHelper in 'D:\Cursos\T001-Introducao-ao-Google-Firebase\classes\ULGTDataSetHelper.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
