program MyServerStandAlone;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  MyServerUnit in 'MyServerUnit.pas',
  DBDemosModule in 'DBDemosModule.pas' {dmDBDemos: TDataModule},
  DBDemosEntities in 'DBDemosEntities.pas',
  MyServerOperations in 'MyServerOperations.pas',
  MyServerImplementation in 'MyServerImplementation.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
