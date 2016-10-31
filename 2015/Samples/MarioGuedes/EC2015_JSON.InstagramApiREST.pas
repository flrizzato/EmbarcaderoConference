unit EC2015_JSON.InstagramApiREST;

interface

uses
  System.SysUtils,
  System.Classes,
  IPPeerClient,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Authenticator.OAuth,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdCustomTCPServer,
  IdCustomHTTPServer,
  IdHTTPServer,
  IdContext;

type
  TDataModule1 = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    OAuth2Authenticator1: TOAuth2Authenticator;
    IdHTTPServer1: TIdHTTPServer;
    procedure IdHTTPServer1CommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure PedirAutorizacao(const AClientID: string; const AClientSecret: string);
  end;

var
  DataModule1: TDataModule1;

implementation

uses
  Shellapi,
  Winapi.Windows,
  EC2015_JSON.Principal;

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  Self.IdHTTPServer1.Active := True;
end;

procedure TDataModule1.DataModuleDestroy(Sender: TObject);
begin
  Self.IdHTTPServer1.Active := False;
end;

procedure TDataModule1.IdHTTPServer1CommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
const
  C_TEXTOHTML = '<html><head><title>Embarcadero Conference 2015</title></head><strong>Obrigado!</strong></html>';
var
  oImagem: TStringList;
begin
  if (ARequestInfo.Params.IndexOfName('code') = -1) then
  begin
    AResponseInfo.ContentType := 'application/json';
    AResponseInfo.CustomHeaders.AddValue('Cache-Control', 'no-store, no-cache, must-revalidate, max-age=0');
    AResponseInfo.CustomHeaders.AddValue('Access-Control-Allow-Origin', '*');
    AResponseInfo.CustomHeaders.AddValue('Access-Control-Allow-Methods', 'POST, OPTIONS, PUT, GET');
    AResponseInfo.CustomHeaders.AddValue('Access-Control-Allow-Headers', 'Content-Type, Accept, Origin, x-requested-with');
    AResponseInfo.ContentText := fPrincipal.Memo2.Text;;
  end
  else
  begin
    Self.OAuth2Authenticator1.AuthCode := ARequestInfo.Params.Values['code'];

    Self.OAuth2Authenticator1.AccessTokenEndpoint := 'https://api.instagram.com/oauth/access_token';

    Self.OAuth2Authenticator1.ChangeAuthCodeToAccesToken;

    AResponseInfo.ContentText := Format(C_TEXTOHTML, ['']);
  end;
end;

procedure TDataModule1.PedirAutorizacao(const AClientID: string; const AClientSecret: string);
begin
  Self.IdHTTPServer1.Active := True;
  Self.OAuth2Authenticator1.ResetToDefaults;
  Self.OAuth2Authenticator1.ClientID := AClientID;
  Self.OAuth2Authenticator1.ClientSecret := AClientSecret;
  Self.OAuth2Authenticator1.AuthorizationEndpoint := 'https://api.instagram.com/oauth/authorize/';
  Self.OAuth2Authenticator1.ResponseType := TOAuth2ResponseType.rtCODE;
  Self.OAuth2Authenticator1.Scope := '';
  Self.OAuth2Authenticator1.RedirectionEndpoint := 'http://127.0.0.1:9090';
  ShellExecute(0, 'OPEN', PChar(DataModule1.OAuth2Authenticator1.AuthorizationRequestURI()), '', '', SW_SHOWNORMAL);
end;

end.
