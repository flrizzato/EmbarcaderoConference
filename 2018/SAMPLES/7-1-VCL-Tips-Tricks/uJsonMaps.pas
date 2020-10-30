unit uJsonMaps;

interface
uses System.JSON, System.SysUtils, System.Classes, uGoogleMapsClass, Vcl.Dialogs, Generics.Collections;

type
  TJsonMaps = class
  private
    FJson : TJSONObject;
    FStringList : TStringList;
    FDirectionsRoute: TDirectionsRoute;
    procedure MapearJSONArray(pJSONArray: TJSONArray; pPropAnterior: string = '');
    procedure MapearJSONObject(pJSONObject: TJSONObject; pPropAnterior: string = '');
    function MapearJSONString(pJSONString: TJSONString; pPropAnterior: string = '') : string;
    procedure JsonToDistance(pJSONObject: TJSONObject; lDistance: TDistance);
    procedure JsonToDuration(pJSONObject: TJSONObject; lDuration: TDuration);
    procedure JsonToLatLng(pJSONObject: TJSONObject; lLatLng: TLatLng);
    function JsonToDirectionsLeg(pJSONValue: TJSONValue): TDirectionsLeg;
    function JsonToDirectionsStep(pJSONValue: TJSONValue): TDirectionsStep;
    procedure JsonToLatLngs(pJsonValue: TJsonValue; pLatLngs: TObjectList<TLatLng>);
  public
    constructor Create;
    destructor Destroy; override;
    function CaregarJson(pJson: string) : string;
    procedure MontarInformacoesDeRota(pJson: string);
    property DirectionsRoute: TDirectionsRoute read FDirectionsRoute;
  end;

   
  
implementation



{ TJsonMaps }

function TJsonMaps.CaregarJson(pJson: string) : string;
var
  li: Integer;
  lJSONPair: TJSONPair;
  ljsRoutes: TJSONArray;
  ljsValue: TJSONValue;
begin
  Result := '';
  FStringList.Clear;
  FJson := TJSONObject(TJSONObject.ParseJSONValue(pJson));
  if FJson <> nil then
  begin
    MapearJSONObject(FJson,'Rota');
    Result := FStringList.Text;
  end;

end;

function TJsonMaps.MapearJSONString(pJSONString: TJSONString; pPropAnterior: string = '') : string;
begin
  Result := pPropAnterior+StringReplace(pJSONString.value,'"','',[rfReplaceAll]);
end;

constructor TJsonMaps.Create;
begin
  FStringList := TStringList.Create;
  FDirectionsRoute:= TDirectionsRoute.Create;
end;

procedure TJsonMaps.MontarInformacoesDeRota(pJson: string);
var
  lDirectionsLeg: TDirectionsLeg;
  liRoutes, li, liLegs, lx, liPropLegs: Integer;
  FJson: TJSONObject;
  lJSONPair: TJSONPair;
  lJSONArrayRoutes,lJSONArrayLegs: TJSONArray;
  lJSONValue: TJSONValue;
begin
  FJson := TJSONObject(TJSONObject.ParseJSONValue(pJson));
  if FJson <> nil then
  begin
    FDirectionsRoute.Legs.Clear;
    for liRoutes := 0 to FJson.Count - 1 do
    begin
      lJSONPair := FJson.Get(liRoutes);
      if lJSONPair.JsonString.Value = 'routes' then
      begin
        lJSONArrayRoutes := TJSONArray(lJSONPair.JsonValue);
        for li := 0 to lJSONArrayRoutes.Count - 1 do
        begin
          lJSONValue := lJSONArrayRoutes.Get(li);
          if lJSONValue is TJSONObject then
          begin
            for liLegs := 0 to TJSONObject(lJSONValue).Count - 1 do
            begin
              lJSONPair := TJSONObject(lJSONValue).Get(liLegs);
              if lJSONPair.JsonString.Value = 'legs' then
              begin
                lJSONArrayLegs := TJSONArray(lJSONPair.JsonValue);
                for lx := 0 to lJSONArrayLegs.Count - 1 do
                begin
                  lJSONValue := lJSONArrayLegs.Get(lx);
                  if lJSONValue is TJSONObject then
                  begin
                    lDirectionsLeg := JsonToDirectionsLeg(lJSONValue);
                    FDirectionsRoute.Legs.Add(lDirectionsLeg);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TJsonMaps.JsonToDirectionsLeg(pJSONValue: TJSONValue): TDirectionsLeg;
