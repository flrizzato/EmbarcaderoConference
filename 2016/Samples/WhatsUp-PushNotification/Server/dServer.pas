unit dServer;
interface
uses
  System.SysUtils, System.Classes, FireDAC.Phys.MySQLDef, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  Winapi.Windows, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  System.JSON, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet,
  aClasses, aConsts;

type
  TdmPushDB = class(TDataModule)
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    conApp: TFDConnection;
    qryUpdRegistry: TFDQuery;
  private
    procedure DoInsertOrUpdatePushRegistry(PushDevice: TPushDevice);
  public
    procedure InsertOrUpdatePushRegistry(const JSONString: string);
  end;

var
  dmPushDB: TdmPushDB;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmPushDB }

procedure TdmPushDB.DoInsertOrUpdatePushRegistry(PushDevice: TPushDevice);
var
  PushEnabledChar: Char;
begin
  if (PushDevice.DeviceId.IsEmpty) then
    Exit;
  qryUpdRegistry.ParamByName('DEVICEID').AsString:= PushDevice.DeviceId;
  qryUpdRegistry.ParamByName('DEVICETOKEN').AsString:= PushDevice.DeviceToken;
  qryUpdRegistry.ParamByName('DEVICETYPE').AsString:= PushDevice.DeviceType;
  qryUpdRegistry.ParamByName('OSNAME').AsString:= PushDevice.OSName;
  qryUpdRegistry.ParamByName('OSVERSION').AsString:= PushDevice.OSVersion;
  if PushDevice.PushEnabled then
    PushEnabledChar:= 'S'
  else
    PushEnabledChar:= 'N';
  qryUpdRegistry.ParamByName('PUSHENABLED').AsString:= PushEnabledChar;
  qryUpdRegistry.ParamByName('USERNAME').AsString:= PushDevice.UserName;
  qryUpdRegistry.ParamByName('USEREMAIL').AsString:= PushDevice.UserEmail;
  try
    qryUpdRegistry.ExecSQL;
  except
    On E: Exception do
      if CurrentMessageQueueHandler > 0 then
        PostMessage(CurrentMessageQueueHandler, WM_LOG, 0, NativeInt(StrNew(PWideChar(E.Message))));
  end;
end;

procedure TdmPushDB.InsertOrUpdatePushRegistry(const JSONString: string);
var
  ps: TPushDevice;
begin
  ps:= TPushDevice.Create;
  try
    ps.AsJSONString:= JSONString;
    DoInsertOrUpdatePushRegistry(ps);
  finally
    ps.Free;
  end;
end;

end.
