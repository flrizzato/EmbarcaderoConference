program LocalSQL;

uses
  Vcl.Forms,
  fLocalSQL in 'fLocalSQL.pas' {FrmLocalSQL},
  dLocalSQL in 'dLocalSQL.pas' {DMLocalSQL: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmLocalSQL, FrmLocalSQL);
  Application.CreateForm(TDMLocalSQL, DMLocalSQL);
  Application.Run;
end.
