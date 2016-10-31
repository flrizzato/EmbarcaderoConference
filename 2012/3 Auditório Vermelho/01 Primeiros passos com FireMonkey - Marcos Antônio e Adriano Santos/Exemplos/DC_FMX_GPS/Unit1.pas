
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Unit1;

interface

uses
  SysUtils, Types, UITypes, Classes, Variants, FMX_Types, FMX_Controls, FMX_Forms,
  FMX_Dialogs, FMX_Objects, FMX_Effects, FMX_Types3D, FMX_Layers3D, Location;

type
  TForm1 = class(TForm)
    Latitude: TLabel;
    Longitude: TLabel;
    Altitude: TLabel;
    Compass: TCircle;
    SelectionPoint1: TSelectionPoint;
    CompassLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    iOSLocation1: TiOSLocation;
    procedure iOSLocation1UpdateHeading(HeadingData: THeadingData);
    procedure iOSLocation1UpdateLocation(LocationData: TLocationData);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

// 37 3'45.88'' N 122 0'26.66'' W (my office)
function CoordPartToStr(CoordPart: Double) : String;
var
  Degrees, Minutes, Seconds : Double;
begin
  CoordPart := Abs(CoordPart);
  Degrees := Trunc(CoordPart);
  CoordPart := 60*(CoordPart-Degrees);
  Minutes := Trunc(CoordPart);
  CoordPart := 60*(CoordPart-Minutes);
  Seconds := Trunc(CoordPart*100)/100;
  Result := FloatToStr(Degrees)+' '+FloatToStr(Minutes)+''''+FloatToStr(Seconds)+''''' ';
end;

function LatitudeToStr(Latitude: Double) : String;
begin
  if Latitude < 0 then
    Result := CoordPartToStr(Latitude)+'S'
  else
    Result := CoordPartToStr(Latitude)+'N';
end;

function LongitudeToStr(Longitude: Double) : String;
begin
  if Longitude < 0 then
    Result := CoordPartToStr(Longitude)+'W'
  else
    Result := CoordPartToStr(Longitude)+'E';
end;

procedure TForm1.iOSLocation1UpdateHeading(HeadingData: THeadingData);
begin
  Form1.CompassLabel.Text := IntToStr(Round(HeadingData.MagneticHeading));
  Form1.Compass.RotationAngle := -HeadingData.MagneticHeading;
end;

procedure TForm1.iOSLocation1UpdateLocation(LocationData: TLocationData);
begin
  Form1.Latitude.Text := LatitudeToStr(LocationData.Latitude);
  Form1.Longitude.Text := LongitudeToStr(LocationData.Longitude);
  Form1.Altitude.Text := IntToStr(Round(LocationData.Altitude/0.3048))+' ft';
end;

end.

