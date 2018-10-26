unit ChatFacade;

interface

uses
  Firebase.Interfaces,
  Firebase.Database,
  System.SysUtils,
  Generics.Collections,
  System.Threading,
  System.JSON;

type

  TChatMessage = class(TObject)
  private
    FMsg: string;
    FUsername: string;
    FTimeStamp: TDateTime;
    procedure SetMsg(const Value: string);
    procedure SetUsername(const Value: string);
    procedure SetTimeStamp(const Value: TDateTime);
  public
    property Username: string read FUsername write SetUsername;
    property Msg: string read FMsg write SetMsg;
    property TimeStamp: TDateTime read FTimeStamp write SetTimeStamp;
  end;

  IFirebaseChatFacade = interface
    ['{84BAC826-AF2A-4422-A98F-53382119A693}']
    procedure SetBaseURI(const AURI: string);
    procedure SetToken(const AToken: string);
    procedure SetUsername(const AUsername: string);
    procedure SendMessage(AMessage: string);
    procedure SetOnNewMessage(AProc: TProc<TChatMessage>);
    procedure StartListenChat;
    procedure StopListenChat;
  end;

  TFirebaseChatFacade = class(TInterfacedObject, IFirebaseChatFacade)
  private
    FMessages: TDictionary<String, TChatMessage>;
    FBaseURI: string;
    FUsername: string;
    FOnNewMessage: TProc<TChatMessage>;
    Run: Boolean;
    FToken: string;
    procedure ParseResponse(AResp: IFirebaseResponse);
    procedure RemoveOlderMessage;
    procedure SetBaseURI(const Value: string);
    procedure SetUsername(const Value: string);
    procedure OnNewMessage(AChatMsg: TChatMessage);
    procedure SetToken(const Value: string);

  public
    constructor Create;
    destructor Destroy; override;
    property BaseURI: string read FBaseURI write SetBaseURI;
    property Username: string read FUsername write SetUsername;
    property Token: string read FToken write SetToken;
    procedure SetOnNewMessage(AProc: TProc<TChatMessage>);
    procedure SendMessage(AMessage: string);
    procedure StartListenChat;
    procedure StopListenChat;
  end;

implementation

uses
  System.Classes;

type
  TChatParser = class(TObject)
    class function GetMessage(AObj: TJSONObject): TChatMessage;
    class function GetJSON(AChatMessage: TChatMessage): TJSONObject; overload;
    class function GetJSON(AUsername: string; AMessage: string)
      : TJSONObject; overload;
  end;

  { TFirebaseChatFacade }

constructor TFirebaseChatFacade.Create;
begin
  inherited Create;
  FMessages := TDictionary<String, TChatMessage>.Create;
end;

destructor TFirebaseChatFacade.Destroy;
var
  I: Integer;
begin
  Run := false;
  for I := 0 to 2 do
    TThread.Sleep(50);
  if Assigned(FMessages) then
    FMessages.Free;
  inherited;
end;

procedure TFirebaseChatFacade.OnNewMessage(AChatMsg: TChatMessage);
begin
  TThread.Queue(nil,
    procedure
    begin
      FOnNewMessage(AChatMsg);
    end);
end;

procedure TFirebaseChatFacade.ParseResponse(AResp: IFirebaseResponse);
var
  Obj: TJSONObject;
  I: Integer;
  Key: string;
  ChatMsg: TChatMessage;
  JSONResp: TJSONValue;
begin
  JSONResp := TJSONObject.ParseJSONValue(AResp.ContentAsString);
  if (not Assigned(JSONResp)) or (not(JSONResp is TJSONObject)) then
  begin
    if Assigned(JSONResp) then
      JSONResp.Free;
    exit;
  end;
  Obj := JSONResp as TJSONObject;
  try
    TMonitor.Enter(FMessages);
    try
      for I := 0 to Obj.Count - 1 do
      begin
        Key := Obj.Pairs[I].JsonString.Value;
        if not FMessages.ContainsKey(Key) then
        begin
          ChatMsg := TChatParser.GetMessage
            (Obj.Pairs[I].JsonValue as TJSONObject);
          FMessages.Add(Key, ChatMsg);
          OnNewMessage(ChatMsg);
          RemoveOlderMessage;
        end;
      end;
    finally
      TMonitor.exit(FMessages);
    end;
  finally
    Obj.Free;
  end;
