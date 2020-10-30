program FDD_Geolocalizar;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  uGeoCode in 'uGeoCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
