unit Principal;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Datasnap.DBClient,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL;

type

  TVarreDiretorio = class(TThread)
  public
    procedure Execute; override;
  end;

  TfPrincipal = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    IdHTTP1: TIdHTTP;
    fpStreaming: TFlowPanel;
    Button1: TButton;
    Label3: TLabel;
    Label1: TLabel;
    lQuantidade: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FVarreVarre: TVarreDiretorio;
    FQuantidade: NativeUInt;
  public
    procedure Incrementar;
  end;

var
  fPrincipal: TfPrincipal;

implementation

uses
  System.JSON,
  System.TypInfo,
  Vcl.Imaging.jpeg,
  Twittada;

{$R *.dfm}
{ TVarreDiretorio }

procedure TVarreDiretorio.Execute;
const
  C_DIR_ALVO = '..\..\..\01 - Cliente WebSocket\EC2014WebClient\';
var
  iRet        : Integer;
  rLocalizador: TSearchRec;
  oLeitor     : TStringList;
  oMensagem   : TJSONValue;
  oTwitter    : TJSONObject;
  oFrame      : TFrame1;
  sTexto      : string;
  sUsuario    : string;
  oFoto       : TStringStream;
  sURL        : string;
begin
  oLeitor := TStringList.Create;
  iRet := FindFirst(C_DIR_ALVO + '*.json', 0, rLocalizador);
  while not Self.Terminated do
  begin
    if (iRet = 0) then
    begin
      oLeitor.LoadFromFile(C_DIR_ALVO + rLocalizador.Name);
      oMensagem := TJSONObject.ParseJSONValue(oLeitor.Text);
      if (oMensagem is TJSONObject) then
      begin
        oTwitter := TJSONObject(oMensagem);

        sTexto := oTwitter.Get('text').JsonValue.Value;
        sUsuario := TJSONObject(oTwitter.Get('user').JsonValue).Get('screen_name').JsonValue.Value;
        sURL := TJSONObject(oTwitter.Get('user').JsonValue).Get('profile_image_url').JsonValue.Value;

        oFoto := TStringStream.Create;
        fPrincipal.IdHTTP1.Get(sURL, oFoto);

        Self.Synchronize(
          procedure
          begin
            oFrame := TFrame1.Create(fPrincipal, sUsuario, sTexto, oFoto, fPrincipal.IdHTTP1.Response.ContentType);
            oFrame.Name := '';
            oFrame.Parent := fPrincipal.fpStreaming;
            oFoto.Free;

            fPrincipal.Incrementar;

            Application.ProcessMessages;
          end);
      end;
      oMensagem.Free;
      DeleteFile(C_DIR_ALVO + rLocalizador.Name);
    end
    else
    begin
      Sleep(1000);
    end;

    iRet := FindNext(rLocalizador);
    if (iRet <> 0) then
    begin
      iRet := FindFirst(C_DIR_ALVO + '*.json', 0, rLocalizador);
    end;
  end;
  FindClose(rLocalizador);
  oLeitor.Free;
end;

procedure TfPrincipal.Button1Click(Sender: TObject);
begin
  Self.FVarreVarre := TVarreDiretorio.Create;
  Self.Button1.Enabled := False;
end;

procedure TfPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(Self.FVarreVarre) then
  begin
    Self.FVarreVarre.Terminate;
    Self.FVarreVarre.WaitFor;
    Self.FVarreVarre.Free;
  end;
end;

procedure TfPrincipal.FormCreate(Sender: TObject);
begin
  Self.FQuantidade := 0;
  Self.lQuantidade.Caption := '0';
end;

procedure TfPrincipal.Incrementar;
begin
  Self.FQuantidade := Self.FQuantidade + 1;
  Self.lQuantidade.Caption := IntToStr(Self.FQuantidade);
end;

end.
