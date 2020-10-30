program DC2013.OlaMundo.CargaDinamica;

uses
  Vcl.Forms,
  Unt_Principal in 'Unt_Principal.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
