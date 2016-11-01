program ServerTethering;

uses
  Vcl.Forms,
  UntServerMain in 'UntServerMain.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
