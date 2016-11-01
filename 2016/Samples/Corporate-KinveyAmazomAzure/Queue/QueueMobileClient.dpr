program QueueMobileClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  QueueMobileClientUnit in 'QueueMobileClientUnit.pas' {QueueMobileClientForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TQueueMobileClientForm, QueueMobileClientForm);
  Application.Run;
end.
