program BathMove;

uses
  Vcl.Forms,
  fBathMove in 'fBathMove.pas' {FrmBathMove},
  dBathMove in 'dBathMove.pas' {DMBathMove: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmBathMove, FrmBathMove);
  Application.CreateForm(TDMBathMove, DMBathMove);
  Application.Run;
end.
