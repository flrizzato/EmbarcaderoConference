unit mSender;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.JSon, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, aFormMDI, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.Bind.EngExt, Vcl.Bind.DBEngExt,
  Vcl.Bind.Grid, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.ComCtrls, Vcl.Menus,
  System.Actions, Vcl.ActnList, System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TmdiSender = class(TFormMDI)
    PageControl1: TPageControl;
    tabSender: TTabSheet;
    pnlToolbar: TPanel;
    gridRegistry: TStringGrid;
    mmLog: TMemo;
    Splitter1: TSplitter;
    Button1: TButton;
    tblRegistry: TFDTable;
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
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    alServer: TActionList;
    acOpenRegistry: TAction;
    acCloseRegistry: TAction;
    acRefreshRegistry: TAction;
    pmRegistry: TPopupMenu;
    OpenBrowser1: TMenuItem;
    Close1: TMenuItem;
    Refresh1: TMenuItem;
    acSend: TAction;
    Label5: TLabel;
    edtMsg: TEdit;
    Button3: TButton;
    Label6: TLabel;
    edtAuthKey: TEdit;
    acSendAll: TAction;
    acSendRandom: TAction;
    nHTTP: TNetHTTPClient;
    nHTTPReq: TNetHTTPRequest;
    N1: TMenuItem;
    acSendRandom1: TMenuItem;
    Label1: TLabel;
    procedure acOpenRegistryExecute(Sender: TObject);
    procedure acCloseRegistryExecute(Sender: TObject);
    procedure acRefreshRegistryExecute(Sender: TObject);
    procedure alServerUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure acSendRandomExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acSendExecute(Sender: TObject);
    procedure acSendAllExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    procedure OpenRegistry;
    procedure CloseRegistry;
    procedure RefreshRegistry;
    procedure CheckMsg;
    procedure DoSend(const AMsg, ADeviceToken: string);
    procedure DoSendToAll(const AMsg: string);
  public
    { Public declarations }
  end;

var
  mdiSender: TmdiSender;

implementation

{$R *.dfm}

{ TmdiSender }

procedure TmdiSender.OpenRegistry;
begin
  tblRegistry.Open;
end;

procedure TmdiSender.RefreshRegistry;
begin
  tblRegistry.Refresh;
end;

procedure TmdiSender.CheckMsg;
begin
  if Trim(edtMsg.Text) = EmptyStr then
    raise exception.Create('Cannot send an empty message');
end;

procedure TmdiSender.CloseRegistry;
begin
  tblRegistry.Close;
end;

procedure TmdiSender.acOpenRegistryExecute(Sender: TObject);
begin
  OpenRegistry;
end;

procedure TmdiSender.acRefreshRegistryExecute(Sender: TObject);
begin
  RefreshRegistry;
end;

procedure TmdiSender.acSendExecute(Sender: TObject);
begin
  inherited;
  CheckMsg;
  if tblRegistry.Active and (not tblRegistry.IsEmpty) then
    DoSend(edtMsg.Text, tblRegistry.FieldByName('DeviceToken').AsString);
end;

procedure TmdiSender.acSendAllExecute(Sender: TObject);
begin
  inherited;
  CheckMsg;
  if tblRegistry.Active and (not tblRegistry.IsEmpty) then
    DoSendToAll(edtMsg.Text);
end;

procedure TmdiSender.acSendRandomExecute(Sender: TObject);
var
  Tries, SelectedRec: integer;
begin
  inherited;
  CheckMsg;
  if tblRegistry.Active and (not tblRegistry.IsEmpty) then
  begin
    tblRegistry.Close; tblRegistry.Open;
    Randomize;
    Tries:= 0;
    repeat
      SelectedRec:= Random(tblRegistry.RecordCount);
      tblRegistry.RecNo:= SelectedRec;
      Inc(Tries);
    until ((Tries = tblRegistry.RecordCount) or
           ((not tblRegistry.FieldByName('UserName').AsString.Trim.IsEmpty) and
           (not tblRegistry.FieldByName('UserEmail').AsString.Trim.IsEmpty)));
    DoSend(format('%s, você ganhou %s', [tblRegistry.FieldByName('UserName').AsString, edtMsg.text]),
           tblRegistry.FieldByName('DeviceToken').AsString);
    mmLog.Lines.Add(format('Congratulations %s !', [tblRegistry.FieldByName('UserName').AsString]));
  end;
end;

procedure TmdiSender.alServerUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  acSend.Enabled:= tblRegistry.Active and (not tblRegistry.IsEmpty);
  acSendAll.Enabled:= acSend.Enabled;
  acOpenRegistry.Enabled:= not tblRegistry.Active;
  acRefreshRegistry.Enabled:= tblRegistry.Active;
  acCloseRegistry.Enabled:= acRefreshRegistry.Enabled;
end;

procedure TmdiSender.acCloseRegistryExecute(Sender: TObject);
begin
  CloseRegistry;
end;

procedure TmdiSender.FormActivate(Sender: TObject);
begin
  inherited;
  OnActivate:= nil;
  OpenRegistry;
end;

procedure TmdiSender.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TmdiSender.DoSend(const AMsg, ADeviceToken: string);
var
  AJson: TJsonObject;
  AJsonData: TJsonObject;
  ARegisterIds: TJsonArray;
  AData, AResponseContent: TStringStream;
begin
  ARegisterIds:= TJSonArray.Create;
  AJSon:= TJSonObject.Create;
  AJsonData:= TJsonObject.Create;
  AData:= TStringStream.Create;
  AResponseContent:= TStringStream.Create;
  try
    AJsonData.AddPair('message', AMsg);
    AJson.AddPair('data', AJsonData);
    ARegisterIds.Add(ADeviceToken);
    AJson.AddPair('registration_ids', ARegisterIds);
    mmLog.Lines.Add('-------');
    mmLog.Lines.Add(AJson.ToString);
    AData.WriteString(AJson.ToString);
    AData.Position:= 0;
    nHTTP.ContentType:= 'application/json';
    nHTTPReq.CustomHeaders['Authorization']:= format('key=%s', [edtAuthKey.Text]);
    nHTTPReq.Post('https://fcm.googleapis.com/fcm/send', AData, AResponseContent);
    AResponseContent.Position:= 0;
    mmLog.Lines.Add(AResponseContent.DataString);
  finally
    AJSon.Free;
    AData.Free;
    AResponseContent.Free;
  end;
end;

procedure TmdiSender.DoSendToAll(const AMsg: string);
begin
  tblRegistry.First;
  while not tblRegistry.EOF do
  begin
    DoSend(AMsg, tblRegistry.FieldByName('DeviceToken').AsString);
    tblRegistry.Next;
  end;
end;


end.
