program RecoveringConnection;

uses
  Vcl.Forms,
  fRecoveringConnection in 'fRecoveringConnection.pas' {FrmRecoveringConnection};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmRecoveringConnection, FrmRecoveringConnection);
  Application.Run;
end.
