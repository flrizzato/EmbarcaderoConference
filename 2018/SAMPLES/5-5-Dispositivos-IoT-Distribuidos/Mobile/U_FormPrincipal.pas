unit U_FormPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, lPush,
  System.UIConsts,

  {$IFDEF ANDROID}
  Lib.Android.Account, Lib.AndroidUtils,
  {$ENDIF}
  Lib.DeviceInfo, Lib.Ver,
  aConsts, lPushData,
  System.PushNotification,
  ccPush, System.JSON, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, Datasnap.DSClientRest, IdBaseComponent,
  IdComponent, IdUDPBase, IdUDPServer, FMX.Edit;

type
  TFormPrincipal = class(TForm)
    PushManagerApp: TPushManager;
    LayoutCorpo: TLayout;
    ToolBarTop: TToolBar;
    NetHTTPRequestChat: TNetHTTPRequest;
    NetHTTPClientChat: TNetHTTPClient;
    DSRestConnection: TDSRestConnection;
    ButtonPlayPush: TButton;
    LabelMensagemPush: TLabel;
    IdUDPServer: TIdUDPServer;
    LabelMensagemUDP: TLabel;
    ButtonEnvioUDP: TButton;
    EditIPLocal: TEdit;
    EditIPServer: TEdit;
    EditIPControladora: TEdit;
    procedure PushManagerAppMessage(Sender: TObject;
      const ANotification: TPushServiceNotification);
    procedure PushManagerAppPushChange(Sender: TObject;
      AChange: TPushService.TChanges);
    procedure ToolBarTopClick(Sender: TObject);
    procedure ButtonPlayPushClick(Sender: TObject);
    procedure ButtonEnvioUDPClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    ///////////////////////////////////////Push/////////////////////////////////
    function  GetUserIdDestino : int64;
    function  DoSendRegistration(const DeviceToken: string): TJSONValue;
    procedure SendRegistration(const DeviceToken: string);
//    procedure EnviarMensagem(Msg : String);
    ///////////////////////////////////////Push/////////////////////////////////
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  System.Threading, U_Proxy;

{$R *.fmx}

////////////////////////////////////////////////////////////////////////////////
function TFormPrincipal.GetUserIdDestino : int64;
begin
   Result:=2;
end;

procedure TFormPrincipal.ButtonEnvioUDPClick(Sender: TObject);
begin
   if IdUDPServer.Active then
      begin
         IdUDPServer.Send(EditIPControladora.Text, 26000, 'TX - MOBILE');
         LabelMensagemPush.Text:='TX - Dados Enviados.';
      end;
end;

procedure TFormPrincipal.ButtonPlayPushClick(Sender: TObject);
begin
   IdUDPServer.Active:=False;
   IdUDPServer.Bindings.Add.IP:=EditIPLocal.Text;
   IdUDPServer.Bindings.Add.Port:=26000;
   IdUDPServer.Active:=True;
   if IdUDPServer.Active then
      begin
         LabelMensagemUDP.Text:='Serviço UDP Ativido.';
      end;

end;

function TFormPrincipal.DoSendRegistration(const DeviceToken: string): TJSONValue;
var
  deviceInfo: TPushDevice;
begin
  result:= nil;
  try
    deviceInfo:= TPushDevice.Create(GetUserIdDestino, TMobileDeviceInfo.DeviceID, DeviceToken,
                                    TMobileDeviceInfo.DeviceModel,
                                    TMobileDeviceInfo.OSName, TMobileDeviceInfo.OSVersion,
                                    TAppVer.GetVerName, RECEIVE_PUSH_YES);
    try
      with TPushMethodsClient.Create(DSRestConnection, true) do
      try
        result:= UpdateDevice(deviceInfo);
      finally
        Free;
      end;
    finally
      deviceInfo.Free;
    end;
  except
    On E: Exception do
    begin
      Result:= TJSONObject.Create.AddPair('result', E.Message);
    end;
  end;
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
   PushManagerApp.Active:=False;
   sleep(2000);
   PushManagerApp.Active:=True;
   DSRestConnection.Host:=EditIPServer.Text;
end;

procedure TFormPrincipal.SendRegistration(const DeviceToken: string);
begin
  TTask.Run(
    procedure
    var
      Result: TJSONValue;
      Tries: integer;
      ResultValue: string;
    begin
      Tries:= 0;
      repeat
        try
          Result:= DoSendRegistration(DeviceToken);
        except
        end;
        if assigned(Result) and Result.TryGetValue('success', ResultValue) then
        begin
          if  (ResultValue = EmptyStr)  then
            TThread.Current.Sleep(TIME_BETWEEN_TRIES)
          else
          begin
            TThread.Synchronize(nil,
              procedure
              begin
//                Memo.Lines.Add(ResultValue);
              end
            );
          end;
        end;
        Inc(Tries);
      until (ResultValue <> '0') or (Tries = MAX_REG_TRIES);
    end);
end;

procedure TFormPrincipal.ToolBarTopClick(Sender: TObject);
begin

end;

////////////////////////////////////////////////////////////////////////////////

procedure TFormPrincipal.PushManagerAppMessage(Sender: TObject;
  const ANotification: TPushServiceNotification);
var
  Valor: string;
  JSONObject : TJSONObject;
begin
   JSONObject:=ANotification.Json;
   Valor:=JSONObject.GetValue('message').ToString;
   LabelMensagemPush.Text:='Serviço PushNotification......';
   IdUDPServer.Active:=False;
   IdUDPServer.Bindings.Add.IP:=EditIPLocal.Text;
   IdUDPServer.Bindings.Add.Port:=26000;
   IdUDPServer.Active:=True;
   IdUDPServer.Send(EditIPControladora.Text, 26000, 'TX - PushNotification');
//   if not IdUDPServer.Active then
//      begin
//         IdUDPServer.Active:=False;
//         IdUDPServer.Bindings.Add.IP:='192.168.0.102';
//         IdUDPServer.Bindings.Add.Port:=26000;
//         IdUDPServer.Active:=True;
//         LabelMensagemUDP.Text:='Serviço PushNotification.';
//         IdUDPServer.Send('192.168.0.110', 26000, 'TX - PushNotification');
//      end;
end;

procedure TFormPrincipal.PushManagerAppPushChange(Sender: TObject;
  AChange: TPushService.TChanges);
begin
   if TPushService.TChange.DeviceToken in AChange then
      begin
         SendRegistration(PushManagerApp.DeviceToken);
      end;
end;

end.
