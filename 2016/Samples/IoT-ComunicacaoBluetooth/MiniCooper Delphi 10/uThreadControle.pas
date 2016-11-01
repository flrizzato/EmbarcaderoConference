unit uThreadControle;

interface

uses
  System.Classes, uComum, System.Bluetooth, System.SysUtils, Androidapi.JNI.JavaTypes;

type
  ThreadControle = class(TThread)
  private
    FComandos: TComandos;
    FSocket: TBluetoothSocket;
    FControlStream: JOutputStream;
    procedure SetComandos(const Value: TComandos);
    function GetComandos(): TComandos;
    procedure SetSocket(const Value: TBluetoothSocket);
    { Private declarations }
  protected
    procedure Execute; override;
  public
    property Comandos: TComandos read GetComandos write SetComandos;
    property Socket: TBluetoothSocket read FSocket write SetSocket;
    property ControlStream: JOutputStream read FControlStream write FControlStream;
  end;

implementation

{ ThreadControle }

procedure ThreadControle.Execute;
var
  Cmd: TComando;
begin
  while not Terminated do
  begin
    TMonitor.Enter(Self);
    try
      for Cmd := TComando.PararFrente to TComando.Direita do
      begin
        if Cmd in FComandos then
        begin
//          FControlStream.write(Ord(cmd));
          Socket.SendData([Ord(Cmd)]);
        end;
      end;
    finally
      TMonitor.Exit(Self);
    end;
    Sleep(30);
  end;

end;

function ThreadControle.GetComandos: TComandos;
begin
  TMonitor.Enter(Self);
  try
    result := FComandos;
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure ThreadControle.SetComandos(const Value: TComandos);
begin
  TMonitor.Enter(Self);
  try
    FComandos := Value;
  finally
    TMonitor.Exit(Self);
  end;
end;

procedure ThreadControle.SetSocket(const Value: TBluetoothSocket);
begin
  FSocket := Value;
end;

end.
