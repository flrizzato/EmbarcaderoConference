unit lPush;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Generics.Collections, System.Classes, System.Variants,
  FMX.Types, FMX.Forms, System.Threading, System.DateUtils,
  System.JSON, System.PushNotification, FMX.Layouts, FMX.Memo, FMX.StdCtrls
  {$IFDEF ANDROID}
  , FMX.PushNotification.Android, FMX.Platform.Android, Androidapi.JNI.Os, Androidapi.JNI.JavaTypes, Androidapi.Helpers
  {$ENDIF}
  {$IFDEF IOS}
  , FMX.PushNotification.IOS
  {$ENDIF}
  ;

const
  DEFAULT_WAIT_INCREMENT = 5; //in seconds
  DEFAULT_THREAD_SLEEP = 250;
  DEFAULT_THREAD_SLEEP_LOWPROFILE = 500;
  TPushPlatforms = pidiOSSimulator or pidAndroid or pidiOSDevice;

type
{$IFDEF ANDROID}
  TGCMPushNotification = class(TPushServiceNotification)
  private
    FJSONObject: TJSONObject;
  protected
    function GetDataKey: string; override;
    function GetJson: TJSONObject; override;
    function GetDataObject: TJSONObject; override;
  public
    constructor Create(const ABundle: JBundle); overload;
  end;
{$ENDIF}

  TPushThread = class(TThread)
  private
    FAppID: string;
    FPushService: TPushService;
    FSleepTime: NativeInt;
    {$IFDEF CPUARM} //Mobile only
    FServiceConnection: TPushServiceConnection;
    {$ENDIF}
    FOnMessage: TPushServiceConnection.TReceiveNotificationEvent;
    FOnPushChange: TPushServiceConnection.TChangeEvent;
    {$IFDEF CPUARM}
    procedure OnPushServiceChange(Sender: TObject; AChange: TPushService.TChanges);
    procedure OnReceiveNotification(Sender: TObject; const PushNotification: TPushServiceNotification);
    {$ENDIF}
    function TryActivate: boolean;
    function GetPushReady: boolean;
  public
    Constructor Create(CreateSuspended: boolean; const AAppId: string); reintroduce;
    Destructor Destroy; override;
    procedure Execute; override;
    function GetDeviceID: string;
    function GetDeviceToken: string;
    function GetStartupError: string;
    property OnPushChange: TPushServiceConnection.TChangeEvent read FOnPushChange write FonPushChange;
    property OnMessage: TPushServiceConnection.TReceiveNotificationEvent read FOnMessage write FOnMessage;
  end;

  [ComponentPlatformsAttribute(TPushPlatforms)]
  TPushManager = class(TComponent)
  private
    FAppID: string;
    FPushThread: TPushThread;
    FIsStartupMessage: boolean;
    FOnMessage: TPushServiceConnection.TReceiveNotificationEvent;
    FOnPushChange: TPushServiceConnection.TChangeEvent;
    procedure CreatePushThread;
    procedure DestroyPushThread;
    function GetPushReady: boolean;
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    function GetDeviceID: string;
    function GetDeviceToken: string;
    procedure SetAppID(const Value: string);
    function GetStartupError: string;
    procedure OnPushServiceChange(Sender: TObject; AChange: TPushService.TChanges);
    procedure OnReceiveNotification(Sender: TObject; const PushNotification: TPushServiceNotification);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFDEF ANDROID}
    procedure CheckStartupMessage;
    function HasStartupMessage: boolean;
    {$ENDIF}
    property DeviceID: string read GetDeviceID;
    property DeviceToken: string read GetDeviceToken;
    property Ready: boolean read GetPushReady;
    property IsStartupMessage: boolean read FIsStartupMessage;
  published
    property AppID: string read FAppID write SetAppID;
    property Active: boolean read GetActive write SetActive default False;
    property OnMessage: TPushServiceConnection.TReceiveNotificationEvent read FOnMessage write FOnMessage;
    property OnPushChange: TPushServiceConnection.TChangeEvent read FOnPushChange write FOnPushChange;
    property StartupError: string read GetStartupError;
  end;

{$IFDEF UNIT_REGISTRATION}
  procedure Register;
{$ENDIF}

