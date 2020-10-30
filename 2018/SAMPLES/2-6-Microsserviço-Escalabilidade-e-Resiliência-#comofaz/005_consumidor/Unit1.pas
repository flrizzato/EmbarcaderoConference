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
  Redis.Values,
  Vcl.ExtCtrls

    ;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
begin
  Self.Button1.Enabled := False;

  Self.Label1.Caption := '0';

  Self.FTask := TTask.Run(

    procedure
    var
      oRedis: IRedisClient;
      oValue: TRedisArray;
      iCount: Integer;
    begin

      oRedis := NewRedisClient();

      while TTask.CurrentTask.Status <> TTaskStatus.Canceled do
      begin
        // Puxando o próximo da fila, esperando 10 segundos
        oValue := oRedis.BLPOP(['EC2018:EXEMPLO:FILA'], 10);
        if not oValue.IsNull then
        begin
          Inc(iCount);

          // Sincronização com a Thread principal
          TThread.Synchronize(nil,

            procedure
            var
              sLog: string;
            begin
              sLog := Format('%s - %s', [oValue.Value[0].Value, oValue.Value[1].Value]);
              Self.Memo1.Lines.Add(sLog);
              Self.Label1.Caption := Format('%d comandos processados!',[iCount]);
            end);

          // Representa um processamento qualquer
          Sleep(250);
        end;
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

end.
