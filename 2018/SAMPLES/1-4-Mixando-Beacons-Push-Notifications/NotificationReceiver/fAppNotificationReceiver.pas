unit fAppNotificationReceiver;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.DialogService,
  System.Threading, System.Messaging, System.PushNotification, System.JSON,
  Datasnap.DSClientRest
  {$IFDEF ANDROID}
  , Lib.Android.Account, Lib.AndroidUtils, lPush, lPushData,
  Lib.DeviceInfo, Lib.Ver, FMX.Layouts, FMX.ScrollBox, FMX.Memo, FMX.TabControl, System.Actions,
  FMX.ActnList
  {$ENDIF}
  ,aConsts, aIni, ccPush, System.Notification;

type
  TForm1 = class(TForm)
    StyleBook1: TStyleBook;
    PushManagerApp: TPushManager;
    DSRestConnection1: TDSRestConnection;
    ActionList1: TActionList;
    acSend: TAction;
    tabs: TTabControl;
    tabPush: TTabItem;
    TabItem2: TTabItem;
    Label2: TLabel;
    edtNome: TEdit;
    Label3: TLabel;
    lstPush: TListView;
    lblDeviceToken: TLabel;
    lblLog: TLabel;
    mmLog: TMemo;
    Label1: TLabel;
    Layout1: TLayout;
    spSend: TSpeedButton;
    cbAccounts: TComboBox;
    Label4: TLabel;
    lstDevices: TListView;
    SpeedButton1: TSpeedButton;
    acGetDevices: TAction;
    Label5: TLabel;
    cbControlAccounts: TComboBox;
    Panel1: TPanel;
    aiWait: TAniIndicator;
    edtServer: TEdit;
    NotificationCenterMain: TNotificationCenter;
    procedure PushManagerAppMessage(Sender: TObject; const ANotification: TPushServiceNotification);
    procedure PushManagerAppPushChange(Sender: TObject; AChange: TPushService.TChanges);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acSendExecute(Sender: TObject);
    procedure acGetDevicesExecute(Sender: TObject);
  private
    procedure LoadIni;
    procedure SaveIni;
    procedure SetupServer;
    procedure FillAccounts;
    function GetAccount: string;
    function GetControlAccount: string;
    procedure AddItem(const Title, Msg: string);
    procedure ShowNotification(const ATitle, AMsg: string);
    procedure BuildDeviceList(DeviceList: TJSONArray);
    function DoSendRegistration(const DeviceToken, Account, UserName: string): TJSONValue;
  public
    procedure SendRegistration(const DeviceToken, Account, UserName: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.acGetDevicesExecute(Sender: TObject);
var
  DeviceResult: TJSONObject;
  Errorvalue: TJSONValue;
  DeviceList: TJSONArray;
begin
  acGetDevices.Enabled:= false;
  aiWait.Visible:= true;
  aiWait.Enabled:= true;
  try
    if GetControlAccount = EmptyStr then
      TDialogService.MessageDialog('Por favor, selecione uma conta.',
                                   TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK],
                                   TMsgDlgBtn.mbOK, 0, nil)
    else
    with TPushMethodsClient.Create(DSRestConnection1, true) do
    try
      DeviceResult:= UserDevices(GetControlAccount);
      if assigned(DeviceResult) and DeviceResult.TryGetValue('success', DeviceList) then
        BuildDeviceList(DeviceList)
      else
      if DeviceResult.TryGetValue('error', Errorvalue) then
        TDialogService.MessageDialog(ErrorValue.Value,
                                     TMsgDlgType.mtError, [TMsgDlgBtn.mbOK],
                                     TMsgDlgBtn.mbOK, 0, nil)

    finally
      Free;
    end;
  finally
    acGetDevices.Enabled:= True;
    aiWait.Enabled:= false;
    aiWait.Visible:= false;
  end;
end;

procedure TForm1.acSendExecute(Sender: TObject);
begin
  acSend.Enabled:= false;
  aiWait.Visible:= true;
  aiWait.Enabled:= true;
  try
    SaveIni;
    if (not lblDeviceToken.Text.Trim.IsEmpty) and (not GetAccount.Trim.IsEmpty) and
      (not edtNome.Text.Trim.IsEmpty) then
    SendRegistration(lblDeviceToken.Text, GetAccount, edtNome.Text);
  finally
    acSend.Enabled:= true;
    aiWait.Enabled:= false;
    aiWait.Visible:= false;
  end;
end;

procedure TForm1.AddItem(const Title, Msg: string);
var
  AItem: TListViewItem;
