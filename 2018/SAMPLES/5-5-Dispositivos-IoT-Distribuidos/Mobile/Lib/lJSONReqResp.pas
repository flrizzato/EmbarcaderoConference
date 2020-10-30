unit lJSONReqResp;
interface
uses System.SysUtils, System.JSON, REST.JSON, System.Rtti, System.TypInfo;

const
  Current_Service_Request_Ver = '100';

type
  TServiceResponseCode = (rcUnknown, rcOK, rcError, rcException);

const
  TServiceResponseCodeStr : array[TServiceResponseCode] of string = ('Unknown', 'OK', 'Error', 'Exception');

type
  TServiceResponseCodeHelper = record helper for TServiceResponseCode
  public
    function ToString: string;
    constructor Parse(const Value: string);
  end;

  TBaseJSON = class
  protected
    FPrettyJSON: boolean;
    function GetAsJSONString: string; virtual;
    procedure SetAsJSONString(const AJSONString: string); virtual;
  public
    property AsJSONString: string read GetAsJSONString write SetAsJSONString;
    property PrettyJSON: boolean read FPrettyJSON write FPrettyJSON;
  end;

  TServiceRequest = class(TBaseJSON)
  private
    FVer: string;
    FData: string;
    {function GetAsJSONString: string;
    procedure SetAsJSONString(const AJSONString: string);}
    function GetFId: string;
  public
    constructor Create;
    property AsJSONString: string read GetAsJSONString write SetAsJSONString;
    property PrettyJSon: boolean read FPrettyJSON write FPrettyJSON;
  published
    property Id: string read GetFId;
    property Ver: string read FVer write FVer;
    property Data: string read FData write FData; //JSON String / XML / Text / Etc

  end;

  TServiceResponse = class(TBaseJSON)
  private
    FCode: TServiceResponseCode;
    FMsg: String;
    FData: String;
    {FPrettyJSON: boolean;
    function GetAsJSONString: string;
    procedure SetAsJSONString(const JSONString: string);}
  public
    Constructor Create; overload;
    Constructor Create(ACode: TServiceResponseCode; AMsg: String; AData: String); overload;
    property AsJSONString: string read GetAsJSONString write SetAsJSONString;
    property PrettyJSon: boolean read FPrettyJSON write FPrettyJSON;
  published
    property Code: TServiceResponseCode read FCode write FCode;
    property Msg: String read FMsg write FMsg;
    property Data: String read FData write FData;
  end;

type
  TPushMessageType = (mtUnknown, mtMessage, mtConfig);

const
  TPushMessageTypeStr : array[TPushMessageType] of string = ('unk', 'msg', 'cfg');

type
  TPushMessageTypeHelper = record helper for TPushMessageType
  public
    function ToString: string;
    constructor Parse(const Value: string);
  end;

  TPushMessage = class
  private
    FMsgType: string;
    FMsg: string;
    FPrettyJSON: boolean;
    function GetAsJSONString: string;
    procedure SetAsJSONString(const JSONString: string);
  public
    property MsgType: string read FMsgType write FMsgType;
    property Msg: string read FMsg write FMsg;
    property AsJSONString: string read GetAsJSONString write SetAsJSONString;
    property PrettyJSon: boolean read FPrettyJSON write FPrettyJSON;
  end;

  TPushDevice = class(TBaseJSON)
  private
    FUserId: Int64;
    FDeviceId: string;
    FDeviceToken: string;
    FDeviceModel: string;
    FOSName: string;
    FOSVer: string;
    FAppVer: string;
    FReceivePush: string;
    //function GetAsJSONString: string;
    //procedure SetAsJSONString(const JSONString: string);
  public
    constructor Create; overload;
    constructor Create(AUserId: Int64; const ADeviceId, ADeviceToken, ADeviceModel, AOSName, AOSVer, AAppVer,
      AReceivePush: string); overload;
    //property AsJSONString: string read GetAsJSONString write SetAsJSONString;
    //property PrettyJSon: boolean read FPrettyJSON write FPrettyJSON;
  published
    property UserId: Int64 read FUserId write FUserId;
    property DeviceId: string read FDeviceId write FDeviceId;
    property DeviceToken: string read FDeviceToken write FDeviceToken;
    property DeviceModel: string read FDeviceModel write FDeviceModel;
    property OSName: string read FOSName write FOSName;
    property OSVer: string read FOSVer write FOSVer;
    property AppVer: string read FAppVer write FAppVer;
    property ReceivePush: string read FReceivePush write FReceivePush;
  end;

  function GetJSONStr(AJSON: TJSONValue; UsePrettyFormat: boolean = false): string;

implementation

