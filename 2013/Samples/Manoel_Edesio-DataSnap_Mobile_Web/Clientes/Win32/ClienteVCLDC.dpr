program ClienteVCLDC;

uses
  Vcl.Forms,
  uFrmDC in 'uFrmDC.pas' {frmDC},
  uDMDados in 'uDMDados.pas' {DMDados: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMDados, DMDados);
  Application.CreateForm(TfrmDC, frmDC);
  Application.Run;
end.
