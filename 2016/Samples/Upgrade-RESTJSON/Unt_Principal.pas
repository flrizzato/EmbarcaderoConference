unit Unt_Principal;

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
  IPPeerClient,
  REST.Client,
  REST.Authenticator.OAuth,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  IdContext,
  IdCustomHTTPServer,
  IdBaseComponent,
  IdComponent,
  IdCustomTCPServer,
  IdHTTPServer,
  Data.DB,
  Datasnap.DBClient,
  REST.Response.Adapter, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    OAuth2Authenticator1: TOAuth2Authenticator;
    Button2: TButton;
    Button3: TButton;
    IdHTTPServer1: TIdHTTPServer;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    Button4: TButton;
    RESTRequest3: TRESTRequest;
    RESTResponse3: TRESTResponse;
    Label2: TLabel;
    Button5: TButton;
    RESTRequest4: TRESTRequest;
    RESTResponse4: TRESTResponse;
    IdHTTP1: TIdHTTP;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Memo1: TMemo;
    TabSheet3: TTabSheet;
    Memo3: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button6: TButton;
    Edit1: TEdit;
    Button7: TButton;
    Button8: TButton;
    Label8: TLabel;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure IdHTTPServer1CommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    procedure BuscarFoto(const AURL: string);
    procedure BuscarMeusAlbuns(const AOffSet: Integer);
    procedure BuscarMinhasPlaylists(const AOffSet: Integer);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  Vcl.Imaging.jpeg,
  Vcl.Imaging.GIFImg,
  System.JSON,
  REST.Types,
  Winapi.ShellApi;

{$R *.dfm}

procedure TForm2.BuscarFoto(const AURL: string);
var
  oJPG : TJPEGImage;
  oGIF : TGIFImage;
  oBMP : TBitmap;
  oFoto: TStringStream;
begin
  oFoto := TStringStream.Create;

  oJPG := TJPEGImage.Create;
  oGIF := TGIFImage.Create;
  oBMP := TBitmap.Create;

  try
    Self.IdHTTP1.Get(AURL, oFoto);
    oFoto.Seek(0,0);

    if Self.IdHTTP1.Response.ContentType = 'image/jpeg' then
    begin
      oJPG.LoadFromStream(oFoto);
      oBMP.Assign(oJPG);
    end;

    if Self.IdHTTP1.Response.ContentType = 'image/gif' then
    begin
      oGIF.LoadFromStream(oFoto);
      oBMP.Assign(oGIF);
    end;

    Self.Image1.Picture.Bitmap.Assign(oBMP);
  finally
    oFoto.Free;
    oJPG.Free;
    oGIF.Free;
    oBMP.Free;
  end;

end;

procedure TForm2.BuscarMeusAlbuns(const AOffSet: Integer);
begin
  Self.RESTRequest2.Params.ParameterByName('offset').Value := AOffSet.ToString;

  Self.RESTRequest2.ExecuteAsync(
    procedure
    var
      oItens: TJSONArray;
      oItem: TJSONValue;
      oTrilha: TJSONObject;
    begin
      TThread.Queue(nil,
        procedure
        begin
          Self.Memo3.Lines.Add('----------------------------------------------');
          Self.Memo3.Lines.Add(Self.RESTResponse2.JSONText);
        end
      );


      oItens := TJSONArray(
                  TJSONObject(
                    Self.RESTResponse2.JSONValue
                  ).GetValue('items')
                );

      for oItem in oItens do
      begin
        oTrilha := TJSONObject(
                     TJSONObject(
                       oItem
                     ).GetValue('track')
                   );

        Memo1.Lines.Add(TJSONString(
                          oTrilha.GetValue('name')
                        ).Value);
      end;

      if (oItens.Count > 0) then
      begin
        Self.BuscarMeusAlbuns(AOffSet + 20);
      end
      else
      begin
        Screen.Cursor := crDefault;
      end;
    end)
end;

