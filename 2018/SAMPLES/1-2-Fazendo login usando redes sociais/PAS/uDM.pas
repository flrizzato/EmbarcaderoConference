unit uDM;

interface

uses
  UClassGlobal,
  {$IFDEF ANDROID}
  Androidapi.JNI.PowerManager,
  {$ENDIF ANDROID}

//  Androidapi.Helpers,
  //FMX.Helpers.Android,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, System.IniFiles,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.FMXUI.Wait, IPPeerClient, REST.Client, FMX.Dialogs, Data.FireDACJSONReflect,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Comp.Client, System.IOUtils,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet, System.Classes, System.SysUtils,
  REST.Response.Adapter, System.ImageList, REST.Authenticator.OAuth, REST.Types,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer, IdHTTPServer,
  IdContext, System.JSON, System.Net.URLClient;

type

  Tdm = class(TDataModule)
    IdHTTPServer1: TIdHTTPServer;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    OAuth2Authenticator1: TOAuth2Authenticator;
    RESTClientPhoto: TRESTClient;
    RESTRequestPhoto: TRESTRequest;
    RESTResponsePhoto: TRESTResponse;
    procedure IdHTTPServer1CommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure IdHTTPServer1CommandError(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo; AException: Exception);
  private
    { Private declarations }
    {$IFDEF ANDROID}
    fWakeLock: JWakeLock;
    {$ENDIF ANDROID}

  public
    { Public declarations }
  end;

var
  dm: Tdm;

  bGoogleLogin, bFacebookLogin, bJaMostrou : Boolean;
  AccessToken : String;

implementation

uses fLogin, FAutenticacao;

{$R *.dfm}

procedure Tdm.IdHTTPServer1CommandError(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo; AException: Exception);
begin
  ShowMessage('AException: ' + AException.Message);

  frmLogin.WebBrowser1.Visible := False;
end;

procedure Tdm.IdHTTPServer1CommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  cAuthCode, cTeste : String;
begin
  if (ARequestInfo.Params.IndexOfName('code') = -1) then begin
    Exit;
  end;

  cAuthCode := ARequestInfo.Params.Values['code'];

  OAuth2Authenticator1.AuthCode := cAuthCode;
  OAuth2Authenticator1.AccessTokenEndpoint := 'https://accounts.google.com/o/oauth2/token';
  OAuth2Authenticator1.ChangeAuthCodeToAccesToken;

  AResponseInfo.ContentText := '<html><body><script language=javascript>window.close();</script>Acesso permitido!</body></html>';
  AccessToken   := OAuth2Authenticator1.AccessToken;
  frmAutenticacao.btnOk.Enabled := True;
end;

end.
