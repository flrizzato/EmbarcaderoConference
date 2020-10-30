program DepartmentsClientProject;

uses
  FMX.Forms,
  DepartmentClientFormU in 'DepartmentClientFormU.pas' {DepartmentsClientForm},
  ClientClassesUnit2 in 'ClientClassesUnit2.pas',
  ClientModuleUnit2 in 'ClientModuleUnit2.pas' {ClientModule2: TDataModule};

{$R *.res}

begin
//  TObject.Create;
//  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TDepartmentsClientForm, DepartmentsClientForm);
  Application.CreateForm(TClientModule2, ClientModule2);
  Application.Run;
end.
