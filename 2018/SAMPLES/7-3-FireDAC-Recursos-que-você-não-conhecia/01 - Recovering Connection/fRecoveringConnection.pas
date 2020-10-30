unit fRecoveringConnection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Vcl.ExtCtrls, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.FB, FireDAC.Phys.FBDef;

type
  TFrmRecoveringConnection = class(TForm)
    memLog: TMemo;
    Connection: TFDConnection;
    panTest: TPanel;
    chcAutoReconnect: TCheckBox;
    btnPing: TButton;
    panConnection: TPanel;
    btnConnect: TButton;
    btnDisconnect: TButton;
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure ConnectionAfterConnect(Sender: TObject);
    procedure ConnectionAfterDisconnect(Sender: TObject);
    procedure ConnectionLost(Sender: TObject);
    procedure ConnectionRestored(Sender: TObject);
    procedure ConnectionRecover(ASender, AInitiator: TObject; AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
    procedure btnPingClick(Sender: TObject);
    procedure ConnectionBeforeConnect(Sender: TObject);
  private
    procedure SetLog(ALog: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRecoveringConnection: TFrmRecoveringConnection;

implementation

{$R *.dfm}

procedure TFrmRecoveringConnection.btnConnectClick(Sender: TObject);
begin
  Connection.Connected := True;
end;

procedure TFrmRecoveringConnection.btnDisconnectClick(Sender: TObject);
begin
  Connection.Connected := False;
end;

procedure TFrmRecoveringConnection.btnPingClick(Sender: TObject);
begin
  SetLog('Ping Iniciado');
  Connection.Ping;
  SetLog('Ping Finalizado');
  SetLog(EmptyStr);
end;

procedure TFrmRecoveringConnection.ConnectionBeforeConnect(Sender: TObject);
begin
  Connection.ResourceOptions.AutoReconnect := chcAutoReconnect.Checked;
end;

procedure TFrmRecoveringConnection.ConnectionAfterConnect(Sender: TObject);
begin
  SetLog('Connected');
end;

procedure TFrmRecoveringConnection.ConnectionAfterDisconnect(Sender: TObject);
begin
  SetLog('Disconnected');
end;

procedure TFrmRecoveringConnection.ConnectionLost(Sender: TObject);
begin
  SetLog('Connection Losted');
end;

procedure TFrmRecoveringConnection.ConnectionRecover(ASender, AInitiator: TObject; AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
begin
  SetLog('Connection Recovering');
end;

procedure TFrmRecoveringConnection.ConnectionRestored(Sender: TObject);
begin
  SetLog('Connection Restored');
end;

procedure TFrmRecoveringConnection.SetLog(ALog: String);
var
  Line: String;
begin
  if ALog <> EmptyStr then
    Line := DateTimeToStr(Now) + ' - ';
  memLog.Lines.Add(Line + ALog);
end;

end.
