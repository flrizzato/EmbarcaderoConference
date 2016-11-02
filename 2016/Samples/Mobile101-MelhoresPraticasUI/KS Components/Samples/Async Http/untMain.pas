unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, FMX.StdCtrls, ksTableView,
  FMX.Controls.Presentation, ksNetHttpClient, FMX.ScrollBox, FMX.Memo, FMX.Objects, ksLoadingIndicator, ksTypes;

type
  TForm33 = class(TForm)
    ksNetHttpClient1: TksNetHttpClient;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    Button1: TButton;
    Button2: TButton;
    ksLoadingIndicator1: TksLoadingIndicator;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ksNetHttpClient1ReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var Abort: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form33: TForm33;

implementation

{$R *.fmx}

procedure TForm33.Button1Click(Sender: TObject);
var
  AResponse: IHTTPResponse;
begin
  // standard (blocking) get method...
  ksLoadingIndicator1.ShowLoading;
  try
    //Memo1.Lines.Clear;
    Application.ProcessMessages;
    AResponse := ksNetHttpClient1.Get('http://download.thinkbroadband.com/1MB.zip');
  finally
    ksLoadingIndicator1.HideLoading;
  end;
end;

procedure TForm33.Button2Click(Sender: TObject);
var
  AResponse: IHTTPResponse;
begin
  // async get...
  ksLoadingIndicator1.ShowLoading;
  try
    //Memo1.Lines.Clear;
    Application.ProcessMessages;
    AResponse := ksNetHttpClient1.GetAsyncWait('http://download.thinkbroadband.com/1MB.zip', nil);
  finally
    ksLoadingIndicator1.HideLoading;
  end;

end;

procedure TForm33.ksNetHttpClient1ReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var Abort: Boolean);
begin
  ProgressBar1.Max := AContentLength;
  ProgressBar1.Value := AReadCount;
  Label1.Text := 'Bytes read: '+IntToStr(AReadCount);
end;

end.
