program TesteBAAS;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Layer.Business in 'Layer.Business.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
