program RemoteDBClient;

uses
  Vcl.Forms,
  DBDemosMainForm in 'DBDemosMainForm.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
