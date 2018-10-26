program FD_Client;

uses
  Vcl.Forms,
  Unit8 in 'Unit8.pas' {Form8},
  ClientClassesUnit1 in 'ClientClassesUnit1.pas',
  ClientModuleUnit1 in 'ClientModuleUnit1.pas' {ClientModule1: TDataModule},
  Dm in 'Dm.pas' {Dtm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.CreateForm(TDtm, Dtm);
  Application.Run;
end.
