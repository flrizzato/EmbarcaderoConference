unit fAppPushDemo;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Threading, System.NetEncoding,
  FMX.Platform, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Gestures, System.Actions, FMX.ActnList, FMX.ScrollBox, FMX.Memo, FMX.Layouts, FMX.ExtCtrls, FMX.Edit, System.Notification,
  lPush, lDeviceInfo,
  System.PushNotification,
  System.JSON, System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent, FMX.Objects, FMX.ListBox;

type
  TfrmAppPushDemo = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ToolBar3: TToolBar;
    lblPush: TLabel;
    TabItem3: TTabItem;
    ToolBar4: TToolBar;
    lblTitle4: TLabel;
    TabItem4: TTabItem;
    ToolBar5: TToolBar;
    lblTitle5: TLabel;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    ImageViewer2: TImageViewer;
    ToolBar1: TToolBar;
    Label1: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    edtDeviceId: TEdit;
    Label6: TLabel;
    edtDeviceType: TEdit;
    Label7: TLabel;
    edtOSVersion: TEdit;
    Label8: TLabel;
    edDeviceToken: TEdit;
    PushManager1: TPushManager;
    NotificationCenter1: TNotificationCenter;
    netClient: TNetHTTPClient;
    VertScrollBox1: TVertScrollBox;
    Label5: TLabel;
    edtName: TEdit;
    Label3: TLabel;
    edtEmail: TEdit;
    btnSend: TButton;
    Rectangle1: TRectangle;
    ImageViewer1: TImageViewer;
    TabItem5: TTabItem;
    lstMsg: TListBox;
    mmMsg: TMemo;
    Splitter1: TSplitter;
    ToolBar2: TToolBar;
    Label9: TLabel;
    mmLog: TMemo;
    procedure GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject; ANotification: TNotification);
    procedure PushManager1PushReady(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure PushManager1Message(Sender: TObject; const ANotification: TPushServiceNotification);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lstMsgChange(Sender: TObject);
    procedure PushManager1PushChange(Sender: TObject; AChange: TPushService.TChanges);
  private
    procedure SaveData;
    procedure SendServerRegistration;
    procedure AddNotification(ANotification: TNotification);
  public
    { Public declarations }
  end;

var
  frmAppPushDemo: TfrmAppPushDemo;

implementation
uses aClasses, aIni;
{$R *.fmx}

procedure TfrmAppPushDemo.AddNotification(ANotification: TNotification);
begin
  lstMsg.Items.AddObject(FormatDateTime('hh:nn:ss', ANotification.FireDate), ANotification);
end;

procedure TfrmAppPushDemo.btnSendClick(Sender: TObject);
begin
  SaveData;
  SendServerRegistration;
end;

procedure TfrmAppPushDemo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveData;
end;

procedure TfrmAppPushDemo.FormCreate(Sender: TObject);
begin
  edtDeviceId.Text:= TMobileDeviceInfo.DeviceID;
  edtDeviceType.Text:= TMobileDeviceInfo.DeviceType;
  edtOSVersion.Text:= TMobileDeviceInfo.OSVersion;
  edtName.Text:= Ini.UserName;
  edtEmail.Text:= Ini.UserEmail;
  PushManager1.Active:= true;
end;

procedure TfrmAppPushDemo.GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  case EventInfo.GestureID of
    sgiLeft:
      begin
        if TabControl1.ActiveTab <> TabControl1.Tabs[TabControl1.TabCount - 1] then
          TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex + 1];
        Handled := True;
      end;

    sgiRight:
      begin
        if TabControl1.ActiveTab <> TabControl1.Tabs[0] then
          TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex - 1];
        Handled := True;
      end;
  end;
end;

procedure TfrmAppPushDemo.NotificationCenter1ReceiveLocalNotification(Sender: TObject; ANotification: TNotification);
begin
  AddNotification(ANotification);
end;

procedure TfrmAppPushDemo.lstMsgChange(Sender: TObject);
begin
  mmMsg.Lines.Text:= TNotification(lstMsg.Items.Objects[lstMsg.ItemIndex]).AlertBody;
end;

procedure TfrmAppPushDemo.PushManager1Message(Sender: TObject; const ANotification: TPushServiceNotification);
var
  N: TNotification;
  j: TJSONObject;
  Value: string;
  Clipboard: IFMXClipboardService;
