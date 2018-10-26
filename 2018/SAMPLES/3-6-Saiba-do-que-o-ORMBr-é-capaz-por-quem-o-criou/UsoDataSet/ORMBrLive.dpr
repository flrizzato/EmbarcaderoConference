program ORMBrLive;

uses
  Forms,
  SysUtils,
  uMainFormORM in 'uMainFormORM.pas' {Form3},
  ormbr.criteria.ast in 'C:\ORMBr\Source\Criteria\ormbr.criteria.ast.pas',
  ormbr.criteria in 'C:\ORMBr\Source\Criteria\ormbr.criteria.pas',
  ormbr.criteria.serialize in 'C:\ORMBr\Source\Criteria\ormbr.criteria.serialize.pas',
  ormbr.model.cliente in '..\Models\ormbr.model.cliente.pas',
  ormbr.model.detalhe in '..\Models\ormbr.model.detalhe.pas',
  ormbr.model.mestre in '..\Models\ormbr.model.mestre.pas',
  ormbr.model.status in '..\Models\ormbr.model.status.pas',
  ormbr.monitor in 'C:\ORMBr\Source\Drivers\ormbr.monitor.pas',
  ormbr.form.monitor in 'C:\ORMBr\Source\Monitor\ormbr.form.monitor.pas' {CommandMonitor};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
