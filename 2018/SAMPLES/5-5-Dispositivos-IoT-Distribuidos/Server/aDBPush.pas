unit aDBPush;
interface
uses
  System.SysUtils, System.Classes, System.IOUtils, System.Variants,
  System.JSON, System.Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  lPushData, Lib.Data.Helpers, System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, forms, Data.DBXDataSnap, Data.DBXCommon,
  Data.DbxHTTPLayer, Data.SqlExpr;

type
  TdmPush = class(TDataModule)
    dbPush: TFDConnection;
    qryGetDevice: TFDQuery;
    qryUpdateDevice: TFDQuery;
    qryGetDevices: TFDQuery;
    nHTTP: TNetHTTPClient;
    nHTTPReq: TNetHTTPRequest;
    qrySendToAll: TFDQuery;
    qryUpdatePushSuccess: TFDQuery;
    qryUpdatePushFail: TFDQuery;
    qrySendToUser: TFDQuery;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    SQLConnectionQDT: TSQLConnection;
    procedure dbPushBeforeConnect(Sender: TObject);
  private
    const
      FIREBASE_URL = 'https://fcm.googleapis.com/fcm/send';
      ANDROID_OS = 'Android';
      IOS_OS     = 'iOS';
  private
    FGooglePushServerKey: string;
    procedure UpdateSuccess(TokenList: TStrings);
    procedure UpdateFail(TokenList: TStrings);
    function SendPushToGoogle(const ATitle, AMessage: string; ATokens: TStrings): TJSONArray;
    function SendPushToApple(const ATitle, AMessage: string; ATokens: TStrings): TJSONArray;
    function SendToGoogle(const Title, Msg: string; Tokens: TStrings): integer;
    function SendToApple(const Title, Msg: string; Tokens: TStrings): integer;
  public
    Constructor Create(AOwner: TComponent; const GooglePushServerKey, Database, UserName, Password: string); reintroduce;
    //Consulta
    function DoGetDevice(const DeviceId: string): TJSONObject;
    function DoGetDevices(PageNumber: integer; ItemsPerPage: integer): TJSONArray;
    //Registro
    function DoUpdateDevice(const DeviceInfo: TPushDevice): integer;
    //Envio
    function DoSendMessageToUser(const UserId, Title, Msg: string): TJSONObject;
    function DoSendMessageToAll(const Title, Msg: string): TJSONObject;

  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

{ TdmPush }
constructor TdmPush.Create(AOwner: TComponent; const GooglePushServerKey, Database, UserName, Password: string);
begin
  inherited Create(AOwner);
  FGooglePushServerKey:= GooglePushServerKey;
//  dbPush.Params.Values['Database']:= Database;
//  dbPush.Params.Values['User_Name']:= UserName;
//  dbPush.Params.Values['Password']:= Password;
end;


procedure TdmPush.UpdateSuccess(TokenList: TStrings);
var
  i: integer;
begin
  if TokenList.Count > 0 then
  begin
    qryUpdatePushSuccess.Params.ArraySize:= TokenList.Count;
    for i := 0 to TokenList.Count - 1 do
      qryUpdatePushSuccess.Params[0].AsStrings[i]:= TokenList[i];
    qryUpdatePushSuccess.Execute(TokenList.Count, 0);
  end;
end;

procedure TdmPush.UpdateFail(TokenList: TStrings);
var
  i: integer;
begin
  if TokenList.Count > 0 then
  begin
    qryUpdatePushFail.Params.ArraySize:= TokenList.Count;
    for i := 0 to TokenList.Count - 1 do
      qryUpdatePushFail.Params[0].AsStrings[i] := TokenList[i];
    qryUpdatePushFail.Execute(TokenList.Count, 0);
  end;
end;

function TdmPush.SendPushToGoogle(const ATitle, AMessage: string; ATokens: TStrings): TJSONArray;
var
  AJsonData: TJsonObject;      //mensagem
  AJsonGoogle: TJsonObject;    //formato do Google
  AJSonResult: TJsonObject;    //resposta
  ARegisterIds: TJsonArray;    //destinatários
  AData, AResponseContent: TStringStream;
  UTF8JSON: UTF8String;
  Token, Value: string;
