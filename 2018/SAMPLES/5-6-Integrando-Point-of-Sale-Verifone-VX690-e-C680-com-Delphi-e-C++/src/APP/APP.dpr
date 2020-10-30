program APP;

uses
  System.StartUpCopy,
  FMX.Forms,
  uAPP in 'uAPP.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
