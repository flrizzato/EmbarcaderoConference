program DprServer;

uses
  Vcl.Forms,
  UServer in 'UServer.pas' {frmServer},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Charcoal Dark Slate');
  Application.CreateForm(TfrmServer, frmServer);
  Application.Run;
end.
