unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Threading,

  Redis.Commons, Redis.Client, Redis.NetLib.INDY, Redis.Values, Vcl.StdCtrls

  ;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FCon: IRedisClient;
    FTask: ITask;
    FClosing: Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Self.FClosing := False;

  Self.FCon := NewRedisClient();

  Self.FTask := TTask.Run(
    procedure
    var
    oRedis: IRedisClient;
    begin
      // Conexão exclusiva com o REDIS
      oRedis := NewRedisClient();

      oRedis.SUBSCRIBE(
        // Array de canais sendo assinado
        ['EXEMPLO:PUBSUB'],

        // Método anônimo que trata a mensagem recebida
        procedure (ACanal: string; AMensagem: string)
        begin
          Memo1.Lines.Add(Format('%s - %s', [ACanal, AMensagem]));
        end,

        // Método anônimo que determinará a continuidade do SUBSCRIBE
        function: Boolean
        begin
          Result := Assigned(Self) and not Self.FClosing;
        end,

        // Método anônimo a ser executado após a efetivação da assinatura
        procedure
        begin
          Self.Memo1.Lines.Add('Assinatura em andamento!')
        end

      ); // Fim do Subscribe

      oRedis.Disconnect;
    end
  );
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Self.FCon.PUBLISH('EXEMPLO:PUBSUB', Self.Edit1.Text);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.FClosing := True;
end;

end.
