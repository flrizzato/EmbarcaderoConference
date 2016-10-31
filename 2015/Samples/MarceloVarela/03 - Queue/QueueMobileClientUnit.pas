unit QueueMobileClientUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  Data.Cloud.CloudAPI, Data.Cloud.AmazonAPI, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox, FMX.Edit;

type
  TQueueMobileClientForm = class(TForm)
    AmazonConnectionInfo1: TAmazonConnectionInfo;
    ListBox2: TListBox;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    Label1: TLabel;
    procedure Timer1Timer(Sender: TObject);
  private
    procedure ListMessages;
  public
    { Public declarations }
  end;

var
  QueueMobileClientForm: TQueueMobileClientForm;

const
  queueURL = 'https://url.da.sua.queue';

implementation

{$R *.fmx}

uses System.Generics.Collections;

procedure TQueueMobileClientForm.ListMessages;
var
  ResponseInfo: TCloudResponseInfo;
  QueueService: TAmazonQueueService;
  queues: TList<TCloudQueueMessage>;
  queue: TCloudQueueMessage;
begin
  QueueService := TAmazonQueueService.Create(AmazonConnectionInfo1);
  try
    queues := QueueService.GetMessages(queueURL);
    if queues <> nil then
    begin
      for queue in queues do
      begin
        ListBox2.Items.Add(queue.MessageText);
      end;
    end;
  finally
    QueueService.Free;
  end;
end;

procedure TQueueMobileClientForm.Timer1Timer(Sender: TObject);
begin
  ListMessages;
end;

end.
