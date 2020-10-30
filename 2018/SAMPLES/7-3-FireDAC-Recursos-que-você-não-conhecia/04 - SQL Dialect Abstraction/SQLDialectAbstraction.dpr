program SQLDialectAbstraction;

uses
  Vcl.Forms,
  fSQLDialectAbstraction in 'fSQLDialectAbstraction.pas' {FrmSQLDialectAbstraction},
  dSQLDialectAbstraction in 'dSQLDialectAbstraction.pas' {DMSQLDialectAbstraction: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmSQLDialectAbstraction, FrmSQLDialectAbstraction);
  Application.CreateForm(TDMSQLDialectAbstraction, DMSQLDialectAbstraction);
  Application.Run;
end.
