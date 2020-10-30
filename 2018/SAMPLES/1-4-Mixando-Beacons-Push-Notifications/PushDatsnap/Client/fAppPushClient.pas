unit fAppPushClient;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Json, System.Threading, System.Messaging,
  {$IFDEF ANDROID}
  Lib.Android.Account, Lib.AndroidUtils,
  {$ENDIF}
  Lib.DeviceInfo, Lib.Ver,
  aConsts, lPushData,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, lPush, System.PushNotification,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient, Data.SqlExpr, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Datasnap.DSClientRest, FMX.StdCtrls,
  ccPush, FMX.Edit, FMX.Layouts;

type
  TfrmAppPushClient = class(TForm)
    Memo1: TMemo;
    PushManagerApp: TPushManager;
    DSRestConnection1: TDSRestConnection;
    Layout1: TLayout;
    btnSendToUser: TButton;
    edtPara: TEdit;
    btnSendToAll: TButton;
    Label1: TLabel;
    Label2: TLabel;
    edtTitulo: TEdit;
    edtMsg: TEdit;
    Label3: TLabel;
    edtServer: TEdit;
    Label4: TLabel;
    StyleBook1: TStyleBook;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PushManagerAppPushChange(Sender: TObject; AChange: TPushService.TChanges);
    procedure PushManagerAppMessage(Sender: TObject;
      const ANotification: TPushServiceNotification);
    procedure btnSendToUserClick(Sender: TObject);
    procedure btnSendToAllClick(Sender: TObject);
  private
    procedure SetupServer;
    function GetUserId: string;
    function DoSendRegistration(const DeviceToken: string): TJSONValue;
    procedure SendRegistration(const DeviceToken: string);
  public
    { Public declarations }
  end;

var
  frmAppPushClient: TfrmAppPushClient;

implementation

{$R *.fmx}

function TfrmAppPushClient.GetUserId: string;
begin
  {$IFDEF ANDROID}
  if HasPermission('android.permission.GET_ACCOUNTS') then
    result:= GetFirstAccountEmail('com.google')
  else
    result:= 'DefaultUserId'; //pegar alguma coisa da app que identifique o usuário aqui
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  result:= 'DefaultUserID';
  {$ENDIF}
end;

procedure TfrmAppPushClient.btnSendToUserClick(Sender: TObject);
begin
  //SetupServer;
  with TPushMethodsClient.Create(DSRestConnection1, true) do
  try
    Memo1.Lines.Add(SendMessageToUser(edtPara.Text, edtTitulo.Text, edtMsg.Text).ToJSON);
  finally
    Free;
  end;
end;

procedure TfrmAppPushClient.btnSendToAllClick(Sender: TObject);
begin
  //SetupServer;
  with TPushMethodsClient.Create(DSRestConnection1, true) do
  try
    Memo1.Lines.Add(SendMessageToAll(edtTitulo.Text, edtMsg.Text).ToJSON);
  finally
    Free;
  end;
end;

function TfrmAppPushClient.DoSendRegistration(const DeviceToken: string): TJSONValue;
var
  deviceInfo: TPushDevice;
begin
  result:= nil;
  try
    deviceInfo:= TPushDevice.Create(GetUserId, EmptyStr, TMobileDeviceInfo.DeviceID, DeviceToken,
                                    TMobileDeviceInfo.DeviceModel,
                                    TMobileDeviceInfo.OSName, TMobileDeviceInfo.OSVersion,
                                    TAppVer.GetVerName, RECEIVE_PUSH_YES);
    try
      with TPushMethodsClient.Create(DSRestConnection1, true) do
      try
        result:= UpdateDevice(deviceInfo);
      finally
        Free;
      end;
    finally
      deviceInfo.Free;
    end;
  except
    On E: Exception do
    begin
      Result:= TJSONObject.Create.AddPair('result', E.Message);
    end;
  end;
end;

procedure TfrmAppPushClient.SendRegistration(const DeviceToken: string);
begin
  TTask.Run(
    procedure
    var
      Result: TJSONValue;
      Tries: integer;
      ResultValue: string;
    begin
      Tries:= 0;
      repeat
        try
          Result:= DoSendRegistration(DeviceToken);
        except
        end;
        if assigned(Result) and Result.TryGetValue('success', ResultValue) then
        begin
          if  (ResultValue = EmptyStr)  then
            TThread.Current.Sleep(TIME_BETWEEN_TRIES)
          else
          begin
            TThread.Synchronize(nil,
              procedure
              begin
                Memo1.Lines.Add(ResultValue);
              end
            );
          end;
        end;
        Inc(Tries);
      until (ResultValue <> '0') or (Tries = MAX_REG_TRIES);
    end);
end;

procedure TfrmAppPushClient.SetupServer;
var
  i: integer;
  S, P: string;
begin
  S:= EmptyStr; P:= EmptyStr;
  i:= Pos(edtServer.Text, ':');
  if i > 0 then
  begin
    S:= Copy(edtServer.Text, 1, i - 1);
    P:= Copy(edtServer.Text, i + 1, Length(edtServer.Text));
  end
  else
    S:= edtServer.Text;

  Memo1.Lines.Add('1-------');
  Memo1.Lines.Add(S);
  Memo1.Lines.Add('2-------');
  Memo1.Lines.Add(P);
  Memo1.Lines.Add('3-------');
  DSRestConnection1.Host:= S;
  if P <> EmptyStr then
    DSRestConnection1.Port:= StrToInt(P);
end;

procedure TfrmAppPushClient.FormCreate(Sender: TObject);
begin
  //Connect to push registration service
  PushManagerApp.Active:= true;
end;

procedure TfrmAppPushClient.FormActivate(Sender: TObject);
begin
  //Process offline messages
  PushManagerApp.CheckStartupMessage
end;

procedure TfrmAppPushClient.PushManagerAppPushChange(Sender: TObject;
  AChange: TPushService.TChanges);
begin
  //Register
  if TPushService.TChange.DeviceToken in AChange then
  begin
    Memo1.Lines.Add(PushManagerApp.DeviceToken);
    SendRegistration(PushManagerApp.DeviceToken);
  end;
end;

procedure TfrmAppPushClient.PushManagerAppMessage(Sender: TObject;
  const ANotification: TPushServiceNotification);
var
  Value: string;
begin
  Memo1.Lines.Add(ANotification.Json.ToJSON);
  if ANotification.Json.TryGetValue('title', Value) then
    Memo1.Lines.Add(Value);
  if ANotification.Json.TryGetValue('message', Value) then
    Memo1.Lines.Add(Value);
end;


end.
