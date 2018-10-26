program FD_DBX_Server;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Unit7 in 'Unit7.pas' {Form7},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {ServerMethods2: TDSServerModule},
  ServerContainerUnit1 in 'ServerContainerUnit1.pas' {ServerContainer1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.Run;
end.

