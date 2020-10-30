program IntraWebBootStrap;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  U_IWFormConsCliente in 'U_IWFormConsCliente.pas' {IWFormConsCliente: TIWAppForm},
  ServerController in 'ServerController.pas' {IWServerController: TIWServerControllerBase},
  UserSessionUnit in 'UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase},
  U_DM in 'U_DM.pas' {DM: TDataModule};

{$R *.res}

begin
  TIWStart.Execute(True);
end.
