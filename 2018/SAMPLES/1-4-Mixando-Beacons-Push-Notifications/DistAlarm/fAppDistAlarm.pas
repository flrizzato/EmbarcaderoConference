unit fAppDistAlarm;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Beacon, System.Bluetooth, System.Beacon.Components,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, System.Android.Service, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.EditBox, FMX.SpinBox, FMX.Layouts, FMX.ListView,
  System.Generics.Collections, BeaconAlarmService, FMX.Colors, ccPush,
  DateUtils, Datasnap.DSClientRest, FMX.ScrollBox, FMX.Memo;

type
  TfrmAppDistAlarm = class(TForm)
    Beacon1: TBeacon;
    lstBeacons: TListView;
    Layout1: TLayout;
    Label1: TLabel;
    spDist: TSpinBox;
    Label2: TLabel;
    edtBeaconGUID: TEdit;
    SpeedButton1: TSpeedButton;
    GroupBox1: TGroupBox;
    rbAF: TRadioButton;
    rbAP: TRadioButton;
    StyleBook1: TStyleBook;
    Layout2: TLayout;
    swScan: TSwitch;
    Label3: TLabel;
    swService: TSwitch;
    Label4: TLabel;
    cbStatus: TColorBox;
    lblStatus: TLabel;
    edtAviso: TEdit;
    lblAvisar: TLabel;
    DSRestConnection1: TDSRestConnection;
    mmLog: TMemo;
    procedure Beacon1BeaconEnter(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
    procedure Beacon1BeaconExit(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
    procedure Beacon1BeaconProximity(const Sender: TObject; const ABeacon: IBeacon; Proximity: TBeaconProximity);
    procedure SpeedButton1Click(Sender: TObject);
    procedure swScanSwitch(Sender: TObject);
    procedure lstBeaconsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure swServiceSwitch(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FLastAlarm: TDateTime;
    FBeaconList: TObjectList<TBeaconInfo>;
    FLocalService: TLocalServiceConnection;
    function FindOrAddBeacon(ABeacon: IBeacon): TBeaconInfo;
    procedure RemoveBeacon(ABeacon: IBeacon);
    procedure UpdateList;
    procedure UpdateStatus(ABeacon: IBeacon);
    procedure DoStartService;
    procedure OnServiceConnected(const ALocalService: TAndroidBaseService);
    procedure OnServiceDisconnected;
  public
    procedure DoAlarm(const UserId, Msg: string);
    procedure AnalyseAlarm(ABeaconInfo: TBeaconInfo);
  end;

var
  frmAppDistAlarm: TfrmAppDistAlarm;

implementation
uses aIni;
{$R *.fmx}

procedure TfrmAppDistAlarm.DoAlarm(const UserId, Msg: string);
var
  Secs: Int64;
begin
  Secs:= DateUtils.SecondsBetween(FLastAlarm, Now);
  if (FLastAlarm > 0) and (Secs < 20) then
    Exit;
  mmLog.Lines.Add(Msg);
  FLastAlarm:= Now;
  with TPushMethodsClient.Create(DSRestConnection1, true) do
  try
    SendMessageToUser(UserId, 'Alarme', Msg);
  finally
    Free;
  end;
end;

procedure TfrmAppDistAlarm.DoStartService;
begin
  FLocalService:= TLocalServiceConnection.Create;
  FLocalService.OnConnected:= Self.OnServiceConnected;
  FLocalService.OnDisconnected:= Self.OnServiceDisconnected;
end;

procedure TfrmAppDistAlarm.OnServiceConnected(const ALocalService: TAndroidBaseService);
begin
  FLocalService.BindService('BeaconAlarmSvc');
end;

procedure TfrmAppDistAlarm.OnServiceDisconnected;
begin

end;

procedure TfrmAppDistAlarm.FormCreate(Sender: TObject);
begin
  FBeaconList:= TObjectList<TBeaconInfo>.Create;
  rbAF.IsChecked:= Ini.Mode.Equals(MODE_AFASTAMENTO);
  rbAP.IsChecked:= Ini.Mode.Equals(MODE_APROXIMACAO);
  spDist.Value:= Ini.DistanceAlarm;
  edtBeaconGUID.Text:= Ini.BeaconGUID;
  edtAviso.Text:= Ini.UserEmail;
end;

procedure TfrmAppDistAlarm.FormDestroy(Sender: TObject);
begin
  FBeaconList.Free;
end;

procedure TfrmAppDistAlarm.FormShow(Sender: TObject);
begin
  DoStartService;
end;

procedure TfrmAppDistAlarm.lstBeaconsChange(Sender: TObject);
begin
  TMonitor.Enter(Beacon1, 3000);
  try
    edtBeaconGUID.Text:= TListViewItem(lstBeacons.Selected).Text;
  finally
    TMonitor.Exit(Beacon1);
  end;
end;

procedure TfrmAppDistAlarm.Beacon1BeaconEnter(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
begin
  FindOrAddBeacon(ABeacon);
  UpdateList;
  UpdateStatus(ABeacon);
end;

procedure TfrmAppDistAlarm.Beacon1BeaconExit(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
begin
  RemoveBeacon(ABeacon);
  UpdateList;
  UpdateStatus(ABeacon);
end;

procedure TfrmAppDistAlarm.Beacon1BeaconProximity(const Sender: TObject; const ABeacon: IBeacon; Proximity: TBeaconProximity);
begin
  FindOrAddBeacon(ABeacon);
  UpdateList;
  UpdateStatus(ABeacon);
end;

function TfrmAppDistAlarm.FindOrAddBeacon(ABeacon: IBeacon): TBeaconInfo;
var
  ABeaconInfo: TBeaconInfo;
  AGUID: string;
begin
  result:= nil;
  AGUID:= ABeacon.GUID.ToString;
  for ABeaconInfo in FBeaconList do
  begin
    if ABeaconInfo.BeaconGUID.Equals(AGUID) then
    begin
      result:= ABeaconInfo;
      break;
    end;
  end;
  if not assigned(result) then
  begin
    result:= TBeaconInfo.Create(ABeacon);
    FBeaconList.Add(result);
  end;
end;

procedure TfrmAppDistAlarm.RemoveBeacon(ABeacon: IBeacon);
var
  AGUID: string;
  i: integer;
begin
  AGUID:= ABeacon.GUID.ToString;
  for i:= FBeaconList.Count - 1 downto 0 do
  begin
    if FBeaconList[i].BeaconGUID.Equals(AGUID) then
    begin
      FBeaconList.Delete(i);
      break;
    end;
  end;
end;

procedure TfrmAppDistAlarm.UpdateList;
var
  ABeacon: TBeaconInfo;
  AItem: TListViewItem;
begin
  TMonitor.Enter(Beacon1, 3000);
  try
    //lstBeacons.BeginUpdate;
    try
      lstBeacons.Items.Clear;
      for ABeacon in FBeaconList do
      begin
        AItem:= lstBeacons.Items.Add;
        AItem.Text:= ABeacon.BeaconGUID;
        AItem.Detail:= format('Major: %s; Minor: %s; Distance: %s',
                       [ABeacon.Major.ToString, ABeacon.Minor.ToString, formatFloat('#0.0', ABeacon.CurrentDistance)]);
      end;
    finally
      //lstBeacons.EndUpdate;
    end;
  finally
    TMonitor.Exit(Beacon1);
  end;
end;

procedure TfrmAppDistAlarm.SpeedButton1Click(Sender: TObject);
begin
  Ini.DistanceAlarm:= Trunc(spDist.Value);
  Ini.BeaconGUID:= edtBeaconGUID.Text.Trim;
  Ini.UserEmail:= edtAviso.Text;
  if rbAF.IsChecked then
    Ini.Mode:= MODE_AFASTAMENTO;
  if rbAP.IsChecked then
    Ini.Mode:= MODE_APROXIMACAO;
end;

procedure TfrmAppDistAlarm.swScanSwitch(Sender: TObject);
begin
  lstBeacons.Items.Clear;
  Beacon1.Enabled:= swScan.IsChecked;
end;

procedure TfrmAppDistAlarm.swServiceSwitch(Sender: TObject);
begin
  if swService.IsChecked then
    FLocalService.StartService('BeaconAlarmSvc')
  else
  begin
    if assigned(FLocalService.LocalService) then
      FLocalService.LocalService.JavaService.stopSelf;
  end;
end;

procedure TfrmAppDistAlarm.UpdateStatus(ABeacon: IBeacon);
var
  ABeaconInfo: TBeaconInfo;
begin
  ABeaconInfo:= FindOrAddBeacon(ABeacon);
  ABeaconInfo.UpdateDistance(ABeacon.Distance);

  if ABeaconInfo.IsAppoaching then
    lblStatus.Text:= 'Approaching...'
  else
  if ABeaconInfo.IsMovingAway then
    lblStatus.Text:= 'Moving away...'
  else
    lblStatus.Text:= 'Still';

  case ABeacon.Proximity of
    Immediate: cbStatus.Opacity:= 1;
    Near: cbStatus.Opacity:= 0.70;
    Far: cbStatus.Opacity:= 0.40;
    Away: cbStatus.Opacity:= 0.10;
  end;
  AnalyseAlarm(ABeaconInfo);
end;

procedure TfrmAppDistAlarm.AnalyseAlarm(ABeaconInfo: TBeaconInfo);
var
  IsMovingAway, IsApproaching: boolean;
begin
  IsMovingAway:= false; IsApproaching:= false;
  if assigned(ABeaconInfo) then
  begin
    if rbAF.IsChecked then
      IsMovingAway:= ABeaconInfo.IsMovingAway and (ABeaconInfo.CurrentDistance >= spDist.Value)
    else
      IsApproaching:= ABeaconInfo.IsAppoaching and (ABeaconInfo.CurrentDistance <= spDist.Value);

    if IsMovingAway then
      DoAlarm(edtAviso.Text, 'Afastamento detectado')
    else
    if IsApproaching then
      DoAlarm(edtAviso.Text, 'Aproximação detectada');
  end;
end;



end.