implementation

{$IFDEF UNIT_REGISTRATION}
procedure Register;
begin
  RegisterFmxClasses([TPushManager]);
  RegisterComponents('Agile Software', [TPushManager]);
end;
{$ENDIF}

{$IFDEF ANDROID}
constructor TGCMPushNotification.Create(const ABundle: JBundle);
var
  LJSONObject: TJSONObject;
  LIterator: JIterator;
  LValue: JString;
  LKey: JString;
begin
  LJSONObject := TJSONObject.Create;
  LIterator := ABundle.KeySet.iterator;
  while LIterator.hasNext do
  begin
    LKey := LIterator.next.toString;
    LValue := ABundle.&get(LKey).ToString;
    LJSONObject.AddPair(JStringToString(LKey), JStringToString(LValue));
  end;
  Assert(LJSONObject.Count = ABundle.keySet.size);
  FJSONObject := LJSONObject;
end;

function TGCMPushNotification.GetDataKey: string;
begin
  Result:= 'gcm';
end;

function TGCMPushNotification.GetJson: TJSONObject;
begin
  Result:= FJSONObject;
end;

function TGCMPushNotification.GetDataObject: TJSONObject;
var
  LValue: TJSONValue;
begin
  // The message /can/ be prefaced with "gcm", but this is not required
  Result := FJSONObject;  // take raw JSON as default
  if (GetDataKey <> '') and (FJSONObject <> nil) then
  begin
    LValue := FJSONObject.Values[GetDataKey];
    if LValue <> nil then
      Result := LValue as TJSONObject;
  end;
end;
{$ENDIF}

{ TPushThread }
constructor TPushThread.Create(CreateSuspended: boolean; const AAppId: string);
begin
  inherited create(CreateSuspended);
  FAppId:= AAppId;
  FSleepTime:= DEFAULT_THREAD_SLEEP;
  {$IFDEF ANDROID}
  FPushService:= TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.GCM);
  {$ENDIF}
  {$IFDEF IOS}
  FPushService:= TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.APS);
  {$ENDIF}
  {$IFDEF CPUARM}
  FServiceConnection:= TPushServiceConnection.Create(FPushService);
  FServiceConnection.OnChange:= OnPushServiceChange;
  FServiceConnection.OnReceiveNotification:= OnReceiveNotification;
  {$ENDIF}
end;

destructor TPushThread.Destroy;
begin
  {$IFDEF CPUARM}
  FServiceConnection.Active:= false;
  FServiceConnection.Free;
  {$ENDIF}
  FPushService:= nil;
  inherited;
end;

procedure TPushThread.Execute;
var
  WaitUntil: TDateTime;
  FinishedWaiting: boolean;

  function IsWaiting: boolean;
  begin
    result:= (WaitUntil <> 0) and (Now >= WaitUntil);
  end;

  procedure PostponeTry(NSeconds: NativeInt);
  begin
    WaitUntil:= Now + (OneSecond * NSeconds);
  end;

begin
  WaitUntil:= 0;
  FinishedWaiting:= false;
  while not Terminated do
  begin
    if (not IsWaiting) and (not FinishedWaiting) and (not GetPushReady) then
    begin
      FinishedWaiting:= TryActivate;
      if FinishedWaiting then
        FSleepTime:= DEFAULT_THREAD_SLEEP_LOWPROFILE
      else
        PostponeTry(DEFAULT_WAIT_INCREMENT);
    end;
    Sleep(FSleepTime);
  end;
end;

function TPushThread.TryActivate: boolean;
begin
  result:= false;
  {$IFDEF ANDROID}
  FPushService.AppProps[TPushService.TAppPropNames.GCMAppID]:= FAppID;
  {$ENDIF}
  {$IFDEF CPUARM}
  try
    FServiceConnection.Active:= true;
    result:= FServiceConnection.Active;
  except
    //Nothing to do but try again later
  end;
  {$ENDIF}
end;

function TPushThread.GetPushReady: boolean;
begin
  result:= (GetDeviceID <> EmptyStr) and (GetDeviceToken <> EmptyStr);
end;

