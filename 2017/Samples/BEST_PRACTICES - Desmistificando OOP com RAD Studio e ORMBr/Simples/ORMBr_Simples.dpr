program ORMBr_Simples;

uses
  Vcl.Forms,
  ufrmormbr in 'ufrmormbr.pas' {frmormbr},
  udmdados in 'udmdados.pas' {dmdados: TDataModule},
  uORMBr.Clientes in 'uORMBr.Clientes.pas',
  SQLMonitor in '..\SQLMonitor.pas' {FSQLMonitor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdmdados, dmdados);
  Application.CreateForm(Tfrmormbr, frmormbr);
  Application.CreateForm(TFSQLMonitor, FSQLMonitor);
  Application.Run;
end.
