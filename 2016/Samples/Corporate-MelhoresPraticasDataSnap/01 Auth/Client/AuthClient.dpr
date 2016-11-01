program AuthClient;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {dbgr};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdbgr, dbgr);
  Application.Run;
end.
