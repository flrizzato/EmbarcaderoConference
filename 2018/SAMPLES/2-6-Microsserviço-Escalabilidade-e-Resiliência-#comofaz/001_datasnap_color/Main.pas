unit Main;

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
  Datasnap.DSClientRest,
  Datasnap.DSCommonServer,
  Datasnap.DSServer,
  Datasnap.DSSession,
  IPPeerServer,
  Datasnap.DSHTTP,
  Vcl.ExtCtrls;

type

{$METHODINFO ON}
  TExemplo = class(TComponent)
  public
    function Exemplo: string;
  end;
{$METHODINFO OFF}

  TForm2 = class(TForm)
    DSServer1: TDSServer;
    Button1: TButton;
    DSHTTPService1: TDSHTTPService;
    DSServerClass1: TDSServerClass;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  System.Rtti;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  Self.Button1.Enabled         := False;
  Self.DSHTTPService1.HttpPort := StrToInt(Self.ComboBox1.Text);
  Self.DSServer1.Start;
end;

{ TExemplo }

function TExemplo.Exemplo: string;
begin
  Form2.Color := clRed;
  Application.ProcessMessages;

  Sleep(500);
  Result := Format('Você chegou ao DataSnap pela porta %s', [Form2.ComboBox1.Text]);

  Form2.Color := clBtnFace;
  Application.ProcessMessages
end;

procedure TForm2.DSServerClass1GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TExemplo;
end;

end.
