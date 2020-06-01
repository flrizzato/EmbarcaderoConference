program DemoRecords;

uses
  System.StartUpCopy,
  FMX.Forms,
  fPrincipalRecords in 'fPrincipalRecords.pas' {Form3},
  uCores in 'uCores.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
