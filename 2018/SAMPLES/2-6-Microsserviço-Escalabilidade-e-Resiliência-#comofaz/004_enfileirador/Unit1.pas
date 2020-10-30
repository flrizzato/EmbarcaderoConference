unit Unit1;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  System.Threading,

  Redis.Commons,
  Redis.Client,
  Redis.NetLib.INDY,
  Redis.Values

    ;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FTask: ITask;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
const
  C_NOME_FILA = 'EC2018:EXEMPLO:FILA';
var
  iCount: Integer;
  iPID  : Integer;
begin
  Self.Button1.Enabled := False;

  iCount := 0;
  iPID   := GetCurrentProcessID;

  Self.FTask := TTask.Run(

    procedure
    var
      oRedis: IRedisClient;
      iQtd: Integer;
      sMensagem: string;
    begin

      oRedis := NewRedisClient();

      while TTask.CurrentTask.Status <> TTaskStatus.Canceled do
      begin
        // Simula um processamento qualquer
        Sleep(100);

        // Enfilera uma mensagem na fila
        Inc(iCount);
        sMensagem := Format('MENSAGEM #%d do PID %d', [iCount, iPID]);
        iQtd := oRedis.RPUSH(C_NOME_FILA, [sMensagem]);

        TThread.Synchronize(nil,

          procedure
          begin
            Self.Label1.Caption := Format('%d elementos na fila %s', [iQtd, C_NOME_FILA]);
          end);

      end;

    end

    );
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(Self.FTask) then
  begin
    Self.FTask.Cancel();
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.Label2.Caption := Format('PRODUTOR - PID: %d', [GetCurrentProcessID]);
end;

end.