var
  li, lx: Integer;
  lJSONPair: TJSONPair;
  lDirectionsStep: TDirectionsStep;
  lJSONArraySteps : TJSONArray;
  lJSONValue : TJSONValue;
begin
  Result:= TDirectionsLeg.Create;
  for li := 0 to TJSONObject(pJSONValue).Count - 1 do
  begin
    lJSONPair := TJSONObject(pJSONValue).Get(li);
    if lJSONPair.JsonString.Value = 'distance' then
    begin
      JsonToDistance(TJSONObject(lJSONPair.JsonValue),Result.Distance);
    end;
    if lJSONPair.JsonString.Value = 'duration' then
    begin
      JsonToDuration(TJSONObject(lJSONPair.JsonValue),Result.Duration);
    end;
    if lJSONPair.JsonString.Value = 'end_address' then
    begin
      Result.EndAddress := TJSONObject(lJSONPair.JsonValue).Value;
    end;
    if lJSONPair.JsonString.Value = 'start_address' then
    begin
      Result.StartAddress := TJSONObject(lJSONPair.JsonValue).Value;
    end;
    if lJSONPair.JsonString.Value = 'start_location' then
    begin
      JsonToLatLng(TJSONObject(lJSONPair.JsonValue),Result.StartLocation);
    end;
    if lJSONPair.JsonString.Value = 'end_location' then
    begin
      JsonToLatLng(TJSONObject(lJSONPair.JsonValue),Result.EndLocation);
    end;

    if lJSONPair.JsonString.Value = 'steps' then
    begin
      lJSONArraySteps := TJSONArray(lJSONPair.JsonValue);
      for lx := 0 to lJSONArraySteps.Count - 1 do
      begin
        lJSONValue := lJSONArraySteps.Get(lx);
        if lJSONValue is TJSONObject then
        begin
          lDirectionsStep := JsonToDirectionsStep(lJSONValue);
          Result.Steps.Add(lDirectionsStep);
        end;
      end;
    end;

    if lJSONPair.JsonString.Value = 'via_waypoint' then
    begin
      JsonToLatLngs(lJSONPair.JsonValue,Result.ViaWaypoints);
    end;
  end;
end;

function TJsonMaps.JsonToDirectionsStep(pJSONValue: TJSONValue): TDirectionsStep;
var
  li, lx: Integer;
  lJSONPair: TJSONPair;
  lJSONArrayPath : TJSONArray;
  lJSONValue : TJSONValue;
  lLatLng : TLatLng;
begin
  Result:= TDirectionsStep.Create;
  for li := 0 to TJSONObject(pJSONValue).Count - 1 do
  begin
    lJSONPair := TJSONObject(pJSONValue).Get(li);

    if lJSONPair.JsonString.Value = 'distance' then
    begin
      JsonToDistance(TJSONObject(lJSONPair.JsonValue),Result.Distance);
    end;
    if lJSONPair.JsonString.Value = 'duration' then
    begin
      JsonToDuration(TJSONObject(lJSONPair.JsonValue),Result.Duration);
    end;
    if lJSONPair.JsonString.Value = 'start_location' then
    begin
      JsonToLatLng(TJSONObject(lJSONPair.JsonValue),Result.StartLocation);
    end;
    if lJSONPair.JsonString.Value = 'end_location' then
    begin
      JsonToLatLng(TJSONObject(lJSONPair.JsonValue),Result.EndLocation);
    end;
    if lJSONPair.JsonString.Value = 'travel_mode' then
    begin
      Result.TravelMode := lJSONPair.JsonValue.Value;
    end;
    if lJSONPair.JsonString.Value = 'instructions' then
    begin
      Result.Instructions := lJSONPair.JsonValue.Value;
    end;

    if lJSONPair.JsonString.Value = 'path' then
    begin
      JsonToLatLngs(lJSONPair.JsonValue,Result.Path);
    end;
  end;
end;

