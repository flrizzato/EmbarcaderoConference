program DprClient;

uses
  Vcl.Forms,
  UClient in 'UClient.pas' {FrmCliente},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Charcoal Dark Slate');
  Application.CreateForm(TFrmCliente, FrmCliente);
  Application.Run;
end.
