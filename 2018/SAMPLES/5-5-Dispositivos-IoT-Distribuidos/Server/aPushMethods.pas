unit aPushMethods;
interface
uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, System.IniFiles,
    lPushData, DBXPlatform;

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
    //Registro
    function UpdateDevice(const DeviceInfo: TPushDevice): TJSONObject;
    //Envio
    function SendMessageToUser(const UserId, Title, Msg: string): TJSONObject;
    function SendMessageToAll(const Title, Msg: string): TJSONObject;

    function Autenticacao(vAplicacao, vSenha: String): TJSONArray;
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
  FGooglePushServerKey:='AAAA3N75Hn4:APA91bGdsuGHgK4N8_RnGQdDirVn1QxS6lv7tUfi8bU6ZJzKOvSsG9bNMJzU17PKnuoddtUr09Kn1_HDp76q664a7QuHc_yQhUTsPcBgI191FPSilkgDSXnqC69vRKoXWsOjPRxdH2ao';
  EXIT;
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

function TPushMethods.Autenticacao(vAplicacao, vSenha: String): TJSONArray;
var
objJSONObject : TJSONObject;
objJSONArray  : TJSONArray;
i             : Integer;

begin

//SetDatetime;

//cdsAutenticacao.Params.Clear;
//cdsAutenticacao.Close;
//cdsAutenticacao.Params.CreateParam(ftString, 'Aplicacao', ptInput);
//cdsAutenticacao.Params.CreateParam(ftString, 'Senha',     ptInput);
//
//with fdqAutenticacao do
//   begin
//   Sql.Text := ' Select * from Autenticacao'+
//               ' Where Aplicacao = :Aplicacao'+
//               '   and Senha     = :Senha';
//
//   if (vAplicacao <> '') and
//      (vSenha <> '') then
//      begin
//      cdsAutenticacao.Params.ParamByName('Aplicacao').Value := vAplicacao;
//      cdsAutenticacao.Params.ParamByName('Senha').Value     := vSenha;
//      end
//   else
//      begin
//      cdsAutenticacao.Params.ParamByName('Aplicacao').Value := 'Vazio';
//      cdsAutenticacao.Params.ParamByName('Senha').Value     := 'Vazio';
//      end;
//
//   end;
//
//cdsAutenticacao.Open;

   try
   objJSONObject := TJSONObject.Create;
   objJSONArray  := TJSONArray.Create();

//   if not cdsAutenticacao.Eof then
      begin
      objJSONObject.AddPair(TJSONPair.
                            Create(
                            'Ticket',  '557852n1n\686634XNHX'
                            //cdsAutenticacao.FieldByName('Ticket').AsString
                            )
                            );
      end;

   objJSONArray.AddElement(objJSONObject);
//   cdsAutenticacao.Next;

   finally
   GetInvocationMetadata().ResponseCode    := 200;
   GetInvocationMetadata().ResponseContent := objJSONArray.ToString;
   Result := objJSONArray;
   end;

end;


end.

