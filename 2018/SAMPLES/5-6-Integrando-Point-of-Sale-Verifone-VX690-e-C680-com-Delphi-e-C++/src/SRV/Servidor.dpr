program Servidor;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  CGIApp,
  wmServidor in 'wmServidor.pas' {wbmServidor: TWebModule};

{$R *.res}

begin
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.Run;

end.
