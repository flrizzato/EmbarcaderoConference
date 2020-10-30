unit UClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DBXDataSnap, IPPeerClient, Data.DBXCommon, Data.DB, Data.SqlExpr;

type
  TFrmCliente = class(TForm)
    pnlClient: TPanel;
    pnlBottom: TPanel;
    btnLogin: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    SqlCn: TSQLConnection;
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCliente: TFrmCliente;

implementation

{$R *.dfm}

procedure TFrmCliente.btnLoginClick(Sender: TObject);
var scaption:string;
begin
  scaption := 'Logout';

  if not SqlCn.Connected then
  begin
    SqlCn.Params.Values['HostName'] := 'localhost';
    SqlCn.Params.Values['Port']     := '211';
    SqlCn.Params.Values['DSAuthenticationUser']     := edtUsuario.Text;
    SqlCn.Params.Values['DSAuthenticationPassword'] := edtSenha.Text;
  end;

  SqlCn.Connected := not SqlCn.Connected;

  if not SqlCn.Connected then
    scaption := 'Login';

  btnLogin.Caption := scaption;

end;

end.
