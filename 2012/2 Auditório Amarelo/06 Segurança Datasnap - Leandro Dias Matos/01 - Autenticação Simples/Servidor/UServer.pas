unit UServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerServer, Datasnap.DSCommonServer,
  Datasnap.DSTCPServerTransport, Datasnap.DSServer, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons;

type
  TfrmServer = class(TForm)
    DSServer: TDSServer;
    DSTCPServerTransport: TDSTCPServerTransport;
    pnlTop: TPanel;
    pnlClient: TPanel;
    lblProtocolo: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblIP: TLabel;
    lblAcesso: TLabel;
    lblSessao: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    procedure DSServerConnect(DSConnectEventObject: TDSConnectEventObject);
  private
    { Private declarations }
    function ValidaUsuario(pUsuario,pSenha:string):boolean;
  public
    { Public declarations }
  end;

var
  frmServer: TfrmServer;

implementation

{$R *.dfm}

{ TfrmServer }

procedure TfrmServer.DSServerConnect(DSConnectEventObject: TDSConnectEventObject);
var sUsuario,sSenha: string;
begin

  lblProtocolo.Caption :=  DSConnectEventObject.ChannelInfo.ClientInfo.Protocol;
  lblIP.Caption        :=  DSConnectEventObject.ChannelInfo.ClientInfo.IpAddress;
  lblSessao.Caption    :=  IntToStr(DSConnectEventObject.ChannelInfo.Id);

  with DSConnectEventObject.ConnectProperties do
  begin
    sUsuario := Properties.Values['DSAuthenticationUser'];
	  sSenha   := Properties.Values['DSAuthenticationPassword'];
  end;

  if not (ValidaUsuario(sUsuario,sSenha)) then
  begin
    lblAcesso.Caption    := 'Não Autorizado!!!';
    raise Exception.Create('Usuário não cadastrado!');
  end;
  lblAcesso.Caption    := 'Autorizado!!!';
end;

function TfrmServer.ValidaUsuario(pUsuario, pSenha: string): boolean;
begin
  result := (UpperCase(pUsuario) = 'DELPHI') and (UpperCase(pSenha) = 'XE3');
end;

end.
