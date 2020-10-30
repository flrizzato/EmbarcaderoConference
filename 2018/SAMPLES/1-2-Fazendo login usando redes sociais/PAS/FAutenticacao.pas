unit FAutenticacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Controls.Presentation, System.Sensors,
  System.Sensors.Components, FMX.Layouts, FMX.TabControl,

  JSON, Rest.Client, REST.JSON, Rest.Types,

  FMX.WebBrowser

  {$IFDEF ANDROID}
    ,Androidapi.JNI.GraphicsContentViewText
    ,Androidapi.JNI.App
    ,FMX.Platform.Android
    ,FMX.WebBrowser.Android
    ,Androidapi.Helpers
    ,Androidapi.JNI.JavaTypes
    ,Androidapi.JNI.Net
    ,Androidapi.JNIBridge
    ,Androidapi.JNI.Provider
    ,Androidapi.JNI.Location
    ,Androidapi.JNI.Os
  {$ENDIF ANDROID}

  ,IdURI, FMX.ListBox, FMX.SearchBox, FMX.ScrollBox, FMX.Memo,
  FMX.Gestures, FMX.Maps, FMX.Objects, System.ImageList, FMX.ImgList, IdContext, IdCustomHTTPServer, IdBaseComponent, IdComponent, IdCustomTCPServer, IdHTTPServer, FMX.Edit;

