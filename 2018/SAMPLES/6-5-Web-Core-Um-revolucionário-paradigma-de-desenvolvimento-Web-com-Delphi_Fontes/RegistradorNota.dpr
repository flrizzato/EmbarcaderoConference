program RegistradorNota;

uses
  Vcl.Forms,
  WEBLib.Forms,
  MainForm in 'MainForm.pas' {Form3: TWebForm} {*.html};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
