program CallbackClient;

uses
  Vcl.Forms,
  Unit5 in 'Unit5.pas' {Form5},
  uProxy in 'uProxy.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