procedure TForm2.BuscarMinhasPlaylists(const AOffSet: Integer);
begin
  Self.RESTRequest3.Params.ParameterByName('offset').Value := AOffSet.ToString;
  Self.RESTRequest3.Params.ParameterByName('user_id').Value := Self.Label2.Caption;

  Self.RESTRequest3.ExecuteAsync(
    procedure
    var
      oItens: TJSONArray;
      oItem: TJSONValue;
      oPlayList: TJSONObject;
      sNome: string;
      sID: string;
    begin
      if (Self.RESTResponse3.StatusCode = 200) then
      begin
        TThread.Queue(nil,
          procedure
          begin
            Self.Memo3.Lines.Add('---------------------------------------------------');
            Self.Memo3.Lines.Add(Self.RESTResponse3.JSONText);
          end
        );

        oItens := TJSONArray(
                    TJSONObject(
                      Self.RESTResponse3.JSONValue
                    ).GetValue('items')
                  );

        for oItem in oItens do
        begin
          oPlayList := TJSONObject(oItem);

          sNome := TJSONString(
                     oPlayList.GetValue('name')
                   ).Value;

          sID := TJSONString(
                     oPlayList.GetValue('id')
                   ).Value;

          Self.Memo1.Lines.Add(Format('%s - %s', [sNome, sID]));
        end;

        if (oItens.Count > 0) then
        begin
          Self.BuscarMinhasPlaylists(AOffSet + 20);
        end else
        begin
          Screen.Cursor := crDefault;
        end;
      end else
      begin
        Screen.Cursor := crDefault;
        ShowMessage(Self.RESTResponse3.StatusText);
      end;
    end);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;

  // Requisita as informações do perfil de forma assíncrona
  Self.RESTRequest1.ExecuteAsync(
    procedure
    var
      sURLFoto: string;
    begin
      // Se retornou SUCESSO recupera as informações do usuário
      if (Self.RESTResponse1.StatusCode = 200) then
      begin
        TThread.Queue(nil,
          procedure
          begin;
          Self.Memo3.Text := Self.RESTResponse1.JSONText;
          end
        );

        // Recuperando o ID do usuário
        Self.Label2.Caption := TJSONString(
                                 TJSONObject(
                                   Self.RESTResponse1.JSONValue
                                 ).GetValue('id')
                               ).Value;

        // Recuperando o nome do usuário
        Self.Label1.Caption := TJSONString(
                                 TJSONObject(
                                   Self.RESTResponse1.JSONValue
                                 ).GetValue('display_name')
                               ).Value;

        // Recuperando a foto do usuário
        sURLFoto := TJSONString(
                      TJSONObject(
                        TJSONArray(
                          TJSONObject(
                            Self.RESTResponse1.JSONValue
                          ).GetValue('images')
                        ).Items[0]
                      ).GetValue('url')
                    ).Value;

        Self.BuscarFoto(sURLFoto);

        Screen.Cursor := crDefault;
      end
      else
      begin
        Screen.Cursor := crDefault;
        ShowMessage(Self.RESTResponse1.StatusText);
      end;
    end);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;

  Self.IdHTTPServer1.Active := True;

  // Limpando tudo!
  Self.OAuth2Authenticator1.ResetToDefaults;

  // Credenciais do nosso aplicativo (A partir do seu cadastro de aplicativos no Spotify)
  Self.OAuth2Authenticator1.ClientID := '62dbf87068c149e888c421f8d9bc4b70';
  Self.OAuth2Authenticator1.ClientSecret := '9cb644ba0ae34fa587671d1b23fde3e8';

  // End-point de AUTORIZAÇÃO do Spotify
  Self.OAuth2Authenticator1.AuthorizationEndpoint := 'https://accounts.spotify.com/authorize';

  // Escopos que queremos ter acesso do usuário
  // Self.OAuth2Authenticator1.Scope := 'user-read-private user-library-read';
  Self.OAuth2Authenticator1.Scope := 'user-read-private user-library-read playlist-modify-public';

  // Página de redirecionamento com o efetivo CÓDIGO DE AUTORIZAÇÃO
  Self.OAuth2Authenticator1.RedirectionEndpoint := 'http://localhost:9090';

  // Enfim: A definição da URI para gerar o CÓDIGO DE AUTORIZAÇÃO
  Self.Memo1.Text := Self.OAuth2Authenticator1.AuthorizationRequestURI;
  ShellExecute(0, 'OPEN', PChar(Self.OAuth2Authenticator1.AuthorizationRequestURI), '', '', SW_SHOWNORMAL);
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  Self.Memo1.Clear;
  Screen.Cursor := crHourGlass;
  Self.BuscarMeusAlbuns(0);
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  Self.Memo1.Clear;
  Screen.Cursor := crHourGlass;
  Self.BuscarMinhasPlaylists(0);
end;

procedure TForm2.Button5Click(Sender: TObject);
var
  oDados: TJSONObject;
