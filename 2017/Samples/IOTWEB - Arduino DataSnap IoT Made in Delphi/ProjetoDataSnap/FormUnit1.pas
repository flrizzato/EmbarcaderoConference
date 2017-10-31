unit FormUnit1;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer, IdGlobal, IdSocketHandle,
  System.Bluetooth, System.Bluetooth.Components, Vcl.ExtCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ButtonOpenBrowser: TButton;
    Memo1: TMemo;
    IdUDPServer1: TIdUDPServer;
    BitBtnMsgBluetooth: TBitBtn;
    BluetoothPC: TBluetooth;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure FormShow(Sender: TObject);
    procedure TimerBluetoothTimer(Sender: TObject);
    procedure BitBtnMsgBluetoothClick(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
     ///////////////////Bluetooth//////////////////////////////////////////////
    FSocket : TBluetoothSocket;
    const UUID = '{00001101-0000-1000-8000-00805F9B34FB}';

    function ObterDevicePeloNome(NomeDevice: String): TBluetoothDevice;
    function ConectarControladoraBluetooth(NomeDevice: String): boolean;
    //////////////////Bluetooth////////////////////////////////////////////////

    procedure StartServer;
    function HexToString(H: String): String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  WinApi.Windows, Winapi.ShellApi, Datasnap.DSSession;

procedure TForm1.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

procedure TForm1.BitBtnMsgBluetoothClick(Sender: TObject);
Var
  strRecebida : string;
begin
  BluetoothPC.Enabled:=True;
  if (FSocket = nil) or (not FSocket.Connected) then
     ConectarControladoraBluetooth('CONTROLADORA_HC05_200');
   if (FSocket <> nil) and (FSocket.Connected) then
      begin
        Memo1.Lines.Add('');
        Memo1.Lines.Add(DateTimeToStr(Now));
        strRecebida:='';
        FSocket.SendData(TEncoding.UTF8.GetBytes('L'));
        Memo1.Lines.Add('Enviado: L');
        sleep(300);
        strRecebida:=Trim(TEncoding.ANSI.GetString(FSocket.ReceiveData));
        Memo1.Lines.Add('Recebido -------->: ' + strRecebida);
        Application.ProcessMessages;
        FreeAndNil(FSocket);
      end;

end;

procedure TForm1.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TForm1.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TForm1.ButtonStopClick(Sender: TObject);
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  IdUDPServer1.Bindings.Add.IP:='192.168.25.50';
  IdUDPServer1.Bindings.Add.Port:=26800;
//  IdUDPServer1.Active:=True;
  if IdUDPServer1.Active then
     begin
        Memo1.Lines.Add('Serviço UDP Ativado com Sucesso');
     end
  else
     begin
        Memo1.Lines.Add('Serviço UDP Não Ativado');
     end;
end;

function TForm1.HexToString(H: String): String;
Var I : Integer;
begin
   Result:= '';
   for I := 1 to length (H) div 2 do
       Result:= Result+Char(StrToInt('$'+Copy(H,(I-1)*2+1,2)));
end;

procedure TForm1.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  StringRecebida : String;
  i : integer;
begin
   StringRecebida:='';
   for i:=0 to Length(AData) - 1 do
      begin
         StringRecebida:=StringRecebida +
                         HexToString( IntToHex(Integer(AData[i]), 2) );
      end;

   if StringRecebida <> '' then
      begin
         Memo1.Lines.Add('');
         Memo1.Lines.Add('Recebido: ' + StringRecebida + '  -  ' +
                         'IP Origem: ' + ABinding.PeerIP + '  -  ' +
                         'Porta Origem: ' + ABinding.PeerPort.ToString
                        );
      end;
end;

procedure TForm1.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
end;

procedure TForm1.TimerBluetoothTimer(Sender: TObject);

begin


end;

////////////////////////Bluetooth///////////////////////////////////////////////
function TForm1.ObterDevicePeloNome(NomeDevice: String): TBluetoothDevice;
var
  lDevice: TBluetoothDevice;
begin
  Result := nil;
  for lDevice in BluetoothPC.PairedDevices do
      begin
         if Trim(lDevice.DeviceName) = NomeDevice then
            begin
               Result := lDevice;
            end;
      end;
end;

function TForm1.ConectarControladoraBluetooth(NomeDevice: String): boolean;
var
  lDevice: TBluetoothDevice;
begin
  Result := False;
  lDevice := ObterDevicePeloNome(NomeDevice);
  if lDevice <> nil then
  begin
    FSocket := lDevice.CreateClientSocket(StringToGUID(UUID), False);
    if FSocket <> nil then
    begin
      FSocket.Connect;
      Result := FSocket.Connected
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////


end.
