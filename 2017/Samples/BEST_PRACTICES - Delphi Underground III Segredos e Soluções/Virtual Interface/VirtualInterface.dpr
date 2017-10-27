program VirtualInterface;

uses
  Vcl.Forms,
  fPrincipalVI in 'fPrincipalVI.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
