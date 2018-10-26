program Macros;

uses
  Vcl.Forms,
  fMacros in 'fMacros.pas' {FrmMacros},
  dMacros in 'dMacros.pas' {DMMacros: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMacros, FrmMacros);
  Application.CreateForm(TDMMacros, DMMacros);
  Application.Run;
end.
