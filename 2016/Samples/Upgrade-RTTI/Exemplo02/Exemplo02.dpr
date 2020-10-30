program Exemplo02;

uses
  Vcl.Forms,
  U_Exemplo02 in 'U_Exemplo02.pas' {Form1};

{$R *.res}

begin
   Application.Initialize;
   Application.MainFormOnTaskbar := True;
   Application.CreateForm(TForm1, Form1);
   Application.Run;
end.
