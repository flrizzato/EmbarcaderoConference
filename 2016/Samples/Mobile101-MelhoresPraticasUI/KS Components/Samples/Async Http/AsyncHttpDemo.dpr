program AsyncHttpDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  untMain in 'untMain.pas' {Form33};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm33, Form33);
  Application.Run;
end.
