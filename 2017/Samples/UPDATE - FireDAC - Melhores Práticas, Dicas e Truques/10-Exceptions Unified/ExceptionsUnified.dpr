program ExceptionsUnified;

uses
  Vcl.Forms,
  Unit8 in 'Unit8.pas' {Form8};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm8, Form8);
  Application.Run;
end.
