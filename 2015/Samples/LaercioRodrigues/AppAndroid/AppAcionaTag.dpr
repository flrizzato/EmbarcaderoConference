program AppAcionaTag;

uses
  System.StartUpCopy,
  FMX.Forms,
  U_FormTag in 'U_FormTag.pas' {Form1},
  U_Proxy in 'U_Proxy.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