{$IFDEF CPUARM}
procedure TPushThread.OnPushServiceChange(Sender: TObject; AChange: TPushService.TChanges);
begin
  if assigned(FOnPushChange) then
    Synchronize(
      procedure
      begin
        FOnPushChange(Self, AChange);
      end);
end;

procedure TPushThread.OnReceiveNotification(Sender: TObject; const PushNotification: TPushServiceNotification);
begin
  if assigned(FOnPushChange) then
    Synchronize(
      procedure
      begin
        FOnMessage(Sender, PushNotification);
      end);
end;
{$ENDIF}

function TPushThread.GetStartupError: string;
begin
  if assigned(FPushService) then
    result:= FPushService.StartupError
  else
    result:= EmptyStr;
end;

function TPushThread.GetDeviceID: string;
begin
  if assigned(FPushService) then
    result:= FPushService.DeviceIDValue[TPushService.TDeviceIDNames.DeviceID]
  else
    result:= EmptyStr;
end;

function TPushThread.GetDeviceToken: string;
begin
  if assigned(FPushService) then
    result:= FPushService.DeviceTokenValue[TPushService.TDeviceTokenNames.DeviceToken]
  else
    result:= EmptyStr;
end;

{ TPushManager }
constructor TPushManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAppId:= AppID;
end;

destructor TPushManager.Destroy;
begin

  inherited;
end;

procedure TPushManager.CreatePushThread;
begin
  if (not (csDesigning in ComponentState)) then
  begin
    if assigned(FPushThread) then
      DestroyPushThread;
    FPushThread:= TPushThread.Create(true, FAppId);
    FPushThread.OnPushChange:= OnPushServiceChange;
    FPushThread.OnMessage:= OnReceiveNotification;
    FPushThread.Start;
  end;
end;

procedure TPushManager.DestroyPushThread;
begin
  if (not (csDesigning in ComponentState)) then
  begin
    if assigned(FPushThread) then
    begin
      FPushThread.Terminate;
      FPushThread.Free;
    end;
  end;
end;

{$IFDEF ANDROID}
procedure TPushManager.CheckStartupMessage;
var
  bundle: JBundle;
begin
  inherited;
  bundle:= MainActivity.getStartupGCM;
  if assigned(bundle) and assigned(FOnMessage) then
  begin
    FIsStartupMessage:= true;
    try
      FOnMessage(Self, TGCMPushNotification.Create(bundle));
    finally
      FIsStartupMessage:= false;
    end;
  end;
end;

function TPushManager.HasStartupMessage: boolean;
begin
  result:= assigned(MainActivity.getStartupGCM);
end;

{$ENDIF}

function TPushManager.GetPushReady: boolean;
begin
  result:= (DeviceID <> EmptyStr) and (DeviceToken <> EmptyStr);
end;

function TPushManager.GetStartupError: string;
begin
  if assigned(FPushThread) then
    result:= FPushThread.GetStartupError
  else
    result:= EmptyStr;
end;

function TPushManager.GetDeviceID: string;
begin
  if assigned(FPushThread) then
    result:= FPushThread.GetDeviceID
  else
    result:= EmptyStr;
end;

function TPushManager.GetDeviceToken: string;
begin
  if assigned(FPushThread) then
    result:= FPushThread.GetDeviceToken
  else
    result:= EmptyStr;
end;

function TPushManager.GetActive: boolean;
begin
  result:= assigned(FPushThread);
end;

procedure TPushManager.SetActive(const Value: boolean);
begin
  if Value <> GetActive then
  begin
    if Value then
      CreatePushThread
    else
      DestroyPushThread;
  end;
end;

procedure TPushManager.SetAppID(const Value: string);
var
  OldActive: boolean;
begin
  OldActive:= Active;
  Active:= false;
  FAppID:= Value;
  Active:= OldActive;
end;

procedure TPushManager.OnPushServiceChange(Sender: TObject; AChange: TPushService.TChanges);
begin
  if assigned(FOnPushChange) then
    FOnPushChange(Self, AChange);
end;

procedure TPushManager.OnReceiveNotification(Sender: TObject; const PushNotification: TPushServiceNotification);
begin
  if assigned(FOnMessage) then
    FOnMessage(Sender, PushNotification)
end;

end.