function GetJSONStr(AJSON: TJSONValue; UsePrettyFormat: boolean = false): string;
begin
  if UsePrettyFormat then
    result:= REST.Json.TJSON.Format(AJSON)
  else
    result:= AJSON.ToJSON;
end;

{ TBaseJSON }
function TBaseJSON.GetAsJSONString: string;
var
  Ctx: TRTTIContext;
  RType: TRTTIType;
  Prop: TRTTIProperty;
  Obj: TJSONObject;                       
begin
  Obj:= TJSONObject.Create;
  Ctx:= TRTTIContext.Create;
  RType:= Ctx.GetType(Self.ClassType);
  for Prop in RType.GetProperties do
  if Prop.Visibility = TMemberVisibility.mvPublished then
  begin
    case Prop.PropertyType.TypeKind of
      TTypeKind.tkInteger,
      TTypeKind.tkInt64    : Obj.AddPair(Prop.Name, TJSONNumber.Create(Prop.GetValue(Self).AsInteger));
      TTypeKind.tkFloat    : Obj.AddPair(Prop.Name, TJSONNumber.Create(Prop.GetValue(Self).AsExtended));
      TTypeKind.tkChar,
      TTypeKind.tkWChar,
      TTypeKind.tkString,
      TTypeKind.tkWString,
      TTypeKind.tkUString,
      TTypeKind.tkVariant  : Obj.AddPair(Prop.Name, Prop.GetValue(Self).AsString);
    end;
  end;
  Result:= GetJSONStr(Obj, FPrettyJSON);
end;

procedure TBaseJSON.SetAsJSONString(const AJSONString: string);
var
  Ctx: TRTTIContext;
  RType: TRTTIType;
  Prop: TRTTIProperty;
  Obj: TJSONObject;
  IntValue: int64;
  FltValue: extended;
  StrValue: string;
begin
  Obj:= TJSONObject.Create;
  try
    if Obj.Parse(BytesOf(AJSONString), 0) > -1 then
    begin
      Ctx:= TRTTIContext.Create;
      RType:= Ctx.GetType(Self.ClassType);
      for Prop in RType.GetProperties do
      if Prop.Visibility = TMemberVisibility.mvPublished then
      begin
        case Prop.PropertyType.TypeKind of
          TTypeKind.tkInteger,
          TTypeKind.tkInt64    : if Obj.TryGetValue(Prop.Name, IntValue) then
                                   Prop.SetValue(Self, IntValue);
          TTypeKind.tkFloat    : if Obj.TryGetValue(Prop.Name, FltValue) then
                                   Prop.SetValue(Self, FltValue);
          TTypeKind.tkChar,
          TTypeKind.tkWChar,
          TTypeKind.tkString,
          TTypeKind.tkWString,
          TTypeKind.tkUString,
          TTypeKind.tkVariant  : if Obj.TryGetValue(Prop.Name, StrValue) then
                                   Prop.SetValue(Self, StrValue);
        end;
        
      end;
    end;
  finally
    Obj.Free;
  end;
end;

{ TServiceRequest }
constructor TServiceRequest.Create;
begin
  FVer:= Current_Service_Request_Ver;
end;

function TServiceRequest.GetFId: string;
begin
  result:= Self.ClassName;
end;

{function TServiceRequest.GetAsJSONString: string;
var
  j : TJSONObject;
begin
  j:= TJSONObject.Create;
  try
    j.AddPair('id', Id);
    j.AddPair('ver', FVer);
    j.AddPair('data', FData);
    result:= GetJSONStr(j, FPrettyJSON);
  finally
    j.Free;
  end;
end;


procedure TServiceRequest.SetAsJSONString(const AJSONString: string);
var
  Root: TJSONObject;
  Value: string;
begin
  Root:= TJSONObject.Create;
  try
    if Root.Parse(BytesOf(AJSONString), 0) > -1 then
    begin
      if Root.TryGetValue('id', Value) then
      begin
        if not Value.Equals(Self.ClassName) then
          raise Exception.Create('Invalid class');
      end;
      if Root.TryGetValue('ver', Value) then
        FVer:= Value;
      if Root.TryGetValue('data', Value) then
        FData:= Value;
    end;
  finally
    Root.Free;
  end;
end;
}

{ TServiceResponse }
constructor TServiceResponse.Create;
begin
  FCode:= TServiceResponseCode.rcUnknown;
end;

constructor TServiceResponse.Create(ACode: TServiceResponseCode; AMsg, AData: String);
begin
  Create;
  FCode:= ACode;
  FMsg:= AMsg;
  FData:= AData;
end;

