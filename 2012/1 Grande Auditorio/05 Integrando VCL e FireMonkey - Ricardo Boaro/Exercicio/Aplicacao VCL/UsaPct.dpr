program UsaPct;

uses
  Vcl.Forms,
  uUsaPct in 'uUsaPct.pas' {FrmPrincipal},
  uformVCL in 'uformVCL.pas' {FormVCL},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
