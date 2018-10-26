unit Lib.Persistent.Helpers;
interface
uses System.Classes, System.SysUtils, System.JSON, REST.JSON, System.Rtti, System.TypInfo;

type
  TPublishedProperties2JSONHelper = class
  protected
    function GetAsJSONObject: TJSONObject;
    procedure SetAsJSONObject(AJSONObject: TJSONObject);
    function GetAsJSONString: string;
    procedure SetAsJSONString(const AJSONString: string);
  public
    property AsJSONObject: TJSONObject read GetAsJSONObject;
    property AsJSONString: string read GetAsJSONString write SetAsJSONString;
  end;

implementation

function GetJSONStr(AJSON: TJSONValue; UsePrettyFormat: boolean = false): string;
begin
  if UsePrettyFormat then
    result:= REST.Json.TJSON.Format(AJSON)
  else
    result:= AJSON.ToJSON;
end;

{ TBaseJSON }
function TPublishedProperties2JSONHelper.GetAsJSONObject: TJSONObject;
var
  Ctx: TRTTIContext;
  RType: TRTTIType;
  Prop: TRTTIProperty;
begin
  result:= TJSONObject.Create;
  Ctx:= TRTTIContext.Create;
  RType:= Ctx.GetType(Self.ClassType);
  for Prop in RType.GetProperties do
  if Prop.Visibility = TMemberVisibility.mvPublished then
    result.AddPair(Prop.Name, Prop.GetValue(Self).AsString);
end;

procedure TPublishedProperties2JSONHelper.SetAsJSONObject(AJSONObject: TJSONObject);
var
  Ctx: TRTTIContext;
  RType: TRTTIType;
  Prop: TRTTIProperty;
  Value: string;
begin
  Ctx:= TRTTIContext.Create;
  RType:= Ctx.GetType(Self.ClassType);
  for Prop in RType.GetProperties do
  if Prop.Visibility = TMemberVisibility.mvPublished then
    if AJSONObject.TryGetValue(Prop.Name, Value) then
      Prop.SetValue(Self, Value);
end;

function TPublishedProperties2JSONHelper.GetAsJSONString: string;
begin
  result:= REST.Json.TJSON.Format(GetAsJSONObject);
end;

procedure TPublishedProperties2JSONHelper.SetAsJSONString(const AJSONString: string);
var
  Obj: TJSONObject;
begin
  Obj:= TJSONObject.Create;
  try
    if Obj.Parse(BytesOf(AJSONString), 0) > -1 then
      SetAsJSONObject(Obj);
  finally
    Obj.Free;
  end;
end;


end.
