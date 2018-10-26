unit uGoogleMapsClass;

interface
  uses Generics.Collections;

type
  TDistance = class
  private
    FText: String;
    FValue: Double;
  published
    property Text: String read FText write FText;
    property Value: Double read FValue write FValue;
  end;

  TDuration = class
  private
    FValue: Double;
    FText: String;
  published
    property Text: String read FText write FText;
    property Value: Double read FValue write FValue;
  end;
  
  TLatLng = class
  private
    FXa: Double;
    FYa: Double;
  published
    property Xa: Double read FXa write FXa;
    property Ya: Double read FYa write FYa;
  end;       
    
  TDirectionsStep = class
  private
    FDistance: TDistance;
    FDuration: TDuration;
    FPath: TObjectList<TLatLng>;
    FTravelMode: string;
    FStartLocation: TLatLng;
    FInstructions: string;
    FEndLocation: TLatLng;
  published
    constructor Create;
    destructor Destroy; override;
    property Distance: TDistance read FDistance write FDistance;
    property Duration: TDuration read FDuration write FDuration;
    property EndLocation: TLatLng read FEndLocation write FEndLocation;
    property Instructions: string read FInstructions write FInstructions;
    property StartLocation: TLatLng read FStartLocation write FStartLocation;
    property Path: TObjectList<TLatLng> read FPath write FPath;
    property TravelMode : string read FTravelMode write FTravelMode;
  end;
  
  TDirectionsLeg = class
  private
    FDistance: TDistance;
    FDepartureTime: TDuration;
    FStartAddress: string;
    FDuration: TDuration;
    FSteps: TObjectList<TDirectionsStep>;
    FStartLocation: TLatLng;
    FViaWaypoints: TObjectList<TLatLng>;
    FEndAddress: string;
    FArrivalTime: TDistance;
    FEndLocation: TLatLng;
  published
    constructor Create;
    destructor Destroy; override;
    property ArrivalTime: TDistance read FArrivalTime write FArrivalTime;
    property DepartureTime: TDuration read FDepartureTime write FDepartureTime;
    property Distance: TDistance read FDistance write FDistance;
    property Duration: TDuration read FDuration write FDuration;
    property EndAddress: string read FEndAddress write FEndAddress;
    property EndLocation: TLatLng read FEndLocation write FEndLocation;
    property StartAddress: string read FStartAddress write FStartAddress;
    property StartLocation: TLatLng read FStartLocation write FStartLocation;
    property Steps: TObjectList<TDirectionsStep> read FSteps write FSteps;
    property ViaWaypoints: TObjectList<TLatLng> read FViaWaypoints write FViaWaypoints;
  end;

  TDirectionsRoute = class
  private
    FLegs : TObjectList<TDirectionsLeg>;
  public
    constructor Create;
    destructor Destroy; override;
    property Legs: TObjectList<TDirectionsLeg> read FLegs write FLegs;
  end;



implementation


{ TDirectionsRoute }

constructor TDirectionsRoute.Create;
begin
  FLegs := TObjectList<TDirectionsLeg>.Create;
end;

destructor TDirectionsRoute.Destroy;
begin
  FLegs.Free;
  inherited;
end;

{ TDirectionsLeg }

constructor TDirectionsLeg.Create;
begin
  FDistance     := TDistance.Create;
  FDepartureTime:= TDuration.Create;
  FDuration     := TDuration.Create;
  FStartLocation:= TLatLng.Create;
  FArrivalTime  := TDistance.Create;
  FEndLocation  := TLatLng.Create;
  FSteps        := TObjectList<TDirectionsStep>.Create;
  FViaWaypoints := TObjectList<TLatLng>.Create;
end;

destructor TDirectionsLeg.Destroy;
begin
  FDistance.Free;
  FDepartureTime.Free;
  FDuration.Free;
  FStartLocation.Free;
  FArrivalTime.Free;
  FEndLocation.Free;
  FSteps.Free;
  FViaWaypoints.Free;
  inherited;
end;

{ TDirectionsStep }

constructor TDirectionsStep.Create;
begin
  FDistance     := TDistance.Create;
  FDuration     := TDuration.Create;
  FPath         := TObjectList<TLatLng>.Create;
  FStartLocation:= TLatLng.Create;
  FEndLocation  := TLatLng.Create;
end;

destructor TDirectionsStep.Destroy;
begin
  FDistance.Free;
  FDuration.Free;
  FPath.Free;
  FStartLocation.Free;
  FEndLocation.Free;
  inherited;
end;

end.
