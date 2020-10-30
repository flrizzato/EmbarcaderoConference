// ---------------------------------------------------------------------------

// This software is Copyright (c) 2015 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of an Embarcadero developer tools product.
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

// ---------------------------------------------------------------------------

unit LocationDemoUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Objects, FMX.StdCtrls,
  FMX.ListBox, FMX.Layouts, FMX.WebBrowser, System.Sensors,
  System.Sensors.Components, FMX.MultiView, FMX.Controls.Presentation, FMX.Maps;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    Switch1: TSwitch;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItemLatitude: TListBoxItem;
    ListBoxItemLongitude: TListBoxItem;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxItemAdminArea: TListBoxItem;
    ListBoxItemCountryCode: TListBoxItem;
    ListBoxItemCountryName: TListBoxItem;
    ListBoxItemFeatureName: TListBoxItem;
    ListBoxItemLocality: TListBoxItem;
    ListBoxItemPostalCode: TListBoxItem;
    ListBoxItemSubAdminArea: TListBoxItem;
    ListBoxItemSubLocality: TListBoxItem;
    ListBoxItemSubThoroughfare: TListBoxItem;
    ListBoxItemThoroughfare: TListBoxItem;
    Label1: TLabel;
    LocationSensor1: TLocationSensor;
    MultiView1: TMultiView;
    ToolBar1: TToolBar;
    Button1: TButton;
    ToolBar2: TToolBar;
    Button2: TButton;
    Layout1: TLayout;
    MapView1: TMapView;
    BitmapSource: TImage;
    procedure LocationSensor1LocationChanged(Sender: TObject;
      const OldLocation, NewLocation: TLocationCoord2D);
    procedure Switch1Switch(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure MapView1MarkerClick(Marker: TMapMarker);
  private const
    Accuracy = 0.0005;
  private
    { Private declarations }
    FGeocoder: TGeocoder;
    FCurrentPosition: TLocationCoord2D;
    procedure OnGeocodeReverseEvent(const Address: TCivicAddress);
  public
    { Public declarations }
  end;

  TLocationCoord2DHelper = record helper for TLocationCoord2D
    function Distance(const NewCoord: TLocationCoord2D): Double;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Switch1Switch(Sender: TObject);
begin
  LocationSensor1.Active := Switch1.IsChecked;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  MultiView1.HideMaster;
end;

procedure TForm1.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
var
  URLString: String;
  LSettings: TFormatSettings;
  LDecSeparator: Char;
  Desqr: TMapMarkerDescriptor;
  MyLocation: TMapCoordinate;
begin
  LDecSeparator := FormatSettings.DecimalSeparator;
  LSettings := FormatSettings;
  try
    FormatSettings.DecimalSeparator := '.';
    // Show current location
    ListBoxItemLatitude.ItemData.Detail :=
      Format('%2.6f', [NewLocation.Latitude]);
    ListBoxItemLongitude.ItemData.Detail :=
      Format('%2.6f', [NewLocation.Longitude]);

    // Show Map using Google Maps
    URLString := Format('https://maps.google.com/maps?q=%2.6f,%2.6f',
      [NewLocation.Latitude, NewLocation.Longitude]);
  finally
    FormatSettings.DecimalSeparator := LDecSeparator;
  end;

  MyLocation := TMapCoordinate.Create(NewLocation.Latitude,
    NewLocation.Longitude);
  MapView1.Location := MyLocation;

  // Setup an instance of TGeocoder
  try
    if not Assigned(FGeocoder) then
    begin
      if Assigned(TGeocoder.Current) then
        FGeocoder := TGeocoder.Current.Create;
      if Assigned(FGeocoder) then
        FGeocoder.OnGeocodeReverse := OnGeocodeReverseEvent;
    end;
  except
    ListBoxGroupHeader1.Text := 'Geocoder service error.';
  end;

  // Translate location to address
  if Assigned(FGeocoder) and not FGeocoder.Geocoding then
    FGeocoder.GeocodeReverse(NewLocation);

  if FCurrentPosition.Distance(NewLocation) > Accuracy then
  begin
    FCurrentPosition := NewLocation;
    Desqr := TMapMarkerDescriptor.Create(MyLocation, 'Dropped marker');
    Desqr.Icon := BitmapSource.Bitmap;
    Desqr.Draggable := True;
    MapView1.AddMarker(Desqr);
    MapView1.Zoom := 15;
  end;
end;

procedure TForm1.MapView1MarkerClick(Marker: TMapMarker);
begin
  Marker.DisposeOf;
end;

procedure TForm1.OnGeocodeReverseEvent(const Address: TCivicAddress);
begin
  ListBoxItemAdminArea.ItemData.Detail := Address.AdminArea;
  ListBoxItemCountryCode.ItemData.Detail := Address.CountryCode;
  ListBoxItemCountryName.ItemData.Detail := Address.CountryName;
  ListBoxItemFeatureName.ItemData.Detail := Address.FeatureName;
  ListBoxItemLocality.ItemData.Detail := Address.Locality;
  ListBoxItemPostalCode.ItemData.Detail := Address.PostalCode;
  ListBoxItemSubAdminArea.ItemData.Detail := Address.SubAdminArea;
  ListBoxItemSubLocality.ItemData.Detail := Address.SubLocality;
  ListBoxItemSubThoroughfare.ItemData.Detail := Address.SubThoroughfare;
  ListBoxItemThoroughfare.ItemData.Detail := Address.Thoroughfare;
end;

{ TLocationCoord2DHelper }

function TLocationCoord2DHelper.Distance(const NewCoord
  : TLocationCoord2D): Double;
begin
  Result := Sqrt(Sqr(Abs(Self.Latitude - NewCoord.Latitude)) +
    Sqr(Abs(Self.Longitude - NewCoord.Longitude)));
end;

end.
