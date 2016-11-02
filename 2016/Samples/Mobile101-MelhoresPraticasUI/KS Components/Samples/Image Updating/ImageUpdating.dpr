program ImageUpdating;

uses
  System.StartUpCopy,
  FMX.Forms,
  untMain in 'untMain.pas' {Form58};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm58, Form58);
  Application.Run;
end.
