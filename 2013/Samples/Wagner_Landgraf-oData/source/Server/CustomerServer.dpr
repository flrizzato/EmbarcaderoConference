program CustomerServer;

uses
  Vcl.Forms,
  Forms.Main in 'Forms.Main.pas' {MainForm},
  ServerUnit in 'ServerUnit.pas' {ServerModule: TDataModule},
  Modules.FirebirdConnection in '..\Modules.FirebirdConnection.pas' {FirebirdConnectionModule: TDataModule},
  Entities in '..\Entities.pas',
  Entities.Register in '..\Entities.Register.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
