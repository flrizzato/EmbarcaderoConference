program IntentsDelphi10Seattle;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmIntentsDXUnt in 'frmIntentsDXUnt.pas' {frmIntentsDX};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmIntentsDX, frmIntentsDX);
  Application.Run;
end.