type
  TfrmAutenticacao = class(TForm)
    WebBrowser1: TWebBrowser;
    Layout1: TLayout;
    tabPrincipal: TTabControl;
    tabAutenticacao: TTabItem;
    GridPanelLayout5: TGridPanelLayout;
    ImageControl2: TImageControl;
    btnOk: TButton;
    StyleBook1: TStyleBook;
    Memo1: TMemo;
    Image1: TImage;
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
    procedure WebBrowser1DidFinishLoad(ASender: TObject);
  private
    procedure RequestAccessTokenFB(const AURL: String; var aCloseBrowser : Boolean);
    procedure ExecutaRequestFB(aAccessToken: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAutenticacao : TfrmAutenticacao;
  FCompleto       : Boolean;

implementation

{$R *.fmx}

uses fLogin, uDM;

{ TfrmAutenticacao }

procedure TfrmAutenticacao.btnOkClick(Sender: TObject);
var
  iCodRet, iTentativas  : Integer;
  sStatusText, sCaption : String;

  sName, sGiven_Name, sFamily_Name,
  sProfile, sPicture, sEmail,
  sEmail_Verified, sGender, sLocale : String;

begin
  if (btnOk.Text = 'Fechar') then
  begin
    WebBrowser1.Navigate('about:blank');
    btnOk.Text := 'Ok';
    Close;
    Exit;
  end;

  if bGoogleLogin then
  begin
    sCaption := Caption;

    dm.RESTRequest1.Params.Clear;
    dm.RESTClient1.BaseURL := 'https://www.googleapis.com/oauth2/v3/userinfo';

    iTentativas := 1;

    while iTentativas <= 3 do
    begin
      try
        dm.RESTRequest1.Execute;
        iCodRet     := dm.RESTResponse1.StatusCode;
        sStatusText := dm.RESTResponse1.StatusText;
      except
        iCodRet := 0;
      end;

      if (iCodRet = 200) then
      begin
        Break;
      end;

      if (iCodRet = 429) then
      begin
        iTentativas := iTentativas + 1;
        Caption := 'Aguardando conexão ...';
        Sleep(10000);
      end;
    end;

    if (iCodRet = 200) then
    begin
      sName           := TJSONObject(dm.RESTResponse1.JSONValue).GetValue('name').Value;
      sGiven_Name     := TJSONObject(dm.RESTResponse1.JSONValue).GetValue('given_name').Value;
      sFamily_Name    := TJSONObject(dm.RESTResponse1.JSONValue).GetValue('family_name').Value;
      sProfile        := TJSONObject(dm.RESTResponse1.JSONValue).GetValue('profile').Value;
      sPicture        := TJSONObject(dm.RESTResponse1.JSONValue).GetValue('picture').Value;
      sEmail          := TJSONObject(dm.RESTResponse1.JSONValue).GetValue('email').Value;
      sEmail_Verified := TJSONObject(dm.RESTResponse1.JSONValue).GetValue('email_verified').Value;
      sGender         := TJSONObject(dm.RESTResponse1.JSONValue).GetValue('gender').Value;
      sLocale         := TJSONObject(dm.RESTResponse1.JSONValue).GetValue('locale').Value;

      if not sPicture.IsEmpty then
      begin
        Image1.Bitmap.LoadFromStream(frmLogin.BuscarFoto_HTTP(sPicture));
      end;
    end;

    Memo1.Visible  := True;
    Image1.Visible := True;

    Memo1.Lines.Add('name: ' + sName);
    Memo1.Lines.Add('given_name: ' + sGiven_name);
    Memo1.Lines.Add('family_name: ' + sFamily_Name);
    Memo1.Lines.Add('profile: ' + sProfile);
    Memo1.Lines.Add('picture: ' + sPicture);
    Memo1.Lines.Add('email: ' + sEmail);
    Memo1.Lines.Add('email_verified: ' + sEmail_Verified);
    Memo1.Lines.Add('gender: ' + sGender);
    Memo1.Lines.Add('locale: ' + sLocale);
  end;

  WebBrowser1.Visible := False;
//  Image1.Visible      := False;

  btnOk.Text := 'Fechar';

  Caption := sCaption;
end;

procedure TfrmAutenticacao.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
 if Key = vkHardwareBack then
 begin
   Key := 0; {Prevenir ação padrão}
   close;
 end;
end;

procedure TfrmAutenticacao.WebBrowser1DidFinishLoad(ASender: TObject);
var
  bCloseBrowser : Boolean;
  sUrl, sToken : String;
  iPosString : Integer;
begin
  if bFacebookLogin and not bJaMostrou then
  begin
    sUrl := TWebBrowser(ASender).URL;
    iPosString := Pos('access_token=', sURL, 4);

    if (iPosString > 0) then
    begin
      sToken := Copy(sURL, iPosString+13, Length(sURL));

      if (Pos('&', sToken) > 0) then
      begin
        sToken := Copy(sToken, 1, Pos('&', sToken) -1);
      end;

      if (sToken <> '') then
      begin
        ExecutaRequestFB(sToken);
        Exit;
      end;
    end
    else begin
      Exit;
    end;

    bCloseBrowser := False;

    if (sUrl <> '') then
    begin
      RequestAccessTokenFB(sURL, bCloseBrowser);
    end;

    if bCloseBrowser then
    begin
      TWebBrowser(ASender).Stop;
      TWebBrowser(ASender).URL := '';
      WebBrowser1.Visible := False;
    end;
  end;
end;


procedure TfrmAutenticacao.RequestAccessTokenFB(const AURL : String; var aCloseBrowser : Boolean);
var
  iPosString    : integer;
  sToken        : string;
begin
  try
    aCloseBrowser := False;
    iPosString := Pos('access_token=', aURL);

    if (iPosString > 0) then
    begin
      sToken := Copy(AURL, iPosString+13, Length(aURL));

      if (Pos('&', sToken) > 0) then
      begin
        sToken := Copy(sToken, 1, Pos('&', sToken) -1);
      end;

      if (sToken <> '') then
      begin
        ExecutaRequestFB(sToken);
        Exit;
      end;
    end
    else begin
      iPosString := Pos('api_key=', AURL);

      if (iPosString <= 0) then
      begin
        iPosString := Pos('access_denied', AURL);

        if (iPosString > 0) then
        begin
          {Acesso Negado}
          sToken := '';
          aCloseBrowser := True;
        end;
      end;
    end;
  except
    on e : Exception do
    begin
      ShowMessage(e.message);
    end;
  end;
end;

procedure TfrmAutenticacao.ExecutaRequestFB(aAccessToken : String);
var
  iCodRet     : Integer;
  sStatusText, sCaption : String;

  oPicture, oURL : TJSONObject;

  sName, sLast_Name, sEmail, sPicture : String;
begin
  if (btnOk.Text = 'Fechar') then
  begin
    btnOk.Text := 'Ok';
    Close;
  end;

  sCaption := Caption;

  dm.RESTRequest1.ResetToDefaults;
  dm.RESTClient1.ResetToDefaults;
  dm.RESTResponse1.ResetToDefaults;

  dm.RESTClient1.BaseURL   := 'https://graph.facebook.com/me';
  dm.RESTRequest1.AddParameter('fields', 'first_name, last_name, email, picture.height(150)', pkGETorPOST);
  dm.OAuth2Authenticator1.AccessToken := aAccessToken;

  dm.RESTRequest1.Execute;

  try
    iCodRet     := dm.RESTResponse1.StatusCode;
    sStatusText := dm.RESTResponse1.StatusText;
    bJaMostrou  := True;
  except
    iCodRet := 0;
  end;

  if (iCodRet = 200) then
  begin
    dm.RESTResponse1.JSONText;

    sName      := TJSONObject(dm.RESTResponse1.JSONValue).GetValue('first_name').Value;
    sLast_Name := TJSONObject(dm.RESTResponse1.JSONValue).GetValue('last_name').Value;

//    try
//      sEmail := TJSONObject(dm.RESTResponse1.JSONValue).GetValue('email').Value;
//    except
//    end;

    oPicture := TJSONObject(TJSONObject(TJSONObject(dm.RESTResponse1.JSONValue).GetValue('picture')).GetValue('data'));
    sPicture := TJSONObject(oPicture).GetValue('url').Value;
//    oPicture := TJSONArray(TJSONObject(oPicture).GetValue('picture'));

    if (oPicture <> nil) then
    begin
      oURL := TJSONObject(TJSONObject(oPicture).GetValue('url'));

      if (oURL <> nil) then
      begin
        sPicture := TJSONString(TJSONValue(oURL)).Value;
      end
      else begin
        sPicture := '';
      end;
    end;

    if not sPicture.IsEmpty then
    begin
      Image1.Bitmap.LoadFromStream(frmLogin.BuscarFoto_HTTP(sPicture));
    end;
  end;

  Memo1.Visible := True;

  Memo1.Lines.Add('name: ' + sName);
  Memo1.Lines.Add('last_name: ' + slast_name);
  Memo1.Lines.Add('picture: ' + sPicture);
  Memo1.Lines.Add('email: ' + sEmail);

  WebBrowser1.Visible := False;
  Image1.Visible      := True;

  btnOk.Text    := 'Fechar';
  btnOk.Enabled := True;

  Caption := sCaption;
end;

end.
