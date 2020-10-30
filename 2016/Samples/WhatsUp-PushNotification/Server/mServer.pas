unit mServer;
interface
uses
  Winapi.Windows, Winapi.Messages, Winapi.ShellApi, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.WinXCtrls, System.Actions, Vcl.ActnList,
  IdHTTPWebBrokerBridge, dServer, aFormMDI, aClasses, aConsts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Menus,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.Bind.Grid, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope;

type
  TmdiServer = class(TFormMDI)
    pcServer: TPageControl;
    tabServer: TTabSheet;
    tabRegistry: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    edtPort: TEdit;
    lblAddress: TLabel;
    alServer: TActionList;
    acWebStart: TAction;
    acWebStop: TAction;
    acOpenBrowser: TAction;
    Label3: TLabel;
    Bevel2: TBevel;
    mmLog: TMemo;
    chkLog: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    pnlToolbar: TPanel;
    tblRegistry: TFDTable;
    tmrRefresh: TTimer;
    chkRefresh: TCheckBox;
    Edit1: TEdit;
    udResfresh: TUpDown;
    Label4: TLabel;
    lblTime: TLabel;
    pmRegistry: TPopupMenu;
    acOpenRegistry: TAction;
    acCloseRegistry: TAction;
    OpenBrowser1: TMenuItem;
    Close1: TMenuItem;
    acRefreshRegistry: TAction;
    tblRegistryDeviceId: TWideStringField;
    tblRegistryDeviceToken: TWideStringField;
    tblRegistryDeviceType: TWideStringField;
    tblRegistryOSName: TWideStringField;
    tblRegistryOSVersion: TWideStringField;
    tblRegistryPushEnabled: TWideStringField;
    tblRegistryUserName: TWideStringField;
    tblRegistryUserEmail: TWideStringField;
    tblRegistryDTInsert: TSQLTimeStampField;
    tblRegistryDTUpdate: TSQLTimeStampField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    StringGrid1: TStringGrid;
    LinkGridToDataSourceBindSourceDB12: TLinkGridToDataSource;
    Refresh1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lblAddressClick(Sender: TObject);
    procedure edtPortChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkLogClick(Sender: TObject);
    procedure acWebStartExecute(Sender: TObject);
    procedure acWebStopExecute(Sender: TObject);
    procedure alServerUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure chkRefreshClick(Sender: TObject);
    procedure tmrRefreshTimer(Sender: TObject);
    procedure pcServerChange(Sender: TObject);
    procedure acOpenRegistryExecute(Sender: TObject);
    procedure acCloseRegistryExecute(Sender: TObject);
    procedure acRefreshRegistryExecute(Sender: TObject);
  private
    FRefreshStart: TDateTime;
    FDoLog: boolean;
    FServer: TIdHTTPWebBrokerBridge;
    procedure MsgLog(var Message:TMessage);message WM_LOG;
    procedure MsgReg(var Message:TMessage);message WM_REG;
    procedure DoLog(const Value: string);
    procedure StartServer;
    procedure StopServer;
    procedure UpdateServerAddress;
    procedure CheckRefresh;
    procedure OpenRegistry;
    procedure RefreshRegistry;
    procedure CloseRegistry;
  public
    { Public declarations }
  end;

implementation
{$R *.dfm}

procedure TmdiServer.FormCreate(Sender: TObject);
begin
  CurrentMessageQueueHandler:= Self.Handle;
  FServer:= TIdHTTPWebBrokerBridge.Create(Self);
  tblRegistry.Connection:= dmPushDB.conApp;
end;

procedure TmdiServer.FormDestroy(Sender: TObject);
begin
  CloseRegistry;
  StopServer;
  CurrentMessageQueueHandler:= 0;
  inherited;
end;

procedure TmdiServer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
  inherited;
end;

procedure TmdiServer.acOpenRegistryExecute(Sender: TObject);
begin
  OpenRegistry;
end;

procedure TmdiServer.acRefreshRegistryExecute(Sender: TObject);
begin
  RefreshRegistry;
end;

procedure TmdiServer.acCloseRegistryExecute(Sender: TObject);
begin
  CloseRegistry;
