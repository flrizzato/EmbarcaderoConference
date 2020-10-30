program QueueServer;

uses
  Vcl.Forms,
  QueueServerUnit in 'QueueServerUnit.pas' {QueueServerForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TQueueServerForm, QueueServerForm);
  Application.Run;
end.
