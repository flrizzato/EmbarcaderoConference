program CustomersApp;

uses
  Vcl.Forms,
  Forms.Main in 'Forms.Main.pas' {Form1},
  Entities in 'Entities.pas',
  Forms.CustomerList in 'Forms.CustomerList.pas' {CustomersForm},
  Modules.Connections in 'Modules.Connections.pas' {Connections: TDataModule},
  Forms.CountryList in 'Forms.CountryList.pas' {CountriesForm},
  PhoneTools in 'PhoneTools.pas',
  Modules.FirebirdConnection in 'Modules.FirebirdConnection.pas' {FirebirdConnectionModule: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFirebirdConnectionModule, FirebirdConnectionModule);
  Application.CreateForm(TConnections, Connections);
  Application.Run;
end.
