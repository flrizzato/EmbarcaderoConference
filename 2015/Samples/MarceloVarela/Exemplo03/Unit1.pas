unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  Data.Cloud.CloudAPI, Data.Cloud.AmazonAPI, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox, FMX.Edit;

type
  TForm1 = class(TForm)
    AmazonConnectionInfo1: TAmazonConnectionInfo;
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Button3: TButton;
    ListBox2: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses Unit2, System.Generics.Collections;

procedure TForm1.Button1Click(Sender: TObject);
var
  ResponseInfo: TCloudResponseInfo;
  QueueURL: String;
  QueueService: TAmazonQueueService;
begin
  QueueService := TAmazonQueueService.Create(AmazonConnectionInfo1);
  try
    ResponseInfo := TCloudResponseInfo.Create;
    try
      if QueueService.CreateQueue('myQueue', QueueURL, -1, ResponseInfo) then
      begin
        ListBox1.Items.Add('Success! QueueURL: ' + QueueURL);
        Edit1.Text := QueueURL;
      end
      else
      begin
        ListBox1.Items.Add(Format('Failure! %s', [ResponseInfo.StatusMessage]));
      end;
    finally
      ResponseInfo.Free;
    end;
  finally
    QueueService.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  ResponseInfo: TCloudResponseInfo;
  QueueURL: String;
  QueueService: TAmazonQueueService;
begin
  ResponseInfo := TCloudResponseInfo.Create;
  QueueService := TAmazonQueueService.Create(AmazonConnectionInfo1);
  try
    if QueueService.AddMessage(Edit1.Text, 'Teste...', ResponseInfo) then
    begin
      ListBox1.Items.Add('Success!');
    end
    else
    begin
      ListBox1.Items.Add('Failure! ' + ResponseInfo.StatusMessage);
    end;
  finally
    QueueService.Free;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  ResponseInfo: TCloudResponseInfo;
  QueueURL: String;
  QueueService: TAmazonQueueService;
  queues: TList<TCloudQueueMessage>;
  queue: TCloudQueueMessage;
begin
  QueueService := TAmazonQueueService.Create(AmazonConnectionInfo1);
  try
    queues := QueueService.GetMessages(Edit1.Text);
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

end.
