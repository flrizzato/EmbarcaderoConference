unit BeaconAlarmService;
interface
uses
  System.SysUtils,
  System.Classes, System.Generics.Collections,
  System.Android.Service,
  Androidapi.JNI.App,
  AndroidApi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Os, System.Beacon, System.Bluetooth, System.Beacon.Components,
  System.Notification,
  ccPush, Datasnap.DSClientRest;

type
  TBeaconInfo = class
  private
    FBeaconGUID: string;
    FCurrentDistance: double;
    FLastDistance: double;
    FMinor: Word;
    FMajor: Word;
    function GetIsApproaching: boolean;
    function GetIsMovingAway: boolean;
  public
    constructor Create(ABeacon: IBeacon); virtual;
    property LastDistance: double read FLastDistance;
    property CurrentDistance: double read FCurrentDistance;
    property BeaconGUID: string read FBeaconGUID;
    property Major: Word read FMajor;
    property Minor: Word read FMinor;
    property IsAppoaching: boolean read GetIsApproaching;
    property IsMovingAway: boolean read GetIsMovingAway;
    procedure UpdateDistance(NewDistance: double);
  end;

  TDMDistAlarmService = class(TAndroidService)
    BeaconMain: TBeacon;
    NotificationCenterMain: TNotificationCenter;
    DSRestConnection1: TDSRestConnection;
    function AndroidServiceStartCommand(const Sender: TObject; const Intent: JIntent; Flags, StartId: Integer): Integer;
    procedure BeaconMainBeaconEnter(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
    procedure BeaconMainBeaconProximity(const Sender: TObject; const ABeacon: IBeacon; Proximity: TBeaconProximity);
    procedure AndroidServiceCreate(Sender: TObject);
    procedure AndroidServiceDestroy(Sender: TObject);
    procedure BeaconMainBeaconExit(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
  private
    FBeaconList: TObjectList<TBeaconInfo>;
    function FindOrAddBeacon(ABeacon: IBeacon): TBeaconInfo;
    procedure RemoveBeacon(ABeacon: IBeacon);
    procedure DoAlarm(const UserId, Msg: string);
  public
    procedure AnalyzeBeacon(ABeacon: IBeacon);
    procedure SendNotification(const Msg: string);
    procedure DoStartScan;
    procedure DoPauseScan;
  end;

var
  DMDistAlarmService: TDMDistAlarmService;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
uses aIni;
{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TBeaconInfo }

constructor TBeaconInfo.Create(ABeacon: IBeacon);
begin
  FBeaconGUID:= ABeacon.GUID.ToString;
  FCurrentDistance:= Round(ABeacon.Distance);
  FMajor:= ABeacon.Major;
  FMinor:= ABeacon.Minor;
end;

function TBeaconInfo.GetIsApproaching: boolean;
begin
  result:= (FCurrentDistance > 0) and
           (FLastDistance > 0) and
           (FCurrentDistance < FLastDistance) and
           ((FLastDistance - FCurrentDistance) >= Ini.DistanceAlarm);
end;

function TBeaconInfo.GetIsMovingAway: boolean;
begin
  result:= (FCurrentDistance > 0) and
           (FLastDistance > 0) and
           (FCurrentDistance > FLastDistance) and
           ((FCurrentDistance - FLastDistance) > Ini.DistanceAlarm);
end;

procedure TBeaconInfo.UpdateDistance(NewDistance: double);
begin
  FLastDistance:= FCurrentDistance;
  FCurrentDistance:= Round(NewDistance);
end;

procedure TDMDistAlarmService.AndroidServiceCreate(Sender: TObject);
begin
  FBeaconList:= TObjectList<TBeaconInfo>.Create;
end;

procedure TDMDistAlarmService.AndroidServiceDestroy(Sender: TObject);
begin
  FBeaconList.Free;
end;

function TDMDistAlarmService.FindOrAddBeacon(ABeacon: IBeacon): TBeaconInfo;
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

procedure TDMDistAlarmService.RemoveBeacon(ABeacon: IBeacon);
var
  ABeaconInfo: TBeaconInfo;
  AGUID: string;
begin
  AGUID:= ABeacon.GUID.ToString;
  for ABeaconInfo in FBeaconList do
  begin
    if ABeaconInfo.BeaconGUID.Equals(AGUID) then
    begin
      FBeaconList.Delete(FBeaconList.IndexOf(ABeaconInfo));
      break;
    end;
  end;
end;

function TDMDistAlarmService.AndroidServiceStartCommand(const Sender: TObject; const Intent: JIntent; Flags, StartId: Integer): Integer;
begin
  Result:= TJService.JavaClass.START_STICKY;
  DoStartScan;
end;

procedure TDMDistAlarmService.BeaconMainBeaconEnter(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
begin
  if assigned(ABeacon) and (ABeacon.GUID.ToString.Equals(Ini.BeaconGUID)) then
  begin
    FindOrAddBeacon(ABeacon);
    //SendNotification('Entered: ' + ABeacon.GUID.ToString);
  end;
end;

procedure TDMDistAlarmService.BeaconMainBeaconExit(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
begin
  if assigned(ABeacon) and (ABeacon.GUID.ToString.Equals(Ini.BeaconGUID)) then
  begin
    RemoveBeacon(ABeacon);
    //SendNotification('Exited: ' + ABeacon.GUID.ToString);
  end;
end;

procedure TDMDistAlarmService.BeaconMainBeaconProximity(const Sender: TObject; const ABeacon: IBeacon; Proximity: TBeaconProximity);
begin
  AnalyzeBeacon(ABeacon);
end;

procedure TDMDistAlarmService.AnalyzeBeacon(ABeacon: IBeacon);
var
  ABeaconInfo: TBeaconInfo;
  IsMovingAway, IsApproaching: boolean;
begin
  IsMovingAway:= false; IsApproaching:= false;
  ABeaconInfo:= FindOrAddBeacon(ABeacon);
  if assigned(ABeaconInfo) then
  begin
    ABeaconInfo.UpdateDistance(ABeacon.Distance);
    if Ini.Mode = MODE_AFASTAMENTO then
      IsMovingAway:= ABeaconInfo.IsMovingAway and (ABeaconInfo.LastDistance >= Ini.DistanceAlarm)
    else
      IsApproaching:= ABeaconInfo.IsAppoaching and (ABeaconInfo.LastDistance <= Ini.DistanceAlarm);

    if IsMovingAway then
      SendNotification('Afastamento detectado')
    else
    if IsApproaching then
      SendNotification('Aproximação detectada');
  end;
end;

procedure TDMDistAlarmService.SendNotification(const Msg: string);
var
  MyNotification: TNotification;
begin
  MyNotification:= NotificationCenterMain.CreateNotification;
  try
    MyNotification.Name:= 'DistAlarm' + Msg;
    MyNotification.AlertBody := Msg;
    NotificationCenterMain.PresentNotification(MyNotification);
  finally
    MyNotification.Free;
  end;
end;

procedure TDMDistAlarmService.DoStartScan;
begin
  //SendNotification('Enabled');
  BeaconMain.Enabled:= True;
end;

procedure TDMDistAlarmService.DoPauseScan;
begin
  //SendNotification('Disabled');
  BeaconMain.Enabled:= false;
end;

procedure TDMDistAlarmService.DoAlarm(const UserId, Msg: string);
begin
  with TPushMethodsClient.Create(DSRestConnection1, true) do
  try
    SendMessageToUser(UserId, 'Alarme', Msg);
  finally
    Free;
  end;
end;

end.
