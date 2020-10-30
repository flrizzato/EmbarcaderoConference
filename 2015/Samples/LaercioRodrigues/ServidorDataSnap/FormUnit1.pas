unit FormUnit1;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp, Winapi.ShellApi,
  Vcl.ExtCtrls, U_DSMPalestra;

type
  TForm1 = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ButtonOpenBrowser: TButton;
    MemoListaTag: TMemo;
    TimerLerSerial: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure TimerLerSerialTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    DSMPalestra : TDSMPalestra;
    FServer: TIdHTTPWebBrokerBridge;
    H : THandle;
    FRespTmp : array[0..1024] of Char;
    FHandleCom : THANDLE;
    const
      dcb_Binary = $00000001;
      dcb_ParityCheck = $00000002;
      dcb_DtrControlEnable = $00000010;
      dcb_OutX = $00000100;
      dcb_InX = $00000200;
      dcb_RtsControlEnable = $00001000;



    function  AbrePorta(Porta : Pchar) : THANDLE;
    procedure LerPorta;


    procedure StartServer;
  public
    { Public declarations }
    procedure EscreveDados(Cmd : string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
   Datasnap.DSSession, Winapi.Windows;

function TForm1.AbrePorta(Porta : Pchar) : THANDLE;
var
  dcbPar : TDCB;
  Timeouts : TCOMMTIMEOUTS;
begin
  SetLastError(0);
  Result := CreateFile(Porta, GENERIC_READ or GENERIC_WRITE,
                       0, nil, OPEN_EXISTING, 0, 0);
  if Result = INVALID_HANDLE_VALUE then
    Result := 0;
  if Result = 0 then
    Exit;
  try
    SetCommMask(Result, 0);
    SetupComm(Result, 4096, 0);
    FillChar(dcbPar, SizeOf(dcbPar), 0);
    dcbPar.DCBlength := SizeOf(dcbPar);
    if not GetCommState(Result, dcbPar) then
       raise Exception.Create('Erro lendo configurações da porta');
    dcbPar.BaudRate := CBR_9600;
    dcbPar.ByteSize := 8;
    dcbPar.Parity := NOPARITY;
    dcbPar.StopBits := ONESTOPBIT;
    dcbPar.wReserved := 8;
    dcbPar.XonLim := 4096 div 4;
    dcbPar.XoffLim := 4096 div 4;
    dcbPar.XonChar := #17;
    dcbPar.XoffChar := #19;
    dcbPar.ErrorChar := #0;
    dcbPar.Flags := dcb_Binary or dcb_DtrControlEnable;
    dcbPar.Flags := dcbPar.Flags or dcb_RtsControlEnable;
    if dcbPar.Parity > 0 then
        dcbPar.Flags := dcbPar.Flags or dcb_ParityCheck;
    if not SetCommState(Result, dcbPar) then
        raise Exception.Create('Erro escrevendo configurações da porta');
      GetCommTimeouts(Result, Timeouts);
      Timeouts.ReadIntervalTimeout := 2;
      Timeouts.ReadTotalTimeoutConstant := 150;
      SetCommTimeouts(Result, Timeouts);
  except
    PurgeComm(Result, PURGE_TXABORT or PURGE_TXCLEAR or PURGE_RXABORT or PURGE_RXCLEAR);
    FileClose(Result);
    Result := 0;
  end;
end;

procedure TForm1.LerPorta;
var
  vI  : integer;
  vS : String;
  i : integer;
  Limpa : string;
begin
   Limpa:='0';
   if H = 0 then
      H := AbrePorta('COM5');
   if H > 0 then
      try
        vI := 0;
        SetLength(vS, 30);
        while vI < 30 do
          begin
            if FileRead(H, vS[vI + 1], 1) = 1 then
               begin
                  Inc(vI);
                  if (Pos('INI', vS) > 0)  AND (Pos('FIN', vS) > 0) then
                     begin
                        TimerLerSerial.Enabled:=False;
                        FileWrite(H, Limpa, 30);
                        sleep(100);
                        MemoListaTag.Lines.Add(Copy(vS, 7, 8));
                        if DSMPalestra.ExisteTAG(Copy(vS, 7, 8)) then
                           begin
                              EscreveDados('CMDATIVAR');
                           end;
                        TimerLerSerial.Enabled:=True;
                     end;
               end
            else
               begin
                  Break;
               end;
          end;
      finally
         if MemoListaTag.Lines.Count > 500 then
            MemoListaTag.Lines.Clear;
      end;
end;

procedure TForm1.EscreveDados(Cmd : string);
var
  vI : integer;
  vS : String;
  Limpa:string;
begin
  if H = 0 then
     H := AbrePorta('COM5');
  SetLength(Limpa, 1);
  Limpa:='0';
  if H > 0 then
  try
    vI := 0;
    SetLength(Cmd, 9);
    while vI < 9 do
      begin
        if FileWrite(H, Cmd[vI + 1], 1) = 1 then
           begin
              Inc(vI);
           end;
      end;
     Sleep(100);
     FileWrite(H, Limpa, 1);
     MemoListaTag.Lines.Add('Enviado Comando CMDATIVAR.');
  finally

  end;
end;

procedure TForm1.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
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
   H := AbrePorta('COM5');
   Sleep(500);
   TimerLerSerial.Enabled:=True;
   DSMPalestra:=TDSMPalestra.Create(Self);
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

procedure TForm1.TimerLerSerialTimer(Sender: TObject);
begin
   LerPorta;
end;

end.
