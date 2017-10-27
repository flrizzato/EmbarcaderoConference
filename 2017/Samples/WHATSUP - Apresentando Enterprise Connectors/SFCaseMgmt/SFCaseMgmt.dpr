program SFCaseMgmt;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uMainDM in 'uMainDM.pas' {MainDM: TDataModule},
  ClientClassesUnit1 in 'ClientClassesUnit1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainDM, MainDM);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
