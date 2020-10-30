unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Beacon, System.Beacon.Components,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, System.ImageList, FMX.ImgList, FMX.TabControl, System.Bluetooth;

type
  TForm3 = class(TForm)
    Beacon1: TBeacon;
    ListView1: TListView;
    ToolBar1: TToolBar;
    Label1: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ImageList1: TImageList;
    Glyph1: TGlyph;
    Switch1: TSwitch;
    procedure Beacon1BeaconEnter(const Sender: TObject; const ABeacon: IBeacon;
      const CurrentBeaconList: TBeaconList);
    procedure FormCreate(Sender: TObject);
    procedure Beacon1BeaconExit(const Sender: TObject; const ABeacon: IBeacon;
      const CurrentBeaconList: TBeaconList);
    procedure Beacon1BeaconProximity(const Sender: TObject; const ABeacon: IBeacon;
      Proximity: TBeaconProximity);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure Beacon1CalculateDistances(const Sender: TObject; const ABeacon: IBeacon; ATxPower,
      ARssi: Integer; var NewDistance: Double);
  private
    { Private declarations }
    FLock: TObject;
    FListaBeacon: TBeaconList;
    procedure AtualizarLista(const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  FMX.MultiResBitmap, Math;

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TForm3.AtualizarLista(const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
var
  LItem: TListViewItem;
  I: Integer;
begin
  ListView1.Items.Clear();
  TMonitor.Enter(FLock);
  try
    FListaBeacon := CurrentBeaconList;
  finally
    TMonitor.Exit(FLock);
  end;
  for I := Low(FListaBeacon) to High(FListaBeacon) do
  begin
    LItem := ListView1.Items.Add;
    LItem.Text := FListaBeacon[I].Guid.ToString();
     LItem.Detail := 'Major: ' + FListaBeacon[I].Major.ToString + ' Minor: ' + FListaBeacon[I].Minor.ToString +
     ' time :' + TimeToStr(now);
  end;
end;

procedure TForm3.Beacon1BeaconEnter(const Sender: TObject; const ABeacon: IBeacon;
  const CurrentBeaconList: TBeaconList);
begin
  AtualizarLista(ABeacon, CurrentBeaconList);
end;

procedure TForm3.Beacon1BeaconExit(const Sender: TObject; const ABeacon: IBeacon;
  const CurrentBeaconList: TBeaconList);
begin
  AtualizarLista(ABeacon, CurrentBeaconList);
end;

procedure TForm3.Beacon1BeaconProximity(const Sender: TObject; const ABeacon: IBeacon;
  Proximity: TBeaconProximity);
var
 D: Double;
begin
  if Switch1.IsChecked then
  begin
    D := ABeacon.Distance;
    if (D >= 0) and (D < 2) then
    begin
      case ABeacon.Minor of
        15567:
          Glyph1.ImageIndex := 1;
        15235:
          Glyph1.ImageIndex := 2;
      end;
      TabControl1.ActiveTab := TabItem2;
    end;
  end;
end;

procedure TForm3.Beacon1CalculateDistances(const Sender: TObject; const ABeacon: IBeacon; ATxPower,
  ARssi: Integer; var NewDistance: Double);
begin
  NewDistance := 2;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  FLock := TObject.Create();
end;

procedure TForm3.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
  begin
    if TabControl1.ActiveTab = TabItem2 then
    begin
      TabControl1.ActiveTab := TabItem1;
      Key := 0;
    end;
  end;
end;

end.
{
var
  RatioDB: Integer;
  RatioLinear: Double;
  Dist: Double;
begin
  if Switch1.IsChecked then
  begin
    RatioDB := -89 - ARssi;
    RatioLinear := Power(10, RatioDB / 10);
    Dist := Sqrt(RatioLinear);
    NewDistance := Dist;
  end;
}
