unit aPushMethods;
interface
uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, System.IniFiles,
    lPushData;

type
{$METHODINFO ON}
  TPushMethods = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    FGooglePushServerKey: string;
    FDatabase: string;
    FDBUser: string;
    FDBPassword: string;
  public
    { Public declarations }
    //Consulta
    function Device(const DeviceId: string): TJSONObject;
    function Devices(PageNumber: integer; ItemsPerPage: integer): TJSONObject;
    function UserDevices(const UserId: string): TJSONObject;
    //Registro
    function UpdateDevice(const DeviceInfo: TPushDevice): TJSONObject;
    function UpdatePushOption(const DeviceId: string; PushOption: boolean): TJSONObject;
    //Envio
    function SendMessageToUser(const UserId, Title, Msg: string): TJSONObject;
    function SendMessageToAll(const Title, Msg: string): TJSONObject;
  end;
{$METHODINFO OFF}

implementation
{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}
uses aDBPush;
{ TPushMethods }

function GetAppFileName: string;
begin
  result:= GetModuleName(HInstance);
  result:= result.Substring(result.IndexOf(':') - 1);
end;

function GetIniFileName: string;
begin
  result:= ChangeFileExt(GetAppFileName, '.ini');
end;

procedure TPushMethods.DataModuleCreate(Sender: TObject);
begin
  with TIniFile.Create(GetIniFileName) do
  try
     FDatabase:= ReadString('DB', 'Database', '');
     FDBUser:= ReadString('DB', 'DBUser', '');
     FDBPassword:= ReadString('DB', 'DBPassword', '');
     FGooglePushServerKey:= ReadString('PUSH', 'Google', '');
  finally
    Free;
  end;
end;

function TPushMethods.Device(const DeviceId: string): TJSONObject;
var
  Obj: TJSONObject;
begin
  Obj:= TJSONObject.Create;
  try
    With TdmPush.Create(Self, FGooglePushServerKey, FDatabase, FDBUser, FDBPassword) do
    try
      Obj.AddPair('success', DoGetDevice(DeviceID));
    finally
      Free;
    end;
  except
     on E: Exception do
       Obj.AddPair('error', E.Message);
  end;
  result:= Obj;
end;

function TPushMethods.Devices(PageNumber: integer; ItemsPerPage: integer): TJSONObject;
var
  ja: TJSONArray;
begin
  result:= TJSONObject.Create;
  try
    With TdmPush.Create(Self, FGooglePushServerKey, FDatabase, FDBUser, FDBPassword) do
    try
      ja:= DoGetDevices(PageNumber, ItemsPerPage);
      result.AddPair(TJSONPair.Create('success', ja));
    finally
      Free;
    end;
  except
     on E: Exception do
       result.AddPair('error', E.Message);
  end;
end;

function TPushMethods.UserDevices(const UserId: string): TJSONObject;
var
  ja: TJSONArray;
begin
  result:= TJSONObject.Create;
  try
    With TdmPush.Create(Self, FGooglePushServerKey, FDatabase, FDBUser, FDBPassword) do
    try
      ja:= DoGetUserDevices(UserId);
      result.AddPair(TJSONPair.Create('success', ja));
    finally
      Free;
    end;
  except
     on E: Exception do
       result.AddPair('error', E.Message);
  end;
end;

function TPushMethods.UpdateDevice(const DeviceInfo: TPushDevice): TJSONObject;
begin
  result:= TJSONObject.Create;
  try
    with TdmPush.Create(Self, FGooglePushServerKey, FDatabase, FDBUser, FDBPassword) do
    try
      result.AddPair('success', DoUpdateDevice(DeviceInfo).ToString);
    finally
      Free;
    end;
  except
     on E: Exception do
       result.AddPair('error', E.Message);
  end;
end;

function TPushMethods.UpdatePushOption(const DeviceId: string; PushOption: boolean): TJSONObject;
begin
  result:= TJSONObject.Create;
  try
    with TdmPush.Create(Self, FGooglePushServerKey, FDatabase, FDBUser, FDBPassword) do
    try
      result.AddPair('success', DoUpdatePushOption(DeviceId, PushOption).ToString);
    finally
      Free;
    end;
  except
     on E: Exception do
       result.AddPair('error', E.Message);
  end;
end;

function TPushMethods.SendMessageToUser(const UserId, Title, Msg: string): TJSONObject;
begin
  result:= TJSONObject.Create;
  try
    with TdmPush.Create(Self, FGooglePushServerKey, FDatabase, FDBUser, FDBPassword) do
    try
      result.AddPair('success', DoSendMessageToUser(UserId, Title, Msg));
    finally
      Free;
    end;
  except
     on E: Exception do
       result.AddPair('error', E.Message);
  end;
end;

function TPushMethods.SendMessageToAll(const Title, Msg: string): TJSONObject;
begin
  result:= TJSONObject.Create;
  try
    with TdmPush.Create(Self, FGooglePushServerKey, FDatabase, FDBUser, FDBPassword) do
    try
      result.AddPair('success', DoSendMessageToAll(Title, Msg));
    finally
      Free;
    end;
  except
     on E: Exception do
       result.AddPair('error', E.Message);
  end;
end;


end.

