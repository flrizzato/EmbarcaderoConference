program EC2014.Facebook;

uses
  Vcl.Forms,
  Unt_Principal in 'Unt_Principal.pas' {Form1},
  Unt_Nucleo in 'Unt_Nucleo.pas' {dmNucleo: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmNucleo, dmNucleo);
  Application.Run;
end.
