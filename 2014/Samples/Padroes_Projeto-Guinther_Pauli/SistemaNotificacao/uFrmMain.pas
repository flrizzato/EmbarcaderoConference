{
Sobre o autor:
Guinther Pauli
Delphi Certified Professional - 3,5,6,7,2005,2006,Delphi Web,Kylix,XE
Microsoft Certified Professional - MCP,MCAD,MCSD.NET,MCTS,MCPD (C#, ASP.NET, Arquitetura)
Colaborador Editorial Revistas .net Magazine e ClubeDelphi
MVP (Most Valuable Professional) - Embarcadero Technologies - US
http://gpauli.com
http://www.facebook.com/guintherpauli
http://www.twitter.com/guintherpauli
http://br.linkedin.com/in/guintherpauli
}

unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrmMain = class(TForm)
    edtMensagem: TEdit;
    btnNotificar: TButton;
    cmbFormaEnvio: TComboBox;
    procedure btnNotificarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses uFramework;

procedure TFrmMain.btnNotificarClick(Sender: TObject);
var
  envio: TNotificacao;
  ctx: TContext;
  msg: TMessage;
begin
  msg := TMessage.Create();
  msg.Mensagem := edtMensagem.Text;
  //msg.Data := ....
  envio := TFabrica.CreateInstance(TFormaNotificacao(cmbFormaEnvio.ItemIndex));
  ctx := TContext.Create(envio);
  ctx.Enviar(msg);
end;

end.
