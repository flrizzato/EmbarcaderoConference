program LoadingIndicator;

uses
  System.StartUpCopy,
  FMX.Forms,
  untMain in 'untMain.pas' {Form64};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm64, Form64);
  Application.Run;
end.
