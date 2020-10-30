program AppApacheAoVivo;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  ClientClassesUnit3 in 'ClientClassesUnit3.pas',
  ClientModuleUnit3 in 'ClientModuleUnit3.pas' {ClientModule3: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TClientModule3, ClientModule3);
  Application.Run;
end.
