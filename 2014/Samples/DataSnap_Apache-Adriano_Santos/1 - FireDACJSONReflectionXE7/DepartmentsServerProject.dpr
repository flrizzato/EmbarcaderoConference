program DepartmentsServerProject;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Data.FireDACJSONReflect in 'Data.FireDACJSONReflect.pas',
  DepartmentsServerFormU in 'DepartmentsServerFormU.pas' {DepartmentsServerForm},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {ServerMethods1: TDataModule},
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TDepartmentsServerForm, DepartmentsServerForm);
  Application.Run;
end.
