program TestInsight;

uses
  Vcl.Forms,
  TestInsight.DUnitX,
  Unit1 in 'Unit1.pas' {Form1},
  uExemplo in 'uExemplo.pas',
  uTestes in 'uTestes.pas';

{$R *.res}

begin
  RunRegisteredTests;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
