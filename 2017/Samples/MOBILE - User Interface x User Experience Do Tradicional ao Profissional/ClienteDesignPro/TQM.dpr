program TQM;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFrmLogin in 'uFrmLogin.pas' {frmLogin},
  OpenViewUrl in 'OpenViewUrl.pas',
  uFrmMobile in 'uFrmMobile.pas' {frmMobile};

{$R *.res}

begin
   Application.Initialize;
   Application.FormFactor.Orientations := [TFormOrientation.Portrait];
   Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmMobile, frmMobile);
  Application.Run;

end.
