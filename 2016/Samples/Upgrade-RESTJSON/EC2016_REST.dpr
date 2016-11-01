program EC2016_REST;

uses
  Vcl.Forms,
  Unt_Principal in 'Unt_Principal.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
