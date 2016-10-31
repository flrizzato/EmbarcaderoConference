program DataMergeProj;

uses
  Vcl.Forms,
  formMergeMain in 'formMergeMain.pas' {frmMergeMain},
  dmDatabase in 'dmDatabase.pas' {dtmdDatabase: TDataModule},
  formMergeMainController in 'formMergeMainController.pas' {MergeMainController: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMergeMain, frmMergeMain);
  Application.Run;
end.
