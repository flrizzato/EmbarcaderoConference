program CircleProgress;

uses
  System.StartUpCopy,
  FMX.Forms,
  untMain in 'untMain.pas' {Form80};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm80, Form80);
  Application.Run;
end.