end;

procedure TmdiServer.acWebStartExecute(Sender: TObject);
begin
  StartServer;
  UpdateServerAddress;
end;

procedure TmdiServer.acWebStopExecute(Sender: TObject);
begin
  StopServer;
  UpdateServerAddress
end;

procedure TmdiServer.alServerUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  acWebStart.Enabled:= assigned(FServer) and not FServer.Active;
  acWebStop.Enabled:= not acWebStart.Enabled;
  acOpenBrowser.Enabled:= acWebStop.Enabled;
  chkRefresh.Enabled:= tblRegistry.Active;
end;

procedure TmdiServer.chkRefreshClick(Sender: TObject);
begin
  CheckRefresh;
end;

procedure TmdiServer.chkLogClick(Sender: TObject);
begin
  FDoLog:= chkLog.Checked;
end;

procedure TmdiServer.DoLog(const Value: string);
var
  Key: string;
begin
  if FDoLog then
  begin
    Key:= FormatDateTime('yymmdd-hhnnss.zzz', Now);
    mmLog.Lines.Add(Format('%s = %s', [Key, Value]));
  end;
end;

procedure TmdiServer.edtPortChange(Sender: TObject);
begin
  UpdateServerAddress;
end;

procedure TmdiServer.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(edtPort.Text);
    FServer.Active:= True;
  end;
end;

procedure TmdiServer.StopServer;
begin
  FServer.Active:= False;
  FServer.Bindings.Clear;
end;

procedure TmdiServer.tmrRefreshTimer(Sender: TObject);
var
  DiffStr: string;
  DiffInt: integer;
begin
  DiffStr:= FormatDateTime('ss', (Now - FRefreshStart));
  DiffInt:= udResfresh.Position - StrToInt(DiffStr);
  if DiffInt <= 0 then
    DiffInt:= 0;
  lblTime.Caption:= format('%2.2d', [DiffInt]);
  lblTime.Repaint;
  if DiffInt = 0 then
  begin
    tmrRefresh.Enabled:= false;
    RefreshRegistry;
    CheckRefresh;
  end;
end;

procedure TmdiServer.UpdateServerAddress;
begin
  lblAddress.Caption:= format('http://localhost:%s/alive', [edtPort.Text]);
  lblAddress.Enabled:= assigned(FServer) and (FServer.Active);
end;

procedure TmdiServer.CheckRefresh;
begin
  if chkRefresh.Checked then
    FRefreshStart:= Now;
  lblTime.Visible:= chkRefresh.Checked;;
  tmrRefresh.Enabled:= chkRefresh.Checked;
  Application.ProcessMessages;
end;

procedure TmdiServer.OpenRegistry;
begin
  tblRegistry.Open;
end;

procedure TmdiServer.RefreshRegistry;
begin
  tblRegistry.DisableControls;
  try
    tblRegistry.Close;
    tblRegistry.Open;
    tblRegistry.Last;
  finally
    tblRegistry.EnableControls;
  end;
end;

procedure TmdiServer.CloseRegistry;
begin
  tblRegistry.Close;
end;

procedure TmdiServer.lblAddressClick(Sender: TObject);
begin
  if lblAddress.Enabled then
    ShellExecute(0, 'Open', PChar(lblAddress.Caption), nil, nil, SW_SHOWNORMAL);
end;

procedure TmdiServer.MsgLog(var Message: TMessage);
begin
  if Message.LParam > 0 then
  begin
    DoLog(PWideChar(Message.LParam));
    StrDispose(PWideChar(Message.LParam));
  end;
end;

procedure TmdiServer.MsgReg(var Message: TMessage);
var
  Value: string;
begin
  if Message.LParam > 0 then
  try
    Value:= PWideChar(Message.LParam);
    dmPushDB.InsertOrUpdatePushRegistry(Value);
  finally
    StrDispose(PWideChar(Message.LParam));
  end;
end;

procedure TmdiServer.pcServerChange(Sender: TObject);
begin
  if pcServer.ActivePage = tabRegistry then
    OpenRegistry;
end;

end.
