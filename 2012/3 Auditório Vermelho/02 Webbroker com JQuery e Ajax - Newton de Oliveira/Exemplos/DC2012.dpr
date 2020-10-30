program DC2012;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  CGIApp,
  wmDC2012 in 'wmDC2012.pas' {wmPrincipal: TWebModule};

{$R *.res}

begin
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.Run;

end.
