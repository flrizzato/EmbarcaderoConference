program DprCliente;

uses
  Vcl.Forms,
  UCliente in 'UCliente.pas' {FrmClienteFiltro},
  UMetodos in 'UMetodos.pas',
  UFilterCustomizado in '..\Package\UFilterCustomizado.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Charcoal Dark Slate');
  Application.CreateForm(TFrmClienteFiltro, FrmClienteFiltro);
  Application.Run;
end.
