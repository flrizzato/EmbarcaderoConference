unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdUDPBase, IdUDPServer, IdGlobal, IdSocketHandle;

type
  TForm3 = class(TForm)
    IdUDPServer1: TIdUDPServer;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  IdUDPServer1.Active := not IdUDPServer1.Active;
  if IdUDPServer1.Active then
  begin
    Button1.Caption := 'Desativar';
  end
  else
  begin
    Button1.Caption := 'Ativar';
  end;
end;

procedure TForm3.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  s: string;
begin
  s := String(AData);
  s := s + ' recebido com sucesso.';
  ABinding.SendTo(ABinding.PeerIP, ABinding.PeerPort, s);
end;

end.
