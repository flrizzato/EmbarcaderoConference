program MobilePrototipando;

uses
  System.StartUpCopy,
  FMX.Forms,
  uModeloMobile in 'uModeloMobile.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