begin
  oDados := TJSONObject.Create;
  try
    oDados.AddPair('name', TJSONString.Create(InputBox('Nome da playlist:', 'Nome:', '')));
    oDados.AddPair('public', TJSONTrue.Create);
    Self.RESTRequest4.AddBody(oDados);

    Self.RESTRequest4.Method := TRESTRequestMethod.rmPOST;
    Self.RESTRequest4.Resource := 'v1/users/{user_id}/playlists';
    Self.RESTRequest4.Params.ParameterByName('user_id').Value := Self.Label2.Caption;

    Self.Memo3.Lines.Add(oDados.ToJSON);

    Self.RESTRequest4.Execute;

    if (Self.RESTResponse4.StatusCode = 201) then
    begin
      Self.Memo3.Lines.Add('--------------------------------------------');
      Self.Memo3.Lines.Add(Self.RESTResponse4.JSONText);

      Self.Edit1.Text := TJSONString(
                           TJSONObject(
                             Self.RESTResponse4.JSONValue
                           ).GetValue('id')
                         ).Value;
    end else
    begin
      ShowMessage(Self.RESTResponse4.StatusText);
    end;

  finally
    oDados.Free;
  end;
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
    Self.RESTRequest4.Method := TRESTRequestMethod.rmGET;
    Self.RESTRequest4.Resource := 'v1/users/{user_id}/playlists/{playlist_id}';
    Self.RESTRequest4.Params.ParameterByName('user_id').Value := Self.Label2.Caption;
    Self.RESTRequest4.Params.ParameterByName('playlist_id').Value := Self.Edit1.Text;

    Self.RESTRequest4.Execute;

    if (Self.RESTResponse4.StatusCode = 200) then
    begin
      Self.Memo3.Lines.Add('--------------------------------------------');
      Self.Memo3.Lines.Add(Self.RESTResponse4.JSONText);
    end else
    begin
      ShowMessage(Self.RESTResponse4.StatusText);
    end;
end;

procedure TForm2.Button7Click(Sender: TObject);
var
  oDados: TJSONObject;
begin
  oDados := TJSONObject.Create;
  try
    oDados.AddPair('name', TJSONString.Create(InputBox('Nome da playlist:', 'Nome:', '')));
    oDados.AddPair('public', TJSONTrue.Create);
    Self.RESTRequest4.AddBody(oDados);

    Self.RESTRequest4.Method := TRESTRequestMethod.rmPUT;
    Self.RESTRequest4.Resource := 'v1/users/{user_id}/playlists/{playlist_id}';
    Self.RESTRequest4.Params.ParameterByName('user_id').Value := Self.Label2.Caption;
    Self.RESTRequest4.Params.ParameterByName('playlist_id').Value := Self.Edit1.Text;

    Self.Memo3.Lines.Add(oDados.ToJSON);

    Self.RESTRequest4.Execute;

    if (Self.RESTResponse4.StatusCode = 200) then
    begin
      Self.Memo3.Lines.Add('--------------------------------------------');
      Self.Memo3.Lines.Add(Self.RESTResponse4.JSONText);
    end else
    begin
      ShowMessage(Self.RESTResponse4.StatusText);
    end;

  finally
    oDados.Free;
  end;
end;

procedure TForm2.Button8Click(Sender: TObject);
begin
    ShowMessage('Não existe exclusão de playlist no Spotify!');

    Self.RESTRequest4.Method := TRESTRequestMethod.rmDELETE;
    Self.RESTRequest4.Resource := 'v1/users/{user_id}/playlists/{playlist_id}/tracks';
    Self.RESTRequest4.Params.ParameterByName('user_id').Value := Self.Label2.Caption;
    Self.RESTRequest4.Params.ParameterByName('playlist_id').Value := Self.Edit1.Text;

    Self.RESTRequest4.Execute;
end;

Procedure TForm2.FormCreate(Sender: TObject);
begin
  Self.PageControl1.ActivePageIndex := 0;
end;

procedure TForm2.IdHTTPServer1CommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  // Validado a query string
  if (ARequestInfo.Params.IndexOfName('code') = -1) then
  begin
    Exit;
  end;

  // Definição do CÓDIGO DE ACESSO, que recuperamos à partir da página de redirecionamento
  Self.OAuth2Authenticator1.AuthCode := ARequestInfo.Params.Values['code'];

  // End-point para a geração do TOKEN DE ACESSO
  Self.OAuth2Authenticator1.AccessTokenEndpoint := 'https://accounts.spotify.com/api/token';

  // Definindo o TOKEN DE ACESSO à partir do CÓDIGO DE AUTORIZAÇÃO
  Self.OAuth2Authenticator1.ChangeAuthCodeToAccesToken;

  // Resposta para o browser
  AResponseInfo.ContentText := '<html><body><script language=javascript>window.close();</script>Obrigado por conceder o acesso!</body></html>';

  // Operação efetuada com sucesso!
  Memo1.Text := Self.OAuth2Authenticator1.AccessToken;
  Screen.Cursor := crDefault;
  ShowMessage('Autorização concedida com sucesso!');
end;


end.
