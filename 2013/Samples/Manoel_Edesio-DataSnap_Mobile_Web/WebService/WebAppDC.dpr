program WebAppDC;

{$APPTYPE CONSOLE}

uses
  WebBroker,
  CGIApp,
  uWebModule in 'uWebModule.pas' {WebModule2: TWebModule},
  DCImpl in 'DCImpl.pas',
  DCIntf in 'DCIntf.pas',
  uDM in 'uDM.pas' {DMdados: TDataModule},
  uClasses in 'uClasses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWebModule2, WebModule2);
  Application.Run;
end.
