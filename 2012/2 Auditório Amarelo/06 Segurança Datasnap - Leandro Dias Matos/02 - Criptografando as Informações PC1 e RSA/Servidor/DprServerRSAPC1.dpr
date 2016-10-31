program DprServerRSAPC1;

uses
  Vcl.Forms,
  UServer in 'UServer.pas' {FrmServer},
  ServerMethodsUnit in 'ServerMethodsUnit.pas' {ServerMethods: TDSServerModule},
  ServerContainerUnit in 'ServerContainerUnit.pas' {ServerContainer1: TDataModule},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TFrmServer, FrmServer);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.Run;
end.