begin
  AItem:= lstPush.Items.Add;
  AItem.Text:= Title;
  AItem.Detail:= Msg;
end;

procedure TForm1.ShowNotification(const ATitle, AMsg: string);
var
  MyNotification: TNotification;
begin
  MyNotification:= NotificationCenterMain.CreateNotification;
  try
    MyNotification.Name:= 'DistAlarm' + AMsg;
    MyNotification.AlertBody := AMsg;
    NotificationCenterMain.PresentNotification(MyNotification);
  finally
    MyNotification.Free;
  end;
end;

procedure TForm1.LoadIni;
begin
  edtNome.Text:= Ini.Nome;
  cbAccounts.ItemIndex:= cbAccounts.Items.IndexOf(Ini.Conta);
end;

procedure TForm1.SaveIni;
begin
  Ini.Nome:= edtNome.Text;
  if cbAccounts.ItemIndex > -1 then
    Ini.Conta:= cbAccounts.Items[cbAccounts.ItemIndex]
  else
    Ini.Conta:= EmptyStr;
end;

procedure TForm1.SetupServer;
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

  DSRestConnection1.Host:= S;
  if P <> EmptyStr then
    DSRestConnection1.Port:= StrToInt(P);
end;

procedure TForm1.FillAccounts;
begin
  cbAccounts.Items.Clear;
  FillAccountEmails('com.google', cbAccounts.Items);
  cbControlAccounts.Items.Assign(cbAccounts.Items);
end;

function TForm1.GetAccount: string;
begin
  if cbAccounts.ItemIndex > -1 then
    result:= cbAccounts.Items[cbAccounts.ItemIndex]
  else
    result:= EmptyStr;
end;

function TForm1.GetControlAccount: string;
begin
  if cbControlAccounts.ItemIndex > -1 then
    result:= cbControlAccounts.Items[cbControlAccounts.ItemIndex]
  else
    result:= EmptyStr;
end;

procedure TForm1.BuildDeviceList(DeviceList: TJSONArray);
var
  AItem: TListViewItem;
  AValue: TJSONValue;
  user_id, device_id, device_model, os_name, os_ver: TJSONValue;
begin
  lstDevices.Items.Clear;
  for AValue in DeviceList do
  begin
    AValue.TryGetValue('USER_ID', user_id);
    AValue.TryGetValue('DEVICE_ID', device_id);
    AValue.TryGetValue('DEVICE_MODEL', device_model);
    AValue.TryGetValue('OS_NAME', os_name);
    AValue.TryGetValue('OS_VER', os_ver);
    AItem:= lstDevices.Items.Add;
    AItem.Text:= device_id.Value;
    AItem.Detail:= format('%s - %s - %s', [device_model.Value, os_name.Value, os_ver.Value]);
  end;
end;

function TForm1.DoSendRegistration(const DeviceToken, Account, UserName: string): TJSONValue;
var
  deviceInfo: TPushDevice;
begin
  result:= nil;
  try
    deviceInfo:= TPushDevice.Create(Account, UserName, TMobileDeviceInfo.DeviceID, DeviceToken,
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

procedure TForm1.SendRegistration(const DeviceToken, Account, UserName: string);
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
        Result:= DoSendRegistration(DeviceToken, Account, UserName);
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
              mmLog.Lines.Add(ResultValue);
            end
          );
        end;
      end;
      Inc(Tries);
    until (ResultValue <> '0') or (Tries = MAX_REG_TRIES);
  end);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveIni;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //Connect to push registration service
  PushManagerApp.Active:= true;
  FillAccounts;
  LoadIni;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  //Process offline messages
  PushManagerApp.CheckStartupMessage;
end;

procedure TForm1.PushManagerAppMessage(Sender: TObject; const ANotification: TPushServiceNotification);
var
  Value, ATitle, AMsg: string;
begin
  ATitle:= EmptyStr; AMsg:= EmptyStr;
  if ANotification.Json.TryGetValue('title', Value) then
    ATitle:= Value;
  if ANotification.Json.TryGetValue('message', Value) then
    AMsg:= Value;
  if (not ATitle.IsEmpty) then
    AddItem(ATitle, AMsg);
  if not PushManagerApp.IsStartupMessage then
    ShowNotification(ATitle, AMsg);
end;

procedure TForm1.PushManagerAppPushChange(Sender: TObject; AChange: TPushService.TChanges);
begin
  if TPushService.TChange.DeviceToken in AChange then
  begin
    lblDeviceToken.Text:= PushManagerApp.DeviceToken;
    //SendRegistration(PushManagerApp.DeviceToken, GetAccount, edtNome.Text);
  end;
end;

end.
