unit lPush;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Generics.Collections, System.Classes, System.Variants,
  FMX.Types, FMX.Forms,
  System.JSON, System.PushNotification, FMX.Layouts, FMX.Memo, FMX.StdCtrls
  {$IFDEF ANDROID}
  ,FMX.PushNotification.Android
  {$ENDIF}
  {$IFDEF IOS}
  ,FMX.PushNotification.IOS
  {$ENDIF}
  ;

const
  TPushPlatforms = pidiOSSimulator or pidAndroid or pidiOSDevice;

type
  [ComponentPlatformsAttribute(TPushPlatforms)]
  TPushManager = class(TComponent)
  private
    FAppID: string;
    FActive: boolean;
    FPushService: TPushService;
    FServiceConnection: TPushServiceConnection;
    FOnMessage: TPushServiceConnection.TReceiveNotificationEvent;
    FOnPushReady: TNotifyEvent;
    FOnPushChange: TPushServiceConnection.TChangeEvent;
    FTimer: TTimer;
    function CheckPushReady: boolean;
    function GetPushReady: boolean;
    procedure OnTimer(Sender: TObject);
    procedure OnPushServiceChange(Sender: TObject; AChange: TPushService.TChanges);
    procedure OnReceiveNotification(Sender: TObject; const PushNotification: TPushServiceNotification);
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    function GetDeviceID: string;
    function GetDeviceToken: string;
    procedure SetAppID(const Value: string);
    function GetStartupError: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DeviceID: string read GetDeviceID;
    property DeviceToken: string read GetDeviceToken;
    property Ready: boolean read GetPushReady;
  published
    property AppID: string read FAppID write SetAppID;
    property Active: boolean read GetActive write SetActive default False;
    property OnMessage: TPushServiceConnection.TReceiveNotificationEvent read FOnMessage write FOnMessage;
    property OnPushReady: TNotifyEvent read FOnPushReady write FOnPushReady;
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
  RegisterComponents('Mobile', [TPushManager]);

end;
{$ENDIF}
{ TPushManager }
constructor TPushManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAppId:= AppID;
  {$IFDEF ANDROID}
  FPushService:= TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.GCM);
  {$ENDIF}
  {$IFDEF IOS}
  FPushService:= TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.APS);
  {$ENDIF}
  FServiceConnection:= TPushServiceConnection.Create(FPushService);
  FServiceConnection.OnChange:= OnPushServiceChange;
  FServiceConnection.OnReceiveNotification:= OnReceiveNotification;
end;

destructor TPushManager.Destroy;
begin
  FServiceConnection.Active:= false;
  FServiceConnection.Free;
  FPushService:= nil;
  if assigned(FTimer) then
    FreeAndNil(FTimer);
  inherited;
end;

function TPushManager.CheckPushReady: boolean;
begin
  result:= GetPushReady;
  if result and assigned(FOnPushReady) then
    FOnPushReady(Self);
end;

function TPushManager.GetPushReady: boolean;
begin
  result:= (DeviceID <> EmptyStr) and (DeviceToken <> EmptyStr);
end;

function TPushManager.GetStartupError: string;
begin
  result:= FPushService.StartupError;
end;

function TPushManager.GetDeviceID: string;
begin
  if assigned(FPushService) then
    result:= FPushService.DeviceIDValue[TPushService.TDeviceIDNames.DeviceID]
  else
    result:= EmptyStr;
end;

function TPushManager.GetDeviceToken: string;
begin
  if assigned(FPushService) then
    result:= FPushService.DeviceTokenValue[TPushService.TDeviceTokenNames.DeviceToken]
  else
    result:= EmptyStr;
end;

function TPushManager.GetActive: boolean;
begin
  result:= FActive
end;

procedure TPushManager.SetActive(const Value: boolean);
begin
  FActive:= Value;
  if (not (csDesigning in ComponentState)) and (not (csLoading in ComponentState)) then
  begin
    {$IFDEF ANDROID}
    if Value then
      FPushService.AppProps[TPushService.TAppPropNames.GCMAppID]:= FAppID;
    {$ENDIF}
    try
      FServiceConnection.Active:= Value;
    except
      //If a connection is not available, start timer to check it later
    end;
    if Value and (not CheckPushReady) then
    begin
      FTimer:= TTimer.Create(nil);
      FTimer.Interval:= 2000;
      FTimer.OnTimer:= Self.OnTimer;
      FTimer.Enabled:= true;
    end
    else
      FreeAndNil(FTimer);
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

procedure TPushManager.OnTimer(Sender: TObject);
begin
  FTimer.Enabled:= False;
  if FTimer.Interval < 60000 then
    FTimer.Interval:= FTimer.Interval + 1000;
  if not Ready then
  try
    FServiceConnection.Active:= true;
    FTimer.Enabled:= not CheckPushReady;
  except
    FTimer.Enabled:= True;
  end;
end;

end.
