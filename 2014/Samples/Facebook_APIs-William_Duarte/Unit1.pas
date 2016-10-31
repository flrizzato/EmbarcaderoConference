unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  REST.Utils, FMX.WebBrowser, IPPeerClient, REST.Client,
  REST.Authenticator.OAuth, Data.Bind.Components, Data.Bind.ObjectScope;

type
  TWebFormRedirectEvent = procedure(const AURL: string; var DoCloseWebView : boolean) of object;

  TForm1 = class(TForm)
    Button1: TButton;
    WebBrowser1: TWebBrowser;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    OAuth2Authenticator1: TOAuth2Authenticator;
    procedure Button1Click(Sender: TObject);
    procedure WebBrowser1ShouldStartLoadWithRequest(ASender: TObject;
      const URL: string);
  private
    { Private declarations }
    FAccessToken : String;
    FOnBeforeRedirect: TWebFormRedirectEvent;
    procedure Facebook_AccessTokenRedirect(const AURL: string; var DoCloseWebView: boolean);
    procedure SetOnBeforeRedirect(const Value: TWebFormRedirectEvent);
  public
    { Public declarations }
    property OnBeforeRedirect: TWebFormRedirectEvent read FOnBeforeRedirect write SetOnBeforeRedirect;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}

procedure TForm1.Button1Click(Sender: TObject);
var
  LURL: string;
begin
  LURL := 'https://www.facebook.com/dialog/oauth';
  LURL := LURL + '?client_id=' + URIEncode('941063429241183');
  LURL := LURL + '&response_type=token';
  LURL := LURL + '&scope=' + URIEncode('user_about_me,user_birthday');
  LURL := LURL + '&redirect_uri=' + URIEncode('https://www.facebook.com/connect/login_success.html');

  Self.OnBeforeRedirect := Facebook_AccessTokenRedirect;
  WebBrowser1.Navigate(LURL);



end;

procedure TForm1.Facebook_AccessTokenRedirect(const AURL: string;
  var DoCloseWebView: boolean);
var
  LATPos: integer;
  LToken: string;
begin
  try
    LATPos := Pos('access_token=', AURL);
    if (LATPos > 0) then
    begin
      LToken := Copy(AURL, LATPos + 13, Length(AURL));
      if (Pos('&', LToken) > 0) then
      begin
        LToken := Copy(LToken, 1, Pos('&', LToken) - 1);
      end;

      FAccessToken := LToken;
      if (LToken <> '') then
      begin
        DoCloseWebView := True;
      end;
    end
    else
    begin
      LATPos := Pos('api_key=', AURL);
      if LATPos <= 0 then
      begin
        LATPos := Pos('access_denied', AURL);

        if (LATPos > 0) then
        begin
          //Acesso negado/usuário cancelou/usuário não permitiu o acesso
          FAccessToken := '';
          DoCloseWebView := True;
        end;
      end;
    end;
  except
    on E: Exception do
      ShowMessage(E.Message);
  END;
end;

procedure TForm1.SetOnBeforeRedirect(const Value: TWebFormRedirectEvent);
begin
  FOnBeforeRedirect := Value;
end;

procedure TForm1.WebBrowser1ShouldStartLoadWithRequest(ASender: TObject;
  const URL: string);
var
  LDoCloseForm : boolean;
begin
  if Assigned(FOnBeforeRedirect) then
  begin
    LDoCloseForm:= FALSE;

    FOnBeforeRedirect(URL, LDoCloseForm);
  end;
end;

end.
