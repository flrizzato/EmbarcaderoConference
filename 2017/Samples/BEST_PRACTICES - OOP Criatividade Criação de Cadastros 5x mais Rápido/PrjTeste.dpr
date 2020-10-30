program PrjTeste;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {Form11},
  uFrmBaseForm in 'uFrmBaseForm.pas' {FrmBaseForm},
  uFrmBaseAutoForm in 'uFrmBaseAutoForm.pas' {frmBaseAutoForm},
  uFrmAutoForm in 'uFrmAutoForm.pas' {frmAutoForm},
  uDM in 'uDM.pas' {DM: TDataModule},
  Model.FactoryForm in 'Model.FactoryForm.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm11, Form11);
  Application.Run;
end.
