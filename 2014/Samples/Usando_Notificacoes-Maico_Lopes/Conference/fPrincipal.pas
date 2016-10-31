unit fPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.Memo, FMX.Notification,
  FMX.Platform;

type
  TfrmPrincipal = class(TForm)
    memMsg: TMemo;
    btnDisparar: TButton;
    btnAgendar: TButton;
    pnlgendar: TPanel;
    edtSegundos: TEdit;
    lblTitulo: TLabel;
    NotificationCenter: TNotificationCenter;
    btnCancelar: TButton;
    procedure btnDispararClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NotificationCenterReceiveLocalNotification(Sender: TObject;
      ANotification: TNotification);
    procedure btnAgendarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    FNotificationNumber: Integer;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

const
  NOTIFICACAO_DISPARADA = 'MinhaNotification';
  NOTIFICACAO_AGENDADA  = 'NotificacaoAgendada';

implementation

{$R *.fmx}
{$R *.SmXhdpiPh.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}

procedure TfrmPrincipal.btnAgendarClick(Sender: TObject);
var
  MyNotification: TNotification;
begin
  MyNotification := NotificationCenter.CreateNotification;
  try
    MyNotification.Name      := NOTIFICACAO_AGENDADA;
    MyNotification.AlertBody := 'Notificação agendada';
    MyNotification.FireDate  := Now + EncodeTime(0, 0, edtSegundos.Text.ToInteger, 0);
    NotificationCenter.ScheduleNotification(MyNotification);
  finally
    MyNotification.DisposeOf;
    ShowMessage('Notificação agendada para daqui ' + edtSegundos.Text + ' segundos');
  end;
end;

procedure TfrmPrincipal.btnCancelarClick(Sender: TObject);
begin
  NotificationCenter.CancelNotification(NOTIFICACAO_AGENDADA);
  ShowMessage('Notificação [' + NOTIFICACAO_AGENDADA + '] cancelada');
end;

procedure TfrmPrincipal.btnDispararClick(Sender: TObject);
var
  MyNotification: TNotification;
begin
  FNotificationNumber:= FNotificationNumber + 1;
  MyNotification     := NotificationCenter.CreateNotification;
  try
    MyNotification.Number    := FNotificationNumber;
    MyNotification.Name      := NOTIFICACAO_DISPARADA;
    MyNotification.HasAction := True;
    MyNotification.AlertBody := 'Exemplo de notificação #' + MyNotification.Number.ToString;
    NotificationCenter.PresentNotification(MyNotification);
  finally
    MyNotification.DisposeOf;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FNotificationNumber:= 0;
end;

procedure TfrmPrincipal.NotificationCenterReceiveLocalNotification(
  Sender: TObject; ANotification: TNotification);
begin
  memMsg.Lines.Add(ANotification.Name + ' -> ' + ANotification.AlertBody);
end;

end.
