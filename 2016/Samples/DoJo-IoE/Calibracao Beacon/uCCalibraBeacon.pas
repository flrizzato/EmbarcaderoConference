unit uCCalibraBeacon;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Forms,
  FMX.Controls,
  System.Beacon,
  System.Bluetooth,
  System.Beacon.Components,
  System.Math;

type
  TOnCalibra = procedure(const Sender: TObject; ACalibrado: boolean) of object;

  TCalibrabeacon = class
    FBeacon: TBeacon;
    FRSSI: Double;
    FCount: integer;
    FOnCalibra: TOnCalibra;

    procedure onBeaconEnter(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);

  private
    function GettxCalibratedPower: Double;
    function GetCount: integer;
  public
    property txCalibratedPower: Double read GettxCalibratedPower;
    property RSSI: Double read FRSSI write FRSSI;
    property count: integer read GetCount;
    property onCalibra: TOnCalibra read FOnCalibra write FOnCalibra;

    constructor create(AUUID: string; AMinor: integer = -1; AMajor: integer = -1);
    procedure Calibra;
    function NovaDistancia(ARSSI: integer): Double;
  end;

implementation

{ TCalibrabeacon }

procedure TCalibrabeacon.Calibra;
begin
  FBeacon.Enabled := true;
  FBeacon.StartScan;
end;

constructor TCalibrabeacon.create(AUUID: string; AMinor, AMajor: integer);
var
  lBeaconRegionItem: TBeaconRegionItem;
begin

  FRSSI := 0;
  FCount := 0;

  FBeacon := TBeacon.create(nil);
  FBeacon.onBeaconEnter := onBeaconEnter;

  FBeacon.ModeExtended := [iBeacons, AltBeacons, Eddystones];
  FBeacon.SPC := 0.500000000000000000;

  lBeaconRegionItem := TBeaconRegionItem.create(nil);
  lBeaconRegionItem.UUID := AUUID;
  lBeaconRegionItem.EddyNamespace := '00000000000000000000';
  lBeaconRegionItem.EddyInstance := '000000000000';
  lBeaconRegionItem.IDManufacturer := '-1';
  lBeaconRegionItem.Major := AMajor;
  lBeaconRegionItem.Minor := AMinor;

  FBeacon.MonitorizedRegions.Add.Assign(lBeaconRegionItem);

end;

function TCalibrabeacon.GetCount: integer;
begin
  Application.ProcessMessages;
  result := FCount;
end;

function TCalibrabeacon.GettxCalibratedPower: Double;
begin
  result := (FRSSI / 10);
end;

function TCalibrabeacon.NovaDistancia(ARSSI: integer): Double;
var
  ratio_db: Double;
  ratio_linear: Double;
begin
  ratio_db := txCalibratedPower - ARSSI;
  ratio_linear := Power(10, ratio_db / 10);
  result := sqrt(ratio_linear);
end;

procedure TCalibrabeacon.onBeaconEnter(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
begin
  if FCount <= 10 then
  begin
    FRSSI := FRSSI + ABeacon.RSSI;
    Inc(FCount);
    FBeacon.StartScan;
  end
  else
  begin
    FBeacon.Enabled := false;
  end;

  if Assigned(FOnCalibra) then
    onCalibra(Self, FBeacon.Enabled = false);
end;

end.