begin
  j:= (TJSONObject.ParseJSONValue(ANotification.Json.ToString) as TJSONObject);
  {j:= TJSONObject.Create;
  j.Parse(BytesOf(ANotification.Json.ToJSON), 0);}
  N:= NotificationCenter1.CreateNotification;
  N.Name:= 'UniqueName';

  if j.TryGetValue<string>('gcm.notification.body', Value) then
  begin
    N.AlertBody:= Value;
    if j.TryGetValue<string>('gcm.notification.title', Value) then
      N.Title:= Value
  end
  else
  begin
    N.Title:= 'Embarcadero Conference Notification';
    if j.TryGetValue<string>('message', Value) then
      N.AlertBody:= Value
  end;

  if N.AlertBody <> EmptyStr then
    NotificationCenter1.PresentNotification(N)
  else
  begin
    if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService,IInterface(Clipboard)) then
      Clipboard.SetClipboard(ANotification.DataObject.ToJSON);
    mmMsg.Lines.Add(ANotification.DataObject.ToJSON);
  end;
  N.Free;
end;

procedure TfrmAppPushDemo.PushManager1PushChange(Sender: TObject; AChange: TPushService.TChanges);
begin
  if TPushService.TChange.StartupNotifications in AChange then
    mmLog.Lines.Add('Startup');
  if TPushService.TChange.DeviceToken in AChange then
    mmLog.Lines.Add('DeviceToken');
  if TPushService.TChange.Status in AChange then
    mmLog.Lines.Add('Status');
end;

procedure TfrmAppPushDemo.PushManager1PushReady(Sender: TObject);
begin
  if not Ini.Registered then
  begin
    edDeviceToken.Text:= PushManager1.DeviceToken;
    Ini.DeviceToken:= PushManager1.DeviceToken;
    SendServerRegistration;
  end;
end;

procedure TfrmAppPushDemo.SaveData;
begin
  Ini.UserName:= edtName.Text;
  Ini.UserEmail:= edtEmail.Text;
end;

procedure TfrmAppPushDemo.SendServerRegistration;
begin
  TTask.Run(
  procedure
  var
    Tries: integer;
    pd: TPushDevice;
    js: string;
    SendStream, ReceiveStream: TStringStream;
  begin
    pd:= TPushDevice.Create;
    pd.DeviceId:= TMobileDeviceInfo.DeviceID;
    pd.DeviceToken:= Ini.DeviceToken;
    pd.DeviceType:= TMobileDeviceInfo.DeviceType;
    pd.OSName:= TMobileDeviceInfo.OSName;
    pd.OSVersion:= TMobileDeviceInfo.OSVersion;
    pd.UserName:= Ini.UserName;
    pd.UserEmail:= Ini.UserEmail;
    pd.PushEnabled:= true;
    js:= pd.AsJSONString;
    pd.Free;

    try
      SendStream:= TStringStream.Create(UTF8Encode(js));
    except
      On E: Exception do
      begin
        TThread.Current.Synchronize(nil,
        procedure
        begin
          mmLog.Lines.Add(E.Message);
        end);
        exit;
      end;
    end;
    ReceiveStream:= TStringStream.Create;
    try
      Tries:= 0;
      repeat
        ReceiveStream.Clear;
        SendStream.Position:= 0;
        try
          Inc(Tries);
          TThread.Current.Synchronize(nil,
            procedure
            begin
              mmLog.Lines.Add(Tries.ToString);
            end);
          netClient.Post(Ini.RegUrl, SendStream, ReceiveStream);
          Ini.Registered:= (ReceiveStream.DataString = 'OK'); //Isso tá combinado com a aplicação servidora (PushServerAdmin em TwmServerActions.wmAppwaRegisterAction)
          if not Ini.Registered then
            TThread.Current.Sleep(1000);
        except
          On E: Exception do
          begin
            TThread.Synchronize(nil,
            procedure
            begin
              mmLog.Lines.Add(format('%s: %s', [Tries.ToString, E.Message]));
            end);
          end;
        end;
      until Ini.Registered or (Tries = 10);
      if Ini.Registered then
        TThread.Current.Synchronize(nil,
        procedure
        begin
          mmLog.Lines.Add('Registered');
        end);
    finally
      ReceiveStream.Free;
      SendStream.Free;
    end;
  end);
end;

end.