{function TServiceResponse.GetAsJSONString: string;
var
  j: TJSONObject;
begin
  j:= TJSONObject.Create;
  try
    j.AddPair('Code', FCode.ToString);
    j.AddPair('Msg', FMSg);
    j.AddPair('Data', FData);
    result:= GetJSONStr(j, FPrettyJSON);
  finally
    j.Free;
  end;
end;

procedure TServiceResponse.SetAsJSONString(const JSONString: string);
var
  j: TJSONObject;
  Value: string;
begin
  j:= TJSONObject.ParseJSONValue(BytesOf(JSONString), 0) as TJSONObject;
  if assigned(j) then
  try
    if j.TryGetValue<String>('Code', Value) then
      FCode:= TServiceResponseCode.Parse(Value);
    if j.TryGetValue<String>('Msg', Value) then
      FMsg:= Value;
    if j.TryGetValue<String>('Data', Value) then
      FData:= Value;
  finally
    j.Free;
  end;
end;}

{ TPushDevice }
constructor TPushDevice.Create(AUserId: Int64; const ADeviceId, ADeviceToken, ADeviceModel, AOSName, AOSVer, AAppVer,
      AReceivePush: string);
begin
  inherited Create;
  FUserId:= AUserId;
  FDeviceId:= ADeviceId;
  FDeviceToken:= ADeviceToken;
  FDeviceModel:= ADeviceModel;
  FOSName:= AOSName;
  FOSVer:= AOSVer;
  FAppVer:= AAppVer;
  FReceivePush:= AReceivePush;
end;

constructor TPushDevice.Create;
begin
  inherited Create;
end;

{function TPushDevice.GetAsJSONString: string;
var
  j: TJSONObject;
begin
  j:= TJSONObject.Create;
  try
    j.AddPair('UserId', FUserId);
    j.AddPair('DeviceId', FDeviceId);
    j.AddPair('DeviceToken', FDeviceToken);
    j.AddPair('DeviceModel', FDeviceModel);
    j.AddPair('OSName', FOSName);
    j.AddPair('OSVer', FOSVer);
    j.AddPair('AppVer', FAppVer);
    j.AddPair('ReceivePush', FReceivePush);
    result:= GetJSONStr(j, FPrettyJSON);
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
    if j.TryGetValue<String>('UserId', Value) then
      FUserId:= Value;
    if j.TryGetValue<String>('DeviceId', Value) then
      FDeviceId:= Value;
    if j.TryGetValue<String>('DeviceToken', Value) then
      FDeviceToken:= Value;
    if j.TryGetValue<String>('DeviceModel', Value) then
      FDeviceModel:= Value;
    if j.TryGetValue<String>('OSName', Value) then
      FOSName:= Value;
    if j.TryGetValue<String>('OSVer', Value) then
      FOSVer:= Value;
    if j.TryGetValue<String>('AppVer', Value) then
      FAppVer:= Value;
    if j.TryGetValue<String>('ReceivePush', Value) then
      FReceivePush:= Value;
  finally
    j.Free;
  end;
end;}

{ TServiceResponseCodeHelper }
function TServiceResponseCodeHelper.ToString: string;
begin
  result:= TServiceResponseCodeStr[Self];
end;

constructor TServiceResponseCodeHelper.Parse(const Value: string);
var
  i: TServiceResponseCode;
begin
  Self:= rcError;
  for i:= Low(TServiceResponseCode) to High(TServiceResponseCode) do
    if (TServiceResponseCodeStr[i].Equals(Value)) then
    begin
      Self:= TServiceResponseCode(i);
      break;
    end;
end;

{ TPushMessage }
function TPushMessage.GetAsJSONString: string;
var
  j: TJSONObject;
begin
  j:= TJSONObject.Create;
  try
    j.AddPair('MsgType', FMsgType);
    j.AddPair('Msg', FMsg);
    result:= GetJSONStr(j, FPrettyJSON);
  finally
    j.Free;
  end;
end;

procedure TPushMessage.SetAsJSONString(const JSONString: string);
var
  j: TJSONObject;
  Value: string;
begin
  j:= TJSONObject.ParseJSONValue(BytesOf(JSONString), 0) as TJSONObject;
  if assigned(j) then
  try
    if j.TryGetValue<String>('MsgType', Value) then
      FMsgType:= Value;
    if j.TryGetValue<String>('Msg', Value) then
      FMsg:= Value;
  finally
    j.Free;
  end;
end;

{ TPushMessageTypeHelper }
constructor TPushMessageTypeHelper.Parse(const Value: string);
var
  i: TPushMessageType;
begin
  Self:= mtUnknown;
  for i:= Low(TPushMessageType) to High(TPushMessageType) do
    if (TPushMessageTypeStr[i].Equals(Value)) then
    begin
      Self:= TPushMessageType(i);
      break;
    end;
end;

function TPushMessageTypeHelper.ToString: string;
begin
  result:= TPushMessageTypeStr[Self];
end;

end.
