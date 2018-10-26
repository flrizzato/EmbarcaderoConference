program DataMapping;

uses
  Vcl.Forms,
  fDataMapping in 'fDataMapping.pas' {FrmDataMapping},
  dDataMapping in 'dDataMapping.pas' {DMDataMapping: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmDataMapping, FrmDataMapping);
  Application.CreateForm(TDMDataMapping, DMDataMapping);
  Application.Run;
end.