begin
  Result:= TJSONArray.Create;
  AResponseContent:= TStringStream.Create;
  ARegisterIds:= TJSonArray.Create;
  AJsonData:= TJsonObject.Create;
  AJsonGoogle:= TJSonObject.Create;
  AData:= TStringStream.Create;
  try
    for Token in ATokens do
      ARegisterIds.Add(Token);

    AJsonData.AddPair('title', ATitle);
    AJsonData.AddPair('message', AMessage);

    AJsonGoogle.AddPair('registration_ids', ARegisterIds);
    AJsonGoogle.AddPair('data', AJsonData);

    UTF8JSON:= UTF8Encode(AJsonGoogle.ToString);
    AData.WriteData(BytesOf(UTF8JSON), Length(UTF8JSON));
    AData.Position:= 0;

    nHTTP.ContentType:= 'application/json';
    nHTTPReq.CustomHeaders['Authorization']:= format('key=%s', [FGooglePushServerKey]);
    nHTTPReq.Post(FIREBASE_URL, AData, AResponseContent);

    AResponseContent.Position:= 0;
    AJsonResult:= TJSONObject.ParseJSONValue(AResponseContent.DataString) as TJSONObject;

    if assigned(AJsonResult) and
      (AJsonResult.TryGetValue('success', Value) or AJsonResult.TryGetValue('failure', Value)) then
      Result:= AJsonResult.GetValue('results') as TJSONArray;
  finally
    AJsonGoogle.Free;
    AData.Free;
    AResponseContent.Free;
  end;
end;

function TdmPush.SendPushToApple(const ATitle, AMessage: string; ATokens: TStrings): TJSONArray;
begin
  result:= TJSONArray.Create;
end;

function TdmPush.SendToGoogle(const Title, Msg: string; Tokens: TStrings): integer;
var
  i: integer;
  TokensSuccess: TStrings;
  TokensFail: TStrings;
  PushResult: TJSONArray;
  PushResultValue: TJSONValue;
  Value: string;
begin
  TokensSuccess:= TStringList.Create;
  TokensFail:= TStringList.Create;
  try
    PushResult:= SendPushToGoogle(Title, Msg, Tokens);
    if PushResult.Count = Tokens.Count then
    begin
      for i:= 0 to Tokens.Count - 1 do
      begin
        PushResultValue:= PushResult.Items[i];
        if PushResultValue.TryGetValue('message_id', Value) then
          TokensSuccess.Add(Tokens[i])
        else
          TokensFail.Add(Tokens[i])
      end;
      UpdateSuccess(TokensSuccess);
      UpdateFail(TokensFail);
    end;
  finally
    Result:= TokensSuccess.Count;
    TokensSuccess.Free;
    TokensFail.Free;
  end;
end;

function TdmPush.SendToApple(const Title, Msg: string; Tokens: TStrings): integer;
var
  PushResult: TJSONArray;
begin
  PushResult:= SendPushToApple(Title, Msg, Tokens);
  Result:= PushResult.Count;
end;

//Retorna 1 device
procedure TdmPush.dbPushBeforeConnect(Sender: TObject);
var
  LocalBanco : TStringList;
begin
   LocalBanco:=TStringList.Create;
   //LocalBanco.LoadFromFile(ExtractFileDir(Application.ExeName + 'LocalBanco.TXT'), TEncoding.UTF8);
   LocalBanco.LoadFromFile('LocalBanco.TXT');
   dbPush.Params.Text:=LocalBanco.Text;
end;

function TdmPush.DoGetDevice(const DeviceId: string): TJSONObject;
begin
  Result:= TJSONObject.Create;
  try
    qryGetDevice.ParamByName('Device_Id').AsString:= DeviceId;
    qryGetDevice.Open;
    if not qryGetDevice.IsEmpty then
      result:= qryGetDevice.CurrentRowAsJSON;
  finally
    qryGetDevice.Close;
  end;
end;

function TdmPush.DoGetDevices(PageNumber: integer; ItemsPerPage: integer): TJSONArray;
begin
  result:= TJSONArray.Create;
  try
    qryGetDevices.FetchOptions.RecsSkip:= (PageNumber - 1) * ItemsPerPage;
    qryGetDevices.FetchOptions.RecsMax:= ItemsPerPage;
    qryGetDevices.FetchOptions.RowsetSize:= ItemsPerPage;
    qryGetDevices.Open;
    if not qryGetDevices.IsEmpty then
      result:= qryGetDevices.AllRowsAsJSONArray;
  finally
    qryGetDevices.Close;
  end;
end;

