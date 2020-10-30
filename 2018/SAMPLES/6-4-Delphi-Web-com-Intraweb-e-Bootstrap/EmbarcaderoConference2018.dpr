program EmbarcaderoConference2018;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  U_IWFormIndex in 'U_IWFormIndex.pas' {IWFormIndex: TIWAppForm},
  ServerController in 'ServerController.pas' {IWServerController: TIWServerControllerBase},
  UserSessionUnit in 'UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase},
  U_IWFormFinal in 'U_IWFormFinal.pas' {IWFormFinal: TIWAppForm},
  U_IWFormTableManual in 'U_IWFormTableManual.pas' {IWFormTableManual: TIWAppForm};

{$R *.res}

begin
  TIWStart.Execute(True);
end.
