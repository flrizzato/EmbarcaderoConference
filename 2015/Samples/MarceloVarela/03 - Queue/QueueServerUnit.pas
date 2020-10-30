unit QueueServerUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, Data.Cloud.CloudAPI,
  Data.Cloud.AmazonAPI, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TQueueServerForm = class(TForm)
    AmazonConnectionInfo1: TAmazonConnectionInfo;
    Panel1: TPanel;
    ListBox1: TListBox;
    edMessage: TLabeledEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  QueueServerForm: TQueueServerForm;

const
  queueURL = 'https://url.da.sua.queue';

implementation

{$R *.dfm}

procedure TQueueServerForm.Button1Click(Sender: TObject);
var
  ResponseInfo: TCloudResponseInfo;
  QueueService: TAmazonQueueService;
begin
  ResponseInfo := TCloudResponseInfo.Create;
  QueueService := TAmazonQueueService.Create(AmazonConnectionInfo1);
  try
    if QueueService.AddMessage(queueURL, edMessage.Text, ResponseInfo) then
    begin
      ListBox1.Items.Add('Mensagem enviada com sucesso!');
    end
    else
    begin
      ListBox1.Items.Add('Erro: ' + ResponseInfo.StatusMessage);
    end;
  finally
    QueueService.Free;
  end;
end;

end.