end;

procedure TFirebaseChatFacade.RemoveOlderMessage;
var
  Pair: TPair<string, TChatMessage>;
  Older: TDateTime;
  ToDelete: string;
begin
  TMonitor.Enter(FMessages);
  try
    if FMessages.Count < 20 then
      exit;
    Older := Now;
    for Pair in FMessages do
      if Pair.Value.TimeStamp < Older then
      begin
        Older := Pair.Value.TimeStamp;
        ToDelete := Pair.Key;
      end;
    if not ToDelete.IsEmpty then
      FMessages.Remove(ToDelete);
  finally
    TMonitor.exit(FMessages);
  end;
end;

procedure TFirebaseChatFacade.SendMessage(AMessage: string);
begin
  TTask.Run(
    procedure
    var
      FFC: IFirebaseDatabase;
      ToSend: TJSONObject;
    begin
      FFC := TFirebaseDatabase.Create;
      FFC.SetBaseURI(FBaseURI);
      FFC.SetToken(FToken);
      ToSend := TChatParser.GetJSON(FUsername, AMessage);
      FFC.Post(['.json'], ToSend);
    end);
end;

procedure TFirebaseChatFacade.SetBaseURI(const Value: string);
begin
  FBaseURI := Value;
end;

procedure TFirebaseChatFacade.SetOnNewMessage(AProc: TProc<TChatMessage>);
begin
  FOnNewMessage := AProc;
end;

procedure TFirebaseChatFacade.SetToken(const Value: string);
begin
  FToken := Value;
end;

procedure TFirebaseChatFacade.SetUsername(const Value: string);
begin
  FUsername := Value;
end;

procedure TFirebaseChatFacade.StartListenChat;
begin
  Run := true;
  TTask.Run(
    procedure
    var
      FFC: IFirebaseDatabase;
      Response: IFirebaseResponse;
      I: Integer;
      QueryParams: TDictionary<string, string>;
    begin
      FFC := TFirebaseDatabase.Create;
      FFC.SetBaseURI(FBaseURI);
      FFC.SetToken(FToken);
      QueryParams := TDictionary<string, string>.Create;
      try
        QueryParams.Add('orderBy', '"$key"');
        QueryParams.Add('limitToLast', '10');
        while Run do
        begin
          Response := FFC.Get(['.json'], QueryParams);
          ParseResponse(Response);
          for I := 0 to 5 do
          begin
            TThread.Sleep(100);
            if not Run then
              exit;
          end;
        end;
      finally
        QueryParams.Free;
      end;
    end);
end;

procedure TFirebaseChatFacade.StopListenChat;
begin
  Run := false;
end;

{ TChatMessage }

procedure TChatMessage.SetMsg(const Value: string);
begin
  FMsg := Value;
end;

procedure TChatMessage.SetTimeStamp(const Value: TDateTime);
begin
  FTimeStamp := Value;
end;

procedure TChatMessage.SetUsername(const Value: string);
begin
  FUsername := Value;
end;

{ TChatParser }

class function TChatParser.GetJSON(AChatMessage: TChatMessage): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('name', AChatMessage.Username);
  Result.AddPair('text', AChatMessage.Msg);
end;

class function TChatParser.GetJSON(AUsername, AMessage: string): TJSONObject;
var
  ChatMsg: TChatMessage;
begin
  ChatMsg := TChatMessage.Create;
  try
    ChatMsg.Username := AUsername;
    ChatMsg.Msg := AMessage;
    Result := TChatParser.GetJSON(ChatMsg);
  finally
    ChatMsg.Free;
  end;
end;

class function TChatParser.GetMessage(AObj: TJSONObject): TChatMessage;
var
LUserName: string;
LMessage: string;
begin
  AObj.TryGetValue('name', LUserName);
  AObj.TryGetValue('text', LMessage);
  Result := TChatMessage.Create;
  Result.Username := LUserName;
  Result.Msg := LMessage;
  Result.TimeStamp := Now;
end;

end.
