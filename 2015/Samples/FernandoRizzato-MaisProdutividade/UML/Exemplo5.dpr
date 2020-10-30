program Exemplo5;



uses
  Forms,
  MidasLib,
  uMainForm in 'uMainForm.pas' {MainForm},
  uAbstractForm in 'uAbstractForm.pas' {AbstractForm},
  uAbstractDataForm in 'uAbstractDataForm.pas' {AbstractDataForm},
  uAbstractDataTabForm in 'uAbstractDataTabForm.pas' {AbstractDataTabForm},
  uAbstractDataModule in 'uAbstractDataModule.pas' {AbstractDataModule: TDataModule},
  uAbstractControl in 'uAbstractControl.pas',
  uMainDM in 'uMainDM.pas' {MainDM: TDataModule},
  uRecError in 'uRecError.pas' {ReconcileErrorForm},
  uUserControl in 'uUserControl.pas',
  uUserDM in 'uUserDM.pas' {UserDM: TDataModule},
  uUserForm in 'uUserForm.pas' {UserForm},
  uUserLoginForm in 'uUserLoginForm.pas' {UserLoginForm},
  uMsgControl in 'uMsgControl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Meeting Organizer';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TMainDM, MainDM);
  if TUserControl.GetInstance.DoUserLogin then
    Application.Run
  else
    Application.Terminate;
end.
