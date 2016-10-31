program MobileClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFrmMobile in 'uFrmMobile.pas' {frmMobile},
  uCC in 'uCC.pas',
  uCM in 'uCM.pas' {CM: TDataModule},
  uDML in 'uDML.pas' {DML: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMobile, frmMobile);
  Application.CreateForm(TCM, CM);
  Application.CreateForm(TDML, DML);
  Application.Run;
end.
