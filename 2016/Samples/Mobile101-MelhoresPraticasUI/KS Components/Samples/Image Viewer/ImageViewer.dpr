program ImageViewer;

uses
  System.StartUpCopy,
  FMX.Forms,
  untMain in 'untMain.pas' {Form76};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm76, Form76);
  Application.Run;
end.
