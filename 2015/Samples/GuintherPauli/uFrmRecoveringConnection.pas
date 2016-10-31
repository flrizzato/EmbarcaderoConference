{
Sobre o autor:
Guinther Pauli
Cursos Treinamentos Consultoria
Delphi Certified Professional - 3,5,6,7,2005,2006,Delphi Web,Kylix,XE
Microsoft Certified Professional - MCP,MCAD,MCSD.NET,MCTS,MCPD (C#,ASP.NET, Arquitetura)
Colaborador Editorial Revistas .net Magazine e ClubeDelphi
MVP (Most Valuable Professional) - Embarcadero Technologies - US
http://guintherpauli.blogspot.com
http://www.gpauli.com
http://www.facebook.com/guintherpauli
http://www.twitter.com/guintherpauli
http://br.linkedin.com/in/guintherpauli
Emails: guintherpauli@gmail.com; guinther@gpauli.com
Suporte Skype: guinther.pauli
}
unit uFrmRecoveringConnection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, FireDAC.Phys.Intf, Vcl.StdCtrls;

type
  TFrmRecoveringConnection = class(TForm)
    btnPing: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPingClick(Sender: TObject);
  private
    procedure conRecover(
       ASender, AInitiator: TObject;
       AException: Exception;
       var AAction: TFDPhysConnectionRecoverAction);

  end;

var
  FrmRecoveringConnection: TFrmRecoveringConnection;

implementation

{$R *.dfm}

uses
  System.UITypes;

procedure TFrmRecoveringConnection.btnPingClick(Sender: TObject);
begin
  if DM.con.Ping() then
    ShowMessage('Conexão OK')
  else
    ShowMessage('Não há conexão');
end;

procedure TFrmRecoveringConnection.conRecover(
  ASender, AInitiator: TObject; AException: Exception;
  var AAction: TFDPhysConnectionRecoverAction);
var
  res: Integer;
begin
  res := MessageDlg(
    'Conexão foi perdida. Offline = Yes, Retry = Ok, Fail = Cancel',
    mtConfirmation, [mbYes, mbOK, mbCancel], 0);
  case res of
    mrYes:    AAction := faOfflineAbort;
    mrOk:     AAction := faRetry;
    mrCancel: AAction := faFail;
  end;
end;

procedure TFrmRecoveringConnection.FormCreate(Sender: TObject);
begin
  DM.con.ResourceOptions.AutoReconnect := true;
  DM.con.OnRecover := conRecover;
  DM.con.Open();
end;

end.