procedure TJsonMaps.JsonToLatLngs(pJsonValue : TJsonValue; pLatLngs : TObjectList<TLatLng>);
var
  lJSONArrayPath : TJSONArray;
  li: Integer;
  lJSONValue : TJSONValue;
  lLatLng : TLatLng;
begin
  lJSONArrayPath := TJSONArray(pJsonValue);
  for li := 0 to lJSONArrayPath.Count - 1 do
  begin
    lJSONValue := lJSONArrayPath.Get(li);
    if lJSONValue is TJSONObject then
    begin
      lLatLng := TLatLng.Create;
      JsonToLatLng(TJSONObject(lJSONValue),lLatLng);
      pLatLngs.Add(lLatLng);
    end;
  end;
end;


procedure TJsonMaps.JsonToDistance(pJSONObject : TJSONObject; lDistance : TDistance);
var
  li : integer;
  lJSONPair: TJSONPair;
begin
  for li := 0 to pJSONObject.Count - 1 do
  begin
    lJSONPair := pJSONObject.Get(li);
    if lJSONPair.JsonString.Value = 'text' then
    begin
      lDistance.Text := lJSONPair.JsonValue.Value;
    end;
    if lJSONPair.JsonString.Value = 'value' then
    begin
      lDistance.value := StrToIntDef(lJSONPair.JsonValue.Value,0);
    end;
  end;
end;

procedure TJsonMaps.JsonToDuration(pJSONObject : TJSONObject; lDuration : TDuration);
var
  li : integer;
  lJSONPair: TJSONPair;
begin
  for li := 0 to pJSONObject.Count - 1 do
  begin
    lJSONPair := pJSONObject.Get(li);
    if lJSONPair.JsonString.Value = 'text' then
    begin
      lDuration.Text := lJSONPair.JsonValue.Value;
    end;
    if lJSONPair.JsonString.Value = 'value' then
    begin
      lDuration.value := StrToIntDef(lJSONPair.JsonValue.Value,0);
    end;
  end;
end;

procedure TJsonMaps.JsonToLatLng(pJSONObject : TJSONObject; lLatLng : TLatLng);
var
  li : integer;
  lJSONPair: TJSONPair;
begin
  for li := 0 to pJSONObject.Count - 1 do
  begin
    lJSONPair := pJSONObject.Get(li);
    if lJSONPair.JsonString.Value = 'Xa' then
    begin
      lLatLng.Xa := StrToIntDef(lJSONPair.JsonValue.Value,0);
    end;
    if lJSONPair.JsonString.Value = 'Ya' then
    begin
      lLatLng.Ya := StrToIntDef(lJSONPair.JsonValue.Value,0);
    end;
  end;
end;

destructor TJsonMaps.Destroy;
begin
  FStringList.Free;
  inherited;
end;

procedure TJsonMaps.MapearJSONArray(pJSONArray: TJSONArray; pPropAnterior: string = '');
var
  li: integer;
  lJSONValue: TJSONValue;
begin
  for li := 0 to pJSONArray.Count - 1 do begin
    lJSONValue := pJSONArray.Get(li);
    if lJSONValue is TJSONObject then
      MapearJSONObject(TJSONObject(lJSONValue),pPropAnterior+'['+IntToStr(li)+']');
  end;
end;

procedure TJsonMaps.MapearJSONObject(pJSONObject: TJSONObject;pPropAnterior: string = '');
var
  li: integer;
  lJSONPair: TJSONPair;
  lPropAnterior : string;
begin
  for li := 0 to pJSONObject.Count - 1 do
  begin
    lJSONPair := pJSONObject.Get(li);
    lPropAnterior := pPropAnterior+'.'+MapearJSONString(lJSONPair.JsonString);
    if lJSONPair.JsonValue is TJSONObject then
    begin
      MapearJSONObject(lJSONPair.JsonValue as TJSONObject, lPropAnterior);
    end else if lJSONPair.JsonValue is TJSONArray then
    begin
      MapearJSONArray(lJSONPair.JsonValue as TJSONArray, lPropAnterior);
    end else if lJSONPair.JsonValue is TJSONString then
    begin
      FStringList.Add(MapearJSONString(lJSONPair.JsonValue as TJSONString, lPropAnterior+'='));
    end;
  end;
end;

end.
