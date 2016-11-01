unit aClasses;
interface
uses System.SysUtils, System.JSON;

type
  TPushDevice = class
  private
    FDeviceId: string;
    FDeviceToken: string;
    FDeviceType: string;
    FOSName: string;
    FOSVersion: string;
    FUserName: string;
    FUserEmail: string;
    FPushEnabled: boolean;
    function GetAsJSONString: string;
    procedure SetAsJSONString(const JSONString: string);
  public
    constructor Create(const ADeviceId, ADeviceToken, ADeviceType, AOSName, AOSVersion,
      AUserName, AUserEmail: string; APushEnabled: boolean); overload;
    property DeviceId: string read FDeviceId write FDeviceId;
    property DeviceToken: string read FDeviceToken write FDeviceToken;
    property DeviceType: string read FDeviceType write FDeviceType;
    property OSName: string read FOSName write FOSName;
    property OSVersion: string read FOSVersion write FOSVersion;
    property UserName: string read FUserName write FUserName;
    property UserEmail: string read FUserEmail write FUserEmail;
    property PushEnabled: boolean read FPushEnabled write FPushEnabled;
    property AsJSONString: string read GetAsJSONString write SetAsJSONString;
  end;

var
  CurrentMessageQueueHandler: THandle;

implementation

{ TPushDevice }
constructor TPushDevice.Create(const ADeviceId, ADeviceToken, ADeviceType, AOSName, AOSVersion, AUserName, AUserEmail: string;
  APushEnabled: boolean);
begin
  inherited Create;
  FDeviceId:= ADeviceId;
  FDeviceToken:= ADeviceToken;
  FDeviceType:= ADeviceType;
  FOSName:= AOSName;
  FOSVersion:= AOSVersion;
  FUserName:= AUserName;
  FUSerEmail:= AUSerEmail;
  FPushEnabled:= APushEnabled;
end;

function TPushDevice.GetAsJSONString: string;
var
  j: TJSONObject;
begin
  j:= TJSONObject.Create;
  try
    j.AddPair('DeviceId', FDeviceId);
    j.AddPair('DeviceToken', FDeviceToken);
    j.AddPair('DeviceType', FDeviceType);
    j.AddPair('OSName', FOSName);
    j.AddPair('OSVersion', FOSVersion);
    j.AddPair('UserName', FUserName);
    j.AddPair('UserEmail', FUserEmail);
    if FPushEnabled then
      j.AddPair('PushEnabled', 'S')
    else
      j.AddPair('PushEnabled', 'N');
    result:= j.ToJSON;
  finally
    j.Free;
  end;
end;

procedure TPushDevice.SetAsJSONString(const JSONString: string);
var
  j: TJSONObject;
  Value: string;
begin
  j:= TJSONObject.ParseJSONValue(BytesOf(JSONString), 0) as TJSONObject;
  if assigned(j) then
  try
    if j.TryGetValue<String>('DeviceId', Value) then
      FDeviceId:= Value;
    if j.TryGetValue<String>('DeviceToken', Value) then
      FDeviceToken:= Value;
    if j.TryGetValue<String>('DeviceType', Value) then
      FDeviceType:= Value;
    if j.TryGetValue<String>('OSName', Value) then
      FOSName:= Value;
    if j.TryGetValue<String>('OSVersion', Value) then
      FOSVersion:= Value;
    if j.TryGetValue<String>('UserName', Value) then
      FUserName:= Value;
    if j.TryGetValue<String>('UserEmail', Value) then
      FUserEmail:= Value;
    if j.TryGetValue<String>('PushEnabled', Value) then
      FPushEnabled:= (Value = 'S');
  finally
    j.Free;
  end;
end;

end.
