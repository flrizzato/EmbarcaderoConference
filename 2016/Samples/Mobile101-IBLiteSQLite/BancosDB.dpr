program BancosDB;

uses
  System.StartUpCopy,
  FMX.Forms,
  UntMain in 'UntMain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
