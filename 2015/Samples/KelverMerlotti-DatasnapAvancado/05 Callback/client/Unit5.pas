unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXDataSnap, IPPeerClient,
  Data.DBXCommon, Data.DB, Data.SqlExpr, Vcl.StdCtrls, Vcl.ComCtrls, uProxy,
  Data.DBXJSON, System.JSON, Vcl.ExtCtrls, ShellApi, Datasnap.DSCommon,
  Vcl.Samples.Spin;

type
  TForm5 = class(TForm)
    SQLConnection1: TSQLConnection;
    ProgressBar1: TProgressBar;
    Button1: TButton;
    DSClientCallbackChannelManager1: TDSClientCallbackChannelManager;
    CheckBox1: TCheckBox;
    eManagerID: TEdit;
    eCallBackId: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    eManagerIDDest: TEdit;
    eCallbackIdDest: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    Button2: TButton;
    Button3: TButton;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure SQLConnection1AfterConnect(Sender: TObject);
    procedure SQLConnection1BeforeDisconnect(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Proxy: TServerMethods1Client;
    MyCallbackName: String;
    procedure UpdateProgress(aPosition: Integer);
  end;

  TStatus = class(TDBXCallback)
  public
    function Execute(const Arg: TJSONValue): TJSONValue; override;
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.Button1Click(Sender: TObject);
var
  S: TStream;
  LSize: Integer;
  LFile: TMemoryStream;
  LFileName: String;
begin
  if not SQLConnection1.Connected then
    exit;

  ProgressBar1.Max := 10;
  ProgressBar1.Min := 0;

  S := Proxy.GenerateReport(1, 10, TStatus.Create, LSize);
  LFileName := ExtractFilePath(ParamStr(0))+'LocalReport.pdf';
  LFile := TMemoryStream.Create;
  LFile.CopyFrom(S, LSize);
  LFile.Seek(0, soFromBeginning);
  LFile.SaveToFile(LFileName);
  LFile.Free;

  if FileExists(LFileName) then
    ShellExecute(Handle, 'open', PChar(LFileName), nil, nil, SW_SHOWNORMAL)
  else
    ShowMessage('Could not save report!');
end;

procedure TForm5.Button2Click(Sender: TObject);
var
  etapa: TJSONObject;
begin
  etapa := TJSONObject.Create;
  etapa.AddPair('step', SpinEdit1.Value.ToString);

  Proxy.BroadcastToChannel(
    DSClientCallbackChannelManager1.ChannelName,
    etapa
  );
end;

procedure TForm5.Button3Click(Sender: TObject);
var
  etapa: TJSONObject;
  retorno: TJSONValue;
begin
  etapa := TJSONObject.Create;
  etapa.AddPair('step', SpinEdit1.Value.ToString);

  Proxy.NotifyCallback(
    eManagerIDDest.Text,
    eCallbackIdDest.Text,
    etapa,
    Retorno
  );
end;

procedure TForm5.CheckBox1Click(Sender: TObject);
begin
  SQLConnection1.Connected := CheckBox1.Checked;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  DSClientCallbackChannelManager1.ManagerId :=
    TDSSessionHelper.GenerateSessionId;

  MyCallbackName := TDSSessionHelper.GenerateSessionId;

  DSClientCallbackChannelManager1.RegisterCallback(
    MyCallbackName,
    TStatus.Create
  );

  eManagerID.Text := DSClientCallbackChannelManager1.ManagerId;
  eCallBackId.Text := MyCallbackName;
end;

procedure TForm5.SQLConnection1AfterConnect(Sender: TObject);
begin
  Proxy := TServerMethods1Client.Create(
    SQLConnection1.DBXConnection);
end;

procedure TForm5.SQLConnection1BeforeDisconnect(Sender: TObject);
begin
  FreeAndNil(Proxy);
end;

procedure TForm5.UpdateProgress(aPosition: Integer);
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure begin
    Label5.Caption := aPosition.ToString;
    ProgressBar1.Position := aPosition;
  end);
end;

{ TStatus }

function TStatus.Execute(const Arg: TJSONValue): TJSONValue;
begin
  Form5.UpdateProgress(
    StrToInt(TJSONObject(Arg).GetValue('step').Value)
  );
  Result := TJSONTrue.Create;
end;

end.
