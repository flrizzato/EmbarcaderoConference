unit lPushData;
interface
uses System.SysUtils, System.JSON, REST.JSON, System.Rtti, System.TypInfo;

type
  TBaseJSON = class
  protected
    FPrettyJSON: boolean;
    function GetAsJSONString: string; virtual;
    procedure SetAsJSONString(const AJSONString: string); virtual;
  public
    property AsJSONString: string read GetAsJSONString write SetAsJSONString;
    property PrettyJSON: boolean read FPrettyJSON write FPrettyJSON;
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

end.
