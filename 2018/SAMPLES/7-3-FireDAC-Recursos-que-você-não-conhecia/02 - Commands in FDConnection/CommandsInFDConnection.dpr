program CommandsInFDConnection;

uses
  Vcl.Forms,
  fCommandsInFDConnection in 'fCommandsInFDConnection.pas' {FrmCommandsInFDConnection};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmCommandsInFDConnection, FrmCommandsInFDConnection);
  Application.Run;
end.
