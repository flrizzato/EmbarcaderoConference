program InterfaceRecord;

uses
  System.StartUpCopy,
  FMX.Forms,
  fPrincipalIR in 'fPrincipalIR.pas' {Form5},
  uIR in 'uIR.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