function TdmPush.DoUpdateDevice(const DeviceInfo: TPushDevice): integer;
begin
  try
    qryUpdateDevice.ParamByName('Device_Id').AsString:= DeviceInfo.DeviceId;
    qryUpdateDevice.ParamByName('User_Id').AsInteger:= DeviceInfo.UserId;
    qryUpdateDevice.Open;
    if qryUpdateDevice.IsEmpty then
    begin
      qryUpdateDevice.Insert;
      qryUpdateDevice.FieldByName('USER_ID').AsLargeInt:= DeviceInfo.UserId;
      qryUpdateDevice.FieldByName('DEVICE_ID').AsString:= DeviceInfo.DeviceId;
      qryUpdateDevice.FieldByName('DT_INSERT').AsDateTime:= Now;
    end
    else
    begin
      qryUpdateDevice.Edit;
      qryUpdateDevice.FieldByName('DT_UPDATE').AsDateTime:= Now;
    end;
    qryUpdateDevice.FieldByName('DEVICE_TOKEN').AsString:= DeviceInfo.DeviceToken;
    qryUpdateDevice.FieldByName('DEVICE_MODEL').AsString:= DeviceInfo.DeviceModel;
    qryUpdateDevice.FieldByName('OS_NAME').AsString:= DeviceInfo.OSName;
    qryUpdateDevice.FieldByName('OS_VER').AsString:= DeviceInfo.OSVer;
    qryUpdateDevice.FieldByName('APP_VER').AsString:= DeviceInfo.AppVer;
    qryUpdateDevice.FieldByName('RECEIVE_PUSH').AsString:= DeviceInfo.ReceivePush;
    qryUpdateDevice.Post;
    result:= qryUpdateDevice.ChangeCount;
    qryUpdateDevice.ApplyUpdates(0);
  finally
    qryUpdateDevice.Close;
  end;
end;

function TdmPush.DoSendMessageToUser(const UserId, Title, Msg: string): TJSONObject;
var
  Tokens: TStrings;
  Total: integer;
begin
  Total:= 0;
  Result:= TJSONObject.Create;
  Tokens:= TStringList.Create;
  try
    qrySendToUser.ParamByName('user_id').AsString:= UserId;
    qrySendToUser.Open;
    if not qrySendToUser.IsEmpty then
    begin
      Tokens.Add(qrySendToUser.FieldByName('device_token').AsString);
      if qrySendToUser.FieldByName('os_name').AsString = ANDROID_OS then
        Total:= SendToGoogle(Title, Msg, Tokens)
      else
        if qrySendToUser.FieldByName('os_name').AsString = IOS_OS then
          Total:= SendToApple(Title, Msg, Tokens);
    end;
    qrySendToUser.Close;
  finally
    Tokens.Free;
  end;
  Result.AddPair('sent', TJSONNumber.Create(Total));
end;

function TdmPush.DoSendMessageToAll(const Title, Msg: string): TJSONObject;

  procedure GetNextTokens(ADataset: TDataset; TokenList: TStrings; TokenCount: integer);
  var
    i: integer;
  begin
    for i:= 1 to TokenCount do
    begin
      TokenList.Add(ADataset.FieldByName('device_token').AsString);
      ADataset.Next;
    end;
  end;

const
  MaxGoogleTokens = 1000;
  MaxAppleTokens = 1000;
var
  Tokens: TStrings;
  TheThousands, TheRest: integer;
  i, Total: integer;
begin
  Total:= 0;
  Result:= TJSONObject.Create;
  Tokens:= TStringList.Create;
  //--------------------------------------------------------
  //Google
  qrySendToAll.Close;
  qrySendToAll.ParamByName('os_name').AsString:= ANDROID_OS;
  qrySendToAll.Open;
  TheThousands:= qrySendToAll.RecordCount div MaxGoogleTokens;
  TheRest:= qrySendToAll.RecordCount mod MaxGoogleTokens;
  //Process each 1.000
  for i:= 1 to TheThousands do
  //for i:= 1 to 1 do  //Laercio
  begin
    GetNextTokens(qrySendToAll, Tokens, MaxGoogleTokens);
    Total:= Total + SendToGoogle(Title, Msg, Tokens);
    Tokens.Clear;
  end;
  //Process the rest
  GetNextTokens(qrySendToAll, Tokens, TheRest);
  Total:= Total + SendToGoogle(Title, Msg, Tokens);
  Tokens.Clear;

  //--------------------------------------------------------
  //Apple
  qrySendToAll.Close;
  qrySendToAll.ParamByName('os_name').AsString:= iOS_OS;
  qrySendToAll.Open;
  TheThousands:= qrySendToAll.RecordCount div MaxAppleTokens;
  TheRest:= qrySendToAll.RecordCount mod MaxAppleTokens;
  try
    //Process each 1.000
    for i:= 1 to TheThousands do
    begin
      GetNextTokens(qrySendToAll, Tokens, MaxAppleTokens);
      Total:= Total + SendToApple(Title, Msg, Tokens);
      Tokens.Clear;
    end;
    //Process the rest
    GetNextTokens(qrySendToAll, Tokens, TheRest);
    Total:= Total + SendToApple(Title, Msg, Tokens);
  finally
    Tokens.Free;
  end;
  result.AddPair('sent', TJSONNumber.Create(Total));
end;




end.

