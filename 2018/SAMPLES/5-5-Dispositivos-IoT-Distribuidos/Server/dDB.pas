unit dDB;
interface
uses
  System.SysUtils, System.Classes, System.IOUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmDB = class(TDataModule)
    dbPush: TFDConnection;
    tblPush: TFDTable;
  private
  public
    Constructor Create(AOwner: TComponent; const DatabaseName, UserName, Password: string); reintroduce;
    function DoRegisterDevice(const UserId, DeviceID, DeviceToken, DeviceModel, OSName, AppVer, OSVer: string;
      const ReceivePush: char): string;
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

{ TdmDB }
constructor TdmDB.Create(AOwner: TComponent; const Database, UserName, Password: string);
begin
  inherited Create(AOwner);
  dbApp.Params.Values['Database']:= Database;
  dbApp.Params.Values['User_Name']:= UserName;
  dbApp.Params.Values['Password']:= Password;
end;

function TdmDB.DoRegisterDevice(const UserId, DeviceID, DeviceToken, OSName, AppVer, OSVer: string;
  const ReceivePush: char): boolean;
begin
  result:= EmptyStr;
  try
    tblRegistry.Open;
    try
      if tblRegistry.FindKey([UserId, DeviceId]) then
      begin
        tblRegistry.Edit;
        tblRegistry.FieldByName('DT_UPDATE').AsDateTime:= Now;
      end
      else
      begin
        tblRegistry.Insert;
        tblRegistry.FieldByName('DT_INSERT').AsDateTime:= Now;
      end;
      tblRegistry.FieldByName('USER_ID').AsString:= UserId;
      tblRegistry.FieldByName('DEVICE_ID').AsString:= DeviceId;
      tblRegistry.FieldByName('DEVICE_TOKEN').AsString:= DeviceToken;
      tblRegistry.FieldByName('DEVICE_MODEL').AsString:= DeviceModel;
      tblRegistry.FieldByName('OS_NAME').AsString:= OSName;
      tblRegistry.FieldByName('OS_VER').AsString:= OSVer;
      tblRegistry.FieldByName('RECEIVE_PUSH').AsString:= ReceivePush;
      tblRegistry.Post;
    finally
      tblRegistry.Close;
    end;
  except
    On E: Exception do
      result:= E.Message;
  end;
end;

end.
